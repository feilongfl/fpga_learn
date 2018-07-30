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
// CREATED		"Mon Jul 30 16:16:45 2018"

module spictl(
	spi_di,
	trig,
	sclk,
	datalength,
	senddata,
	spi_cs,
	spi_do,
	isbusy,
	spi_clk,
	recvdata
);


input wire	spi_di;
input wire	trig;
input wire	sclk;
input wire	[7:0] datalength;
input wire	[127:0] senddata;
output wire	spi_cs;
output wire	spi_do;
output wire	isbusy;
output wire	spi_clk;
output wire	[127:0] recvdata;

wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_6;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;





spi	b2v_inst(
	.clk(sclk),
	.en(SYNTHESIZED_WIRE_0),
	.data_send(SYNTHESIZED_WIRE_1),
	.spi_di(spi_di),
	.data_recv(SYNTHESIZED_WIRE_3),
	.spi_clk(SYNTHESIZED_WIRE_6),
	.spi_do(spi_do),
	.cs_n(spi_cs));


spi_read_write	b2v_inst4(
	.start_trig(trig),
	.spi_clk(SYNTHESIZED_WIRE_6),
	.spi_i(SYNTHESIZED_WIRE_3),
	.dataLength(datalength),
	.indata(senddata),
	.isbusy(isbusy),
	.spi_o(SYNTHESIZED_WIRE_1),
	.switch(SYNTHESIZED_WIRE_0),
	.recvdata(recvdata));

assign	spi_clk = SYNTHESIZED_WIRE_4 & SYNTHESIZED_WIRE_6;

assign	SYNTHESIZED_WIRE_4 =  ~trig;


endmodule
