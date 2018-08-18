// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
// Date        : Mon Aug 13 10:47:55 2018
// Host        : feilong-pc running 64-bit Manjaro Linux
// Command     : write_verilog -force -mode synth_stub
//               /home/feilong/Storages/fpga/25_uart_send_pic_to_hdmi/project/project.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_stub.v
// Design      : clk_wiz_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tfgg484-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_wiz_0(clk_25m, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_25m,clk_in1" */;
  output clk_25m;
  input clk_in1;
endmodule