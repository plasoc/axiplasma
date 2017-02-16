-------------------------------------------------------
--! @author Andrew Powell
--! @date January 31, 2017
--! @brief Contains the entity and architecture of the 
--! Plasma-SoC's Timer Core.
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
use work.plasoc_timer_pack.all;

--! The Timer Core is developed so that the Plasma-SoC can
--! perform operations reactively to deterministic periods of time. This
--! operation is especially critical in order to run an operating
--! system preemptively. The only goals behind the development of the 
--! Timer Core are simplicity and having a Slave AXI4-Lite interface.
--!
--! The operation of the Timer Core is as follows. The address space of the 
--! Timer Core defines the registers Control, Trigger Value, and Tick Value. 
--! Before starting the Timer Core's operation, the value written to the 
--! Trigger Value sets the value at which the Tick Value must reach. Setting the
--! Start bit in the Control register starts the operation of the Timer Core, 
--! during which the Tick Value increments every clock cycle until it reaches the Trigger Value.
--! Once the Tick Value equals the Trigger Value, the Done bit and signal is set 
--! high until either the Acknowledge bit is set high or the Start bit is set low.
--! The Acknowledge bit is found in the Control register.
--!
--! If the Reload bit is set high, the Tick Value will reset itself back to zero
--! on the clock cycle after reaching the Trigger Value. The Reload bit is found in
--! the Control register. Both the Done bit and the Tick Value register will remain
--! zero if the Start bit is low.
--!
--! Information specific to the AXI4-Full
--! protocol is excluded from this documentation since the information can
--! be found in official ARM AMBA4 AXI documentation. 
entity plasoc_timer is
    generic (
        -- Timer Core's parameters.
        timer_width : integer := 32;                            --! Defines the width of the Trigger and Tick Value registers.
        -- Slave AXI4-Lite parameters.
        axi_address_width : integer := 16;                      --! Defines the AXI4-Lite Address Width.
        axi_data_width : integer := 32;                         --! Defines the AXI4-Lite Data Width.	
        axi_control_offset : integer := 0;                      --! For the Control register, defines the offset from axi_base_address.
        axi_control_start_bit_loc : integer := 0;               --! For the Start bit, defines the bit location in the Control register.
        axi_control_reload_bit_loc : integer := 1;              --! For the Reload bit, defines the bit location in the Control register.
        axi_control_ack_bit_loc : integer := 2;                 --! For the Acknowledge bit, defines the bit location in the Control register.
        axi_control_done_bit_loc : integer := 3;                --! For the Done bit, defines the bit location in the Control register.
        axi_trig_value_offset : integer := 4;                   --! For the Trigger Value register, defines the offset from axi_base_address.
        axi_tick_value_offset : integer := 8                    --! For the Tick Value register, defines the offset from axi_base_address.
	);
    port (
        -- Global interface.
        aclk : in std_logic;                                    --! Defines the AXI4-Lite Address Width.
        aresetn : in std_logic;                                 --! Reset on low.
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
        -- Timer Core interface.
        done : out std_logic                                                            --! Done signal.
	);
end plasoc_timer;

