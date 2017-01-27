//Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
//Date        : Thu Jan 26 19:15:17 2017
//Host        : LAPTOP-IQ9G3D1I running 64-bit major release  (build 9200)
//Command     : generate_target ip_block_design_wrapper.bd
//Design      : ip_block_design_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module ip_block_design_wrapper
   (aclk,
    aresetn,
    axi_araddr,
    axi_arburst,
    axi_arcache,
    axi_arlen,
    axi_arlock,
    axi_arprot,
    axi_arqos,
    axi_arready,
    axi_arsize,
    axi_arvalid,
    axi_awaddr,
    axi_awburst,
    axi_awcache,
    axi_awlen,
    axi_awlock,
    axi_awprot,
    axi_awqos,
    axi_awready,
    axi_awsize,
    axi_awvalid,
    axi_bready,
    axi_bresp,
    axi_bvalid,
    axi_rdata,
    axi_rlast,
    axi_rready,
    axi_rresp,
    axi_rvalid,
    axi_wdata,
    axi_wlast,
    axi_wready,
    axi_wstrb,
    axi_wvalid,
    gpio_input,
    gpio_output,
    ram_addr,
    ram_clk,
    ram_din,
    ram_dout,
    ram_en,
    ram_rst,
    ram_we,
    raw_clock,
    raw_nreset);
  output aclk;
  output [0:0]aresetn;
  input [31:0]axi_araddr;
  input [1:0]axi_arburst;
  input [3:0]axi_arcache;
  input [7:0]axi_arlen;
  input [0:0]axi_arlock;
  input [2:0]axi_arprot;
  input [3:0]axi_arqos;
  output [0:0]axi_arready;
  input [2:0]axi_arsize;
  input [0:0]axi_arvalid;
  input [31:0]axi_awaddr;
  input [1:0]axi_awburst;
  input [3:0]axi_awcache;
  input [7:0]axi_awlen;
  input [0:0]axi_awlock;
  input [2:0]axi_awprot;
  input [3:0]axi_awqos;
  output [0:0]axi_awready;
  input [2:0]axi_awsize;
  input [0:0]axi_awvalid;
  input [0:0]axi_bready;
  output [1:0]axi_bresp;
  output [0:0]axi_bvalid;
  output [31:0]axi_rdata;
  output [0:0]axi_rlast;
  input [0:0]axi_rready;
  output [1:0]axi_rresp;
  output [0:0]axi_rvalid;
  input [31:0]axi_wdata;
  input [0:0]axi_wlast;
  output [0:0]axi_wready;
  input [3:0]axi_wstrb;
  input [0:0]axi_wvalid;
  input [7:0]gpio_input;
  output [7:0]gpio_output;
  output [15:0]ram_addr;
  output ram_clk;
  output [31:0]ram_din;
  input [31:0]ram_dout;
  output ram_en;
  output ram_rst;
  output [3:0]ram_we;
  input raw_clock;
  input raw_nreset;

  wire aclk;
  wire [0:0]aresetn;
  wire [31:0]axi_araddr;
  wire [1:0]axi_arburst;
  wire [3:0]axi_arcache;
  wire [7:0]axi_arlen;
  wire [0:0]axi_arlock;
  wire [2:0]axi_arprot;
  wire [3:0]axi_arqos;
  wire [0:0]axi_arready;
  wire [2:0]axi_arsize;
  wire [0:0]axi_arvalid;
  wire [31:0]axi_awaddr;
  wire [1:0]axi_awburst;
  wire [3:0]axi_awcache;
  wire [7:0]axi_awlen;
  wire [0:0]axi_awlock;
  wire [2:0]axi_awprot;
  wire [3:0]axi_awqos;
  wire [0:0]axi_awready;
  wire [2:0]axi_awsize;
  wire [0:0]axi_awvalid;
  wire [0:0]axi_bready;
  wire [1:0]axi_bresp;
  wire [0:0]axi_bvalid;
  wire [31:0]axi_rdata;
  wire [0:0]axi_rlast;
  wire [0:0]axi_rready;
  wire [1:0]axi_rresp;
  wire [0:0]axi_rvalid;
  wire [31:0]axi_wdata;
  wire [0:0]axi_wlast;
  wire [0:0]axi_wready;
  wire [3:0]axi_wstrb;
  wire [0:0]axi_wvalid;
  wire [7:0]gpio_input;
  wire [7:0]gpio_output;
  wire [15:0]ram_addr;
  wire ram_clk;
  wire [31:0]ram_din;
  wire [31:0]ram_dout;
  wire ram_en;
  wire ram_rst;
  wire [3:0]ram_we;
  wire raw_clock;
  wire raw_nreset;

  ip_block_design ip_block_design_i
       (.aclk(aclk),
        .aresetn(aresetn),
        .axi_araddr(axi_araddr),
        .axi_arburst(axi_arburst),
        .axi_arcache(axi_arcache),
        .axi_arlen(axi_arlen),
        .axi_arlock(axi_arlock),
        .axi_arprot(axi_arprot),
        .axi_arqos(axi_arqos),
        .axi_arready(axi_arready),
        .axi_arsize(axi_arsize),
        .axi_arvalid(axi_arvalid),
        .axi_awaddr(axi_awaddr),
        .axi_awburst(axi_awburst),
        .axi_awcache(axi_awcache),
        .axi_awlen(axi_awlen),
        .axi_awlock(axi_awlock),
        .axi_awprot(axi_awprot),
        .axi_awqos(axi_awqos),
        .axi_awready(axi_awready),
        .axi_awsize(axi_awsize),
        .axi_awvalid(axi_awvalid),
        .axi_bready(axi_bready),
        .axi_bresp(axi_bresp),
        .axi_bvalid(axi_bvalid),
        .axi_rdata(axi_rdata),
        .axi_rlast(axi_rlast),
        .axi_rready(axi_rready),
        .axi_rresp(axi_rresp),
        .axi_rvalid(axi_rvalid),
        .axi_wdata(axi_wdata),
        .axi_wlast(axi_wlast),
        .axi_wready(axi_wready),
        .axi_wstrb(axi_wstrb),
        .axi_wvalid(axi_wvalid),
        .gpio_input(gpio_input),
        .gpio_output(gpio_output),
        .ram_addr(ram_addr),
        .ram_clk(ram_clk),
        .ram_din(ram_din),
        .ram_dout(ram_dout),
        .ram_en(ram_en),
        .ram_rst(ram_rst),
        .ram_we(ram_we),
        .raw_clock(raw_clock),
        .raw_nreset(raw_nreset));
endmodule
