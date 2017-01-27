// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (lin64) Build 1577090 Thu Jun  2 16:32:35 MDT 2016
// Date        : Thu Jan 26 23:12:58 2017
// Host        : andrewandrepowell2-desktop running 64-bit Ubuntu 16.04 LTS
// Command     : write_verilog -force -mode synth_stub
//               /opt/Xilinx/Projects/koc/axiplasma/hdl/testbenches/vivado_2/ip_block_design/ip/ip_block_design_clk_wiz_0_0/ip_block_design_clk_wiz_0_0_stub.v
// Design      : ip_block_design_clk_wiz_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module ip_block_design_clk_wiz_0_0(clk_in1, clk_out1, resetn, locked)
/* synthesis syn_black_box black_box_pad_pin="clk_in1,clk_out1,resetn,locked" */;
  input clk_in1;
  output clk_out1;
  input resetn;
  output locked;
endmodule
