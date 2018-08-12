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
// CREATED		"Thu Aug 09 17:16:17 2018"

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
output wire	[4:0]r;
output wire	[5:0]g;
output wire	[4:0]b;

wire	[13:0] board_addr;
wire	[13:0] box_addr;
wire	clk_100hz;
wire	clk_25m;
wire	[15:0] display_x;
wire	[15:0] display_y;
wire	[7:0] SYNTHESIZED_WIRE_0;
wire	[7:0] SYNTHESIZED_WIRE_1;
wire	[7:0] SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	[0:0] SYNTHESIZED_WIRE_4;
wire	[0:0] SYNTHESIZED_WIRE_5;
wire	[7:0] SYNTHESIZED_WIRE_6;
wire	[15:0] SYNTHESIZED_WIRE_7;
wire	[15:0] SYNTHESIZED_WIRE_8;
wire	[15:0] SYNTHESIZED_WIRE_9;
wire	[15:0] SYNTHESIZED_WIRE_10;
wire	[7:0] SYNTHESIZED_WIRE_11;
wire	[7:0] SYNTHESIZED_WIRE_12;


wire CLK_OUT2;


clk_wiz_v3_6	b2v_inst(
	.CLK_IN1(sclk),
	.CLK_OUT1(clk_25m),
    .CLK_OUT2(CLK_OUT2));
    
vga	b2v_inst1(
	.clk(clk_25m),
	.rst_n(srst),
	.inB(SYNTHESIZED_WIRE_0),
	.inG(SYNTHESIZED_WIRE_1),
	.inR(SYNTHESIZED_WIRE_2),
	.Hsync(hsync),
	.Vsync(clk_100hz),
	.Bo(SYNTHESIZED_WIRE_12),
	.Go(SYNTHESIZED_WIRE_11),
	.HPixel(display_x),
	.Ro(SYNTHESIZED_WIRE_6),
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
    
blk_mem_gen_v7_3 b2v_inst10 (
  .clka(SYNTHESIZED_WIRE_3), // input clka
  .addra(box_addr), // input [13 : 0] addra
  .douta(SYNTHESIZED_WIRE_4), // output [0 : 0] douta
  .clkb(SYNTHESIZED_WIRE_3), // input clkb
  .addrb(board_addr), // input [13 : 0] addrb
  .doutb(SYNTHESIZED_WIRE_5) // output [0 : 0] doutb
);

assign	SYNTHESIZED_WIRE_3 =  ~CLK_OUT2;


gamebox	b2v_inst2(
	.clk(clk_100hz),
	.rst_n(srst),
	.data_box(SYNTHESIZED_WIRE_4),
	.data_board(SYNTHESIZED_WIRE_5),
	.button_clk(clk_100hz),
	.button_left(button_left),
	.button_right(button_right),
	.x(display_x),
	.y(display_y),
	.b(SYNTHESIZED_WIRE_0),
	.bx(SYNTHESIZED_WIRE_9),
	.by(SYNTHESIZED_WIRE_10),
	.g(SYNTHESIZED_WIRE_1),
	.px(SYNTHESIZED_WIRE_7),
	.py(SYNTHESIZED_WIRE_8),
	.r(SYNTHESIZED_WIRE_2));
	defparam	b2v_inst2.board_height = 50;
	defparam	b2v_inst2.board_width = 100;
	defparam	b2v_inst2.board_x_speed = 5;
	defparam	b2v_inst2.board_y = 400;
	defparam	b2v_inst2.box_h = 100;
	defparam	b2v_inst2.box_w = 100;
	defparam	b2v_inst2.box_x_speed = 2;
	defparam	b2v_inst2.box_y_speed = 2;
	defparam	b2v_inst2.drawable_h = 480;
	defparam	b2v_inst2.drawable_w = 640;

xy2addr	b2v_inst5(
	.x(SYNTHESIZED_WIRE_7),
	.y(SYNTHESIZED_WIRE_8),
	.addr(box_addr));
	defparam	b2v_inst5.WIDTH = 100;


xy2addr	b2v_inst6(
	.x(SYNTHESIZED_WIRE_9),
	.y(SYNTHESIZED_WIRE_10),
	.addr(board_addr));
	defparam	b2v_inst6.WIDTH = 100;

cov8_1	b2v_inst4(
	.i(SYNTHESIZED_WIRE_6),
	.o(r));

cov8_1	b2v_inst8(
	.i(SYNTHESIZED_WIRE_11),
	.o(g));

cov8_1	b2v_inst9(
	.i(SYNTHESIZED_WIRE_12),
	.o(b));

assign	vsync = clk_100hz;

endmodule
