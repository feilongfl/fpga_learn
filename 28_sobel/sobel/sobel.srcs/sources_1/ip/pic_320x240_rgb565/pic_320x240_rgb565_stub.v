// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Tue Aug 21 10:08:49 2018
// Host        : DESKTOP-B3SJCBK running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/fpga/28_sobel/sobel/sobel.srcs/sources_1/ip/pic_320x240_rgb565/pic_320x240_rgb565_stub.v
// Design      : pic_320x240_rgb565
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tfgg484-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_1,Vivado 2018.2" *)
module pic_320x240_rgb565(clka, wea, addra, dina, clkb, addrb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,wea[0:0],addra[17:0],dina[7:0],clkb,addrb[16:0],doutb[15:0]" */;
  input clka;
  input [0:0]wea;
  input [17:0]addra;
  input [7:0]dina;
  input clkb;
  input [16:0]addrb;
  output [15:0]doutb;
endmodule
