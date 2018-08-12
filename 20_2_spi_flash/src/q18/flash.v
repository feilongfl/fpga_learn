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
// CREATED		"Wed Aug 01 10:55:02 2018"

module flash(
           sclk,
           en,
           spi_di,
           spi_clk,
           spi_do,
           spi_cs,
           datareadout
       );


input wire	sclk;
input wire	en;
input wire	spi_di;
output wire	spi_clk;
output wire	spi_do;
output wire	spi_cs;
output wire	[7:0] datareadout;

wire	SYNTHESIZED_WIRE_0;
wire	[7:0] SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	[7:0] SYNTHESIZED_WIRE_4;

assign	SYNTHESIZED_WIRE_2 = 1;




spi	b2v_inst(
        .sclk(sclk),
        .en(SYNTHESIZED_WIRE_0),
        .spi_di(spi_di),
        .datasend(SYNTHESIZED_WIRE_1),
        .dataflag(SYNTHESIZED_WIRE_3),
        .spi_clk(spi_clk),
        .spi_do(spi_do),
        .spi_cs(spi_cs),
        .datarecv(SYNTHESIZED_WIRE_4));


spi_flash_rw	b2v_inst1(
                 .en(en),
                 .rst_n(SYNTHESIZED_WIRE_2),
                 .spi_flag(SYNTHESIZED_WIRE_3),
                 .data_read(SYNTHESIZED_WIRE_4),
                 .en_spi(SYNTHESIZED_WIRE_0),
                 .data_read_out(datareadout),
                 .data_write(SYNTHESIZED_WIRE_1));
defparam	b2v_inst1.DATA = 32'ha8c7b2dd;
defparam	b2v_inst1.datalength = 4;



endmodule
