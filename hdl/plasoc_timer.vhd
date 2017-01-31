----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/31/2017 02:38:24 PM
-- Design Name: 
-- Module Name: plasoc_timer - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.mlitesoc_pack.all;

entity plasoc_timer is
    generic (
        -- timer parameters.
        timer_width : integer := 16;
        -- axi parameters.
        axi_address_width : integer := 16;
        axi_data_width : integer := 32;
        axi_base_address : std_logic_vector := X"0000";
        axi_control_offset : std_logic_vector := X"0000";
        axi_control_start_bit_loc : integer := 0;
        axi_control_reload_bit_loc : integer := 1;
        axi_control_ack_bit_loc : integer := 2;
        axi_control_done_bit_loc : integer := 3;
        axi_trig_value_offset : std_logic_vector := X"0004";
        axi_tick_value_offset : std_logic_vector := X"0008");
    port (
        -- global interface.
        aclk : in std_logic;
        aresetn : in std_logic;
        -- axi write interface.
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
        -- axi read interface.
        axi_araddr : in std_logic_vector(axi_address_width-1 downto 0);
        axi_arprot : in std_logic_vector(2 downto 0);
        axi_arvalid : in std_logic;
        axi_arready : out std_logic;
        axi_rdata : out std_logic_vector(axi_data_width-1 downto 0) := (others=>'0');
        axi_rvalid : out std_logic;
        axi_rready : in std_logic;
        axi_rresp : out std_logic_vector(1 downto 0);
        -- timer controller interface.
        done : out std_logic);
end plasoc_timer;

architecture Behavioral of plasoc_timer is
    component plasoc_timer_cntrl is
        generic (
            timer_width : integer := 16 );
        port (
            -- global interface.
            clock : in std_logic;
            -- timer control interface.
            start : in std_logic;
            reload : in std_logic;
            ack : in std_logic;
            done : out std_logic := '0';
            -- time data interface.
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
            -- global interface.
            clock : in std_logic;
            nreset : in std_logic;
            -- timer interface.
            start : out std_logic := '0';
            reload : out std_logic := '0';
            ack : out std_logic := '0';
            done : in std_logic;
            -- register interface.
            reg_in_valid : in std_logic;
            reg_in_control : in std_logic_vector(axi_data_width-1 downto 0);
            reg_out_control : out std_logic_vector(axi_data_width-1 downto 0) := (others=>'0'));
    end component;
    component plasoc_timer_axi4_write_cntrl is
        generic (
            -- axi parameters.
            axi_address_width : integer := 16;
            axi_data_width : integer := 32;
            -- register interface.
            reg_control_offset : std_logic_vector := X"0000";
            reg_trig_value_offset : std_logic_vector := X"0004");
        port (
            -- global interface.
            aclk : in std_logic;
            aresetn : in std_logic;
            -- axi write interface.
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
            -- register interface.
            reg_control : out std_logic_vector(axi_data_width-1 downto 0);
            reg_trig_value : out std_logic_vector(axi_data_width-1 downto 0);
            reg_valid : out std_logic := '0');
    end component;
    component plasoc_timer_axi4_read_cntrl is
        generic (
            -- axi parameters.
            axi_address_width : integer := 16;
            axi_data_width : integer := 32;
            -- register interface.
            reg_control_offset : std_logic_vector := X"0000";
            reg_trig_value_offset : std_logic_vector := X"0004";
            reg_tick_value_offset : std_logic_vector := X"0008");
        port ( 
            -- global interface.
            aclk : in std_logic;
            aresetn : in std_logic;
            -- axi read interface.
            axi_araddr : in std_logic_vector(axi_address_width-1 downto 0);
            axi_arprot : in std_logic_vector(2 downto 0);
            axi_arvalid : in std_logic;
            axi_arready : out std_logic;
            axi_rdata : out std_logic_vector(axi_data_width-1 downto 0) := (others=>'0');
            axi_rvalid : out std_logic;
            axi_rready : in std_logic;
            axi_rresp : out std_logic_vector(1 downto 0);
            -- interrupt controller interface.
            reg_control : in std_logic_vector(axi_data_width-1 downto 0);
            reg_trig_value : in std_logic_vector(axi_data_width-1 downto 0);
            reg_tick_value : in std_logic_vector(axi_data_width-1 downto 0));
    end component;
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
    signal axi_awaddr_base : std_logic_vector(axi_address_width-1 downto 0);
    signal axi_araddr_base : std_logic_vector(axi_address_width-1 downto 0);
begin
    axi_awaddr_base <= remove_baseFaddress(address=>axi_awaddr,base_address=>axi_base_address);
    axi_araddr_base <= remove_baseFaddress(address=>axi_araddr,base_address=>axi_base_address);
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
            reg_control_offset => axi_control_offset,
            reg_trig_value_offset => axi_trig_value_offset)
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
            reg_control => reg_write_control,
            reg_trig_value => reg_trig_value,
            reg_valid => reg_valid);
    -- Axi read controller.
    plasoc_timer_axi4_read_cntrl_int :
    plasoc_timer_axi4_read_cntrl 
        generic map (
            axi_address_width => axi_address_width,
            axi_data_width => axi_data_width,
            reg_control_offset => axi_control_offset,
            reg_trig_value_offset => axi_trig_value_offset,
            reg_tick_value_offset => axi_tick_value_offset)
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
            reg_control => reg_read_control,
            reg_trig_value => reg_trig_value,
            reg_tick_value => reg_tick_value);
end Behavioral;
