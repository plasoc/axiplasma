
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;
use work.mlitesoc_pack.all;

entity plasoc_axi4_read_cntrl is
    generic (
        -- cpu constants
        cpu_address_width : integer := 16;
        cpu_data_width : integer := 32;
        -- cache constants
        cache_offset_width : integer := 5;
        -- axi read constants
        axi_aruser_width : integer := 0;
        axi_ruser_width : integer := 0);
    port(
        -- global interfaces.
        clock : in std_logic;
        nreset : in std_logic;
        -- mem read interface.
        mem_read_address : in std_logic_vector(cpu_address_width-1 downto 0);
        mem_read_data : out std_logic_vector(cpu_data_width-1 downto 0);
        mem_read_enable : in std_logic;
        mem_read_valid : out std_logic;
        mem_read_ready : in std_logic;
        -- cache interface.
        cache_cacheable : in std_logic;
        -- axi read interface.
        axi_arid : out std_logic_vector(0 downto 0);
        axi_araddr : out std_logic_vector(cpu_address_width-1 downto 0);
        axi_arlen : out std_logic_vector(7 downto 0);
        axi_arsize : out std_logic_vector(2 downto 0);
        axi_arburst : out std_logic_vector(1 downto 0);
        axi_arlock : out std_logic;
        axi_arcache : out std_logic_vector(3 downto 0);
        axi_arprot : out std_logic_vector(2 downto 0);
        axi_arqos : out std_logic_vector(3 downto 0);
        axi_aruser : out std_logic_vector(axi_aruser_width-1 downto 0);
        axi_arvalid : out std_logic;
        axi_arready : in std_logic;
        axi_rid : in std_logic_vector(0 downto 0);
        axi_rdata : in std_logic_vector(cpu_data_width-1 downto 0);
        axi_rresp : in std_logic_vector(1 downto 0);
        axi_rlast : in std_logic;
        axi_ruser : in std_logic_vector(axi_ruser_width-1 downto 0);
        axi_rvalid : in std_logic;
        axi_rready : out std_logic;
        -- error interface.
        error_data : out std_logic_vector(3 downto 0) := (others=>'0') );
end plasoc_axi4_read_cntrl;

architecture Behavioral of plasoc_axi4_read_cntrl is
    subtype error_data_type is std_logic_vector(error_data'high downto error_data'low);
    constant cpu_bytes_per_word : integer := cpu_data_width/8;
    constant cache_words_per_line : integer := 2**cache_offset_width/cpu_bytes_per_word;
    constant axi_burst_len_noncacheable : integer := 0;
    constant axi_burst_len_cacheable : integer := cache_words_per_line-1;
    type state_type is (state_wait,state_read,state_error);
    signal state : state_type := state_wait;
    signal counter : integer range 0 to cache_words_per_line;
    signal axi_finished : boolean := False;
    signal axi_arlen_buff : std_logic_vector(7 downto 0);
    signal axi_arvalid_buff : std_logic;
    signal axi_rready_buff : std_logic;
    signal mem_read_valid_buff : std_logic;
begin

    axi_arid <= (others=>'0');
    axi_arlen <= axi_arlen_buff;
    axi_arsize <= std_logic_vector(to_unsigned(clogb2(cpu_bytes_per_word),axi_arsize'length));
    axi_arburst <= axi_burst_incr;
    axi_arlock <= axi_lock_normal_access;
    axi_arcache <= axi_cache_device_nonbufferable;
    axi_arprot <= axi_prot_instr & not axi_prot_sec & not axi_prot_priv;
    axi_arqos <= (others=>'0');
    axi_aruser <= (others=>'0');
    axi_arvalid <= axi_arvalid_buff;
    axi_rready <= axi_rready_buff;
    mem_read_valid <= mem_read_valid_buff;
    
    process (clock)
        variable burst_len : integer range 0 to 2**axi_arlen'length-1;
        variable error_data_buff : error_data_type := (others=>'0');
        variable handshake : boolean;
    begin
        if rising_edge(clock) then
            if nreset='0' then
                error_data <= (others=>'0');
                error_data_buff := (others=>'0');
                axi_arvalid_buff <= '0';
                axi_rready_buff <= '0';
                mem_read_valid_buff <= '0';
                state <= state_wait;
            else
                case state is
                -- WAIT mode.
                when state_wait =>
                    -- Wait until the memory read interface requests data.
                    if mem_read_enable='1' then
                        -- Set control information. 
                        axi_araddr <= mem_read_address;
                        -- The burst length will change according to whether the memory access is cacheable or not.
                        if cache_cacheable='1' then
                            burst_len := axi_burst_len_cacheable;
                        else
                            burst_len := axi_burst_len_noncacheable;
                        end if;
                        axi_arlen_buff <= std_logic_vector(to_unsigned(burst_len,axi_arlen'length));
                        -- Set counter to keep track the number of words read from the burst.
                        counter <= 0;
                        -- Reset finish indicator.
                        axi_finished <= False;
                        -- Wait until handshake before reading data.
                        if axi_arvalid_buff='1' and axi_arready='1' then
                            axi_arvalid_buff <= '0';
                            state <= state_read;
                        else
                            axi_arvalid_buff <= '1';
                        end if;
                    end if;
                -- READ mode.
                when state_read=>
                    -- Check for axi handshake;
                    handshake := axi_rvalid='1' and axi_rready_buff='1';
                    -- On handshake with the axi4 read interface, sample the word and
                    -- let the memory interface know the data is valid.
                    if handshake then
                        mem_read_data <= axi_rdata;
                        counter <= counter+1;
                        mem_read_valid_buff <= '1';
                    -- Once the memory interface samples the data, the data becomes invalid.
                    elsif mem_read_valid_buff='1' and mem_read_ready='1' then
                        mem_read_valid_buff <= '0';
                    end if;
                    -- Only permit a read if the memory interface is ready to accept.
                    if mem_read_ready='1' then
                        axi_rready_buff <= '1';
                    else
                        axi_rready_buff <= '0';
                    end if;
                    -- Check if enough words have been received.
                    if counter=axi_arlen_buff and handshake then
                        -- Check if an error occurred.
                        if axi_rlast='0' or axi_rresp/=axi_resp_okay then
                            -- Assert on last flag
                            if axi_rlast='0' then
                                error_data_buff(error_axi_read_rlast) := '1';
                            end if;
                            -- Assert on read response.
                            if axi_rresp/=axi_resp_okay then
                                if axi_rresp=axi_resp_exokay then
                                    error_data_buff(error_axi_read_exokay) := '1';
                                elsif axi_rresp=axi_resp_slverr then
                                    error_data_buff(error_axi_read_slverr) := '1';
                                elsif axi_rresp=axi_resp_decerr then
                                    error_data_buff(error_axi_read_decerr) := '1';
                                end if;
                            end if;
                            -- Send out error bits.
                            error_data <= error_data_buff;
                            -- Block on error state.
                            state <= state_error;
                        -- Upon successful completion, signal that the transaction is finished.
                        else
                            axi_finished <= True;
                        end if;
                    end if;
                    -- Start waiting again if both the transaction is finished and the 
                    -- last word is read from the memory read interface.
                    if axi_finished and mem_read_ready='0' then
                        state <= state_wait;
                    end if;
                -- block in ERROR mode.
                when state_error=>
                end case;
            end if;
        end if;
    end process;

end Behavioral;
