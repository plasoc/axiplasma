--Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2016.2 (lin64) Build 1577090 Thu Jun  2 16:32:35 MDT 2016
--Date        : Fri Feb  3 09:31:28 2017
--Host        : andrewandrepowell2-desktop running 64-bit Ubuntu 16.04 LTS
--Command     : generate_target ip_block_design_wrapper.bd
--Design      : ip_block_design_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ip_block_design_wrapper is
  port (
    aclk : in STD_LOGIC;
    aresetn : out STD_LOGIC_VECTOR ( 0 to 0 );
    axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    axi_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    axi_arlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    axi_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_arready : out STD_LOGIC;
    axi_arregion : in STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    axi_arvalid : in STD_LOGIC;
    axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    axi_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    axi_awlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    axi_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_awready : out STD_LOGIC;
    axi_awregion : in STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    axi_awvalid : in STD_LOGIC;
    axi_bready : in STD_LOGIC;
    axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    axi_bvalid : out STD_LOGIC;
    axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    axi_rlast : out STD_LOGIC;
    axi_rready : in STD_LOGIC;
    axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    axi_rvalid : out STD_LOGIC;
    axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    axi_wlast : in STD_LOGIC;
    axi_wready : out STD_LOGIC;
    axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_wvalid : in STD_LOGIC;
    dcm_locked : in STD_LOGIC;
    gpio_input : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gpio_output : out STD_LOGIC_VECTOR ( 3 downto 0 );
    int_axi_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    int_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    int_axi_arready : in STD_LOGIC;
    int_axi_arvalid : out STD_LOGIC;
    int_axi_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    int_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    int_axi_awready : in STD_LOGIC;
    int_axi_awvalid : out STD_LOGIC;
    int_axi_bready : out STD_LOGIC;
    int_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    int_axi_bvalid : in STD_LOGIC;
    int_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    int_axi_rready : out STD_LOGIC;
    int_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    int_axi_rvalid : in STD_LOGIC;
    int_axi_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    int_axi_wready : in STD_LOGIC;
    int_axi_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    int_axi_wvalid : out STD_LOGIC;
    int_gpio_input : out STD_LOGIC;
    ram_addr : out STD_LOGIC_VECTOR ( 15 downto 0 );
    ram_clk : out STD_LOGIC;
    ram_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ram_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    ram_en : out STD_LOGIC;
    ram_rst : out STD_LOGIC;
    ram_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    raw_nreset : in STD_LOGIC;
    timer_axi_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    timer_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    timer_axi_arready : in STD_LOGIC;
    timer_axi_arvalid : out STD_LOGIC;
    timer_axi_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    timer_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    timer_axi_awready : in STD_LOGIC;
    timer_axi_awvalid : out STD_LOGIC;
    timer_axi_bready : out STD_LOGIC;
    timer_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    timer_axi_bvalid : in STD_LOGIC;
    timer_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    timer_axi_rready : out STD_LOGIC;
    timer_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    timer_axi_rvalid : in STD_LOGIC;
    timer_axi_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    timer_axi_wready : in STD_LOGIC;
    timer_axi_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    timer_axi_wvalid : out STD_LOGIC
  );
end ip_block_design_wrapper;

