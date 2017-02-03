//Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
//Date        : Tue Jan 31 17:39:59 2017
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
    axi_arregion,
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
    axi_awregion,
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
    gpio_input_0,
    gpio_output,
    int_axi_araddr,
    int_axi_arprot,
    int_axi_arready,
    int_axi_arvalid,
    int_axi_awaddr,
    int_axi_awprot,
    int_axi_awready,
    int_axi_awvalid,
    int_axi_bready,
    int_axi_bresp,
    int_axi_bvalid,
    int_axi_rdata,
    int_axi_rready,
    int_axi_rresp,
    int_axi_rvalid,
    int_axi_wdata,
    int_axi_wready,
    int_axi_wstrb,
    int_axi_wvalid,
    int_gpio_input,
    ram_addr,
    ram_clk,
    ram_din,
    ram_dout,
    ram_en,
    ram_rst,
    ram_we,
    raw_clock,
    raw_nreset,
    timer_axi_araddr,
    timer_axi_arprot,
    timer_axi_arready,
    timer_axi_arvalid,
    timer_axi_awaddr,
    timer_axi_awprot,
    timer_axi_awready,
    timer_axi_awvalid,
    timer_axi_bready,
    timer_axi_bresp,
    timer_axi_bvalid,
    timer_axi_rdata,
    timer_axi_rready,
    timer_axi_rresp,
    timer_axi_rvalid,
    timer_axi_wdata,
    timer_axi_wready,
    timer_axi_wstrb,
    timer_axi_wvalid);
  output aclk;
  output [0:0]aresetn;
  input [31:0]axi_araddr;
  input [1:0]axi_arburst;
  input [3:0]axi_arcache;
  input [7:0]axi_arlen;
  input [0:0]axi_arlock;
  input [2:0]axi_arprot;
  input [3:0]axi_arqos;
  output axi_arready;
  input [3:0]axi_arregion;
  input [2:0]axi_arsize;
  input axi_arvalid;
  input [31:0]axi_awaddr;
  input [1:0]axi_awburst;
  input [3:0]axi_awcache;
  input [7:0]axi_awlen;
  input [0:0]axi_awlock;
  input [2:0]axi_awprot;
  input [3:0]axi_awqos;
  output axi_awready;
  input [3:0]axi_awregion;
  input [2:0]axi_awsize;
  input axi_awvalid;
  input axi_bready;
  output [1:0]axi_bresp;
  output axi_bvalid;
  output [31:0]axi_rdata;
  output axi_rlast;
  input axi_rready;
  output [1:0]axi_rresp;
  output axi_rvalid;
  input [31:0]axi_wdata;
  input axi_wlast;
  output axi_wready;
  input [3:0]axi_wstrb;
  input axi_wvalid;
  input [7:0]gpio_input_0;
  output [15:0]gpio_output;
  output [31:0]int_axi_araddr;
  output [2:0]int_axi_arprot;
  input int_axi_arready;
  output int_axi_arvalid;
  output [31:0]int_axi_awaddr;
  output [2:0]int_axi_awprot;
  input int_axi_awready;
  output int_axi_awvalid;
  output int_axi_bready;
  input [1:0]int_axi_bresp;
  input int_axi_bvalid;
  input [31:0]int_axi_rdata;
  output int_axi_rready;
  input [1:0]int_axi_rresp;
  input int_axi_rvalid;
  output [31:0]int_axi_wdata;
  input int_axi_wready;
  output [3:0]int_axi_wstrb;
  output int_axi_wvalid;
  output int_gpio_input;
  output [15:0]ram_addr;
  output ram_clk;
  output [31:0]ram_din;
  input [31:0]ram_dout;
  output ram_en;
  output ram_rst;
  output [3:0]ram_we;
  input raw_clock;
  input raw_nreset;
  output [31:0]timer_axi_araddr;
  output [2:0]timer_axi_arprot;
  input timer_axi_arready;
  output timer_axi_arvalid;
  output [31:0]timer_axi_awaddr;
  output [2:0]timer_axi_awprot;
  input timer_axi_awready;
  output timer_axi_awvalid;
  output timer_axi_bready;
  input [1:0]timer_axi_bresp;
  input timer_axi_bvalid;
  input [31:0]timer_axi_rdata;
  output timer_axi_rready;
  input [1:0]timer_axi_rresp;
  input timer_axi_rvalid;
  output [31:0]timer_axi_wdata;
  input timer_axi_wready;
  output [3:0]timer_axi_wstrb;
  output timer_axi_wvalid;

  wire aclk;
  wire [0:0]aresetn;
  wire [31:0]axi_araddr;
  wire [1:0]axi_arburst;
  wire [3:0]axi_arcache;
  wire [7:0]axi_arlen;
  wire [0:0]axi_arlock;
  wire [2:0]axi_arprot;
  wire [3:0]axi_arqos;
  wire axi_arready;
  wire [3:0]axi_arregion;
  wire [2:0]axi_arsize;
  wire axi_arvalid;
  wire [31:0]axi_awaddr;
  wire [1:0]axi_awburst;
  wire [3:0]axi_awcache;
  wire [7:0]axi_awlen;
  wire [0:0]axi_awlock;
  wire [2:0]axi_awprot;
  wire [3:0]axi_awqos;
  wire axi_awready;
  wire [3:0]axi_awregion;
  wire [2:0]axi_awsize;
  wire axi_awvalid;
  wire axi_bready;
  wire [1:0]axi_bresp;
  wire axi_bvalid;
  wire [31:0]axi_rdata;
  wire axi_rlast;
  wire axi_rready;
  wire [1:0]axi_rresp;
  wire axi_rvalid;
  wire [31:0]axi_wdata;
  wire axi_wlast;
  wire axi_wready;
  wire [3:0]axi_wstrb;
  wire axi_wvalid;
  wire [7:0]gpio_input_0;
  wire [15:0]gpio_output;
  wire [31:0]int_axi_araddr;
  wire [2:0]int_axi_arprot;
  wire int_axi_arready;
  wire int_axi_arvalid;
  wire [31:0]int_axi_awaddr;
  wire [2:0]int_axi_awprot;
  wire int_axi_awready;
  wire int_axi_awvalid;
  wire int_axi_bready;
  wire [1:0]int_axi_bresp;
  wire int_axi_bvalid;
  wire [31:0]int_axi_rdata;
  wire int_axi_rready;
  wire [1:0]int_axi_rresp;
  wire int_axi_rvalid;
  wire [31:0]int_axi_wdata;
  wire int_axi_wready;
  wire [3:0]int_axi_wstrb;
  wire int_axi_wvalid;
  wire int_gpio_input;
  wire [15:0]ram_addr;
  wire ram_clk;
  wire [31:0]ram_din;
  wire [31:0]ram_dout;
  wire ram_en;
  wire ram_rst;
  wire [3:0]ram_we;
  wire raw_clock;
  wire raw_nreset;
  wire [31:0]timer_axi_araddr;
  wire [2:0]timer_axi_arprot;
  wire timer_axi_arready;
  wire timer_axi_arvalid;
  wire [31:0]timer_axi_awaddr;
  wire [2:0]timer_axi_awprot;
  wire timer_axi_awready;
  wire timer_axi_awvalid;
  wire timer_axi_bready;
  wire [1:0]timer_axi_bresp;
  wire timer_axi_bvalid;
  wire [31:0]timer_axi_rdata;
  wire timer_axi_rready;
  wire [1:0]timer_axi_rresp;
  wire timer_axi_rvalid;
  wire [31:0]timer_axi_wdata;
  wire timer_axi_wready;
  wire [3:0]timer_axi_wstrb;
  wire timer_axi_wvalid;

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
        .axi_arregion(axi_arregion),
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
        .axi_awregion(axi_awregion),
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
        .gpio_input_0(gpio_input_0),
        .gpio_output(gpio_output),
        .int_axi_araddr(int_axi_araddr),
        .int_axi_arprot(int_axi_arprot),
        .int_axi_arready(int_axi_arready),
        .int_axi_arvalid(int_axi_arvalid),
        .int_axi_awaddr(int_axi_awaddr),
        .int_axi_awprot(int_axi_awprot),
        .int_axi_awready(int_axi_awready),
        .int_axi_awvalid(int_axi_awvalid),
        .int_axi_bready(int_axi_bready),
        .int_axi_bresp(int_axi_bresp),
        .int_axi_bvalid(int_axi_bvalid),
        .int_axi_rdata(int_axi_rdata),
        .int_axi_rready(int_axi_rready),
        .int_axi_rresp(int_axi_rresp),
        .int_axi_rvalid(int_axi_rvalid),
        .int_axi_wdata(int_axi_wdata),
        .int_axi_wready(int_axi_wready),
        .int_axi_wstrb(int_axi_wstrb),
        .int_axi_wvalid(int_axi_wvalid),
        .int_gpio_input(int_gpio_input),
        .ram_addr(ram_addr),
        .ram_clk(ram_clk),
        .ram_din(ram_din),
        .ram_dout(ram_dout),
        .ram_en(ram_en),
        .ram_rst(ram_rst),
        .ram_we(ram_we),
        .raw_clock(raw_clock),
        .raw_nreset(raw_nreset),
        .timer_axi_araddr(timer_axi_araddr),
        .timer_axi_arprot(timer_axi_arprot),
        .timer_axi_arready(timer_axi_arready),
        .timer_axi_arvalid(timer_axi_arvalid),
        .timer_axi_awaddr(timer_axi_awaddr),
        .timer_axi_awprot(timer_axi_awprot),
        .timer_axi_awready(timer_axi_awready),
        .timer_axi_awvalid(timer_axi_awvalid),
        .timer_axi_bready(timer_axi_bready),
        .timer_axi_bresp(timer_axi_bresp),
        .timer_axi_bvalid(timer_axi_bvalid),
        .timer_axi_rdata(timer_axi_rdata),
        .timer_axi_rready(timer_axi_rready),
        .timer_axi_rresp(timer_axi_rresp),
        .timer_axi_rvalid(timer_axi_rvalid),
        .timer_axi_wdata(timer_axi_wdata),
        .timer_axi_wready(timer_axi_wready),
        .timer_axi_wstrb(timer_axi_wstrb),
        .timer_axi_wvalid(timer_axi_wvalid));
endmodule
