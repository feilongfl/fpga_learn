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
// CREATED		"Mon Jul 23 17:35:59 2018"

module uart(
	sclk,
	rx,
	tx,
	data
);


input wire	sclk;
input wire	rx;
output wire	tx;
output wire	[7:0] data;

wire	[3:0] state;
wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_7;
wire	[7:0] SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_4;
wire	[7:0] SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;

assign	data = SYNTHESIZED_WIRE_5;




clock	b2v_inst(
	.clk(sclk),
	.en(SYNTHESIZED_WIRE_0),
	.oclk(SYNTHESIZED_WIRE_7));
	defparam	b2v_inst.clock_max = 5207;


uart_state	b2v_inst1(
	.rx(rx),
	.clk(SYNTHESIZED_WIRE_7),
	.state(state));
	defparam	b2v_inst1.DATA_BYTE_LENGTH = 8;

assign	SYNTHESIZED_WIRE_0 = state[2] | state[3] | state[1];


datasaver	b2v_inst3(
	.saveflag(state[3]),
	.data_i(SYNTHESIZED_WIRE_2),
	.data_o(SYNTHESIZED_WIRE_5));


recode	b2v_inst4(
	.clk(SYNTHESIZED_WIRE_7),
	.en(state[2]),
	.rx(rx),
	.data(SYNTHESIZED_WIRE_2));


send_data	b2v_inst5(
	.flag(state[3]),
	.clk(SYNTHESIZED_WIRE_4),
	.data(SYNTHESIZED_WIRE_5),
	.clk_en(SYNTHESIZED_WIRE_6),
	.data_o(tx));


clock	b2v_inst6(
	.clk(sclk),
	.en(SYNTHESIZED_WIRE_6),
	.oclk(SYNTHESIZED_WIRE_4));
	defparam	b2v_inst6.clock_max = 5207;


endmodule