architecture STRUCTURE of ip_block_design_wrapper is
  component ip_block_design is
  port (
    ram_addr : out STD_LOGIC_VECTOR ( 15 downto 0 );
    ram_clk : out STD_LOGIC;
    ram_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ram_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    ram_en : out STD_LOGIC;
    ram_rst : out STD_LOGIC;
    ram_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    int_axi_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    int_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    int_axi_awvalid : out STD_LOGIC;
    int_axi_awready : in STD_LOGIC;
    int_axi_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    int_axi_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    int_axi_wvalid : out STD_LOGIC;
    int_axi_wready : in STD_LOGIC;
    int_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    int_axi_bvalid : in STD_LOGIC;
    int_axi_bready : out STD_LOGIC;
    int_axi_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    int_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    int_axi_arvalid : out STD_LOGIC;
    int_axi_arready : in STD_LOGIC;
    int_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    int_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    int_axi_rvalid : in STD_LOGIC;
    int_axi_rready : out STD_LOGIC;
    timer_axi_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    timer_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    timer_axi_awvalid : out STD_LOGIC;
    timer_axi_awready : in STD_LOGIC;
    timer_axi_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    timer_axi_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    timer_axi_wvalid : out STD_LOGIC;
    timer_axi_wready : in STD_LOGIC;
    timer_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    timer_axi_bvalid : in STD_LOGIC;
    timer_axi_bready : out STD_LOGIC;
    timer_axi_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    timer_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    timer_axi_arvalid : out STD_LOGIC;
    timer_axi_arready : in STD_LOGIC;
    timer_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    timer_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    timer_axi_rvalid : in STD_LOGIC;
    timer_axi_rready : out STD_LOGIC;
    gpio_output : out STD_LOGIC_VECTOR ( 3 downto 0 );
    aresetn : out STD_LOGIC_VECTOR ( 0 to 0 );
    int_gpio_input : out STD_LOGIC;
    axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    axi_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    axi_awlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    axi_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    axi_awregion : in STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_awvalid : in STD_LOGIC;
    axi_awready : out STD_LOGIC;
    axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_wlast : in STD_LOGIC;
    axi_wvalid : in STD_LOGIC;
    axi_wready : out STD_LOGIC;
    axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    axi_bvalid : out STD_LOGIC;
    axi_bready : in STD_LOGIC;
    axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    axi_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    axi_arlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    axi_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    axi_arregion : in STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_arvalid : in STD_LOGIC;
    axi_arready : out STD_LOGIC;
    axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    axi_rlast : out STD_LOGIC;
    axi_rvalid : out STD_LOGIC;
    axi_rready : in STD_LOGIC;
    raw_nreset : in STD_LOGIC;
    gpio_input : in STD_LOGIC_VECTOR ( 3 downto 0 );
    aclk : in STD_LOGIC;
    dcm_locked : in STD_LOGIC
  );
  end component ip_block_design;
