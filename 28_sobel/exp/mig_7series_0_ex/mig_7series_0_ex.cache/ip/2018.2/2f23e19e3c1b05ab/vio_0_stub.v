// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Tue Aug 21 09:43:59 2018
// Host        : DESKTOP-B3SJCBK running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ vio_0_stub.v
// Design      : vio_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tfgg484-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "vio,Vivado 2018.2" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(clk, probe_out0, probe_out1, probe_out2, 
  probe_out3, probe_out4, probe_out5, probe_out6, probe_out7, probe_out8, probe_out9)
/* synthesis syn_black_box black_box_pad_pin="clk,probe_out0[0:0],probe_out1[3:0],probe_out2[2:0],probe_out3[3:0],probe_out4[1:0],probe_out5[7:0],probe_out6[0:0],probe_out7[0:0],probe_out8[2:0],probe_out9[0:0]" */;
  input clk;
  output [0:0]probe_out0;
  output [3:0]probe_out1;
  output [2:0]probe_out2;
  output [3:0]probe_out3;
  output [1:0]probe_out4;
  output [7:0]probe_out5;
  output [0:0]probe_out6;
  output [0:0]probe_out7;
  output [2:0]probe_out8;
  output [0:0]probe_out9;
endmodule