architecture Behavioral of plasoc_timer is
	-- Component declaration.
    component plasoc_timer_cntrl is
        generic (
            timer_width : integer := 16 );
        port (
            clock : in std_logic;
            start : in std_logic;
            reload : in std_logic;
            ack : in std_logic;
            done : out std_logic := '0';
            trig_value : in std_logic_vector(timer_width-1 downto 0);
            tick_value : out std_logic_vector(timer_width-1 downto 0));
    end component;
    component plasoc_timer_control_bridge is
        generic (
            axi_data_width : integer := 32;
            timer_width : integer := 16;
            start_bit_loc : integer := 0;
            reload_bit_loc : integer := 1;
            ack_bit_loc : integer := 2;
            done_bit_loc : integer := 3); 
        port (
            clock : in std_logic;
            nreset : in std_logic;
            start : out std_logic := '0';
            reload : out std_logic := '0';
            ack : out std_logic := '0';
            done : in std_logic;
            reg_in_valid : in std_logic;
            reg_in_control : in std_logic_vector(axi_data_width-1 downto 0);
            reg_out_control : out std_logic_vector(axi_data_width-1 downto 0) := (others=>'0'));
    end component;
    component plasoc_timer_axi4_write_cntrl is
        generic (
            axi_address_width : integer := 16;
            axi_data_width : integer := 32;
            reg_control_offset : std_logic_vector := X"0000";
            reg_trig_value_offset : std_logic_vector := X"0004");
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
            reg_control : out std_logic_vector(axi_data_width-1 downto 0);
            reg_trig_value : out std_logic_vector(axi_data_width-1 downto 0);
            reg_valid : out std_logic := '0');
    end component;
    component plasoc_timer_axi4_read_cntrl is
        generic (
            axi_address_width : integer := 16;
            axi_data_width : integer := 32;
            reg_control_offset : std_logic_vector := X"0000";
            reg_trig_value_offset : std_logic_vector := X"0004";
            reg_tick_value_offset : std_logic_vector := X"0008");
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
            reg_control : in std_logic_vector(axi_data_width-1 downto 0);
            reg_trig_value : in std_logic_vector(axi_data_width-1 downto 0);
            reg_tick_value : in std_logic_vector(axi_data_width-1 downto 0));
    end component;
    -- constant declarations.
    constant axi_control_offset_slv : std_logic_vector := std_logic_vector(to_unsigned(axi_control_offset,axi_address_width));
    constant axi_trig_value_offset_slv : std_logic_vector := std_logic_vector(to_unsigned(axi_trig_value_offset,axi_address_width));
    constant axi_tick_value_offset_slv : std_logic_vector := std_logic_vector(to_unsigned(axi_tick_value_offset,axi_address_width));
    -- signal declarations.
    signal start : std_logic;
    signal reload : std_logic;
    signal ack : std_logic;
    signal done_buff : std_logic;
    signal reg_valid : std_logic;
    signal reg_write_control : std_logic_vector(axi_data_width-1 downto 0);
    signal reg_read_control : std_logic_vector(axi_data_width-1 downto 0);
    signal reg_trig_value : std_logic_vector(axi_data_width-1 downto 0);
    signal reg_tick_value : std_logic_vector(axi_data_width-1 downto 0);
begin
    done <= done_buff;
    -- Timer controller instantiation.
    plasoc_timer_cntrl_inst :
    plasoc_timer_cntrl
        generic map (
            timer_width => timer_width )
        port map (
            clock => aclk,
            start => start,
            reload => reload,
            ack => ack,
            done => done_buff,
            trig_value => reg_trig_value(timer_width-1 downto 0),
            tick_value => reg_tick_value(timer_width-1 downto 0));
    -- Timer control Bridge instantiation.
    plasoc_timer_control_bridge_inst :
    plasoc_timer_control_bridge
        generic map (
            axi_data_width => axi_data_width,
            timer_width => timer_width,
            start_bit_loc => axi_control_start_bit_loc,
            reload_bit_loc => axi_control_reload_bit_loc,
            ack_bit_loc => axi_control_ack_bit_loc,
            done_bit_loc => axi_control_done_bit_loc)
        port map (
            clock => aclk,
            nreset => aresetn,
            start => start,
            reload => reload,
            ack => ack,
            done => done_buff,
            reg_in_valid => reg_valid,
            reg_in_control => reg_write_control,
            reg_out_control => reg_read_control);
    -- Axi write controller.
    plasoc_timer_axi4_write_cntrl_inst : 
    plasoc_timer_axi4_write_cntrl 
        generic map (
            axi_address_width => axi_address_width,
            axi_data_width => axi_data_width,
            reg_control_offset => axi_control_offset_slv,
            reg_trig_value_offset => axi_trig_value_offset_slv)
        port map (
            aclk => aclk,
            aresetn => aresetn,
            axi_awaddr => axi_awaddr,
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
            reg_control => reg_write_control,
            reg_trig_value => reg_trig_value,
            reg_valid => reg_valid);
    -- Axi read controller.
    plasoc_timer_axi4_read_cntrl_int :
    plasoc_timer_axi4_read_cntrl 
        generic map (
            axi_address_width => axi_address_width,
            axi_data_width => axi_data_width,
            reg_control_offset => axi_control_offset_slv,
            reg_trig_value_offset => axi_trig_value_offset_slv,
            reg_tick_value_offset => axi_tick_value_offset_slv)
        port map ( 
            aclk => aclk,
            aresetn => aresetn,
            axi_araddr => axi_araddr,
            axi_arprot => axi_arprot,
            axi_arvalid => axi_arvalid,
            axi_arready => axi_arready,
            axi_rdata => axi_rdata,
            axi_rvalid => axi_rvalid,
            axi_rready => axi_rready,
            axi_rresp => axi_rresp,
            reg_control => reg_read_control,
            reg_trig_value => reg_trig_value,
            reg_tick_value => reg_tick_value);
end Behavioral;
