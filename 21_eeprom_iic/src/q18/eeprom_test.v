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
// CREATED		"Thu Aug 02 11:00:43 2018"

module eeprom_test(
           s_rst_n,
           sclk_50m,
           trig,
           iic_scl,
           iic_failed,
           iic_sda,
           readData
       );


input wire	s_rst_n;
input wire	sclk_50m;
input wire	trig;
output wire	iic_scl;
output wire	iic_failed;
inout wire	iic_sda;
output wire	[7:0] readData;

wire	clk_4k;
wire	SYNTHESIZED_WIRE_0;
wire	[7:0] SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;





divclk	b2v_divclk_inst(
           .clk(sclk_50m),
           .rst_n(s_rst_n),
           .oclk(clk_4k));
defparam	b2v_divclk_inst.div_count = 10;


iic	b2v_iic_inst(
        .clk(clk_4k),
        .en(SYNTHESIZED_WIRE_0),
        .sdata(iic_sda),
        .data(SYNTHESIZED_WIRE_1),
        .flag(SYNTHESIZED_WIRE_2),
        .iclk(iic_scl),
        .failed(iic_failed),

        .readdata(readData));


iic_data_provider	b2v_inst(
                      .trig(trig),
                      .changeDataFlag(SYNTHESIZED_WIRE_2),
                      .en(SYNTHESIZED_WIRE_0),
                      .data(SYNTHESIZED_WIRE_1));
defparam	b2v_inst.commandLength = 1;
defparam	b2v_inst.communityByteLength = 4;
defparam	b2v_inst.DeviceAddress = 7'b1010000;
defparam	b2v_inst.isRead = 1'b1;
defparam	b2v_inst.writeDate = 8'haa;


endmodule
