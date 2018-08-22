`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2018/08/21 04:46:56
// Design Name:
// Module Name: ddrapp
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module ddrapp(
           output [27:0] app_addr,
           output [2:0] app_cmd,
           output app_en,
           output [127:0] app_wdf_data,
           output app_wdf_end,
           output [15:0] app_wdf_mask,
           output app_wdf_wren,
           input [127:0] app_rd_data,
           input app_rd_data_end,
           input app_rd_data_valid,
           input app_rdy,
           input app_wdf_rdy,

           input ddr_clk,
           input ddr_rst_n
       );







endmodule
