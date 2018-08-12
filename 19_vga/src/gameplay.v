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
// CREATED		"Sat Jul 28 09:49:49 2018"

module gameplay(
	srst,
	sclk,
	button_right,
	button_left,
	hsync,
	vsync,
	r,
	g,
	b
);


input wire	srst;
input wire	sclk;
input wire	button_right;
input wire	button_left;
output wire	hsync;
output wire	vsync;
output wire	r;
output wire	g;
output wire	b;

wire	[13:0] board_addr;
wire	[13:0] box_addr;
wire	clk_100hz;
wire	clk_10hz;
wire	clk_25m;
wire	[15:0] display_x;
wire	[15:0] display_y;
wire	[7:0] SYNTHESIZED_WIRE_0;
wire	[7:0] SYNTHESIZED_WIRE_1;
wire	[7:0] SYNTHESIZED_WIRE_2;
wire	[0:0] SYNTHESIZED_WIRE_3;
wire	[0:0] SYNTHESIZED_WIRE_4;
wire	[7:0] SYNTHESIZED_WIRE_5;
wire	[15:0] SYNTHESIZED_WIRE_6;
wire	[15:0] SYNTHESIZED_WIRE_7;
wire	[15:0] SYNTHESIZED_WIRE_8;
wire	[15:0] SYNTHESIZED_WIRE_9;
wire	[7:0] SYNTHESIZED_WIRE_10;
wire	[7:0] SYNTHESIZED_WIRE_11;





pll	b2v_inst(
	.inclk0(sclk),
	.c0(clk_25m));


vga	b2v_inst1(
	.clk(clk_25m),
	.rst_n(srst),
	.inB(SYNTHESIZED_WIRE_0),
	.inG(SYNTHESIZED_WIRE_1),
	.inR(SYNTHESIZED_WIRE_2),
	.Hsync(hsync),
	.Vsync(vsync),
	.Bo(SYNTHESIZED_WIRE_11),
	.Go(SYNTHESIZED_WIRE_10),
	.HPixel(display_x),
	.Ro(SYNTHESIZED_WIRE_5),
	.VPixel(display_y));
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


divclk	b2v_inst10(
	.clk(sclk),
	.rst_n(srst),
	.oclk(clk_100hz));
	defparam	b2v_inst10.div_count = 500000;


divclk	b2v_inst11(
	.clk(sclk),
	.rst_n(srst),
	.oclk(clk_10hz));
	defparam	b2v_inst11.div_count = 5000000;


gamebox	b2v_inst2(
	.clk(clk_100hz),
	.rst_n(srst),
	.data_box(SYNTHESIZED_WIRE_3),
	.data_board(SYNTHESIZED_WIRE_4),
	.button_clk(clk_10hz),
	.button_left(button_left),
	.button_right(button_right),
	.x(display_x),
	.y(display_y),
	.b(SYNTHESIZED_WIRE_0),
	.bx(SYNTHESIZED_WIRE_8),
	.by(SYNTHESIZED_WIRE_9),
	.g(SYNTHESIZED_WIRE_1),
	.px(SYNTHESIZED_WIRE_6),
	.py(SYNTHESIZED_WIRE_7),
	.r(SYNTHESIZED_WIRE_2));
	defparam	b2v_inst2.board_height = 50;
	defparam	b2v_inst2.board_width = 100;
	defparam	b2v_inst2.board_y = 400;
	defparam	b2v_inst2.box_h = 100;
	defparam	b2v_inst2.box_w = 100;
	defparam	b2v_inst2.box_x_speed = 1;
	defparam	b2v_inst2.box_y_speed = 1;
	defparam	b2v_inst2.drawable_h = 480;
	defparam	b2v_inst2.drawable_w = 640;


rom	b2v_inst3(
	.clock(sclk),
	.address(box_addr),
	.q(SYNTHESIZED_WIRE_3));


cov8_1	b2v_inst4(
	.i(SYNTHESIZED_WIRE_5),
	.o(r));


xy2addr	b2v_inst5(
	.x(SYNTHESIZED_WIRE_6),
	.y(SYNTHESIZED_WIRE_7),
	.addr(box_addr));
	defparam	b2v_inst5.WIDTH = 100;


xy2addr	b2v_inst6(
	.x(SYNTHESIZED_WIRE_8),
	.y(SYNTHESIZED_WIRE_9),
	.addr(board_addr));
	defparam	b2v_inst6.WIDTH = 100;


rom	b2v_inst7(
	.clock(sclk),
	.address(board_addr),
	.q(SYNTHESIZED_WIRE_4));


cov8_1	b2v_inst8(
	.i(SYNTHESIZED_WIRE_10),
	.o(g));


cov8_1	b2v_inst9(
	.i(SYNTHESIZED_WIRE_11),
	.o(b));


endmodule
