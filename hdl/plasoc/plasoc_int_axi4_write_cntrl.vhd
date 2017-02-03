-------------------------------------------------------
--! @author Andrew Powell
--! @date January 28, 2017
--! @brief Contains the entity and architecture of the 
--! Interrupt Controller's Slave AXI4-Lite Write 
--! Controller.
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;                        
use work.plasoc_pack.all;

--! The Write Controller implements a Slave AXI4-Lite Write 
--! interface in order to allow a Master interface to write to
--! the registers of the core.
--!
--! Information specific to the AXI4-Lite
--! protocol is excluded from this documentation since the information can
--! be found in official ARM AMBA4 AXI documentation.
entity plasoc_int_axi4_write_cntrl is
    generic (
        -- AXI4-Lite parameters.
        axi_address_width : integer := 16;						--! Defines the AXI4-Lite Address Width.
        axi_data_width : integer := 32;							--! Defines the AXI4-Lite Data Width.
        -- Interrupt Controller parameters.
        int_enables_address : std_logic_vector := X"0000"		--! Defines the offset for the Interrupt Enables register.
	);
    port (
        -- Global interface.
        aclk : in std_logic;												--! Clock. Tested with 50 MHz.
        aresetn : in std_logic;												--! Reset on low.
        -- Slave AXI4-Lite Write interface.
        axi_awaddr : in std_logic_vector(axi_address_width-1 downto 0);		--! AXI4-Lite Address Write signal.
        axi_awprot : in std_logic_vector(2 downto 0);						--! AXI4-Lite Address Write signal.
        axi_awvalid : in std_logic;											--! AXI4-Lite Address Write signal.
        axi_awready : out std_logic;										--! AXI4-Lite Address Write signal.
        axi_wvalid : in std_logic;											--! AXI4-Lite Write Data signal.
        axi_wready : out std_logic;											--! AXI4-Lite Write Data signal.
        axi_wdata : in std_logic_vector(axi_data_width-1 downto 0);			--! AXI4-Lite Write Data signal.
        axi_wstrb : in std_logic_vector(axi_data_width/8-1 downto 0);		--! AXI4-Lite Write Data signal.
        axi_bvalid : out std_logic;											--! AXI4-Lite Write Response signal.
        axi_bready : in std_logic;											--! AXI4-Lite Write Response signal.
        axi_bresp : out std_logic_vector(1 downto 0);						--! AXI4-Lite Write Response signal.
        -- Interrupt Controller interface.
        int_enables : out std_logic_vector(axi_data_width-1 downto 0) := (others=>'0') --! Interrupt Enables register.
	);
end plasoc_int_axi4_write_cntrl;

architecture Behavioral of plasoc_int_axi4_write_cntrl is
    type state_type is (state_wait,state_write,state_response);
    signal state : state_type := state_wait;
    signal axi_awready_buff : std_logic := '0';
    signal axi_awaddr_buff : std_logic_vector(axi_address_width-1 downto 0);
    signal axi_wready_buff : std_logic := '0';
    signal axi_bvalid_buff : std_logic := '0';
begin
    axi_awready <= axi_awready_buff;
    axi_wready <= axi_wready_buff;
    axi_bvalid <= axi_bvalid_buff;
    axi_bresp <= axi_resp_okay;
    
    -- Drive the axi write interface.
    process (aclk)
    begin
        -- Perform operations on the clock's positive edge.
        if rising_edge(aclk) then
            if aresetn='0' then
                axi_awready_buff <= '0';
                axi_wready_buff <= '0';
                axi_bvalid_buff <= '0';
                int_enables <= (others=>'0');
                state <= state_wait;
            else
                -- Drive state machine.
                case state is
                -- WAIT mode.
                when state_wait=>
                    -- Sample address interface on handshake and go start
                    -- performing the write operation.
                    if axi_awvalid='1' and axi_awready_buff='1' then
                        -- Prevent the master from sending any more control information.
                        axi_awready_buff <= '0';
                        -- Sample the address sent from the master.
                        axi_awaddr_buff <= axi_awaddr;
                        -- Begin to read data to write.
                        axi_wready_buff <= '1';
                        state <= state_write;
                    -- Let the master interface know the slave is ready
                    -- to receive address information.
                    else
                        axi_awready_buff <= '1';
                    end if;
                -- WRITE mode.
                when state_write=>
                    -- Wait for handshake.
                    if axi_wvalid='1' and axi_wready_buff='1' then
                        -- Prevent the master from sending any more data.
                        axi_wready_buff <= '0';
                        -- Only sample written data if the address is valid.
                        if axi_awaddr_buff=int_enables_address then
                            -- Only sample the specified bytes.
                            for each_byte in 0 to axi_data_width/8-1 loop
                                if axi_wstrb(each_byte)='1' then
                                    int_enables(7+each_byte*8 downto each_byte*8) <=
                                        axi_wdata(7+each_byte*8 downto each_byte*8);
                                end if;
                            end loop;
                        end if;
                        -- Begin to transmit the response.
                        state <= state_response;
                        axi_bvalid_buff <= '1';
                    end if;
                -- RESPONSE mode.
                when state_response=>
                    -- Wait for handshake.
                    if axi_bvalid_buff='1' and axi_bready='1' then
                        -- Starting waiting for more address information on 
                        -- successful handshake.
                        axi_bvalid_buff <= '0';
                        state <= state_wait;
                    end if;
                end case;
            end if;
        end if;
    end process;

end Behavioral;
