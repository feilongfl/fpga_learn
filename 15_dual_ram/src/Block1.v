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
// CREATED		"Sat Jul 21 15:36:22 2018"

module Block1(
	clk,
	sw,
	address,
	data,
	do1,
	do2
);


input wire	clk;
input wire	sw;
input wire	[8:0] address;
input wire	[15:0] data;
output wire	[15:0] do1;
output wire	[15:0] do2;

wire	SYNTHESIZED_WIRE_0;





ram_2port	b2v_inst(
	.wren(sw),
	.wrclock(clk),
	.rdclock(clk),
	.data(data),
	.rdaddress(address),
	.wraddress(address),
	.q(do2));


ram_2port	b2v_inst1(
	.wren(SYNTHESIZED_WIRE_0),
	.wrclock(clk),
	.rdclock(clk),
	.data(data),
	.rdaddress(address),
	.wraddress(address),
	.q(do1));

assign	SYNTHESIZED_WIRE_0 =  ~sw;


endmodule
