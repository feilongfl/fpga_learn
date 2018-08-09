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
// CREATED		"Fri Jul 27 10:51:10 2018"

module box_move(
	srst,
	sclk,
	hsync,
	vsync,
	r,
	g,
	b
);


input wire	srst;
input wire	sclk;
output wire	hsync;
output wire	vsync;
output wire	r;
output wire	g;
output wire	b;

wire	SYNTHESIZED_WIRE_0;
wire	[7:0] SYNTHESIZED_WIRE_1;
wire	[7:0] SYNTHESIZED_WIRE_2;
wire	[7:0] SYNTHESIZED_WIRE_3;
wire	[7:0] SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_5;
wire	[15:0] SYNTHESIZED_WIRE_6;
wire	[15:0] SYNTHESIZED_WIRE_7;
wire	[7:0] SYNTHESIZED_WIRE_8;
wire	[7:0] SYNTHESIZED_WIRE_9;





pll	b2v_inst(
	.inclk0(sclk),
	.c0(SYNTHESIZED_WIRE_0));


vga	b2v_inst1(
	.clk(SYNTHESIZED_WIRE_0),
	.rst_n(srst),
	.inB(SYNTHESIZED_WIRE_1),
	.inG(SYNTHESIZED_WIRE_2),
	.inR(SYNTHESIZED_WIRE_3),
	.Hsync(hsync),
	.Vsync(vsync),
	.Bo(SYNTHESIZED_WIRE_9),
	.Go(SYNTHESIZED_WIRE_8),
	.HPixel(SYNTHESIZED_WIRE_6),
	.Ro(SYNTHESIZED_WIRE_4),
	.VPixel(SYNTHESIZED_WIRE_7));
	defparam	b2v_inst1.HBackPorch = 40;
	defparam	b2v_inst1.HFrontPorch = 8;
	defparam	b2v_inst1.HLeftBoader = 8;
	defparam	b2v_inst1.HorAddr = 640;
	defparam	b2v_inst1.HorBlankStart = 648;
	defparam	b2v_inst1.HorBlankTime = 144;
	defparam	b2v_inst1.HorSyncStart = 656;
	defparam	b2v_inst1.HorSyncTime = 96;
	defparam	b2v_inst1.HorTotal = 800;
	defparam	b2v_inst1.HRightBorder = 8;
	defparam	b2v_inst1.VBackPorch = 25;
	defparam	b2v_inst1.VBottomBorder = 8;
	defparam	b2v_inst1.VerAddr = 480;
	defparam	b2v_inst1.VerBlankStart = 488;
	defparam	b2v_inst1.VerBlankTime = 29;
	defparam	b2v_inst1.VerSyncStart = 490;
	defparam	b2v_inst1.VerSyncTime = 2;
	defparam	b2v_inst1.VerTotal = 525;
	defparam	b2v_inst1.VFrontPorch = 2;
	defparam	b2v_inst1.VTopBorder = 8;


cov8_1	b2v_inst4(
	.i(SYNTHESIZED_WIRE_4),
	.o(r));


box	b2v_inst5(
	.clk(SYNTHESIZED_WIRE_5),
	.rst_n(srst),
	.x(SYNTHESIZED_WIRE_6),
	.y(SYNTHESIZED_WIRE_7),
	.b(SYNTHESIZED_WIRE_1),
	.g(SYNTHESIZED_WIRE_2),
	.r(SYNTHESIZED_WIRE_3));
	defparam	b2v_inst5.box_h = 50;
	defparam	b2v_inst5.box_w = 50;
	defparam	b2v_inst5.box_x_speed = 1;
	defparam	b2v_inst5.box_y_speed = 1;
	defparam	b2v_inst5.drawable_h = 480;
	defparam	b2v_inst5.drawable_w = 640;


divclk	b2v_inst6(
	.clk(sclk),
	.rst_n(srst),
	.oclk(SYNTHESIZED_WIRE_5));
	defparam	b2v_inst6.div_count = 50000000;


cov8_1	b2v_inst8(
	.i(SYNTHESIZED_WIRE_8),
	.o(g));


cov8_1	b2v_inst9(
	.i(SYNTHESIZED_WIRE_9),
	.o(b));


endmodule
