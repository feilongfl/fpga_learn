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
// CREATED		"Tue Jul 24 15:42:21 2018"

module uart(
	sclk,
	rx,
	pin_name1,
	datarecv
);


input wire	sclk;
input wire	rx;
output wire	pin_name1;
output wire	[7:0] datarecv;

wire	SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;





divclk	b2v_inst(
	.clk_in(sclk),
	.clk_out(SYNTHESIZED_WIRE_5));
	defparam	b2v_inst.DIV_COUNT = 5206;


rx_recode_enable_gen	b2v_inst1(
	.clk(SYNTHESIZED_WIRE_5),
	.rx(SYNTHESIZED_WIRE_6),
	.en(pin_name1));
	defparam	b2v_inst1.Max = 8;


recode	b2v_inst2(
	.rx(SYNTHESIZED_WIRE_6),
	.clk(SYNTHESIZED_WIRE_5),
	.data(datarecv));


fifo	b2v_inst4(
	.clk(SYNTHESIZED_WIRE_5),
	.indata(rx),
	.outdata(SYNTHESIZED_WIRE_6));


endmodule
