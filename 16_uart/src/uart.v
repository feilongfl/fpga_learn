// Copyright (C) 1991-2013 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, Altera MegaCore Function License 
// Agreement, or other applicable license agreement, including, 
// without limitation, that your use is for the sole purpose of 
// programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the 
// applicable agreement for further details.

// PROGRAM		"Quartus II 64-Bit"
// VERSION		"Version 13.1.0 Build 162 10/23/2013 SJ Web Edition"
// CREATED		"Mon Jul 23 11:20:52 2018"

module uart(
	sclk,
	rx,
	data
);


input wire	sclk;
input wire	rx;
output wire	[7:0] data;

wire	[3:0] state;
wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_3;





clock	b2v_inst(
	.clk(sclk),
	.en(SYNTHESIZED_WIRE_0),
	.oclk(SYNTHESIZED_WIRE_3));
	defparam	b2v_inst.clock_max = 5207;


uart_state	b2v_inst1(
	.rx(rx),
	.clk(SYNTHESIZED_WIRE_3),
	.state(state));
	defparam	b2v_inst1.DATA_BYTE_LENGTH = 8;

assign	SYNTHESIZED_WIRE_0 = state[2] | state[1];


recode	b2v_inst4(
	.clk(SYNTHESIZED_WIRE_3),
	.en(state[2]),
	.rx(rx),
	.data(data));


endmodule
