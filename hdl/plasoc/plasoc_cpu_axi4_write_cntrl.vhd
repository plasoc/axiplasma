-------------------------------------------------------
--! @author Andrew Powell
--! @date January 17, 2017
--! @brief Contains the entity and architecture of the 
--! CPU's Master AXI4-Full Write Memory Controller.
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;
use work.plasoc_pack.all;

--! The Write Memory Controller implements a Master AXI4-Full Write 
--! interface in order to allow the CPU to perform writes to
--! main memory and other devices external to the CPU. Much optimization
--! of the Write and Read Memory Controllers is needed for future revisions,
--! considering the current revision is implemented in a sequential, blocking
--! manner. Specifically, for the sake simplicity, the AXI4-Full Write Address,
--! Write Data, and Write Response channels are implemented as a state machine,
--! rather than as separate processes that can permit concurrent execution.
--!
--! Information specific to the AXI4-Full
--! protocol is excluded from this documentation since the information can
--! be found in official ARM AMBA4 AXI documentation.
entity plasoc_cpu_axi4_write_cntrl is
    generic(
        -- CPU parameters.
        cpu_address_width : integer := 16;      --! Defines the address width of the CPU. This should normally be equal to the CPU's width.	
        cpu_data_width : integer := 32;         --! Defines the data width of the CPU. This should normally be equal to the CPU's width.
        -- Cache parameters.
        cache_offset_width : integer := 5;      --! Indicates whether the requested address of the CPU is cacheable or noncacheable.
        -- AXI4-Full Write parameters.
        axi_awuser_width : integer := 0;        --! Width of user-define AXI4-Full Address Write signal.
        axi_wuser_width : integer := 0;         --! Width of user-define AXI4-Full Write Data signal.
        axi_buser_width : integer := 0          --! Width of user-define AXI4-Full Write Response signal.
	);
    port(
        -- Global interfaces.
        clock : in std_logic;                                                                   --! Clock. Tested with 50 MHz.
        nreset : in std_logic;                                                                  --! Reset on low.
        -- Memory interface.
        mem_write_address : in std_logic_vector(cpu_address_width-1 downto 0);                  --! The requested address sent to the write memory controller.
        mem_write_data : in std_logic_vector(cpu_data_width-1 downto 0) := (others=>'0');       --! The word written to the write memory controller.
        mem_write_strobe : in std_logic_vector(cpu_data_width/8-1 downto 0);                    --! Each bit that is high enables writing for the corresponding byte in mem_write_data.
        mem_write_enable : in std_logic;                                                        --! Enables the operation of the write memory controller.
        mem_write_valid : in std_logic;	                                                        --! Indicates the cache has a valid word on mem_write_data.	
        mem_write_ready  : out std_logic;                                                       --! Indicates the read memory controller is ready to sample a word from mem_write_data.	
        -- Cache interface.
        cache_cacheable : in std_logic;                                                         --! Indicates whether the requested address of the CPU is cacheable or noncacheable.
        -- Master AXI4-Full Write interface.
        axi_awid : out std_logic_vector(0 downto 0);                                            --! AXI4-Full Address Write signal.
        axi_awaddr : out std_logic_vector(cpu_address_width-1 downto 0) := (others=>'0');       --! AXI4-Full Address Write signal.	
        axi_awlen : out std_logic_vector(7 downto 0);                                           --! AXI4-Full Address Write signal.
        axi_awsize : out std_logic_vector(2 downto 0);                                          --! AXI4-Full Address Write signal.
        axi_awburst : out std_logic_vector(1 downto 0);                                         --! AXI4-Full Address Write signal.
        axi_awlock : out std_logic;                                                             --! AXI4-Full Address Write signal.
        axi_awcache : out std_logic_vector(3 downto 0);                                         --! AXI4-Full Address Write signal.
        axi_awprot : out std_logic_vector(2 downto 0);                                          --! AXI4-Full Address Write signal.	
        axi_awqos : out std_logic_vector(3 downto 0);                                           --! AXI4-Full Address Write signal.	
        axi_awregion : out std_logic_vector(3 downto 0);                                        --! AXI4-Full Address Write signal.	
        axi_awuser : out std_logic_vector(axi_awuser_width-1 downto 0);                         --! AXI4-Full Address Write signal.
        axi_awvalid : out std_logic;                                                            --! AXI4-Full Address Write signal.	
        axi_awready : in std_logic;                                                             --! AXI4-Full Address Write signal.	
        axi_wdata : out std_logic_vector(cpu_data_width-1 downto 0) := (others=>'0');           --! AXI4-Full Write Data signal.
        axi_wstrb : out std_logic_vector(cpu_data_width/8-1 downto 0) := (others=>'0');         --! AXI4-Full Write Data signal.
        axi_wlast : out std_logic := '0';                                                       --! AXI4-Full Write Data signal.
        axi_wuser : out std_logic_vector(axi_wuser_width-1 downto 0);                           --! AXI4-Full Write Data signal.	
        axi_wvalid : out std_logic;                                                             --! AXI4-Full Write Data signal.
        axi_wready : in std_logic;                                                              --! AXI4-Full Write Data signal.
        axi_bid : in std_logic_vector(0 downto 0);                                              --! AXI4-Full Write Response signal.
        axi_bresp : in  std_logic_vector(1 downto 0);                                           --! AXI4-Full Write Response signal.
        axi_buser : in std_logic_vector(axi_buser_width-1 downto 0);                            --! AXI4-Full Write Response signal.
        axi_bvalid : in std_logic;                                                              --! AXI4-Full Write Response signal.
        axi_bready : out std_logic;                                                             --! AXI4-Full Write Response signal.
        -- Error interface.
        error_data : out std_logic_vector(2 downto 0) := (others=>'0')                          --! Returns value signifying error in the transaction.
	);
