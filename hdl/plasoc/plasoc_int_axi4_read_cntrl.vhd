-------------------------------------------------------
--! @author Andrew Powell
--! @date January 28, 2017
--! @brief Contains the entity and architecture of the 
--! Interrupt Controller's Slave AXI4-Lite Read 
--! Controller.
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.plasoc_int_pack.all;

--! The Read Controller implements a Slave AXI4-Lite Read 
--! interface in order to allow a Master interface to read from
--! the registers of the core.
--!
--! Information specific to the AXI4-Lite
--! protocol is excluded from this documentation since the information can
--! be found in official ARM AMBA4 AXI documentation.
entity plasoc_int_axi4_read_cntrl is
    generic (
        -- AXI4-Lite parameters.
        axi_address_width : integer := 16;						--! Defines the AXI4-Lite Address Width.
        axi_data_width : integer := 32;							--! Defines the AXI4-Lite Data Width.	
        -- Interrupt Controller parameters.
        int_id_address : std_logic_vector := X"0004";			--! Defines the offset for the Interrupt Identifier register.
        int_enables_address : std_logic_vector := X"0000";		--! Defines the offset for the Interrupt Enables register.
        int_active_address : std_logic_vector := X"0008"		--! Defines the offset for the Interrupt Active register.	
	);
    port ( 
        -- Global interface.
        aclk : in std_logic;															--! Clock. Tested with 50 MHz.
        aresetn : in std_logic;															--! Reset on low.
        -- Slave AXI4-Lite Read interface.
        axi_araddr : in std_logic_vector(axi_address_width-1 downto 0);					--! AXI4-Lite Address Read signal.
        axi_arprot : in std_logic_vector(2 downto 0);									--! AXI4-Lite Address Read signal.
        axi_arvalid : in std_logic;														--! AXI4-Lite Address Read signal.
        axi_arready : out std_logic;													--! AXI4-Lite Address Read signal.
        axi_rdata : out std_logic_vector(axi_data_width-1 downto 0) := (others=>'0');	--! AXI4-Lite Read Data signal.
        axi_rvalid : out std_logic;														--! AXI4-Lite Read Data signal.
        axi_rready : in std_logic;														--! AXI4-Lite Read Data signal.
        axi_rresp : out std_logic_vector(1 downto 0);									--! AXI4-Lite Read Data signal.	
        -- Interrupt Controller Interface.
        int_id : in std_logic_vector(axi_data_width-1 downto 0);						--! Interrupt Identifier register.
        int_enables : in std_logic_vector(axi_data_width-1 downto 0);					--! Interrupt Enables register.
        int_active : in std_logic_vector(axi_data_width-1 downto 0)						--! Interrupt Active register.	
	);
end plasoc_int_axi4_read_cntrl;

architecture Behavioral of plasoc_int_axi4_read_cntrl is
    type state_type is (state_wait,state_read);
    signal state : state_type := state_wait;
    signal axi_arready_buff : std_logic := '0';
    signal axi_rvalid_buff : std_logic := '0';
    signal axi_araddr_buff : std_logic_vector(axi_address_width-1 downto 0);
begin
    axi_arready <= axi_arready_buff;
    axi_rvalid <= axi_rvalid_buff;
    axi_rresp <= axi_resp_okay;
    -- Drive the axi read interface.
    process (aclk)
    begin
        -- Perform operations on the clock's positive edge.
        if rising_edge(aclk) then
            if aresetn='0' then
                axi_arready_buff <= '0';
                axi_rvalid_buff <= '0';
                state <= state_wait;
            else
                -- Drive state machine.
                case state is
                -- WAIT mode.
                when state_wait=>
                    -- Wait for handshake,
                    if axi_arvalid='1' and axi_arready_buff='1' then
                        -- Prevent the master from sending any more control information.
                        axi_arready_buff <= '0';
                        -- Sample the address sent from the master.
                        axi_araddr_buff <= axi_araddr;
                        state <= state_read;
                    -- Let the master interface know the slave is ready
                    -- to receive address information.
                    else
                        axi_arready_buff <= '1';
                    end if;
                -- READ mode.
                when state_read=>
                    -- Wait for handshake,
                    if axi_rvalid_buff='1' and axi_rready='1' then
                        axi_rvalid_buff <= '0';
                        state <= state_wait;
                    -- Set the data and let the master know it's available.
                    else
                        axi_rvalid_buff <= '1';
                        -- Send data according to the bufferred address.
                        if axi_araddr_buff=int_id_address then 
                            axi_rdata <= int_id;
                        elsif axi_araddr_buff=int_enables_address then
                            axi_rdata <= int_enables;
                        elsif axi_araddr_buff=int_active_address then
                            axi_rdata <= int_active;
                        else
                            axi_rdata <= (others=>'0');
                        end if;
                    end if;
                end case;
            end if;
        end if;
    end process;
    
end Behavioral;
