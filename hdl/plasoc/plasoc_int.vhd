-------------------------------------------------------
--! @author Andrew Powell
--! @date January 28, 2017
--! @brief Contains the entity and architecture of the 
--! Plasma-SoC's Interrupt Controller.
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
use work.plasoc_int_pack.all;

--! The Interrupt Controller is developed to extend 
--! the single external interrupt of the Plasma-SoC's CPU to
--! support multiple interrupts. The only goals behind the 
--! development of the Interrupt Controller are simplicity and
--! having a Slave AXI4-Lite interface.
--!
--! The operation of the Interrupt Controller is as follows. Each
--! device interrupt, which are the interrupts associated with the
--! devices connecting to the Interrupt Controller, is enabled by
--! writing to the corresponding bit at the Interrupt Enables register
--! located at axi_int_enables_offset. A device can trigger its respective
--! interrupt by setting it high. At this point, the device interrupt is 
--! considered active if it is both enabled in the Interrupt Enables register
--! and set high by the respective device.
--!
--! If there is at least one active device interrupt, the Interrupt Controller 
--! will set the CPU interrupt, which is the single interrupt associated with the
--! CPU, high and set the Interrupt Identifier register at axi_int_id_offset
--! as the identifier (IRQ) of the active device interrupt.
--! If there are multiple active device interrupts, the lowest identifier will
--! always have priority over the Interrupt Identifier register. The CPU
--! interrupt will remain high until there are no active device interrupts.
--!
--! Information specific to the AXI4-Full
--! protocol is excluded from this documentation since the information can
--! be found in official ARM AMBA4 AXI documentation.
entity plasoc_int is
    generic(
        -- Slave AXI4-Lite parameters.
        axi_address_width : integer := 16;                      --! Defines the AXI4-Lite Address Width.
        axi_data_width : integer := 32;                         --! Defines the AXI4-Lite Data Width.	
        axi_base_address : std_logic_vector := X"0000";         --! Defines the AXI4-Lite base address.
        axi_int_id_offset : integer := 4;                       --! Defines the offset from axi_base_address for the Interrupt Identifier register.
        axi_int_enables_offset : integer := 0;                  --! Defines the offset from axi_base_address for the Interrupt Enables register.
        axi_int_active_offset : integer := 8;                   --! Defines the offset from axi_base_address for the Interrupt Active register.
        -- Interrupt Controller parameters.
        interrupt_total : integer := 8                          --! Defines the number of available device interrupts.
     );
    port(
        -- Global Interface.
        aclk : in std_logic;                                                            --! Clock. Tested with 50 MHz.
        aresetn : in std_logic;                                                         --! Reset on low.
        -- Slave AXI4-Lite Write interface.
        axi_awaddr : in std_logic_vector(axi_address_width-1 downto 0);                 --! AXI4-Lite Address Write signal.
        axi_awprot : in std_logic_vector(2 downto 0);                                   --! AXI4-Lite Address Write signal.
        axi_awvalid : in std_logic;                                                     --! AXI4-Lite Address Write signal.
        axi_awready : out std_logic;                                                    --! AXI4-Lite Address Write signal.		
        axi_wvalid : in std_logic;                                                      --! AXI4-Lite Write Data signal.
        axi_wready : out std_logic;                                                     --! AXI4-Lite Write Data signal.
        axi_wdata : in std_logic_vector(axi_data_width-1 downto 0);                     --! AXI4-Lite Write Data signal.
        axi_wstrb : in std_logic_vector(axi_data_width/8-1 downto 0);                   --! AXI4-Lite Write Data signal.
        axi_bvalid : out std_logic;                                                     --! AXI4-Lite Write Response signal.
        axi_bready : in std_logic;                                                      --! AXI4-Lite Write Response signal.
        axi_bresp : out std_logic_vector(1 downto 0);                                   --! AXI4-Lite Write Response signal.	
        -- Slave AXI4-Lite Read interface.
        axi_araddr : in std_logic_vector(axi_address_width-1 downto 0);                 --! AXI4-Lite Address Read signal.
        axi_arprot : in std_logic_vector(2 downto 0);                                   --! AXI4-Lite Address Read signal.
        axi_arvalid : in std_logic;                                                     --! AXI4-Lite Address Read signal.
        axi_arready : out std_logic;                                                    --! AXI4-Lite Address Read signal.
        axi_rdata : out std_logic_vector(axi_data_width-1 downto 0) := (others=>'0');   --! AXI4-Lite Read Data signal.
        axi_rvalid : out std_logic;                                                     --! AXI4-Lite Read Data signal.
        axi_rready : in std_logic;                                                      --! AXI4-Lite Read Data signal.
        axi_rresp : out std_logic_vector(1 downto 0);                                   --! AXI4-Lite Read Data signal.
        -- CPU interface.
        cpu_int : out std_logic;                                                        --! CPU interrupt.
        -- Device interface.
        dev_ints : in std_logic_vector(interrupt_total-1 downto 0));                    --! Device interrupts.	
end plasoc_int;