end plasoc_cpu_axi4_write_cntrl;

architecture Behavioral of plasoc_cpu_axi4_write_cntrl is
    subtype error_data_type is std_logic_vector(error_data'high downto error_data'low);
    constant cpu_bytes_per_word : integer := cpu_data_width/8;
    constant cache_words_per_line : integer := 2**cache_offset_width/cpu_bytes_per_word;
    constant axi_burst_len_noncacheable : integer := 0;
    constant axi_burst_len_cacheable : integer := cache_words_per_line-1;
    type state_type is (state_wait,state_write,state_response,state_error);
    signal state : state_type := state_wait;
    signal counter : integer range 0 to cache_words_per_line;
    signal axi_awlen_buff : std_logic_vector(7 downto 0) := (others=>'0');
    signal axi_awvalid_buff : std_logic := '0';
    signal axi_wvalid_buff : std_logic := '0';
    signal mem_write_ready_buff : std_logic := '0';
    signal axi_bready_buff : std_logic := '0';
begin

    axi_awid <= (others=>'0');
    axi_awlen <= axi_awlen_buff;
    axi_awsize <= std_logic_vector(to_unsigned(clogb2(cpu_bytes_per_word),axi_awsize'length));
    axi_awburst <= axi_burst_incr;
    axi_awlock <= axi_lock_normal_access;
    axi_awcache <= axi_cache_device_nonbufferable;
    axi_awprot <= axi_prot_instr & not axi_prot_sec & not axi_prot_priv;
    axi_awqos <= (others=>'0');
    axi_awregion <= (others=>'0');
    axi_awuser <= (others=>'0');
    axi_awvalid <= axi_awvalid_buff;
    axi_wvalid <= axi_wvalid_buff;
    mem_write_ready <= mem_write_ready_buff;
    axi_bready <= axi_bready_buff;
    axi_wuser <= (others=>'0');

    process (clock)
        variable burst_len : integer range 0 to 2**axi_awlen'length-1;
        variable error_data_buff : error_data_type := (others=>'0');
        variable mem_handshake : boolean;
        variable axi_handshake : boolean;
        variable finished : boolean;
    begin
        if rising_edge(clock) then
            if nreset='0' then
                error_data <= (others=>'0');
                state <= state_wait;
            else
                case state is
                -- WAIT mode.
                when state_wait=>
                    -- Wait until the memory write interface issues a write memory access.
                    if mem_write_enable='1' then
                        -- Set control information.
                        axi_awaddr <= mem_write_address;
                        -- The burst length will change according to whether the memory access is cacheable or not.
                        if cache_cacheable='1' then
                            burst_len := axi_burst_len_cacheable;
                        else
                            burst_len := axi_burst_len_noncacheable;
                        end if;
                        axi_awlen_buff <= std_logic_vector(to_unsigned(burst_len,axi_awlen'length));
                        -- Set counter to keep track the number of words written to the axi write interface.
                        counter <= 0;
                        -- Wait until handshake before writing data.
                        if axi_awvalid_buff='1' and axi_awready='1' then
                            axi_awvalid_buff <= '0';
                            state <= state_write;
                        else
                            axi_awvalid_buff <= '1';
                        end if;
                    end if;
                -- WRITE mode.
                when state_write=>
                    -- Check for handshakes;
                    mem_handshake := mem_write_valid='1' and mem_write_ready_buff='1';
                    axi_handshake := axi_wvalid_buff='1' and axi_wready='1';
                    -- On handshake with the mem interface, sample the word and
                    -- let the axi write interface know that data is valid.
                    if mem_handshake then
                        axi_wdata <= mem_write_data;
                        axi_wstrb <= mem_write_strobe;
                        counter <= counter+1;
                        axi_wvalid_buff <= '1';
                        -- Set the last signal on the last word in the burst.
                        if counter=axi_awlen_buff then
                            axi_wlast <= '1';
                        end if;
                    -- Once the axi write interface samples the data, the data becomes invalid.
                    elsif axi_handshake then
                        axi_wvalid_buff <= '0';
                        axi_wlast <= '0';
                    end if;
                    -- On completition, it is no longer valid for the memory write interface to 
                    -- continue to write more words. Also, it is time to acknowledge the write response
                    -- from the axi write interface.
                    if counter=axi_awlen_buff+1 and axi_handshake then
                        mem_write_ready_buff <= '0';
                        state <= state_response;
                    -- Only permit the memory write interface to write data if the axi write interface
                    -- is ready for more words.
                    elsif axi_wready='1' then
                        mem_write_ready_buff <= '1';
                    else
                        mem_write_ready_buff <= '0';
                    end if;
                -- RESPONSE mode.
                when state_response=>
                    -- Wait until handshake before reading the response.
                    if axi_bvalid='1' and axi_bready_buff='1' then
                        -- The response channel should no longer be ready once the response has been acquired.
                        axi_bready_buff <= '0';
                        -- Check if an error occurred.
                        if axi_bresp/=axi_resp_okay then
                            -- Block on error.
                            state <= state_error;
                            -- Determine error code.
                            if axi_bresp=axi_resp_exokay then
                                error_data(error_axi_read_exokay) <= '1';
                            elsif axi_bresp=axi_resp_slverr then
                                error_data(error_axi_read_slverr) <= '1';
                            elsif axi_bresp=axi_resp_decerr then
                                error_data(error_axi_read_decerr) <= '1';
                            end if;
                        else
                            -- If an error didn't occur, begin waiting for the next memory write request.
                            state <= state_wait;
                        end if;
                    -- Let the slave axi write interface know the master is ready for the response.
                    else
                        axi_bready_buff <= '1';
                    end if;
                -- ERROR mode.
                when state_error=> 
                end case;
            end if;
        end if;
    end process;

end Behavioral;