begin
ip_block_design_i: component ip_block_design
     port map (
      aclk => aclk,
      aresetn(0) => aresetn(0),
      axi_araddr(31 downto 0) => axi_araddr(31 downto 0),
      axi_arburst(1 downto 0) => axi_arburst(1 downto 0),
      axi_arcache(3 downto 0) => axi_arcache(3 downto 0),
      axi_arlen(7 downto 0) => axi_arlen(7 downto 0),
      axi_arlock(0) => axi_arlock(0),
      axi_arprot(2 downto 0) => axi_arprot(2 downto 0),
      axi_arqos(3 downto 0) => axi_arqos(3 downto 0),
      axi_arready => axi_arready,
      axi_arregion(3 downto 0) => axi_arregion(3 downto 0),
      axi_arsize(2 downto 0) => axi_arsize(2 downto 0),
      axi_arvalid => axi_arvalid,
      axi_awaddr(31 downto 0) => axi_awaddr(31 downto 0),
      axi_awburst(1 downto 0) => axi_awburst(1 downto 0),
      axi_awcache(3 downto 0) => axi_awcache(3 downto 0),
      axi_awlen(7 downto 0) => axi_awlen(7 downto 0),
      axi_awlock(0) => axi_awlock(0),
      axi_awprot(2 downto 0) => axi_awprot(2 downto 0),
      axi_awqos(3 downto 0) => axi_awqos(3 downto 0),
      axi_awready => axi_awready,
      axi_awregion(3 downto 0) => axi_awregion(3 downto 0),
      axi_awsize(2 downto 0) => axi_awsize(2 downto 0),
      axi_awvalid => axi_awvalid,
      axi_bready => axi_bready,
      axi_bresp(1 downto 0) => axi_bresp(1 downto 0),
      axi_bvalid => axi_bvalid,
      axi_rdata(31 downto 0) => axi_rdata(31 downto 0),
      axi_rlast => axi_rlast,
      axi_rready => axi_rready,
      axi_rresp(1 downto 0) => axi_rresp(1 downto 0),
      axi_rvalid => axi_rvalid,
      axi_wdata(31 downto 0) => axi_wdata(31 downto 0),
      axi_wlast => axi_wlast,
      axi_wready => axi_wready,
      axi_wstrb(3 downto 0) => axi_wstrb(3 downto 0),
      axi_wvalid => axi_wvalid,
      dcm_locked => dcm_locked,
      gpio_input(3 downto 0) => gpio_input(3 downto 0),
      gpio_output(3 downto 0) => gpio_output(3 downto 0),
      int_axi_araddr(31 downto 0) => int_axi_araddr(31 downto 0),
      int_axi_arprot(2 downto 0) => int_axi_arprot(2 downto 0),
      int_axi_arready => int_axi_arready,
      int_axi_arvalid => int_axi_arvalid,
      int_axi_awaddr(31 downto 0) => int_axi_awaddr(31 downto 0),
      int_axi_awprot(2 downto 0) => int_axi_awprot(2 downto 0),
      int_axi_awready => int_axi_awready,
      int_axi_awvalid => int_axi_awvalid,
      int_axi_bready => int_axi_bready,
      int_axi_bresp(1 downto 0) => int_axi_bresp(1 downto 0),
      int_axi_bvalid => int_axi_bvalid,
      int_axi_rdata(31 downto 0) => int_axi_rdata(31 downto 0),
      int_axi_rready => int_axi_rready,
      int_axi_rresp(1 downto 0) => int_axi_rresp(1 downto 0),
      int_axi_rvalid => int_axi_rvalid,
      int_axi_wdata(31 downto 0) => int_axi_wdata(31 downto 0),
      int_axi_wready => int_axi_wready,
      int_axi_wstrb(3 downto 0) => int_axi_wstrb(3 downto 0),
      int_axi_wvalid => int_axi_wvalid,
      int_gpio_input => int_gpio_input,
      ram_addr(15 downto 0) => ram_addr(15 downto 0),
      ram_clk => ram_clk,
      ram_din(31 downto 0) => ram_din(31 downto 0),
      ram_dout(31 downto 0) => ram_dout(31 downto 0),
      ram_en => ram_en,
      ram_rst => ram_rst,
      ram_we(3 downto 0) => ram_we(3 downto 0),
      raw_nreset => raw_nreset,
      timer_axi_araddr(31 downto 0) => timer_axi_araddr(31 downto 0),
      timer_axi_arprot(2 downto 0) => timer_axi_arprot(2 downto 0),
      timer_axi_arready => timer_axi_arready,
      timer_axi_arvalid => timer_axi_arvalid,
      timer_axi_awaddr(31 downto 0) => timer_axi_awaddr(31 downto 0),
      timer_axi_awprot(2 downto 0) => timer_axi_awprot(2 downto 0),
      timer_axi_awready => timer_axi_awready,
      timer_axi_awvalid => timer_axi_awvalid,
      timer_axi_bready => timer_axi_bready,
      timer_axi_bresp(1 downto 0) => timer_axi_bresp(1 downto 0),
      timer_axi_bvalid => timer_axi_bvalid,
      timer_axi_rdata(31 downto 0) => timer_axi_rdata(31 downto 0),
      timer_axi_rready => timer_axi_rready,
      timer_axi_rresp(1 downto 0) => timer_axi_rresp(1 downto 0),
      timer_axi_rvalid => timer_axi_rvalid,
      timer_axi_wdata(31 downto 0) => timer_axi_wdata(31 downto 0),
      timer_axi_wready => timer_axi_wready,
      timer_axi_wstrb(3 downto 0) => timer_axi_wstrb(3 downto 0),
      timer_axi_wvalid => timer_axi_wvalid
    );
end STRUCTURE;