architecture Behavioral of plasoc_int is
    component plasoc_int_cntrl is
        generic (
            interrupt_total : integer := 8 );
        port (
            clock : in std_logic;
            nreset : in std_logic;
            cpu_int : out std_logic := '0';
            cpu_int_id : out std_logic_vector(clogb2(interrupt_total) downto 0) := (others=>'0');
            cpu_int_enables : in std_logic_vector(interrupt_total-1 downto 0);
            cpu_int_active : out std_logic_vector(interrupt_total-1 downto 0);
            dev_ints : in std_logic_vector(interrupt_total-1 downto 0));
    end component;
    component plasoc_int_axi4_read_cntrl is
        generic (
            axi_address_width : integer := 16;
            axi_data_width : integer := 32;
            int_id_address : std_logic_vector := X"0004";
            int_enables_address : std_logic_vector := X"0000";
            int_active_address : std_logic_vector := X"0008");
        port ( 
            aclk : in std_logic;
            aresetn : in std_logic;
            axi_araddr : in std_logic_vector(axi_address_width-1 downto 0);
            axi_arprot : in std_logic_vector(2 downto 0);
            axi_arvalid : in std_logic;
            axi_arready : out std_logic;
            axi_rdata : out std_logic_vector(axi_data_width-1 downto 0) := (others=>'0');
            axi_rvalid : out std_logic;
            axi_rready : in std_logic;
            axi_rresp : out std_logic_vector(1 downto 0);
            int_id : in std_logic_vector(axi_data_width-1 downto 0);
            int_enables : in std_logic_vector(axi_data_width-1 downto 0);
            int_active : in std_logic_vector(axi_data_width-1 downto 0));
    end component;
    component plasoc_int_axi4_write_cntrl is
        generic (
            axi_address_width : integer := 16;
            axi_data_width : integer := 32;
            int_enables_address : std_logic_vector := X"0000");
        port (
            aclk : in std_logic;
            aresetn : in std_logic;
            axi_awaddr : in std_logic_vector(axi_address_width-1 downto 0);
            axi_awprot : in std_logic_vector(2 downto 0);
            axi_awvalid : in std_logic;
            axi_awready : out std_logic;
            axi_wvalid : in std_logic;
            axi_wready : out std_logic;
            axi_wdata : in std_logic_vector(axi_data_width-1 downto 0);
            axi_wstrb : in std_logic_vector(axi_data_width/8-1 downto 0);
            axi_bvalid : out std_logic;
            axi_bready : in std_logic;
            axi_bresp : out std_logic_vector(1 downto 0);
            int_enables : out std_logic_vector(axi_data_width-1 downto 0));
    end component;
    constant axi_int_id_offset_slv : std_logic_vector := std_logic_vector(to_unsigned(axi_int_id_offset,axi_address_width));
    constant axi_int_enables_offset_slv : std_logic_vector := std_logic_vector(to_unsigned(axi_int_enables_offset,axi_address_width));
    constant axi_int_active_offset_slv : std_logic_vector := std_logic_vector(to_unsigned(axi_int_active_offset,axi_address_width));
    signal axi_awaddr_base : std_logic_vector(axi_address_width-1 downto 0);
    signal axi_araddr_base : std_logic_vector(axi_address_width-1 downto 0);
    signal int_id : std_logic_vector(axi_data_width-1 downto 0);
    signal int_enables : std_logic_vector(axi_data_width-1 downto 0);
    signal int_active : std_logic_vector(axi_data_width-1 downto 0);
begin
    axi_awaddr_base <= remove_baseFaddress(address=>axi_awaddr,base_address=>axi_base_address);
    axi_araddr_base <= remove_baseFaddress(address=>axi_araddr,base_address=>axi_base_address);
    int_id(axi_data_width-1 downto clogb2(interrupt_total)+1) <= (others=>'0');
    int_active(axi_data_width-1 downto interrupt_total) <= (others=>'0');
    
    plasoc_int_cntrl_inst :
    plasoc_int_cntrl 
        generic map (
            interrupt_total => interrupt_total )
        port map (
            clock => aclk,
            nreset => aresetn,
            cpu_int => cpu_int,
            cpu_int_id => int_id(clogb2(interrupt_total) downto 0),
            cpu_int_enables => int_enables(interrupt_total-1 downto 0),
            cpu_int_active => int_active(interrupt_total-1 downto 0),
            dev_ints => dev_ints);
            
    plasoc_int_axi4_read_cntrl_inst :
    plasoc_int_axi4_read_cntrl 
        generic map (
            axi_address_width => axi_address_width,
            axi_data_width => axi_data_width,
            int_id_address => axi_int_id_offset_slv,
            int_enables_address => axi_int_enables_offset_slv,
            int_active_address => axi_int_active_offset_slv )
        port map ( 
            aclk => aclk,
            aresetn => aresetn,
            axi_araddr => axi_araddr_base,
            axi_arprot => axi_arprot,
            axi_arvalid => axi_arvalid,
            axi_arready => axi_arready,
            axi_rdata => axi_rdata,
            axi_rvalid => axi_rvalid,
            axi_rready => axi_rready,
            axi_rresp => axi_rresp,
            int_id => int_id,
            int_enables => int_enables,
            int_active => int_active);
            
    plasoc_int_axi4_write_cntrl_inst :
    plasoc_int_axi4_write_cntrl 
        generic map (
            axi_address_width => axi_address_width,
            axi_data_width => axi_data_width,
            int_enables_address => axi_int_enables_offset_slv)
        port map (
            aclk => aclk,
            aresetn => aresetn,
            axi_awaddr => axi_awaddr_base,
            axi_awprot => axi_awprot,
            axi_awvalid => axi_awvalid,
            axi_awready => axi_awready,
            axi_wvalid => axi_wvalid,
            axi_wready => axi_wready,
            axi_wdata => axi_wdata,
            axi_wstrb => axi_wstrb,
            axi_bvalid => axi_bvalid,
            axi_bready => axi_bready,
            axi_bresp => axi_bresp,
            int_enables => int_enables);

end Behavioral;
