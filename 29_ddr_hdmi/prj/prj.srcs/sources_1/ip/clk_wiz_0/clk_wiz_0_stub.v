// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Wed Aug 22 18:09:43 2018
// Host        : DESKTOP-B3SJCBK running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/fpga/29_ddr_hdmi/prj/prj.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_stub.v
// Design      : clk_wiz_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tfgg484-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_wiz_0(clk_200m, clk_500m, clk_hdmi, clk_hdmi_5x, reset, 
  locked, clk_50m)
/* synthesis syn_black_box black_box_pad_pin="clk_200m,clk_500m,clk_hdmi,clk_hdmi_5x,reset,locked,clk_50m" */;
  output clk_200m;
  output clk_500m;
  output clk_hdmi;
  output clk_hdmi_5x;
  input reset;
  output locked;
  input clk_50m;
endmodule
