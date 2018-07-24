// Copyright (C) 2018  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions
// and other software and tools, and its AMPP partner logic
// functions, and any output files from any of the foregoing
// (including device programming or simulation files), and any
// associated documentation or information are expressly subject
// to the terms and conditions of the Intel Program License
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 18.0.0 Build 614 04/24/2018 SJ Standard Edition"
// CREATED		"Tue Jul 24 17:27:22 2018"

module uart(
           rx,
           sclk
       );


input wire	rx;
input wire	sclk;

wire	[3:0] state;
wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;





divclk	b2v_inst(
           .clk_in(sclk),
           .en(SYNTHESIZED_WIRE_0),
           .clk_out(SYNTHESIZED_WIRE_1));
defparam	b2v_inst.DIV_COUNT = 10;


sm	b2v_inst2(
       .clk(SYNTHESIZED_WIRE_1),
       .rx(SYNTHESIZED_WIRE_2),
       .state(state));
defparam	b2v_inst2.DATA_LENGTH = 8;


fifo	b2v_inst3(
         .clk(sclk),
         .indata(rx),
         .outdata(SYNTHESIZED_WIRE_2));

assign	SYNTHESIZED_WIRE_0 = state[2] | state[3] | state[1];


endmodule
