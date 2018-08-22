`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2018/08/22 11:16:40
// Design Name:
// Module Name: ddr3_wr
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


module ddr(
           // Inouts
           inout [31:0] ddr3_dq,
           inout [3:0] ddr3_dqs_n,
           inout [3:0] ddr3_dqs_p,
           // Outputs
           output [13:0] ddr3_addr,
           output [2:0] ddr3_ba,
           output ddr3_ras_n,
           output ddr3_cas_n,
           output ddr3_we_n,
           output ddr3_reset_n,
           output [0:0] ddr3_ck_p,
           output [0:0] ddr3_ck_n,
           output [0:0] ddr3_cke,
           output [0:0] ddr3_cs_n,
           output [3:0] ddr3_dm,
           output [0:0] ddr3_odt,
           // Inputs
           // Single-ended system clock
           input sys_clk_i,
           // Single-ended iodelayctrl clk (reference clock)
           input clk_ref_i,
           input sys_rst,

           input req_read,
           input req_write,
           output ack_write,
           output[31:0] read_data,
           input[7:0] write_data,
           input readClk,
           input fifo_reset
       );

wire [27:0] app_addr;
wire [2:0] app_cmd;
wire app_en;
wire [255:0] app_wdf_data;
wire app_wdf_end;
wire [31:0] app_wdf_mask;
wire app_wdf_wren;
wire [255:0] app_rd_data;
wire app_rd_data_end;
wire app_rd_data_valid;
wire app_rdy;
wire app_wdf_rdy;
wire ui_clk;
wire ui_clk_sync_rst;
//wire ack_write;

ddr_app ddrapp_inst(
            // ctl
            .req_read(req_read),
            .req_write(req_write),
            .ack_write(ack_write),
            .read_data(read_data),
            .write_data(write_data),
            .readClk(readClk),
            .fifo_reset(fifo_reset),

            // ddr3 user interface signals
            .app_addr (app_addr), // input [27:0] app_addr
            .app_cmd (app_cmd), // input [2:0] app_cmd
            .app_en (app_en), // input app_en
            .app_wdf_data (app_wdf_data), // input [255:0] app_wdf_data
            .app_wdf_mask (app_wdf_mask), // input [31:0] app_wdf_mask
            .app_wdf_wren (app_wdf_wren), // input app_wdf_wren
            .app_rd_data (app_rd_data), // output [255:0] app_rd_data
            .app_rd_data_end (app_rd_data_end), // output app_rd_data_end
            .app_rd_data_valid (app_rd_data_valid), // output app_rd_data_valid
            .app_rdy (app_rdy), // output app_rdy
            .app_wdf_rdy (app_wdf_rdy),
            .ui_clk (ui_clk), // output ui_clk
            .ui_clk_sync_rst (ui_clk_sync_rst) // output ui_clk_sync_rst
        );


mig_7series_0 u_mig_7series_0 (

                  // Memory interface ports
                  .ddr3_addr (ddr3_addr), // output [13:0] ddr3_addr
                  .ddr3_ba (ddr3_ba), // output [2:0] ddr3_ba
                  .ddr3_cas_n (ddr3_cas_n), // output ddr3_cas_n
                  .ddr3_ck_n (ddr3_ck_n), // output [0:0] ddr3_ck_n
                  .ddr3_ck_p (ddr3_ck_p), // output [0:0] ddr3_ck_p
                  .ddr3_cke (ddr3_cke), // output [0:0] ddr3_cke
                  .ddr3_ras_n (ddr3_ras_n), // output ddr3_ras_n
                  .ddr3_reset_n (ddr3_reset_n), // output ddr3_reset_n
                  .ddr3_we_n (ddr3_we_n), // output ddr3_we_n
                  .ddr3_dq (ddr3_dq), // inout [31:0] ddr3_dq
                  .ddr3_dqs_n (ddr3_dqs_n), // inout [3:0] ddr3_dqs_n
                  .ddr3_dqs_p (ddr3_dqs_p), // inout [3:0] ddr3_dqs_p
                  .init_calib_complete (init_calib_complete), // output init_calib_complete

                  .ddr3_cs_n (ddr3_cs_n), // output [0:0] ddr3_cs_n
                  .ddr3_dm (ddr3_dm), // output [3:0] ddr3_dm
                  .ddr3_odt (ddr3_odt), // output [0:0] ddr3_odt
                  // Application interface ports
                  .app_addr (app_addr), // input [27:0] app_addr
                  .app_cmd (app_cmd), // input [2:0] app_cmd
                  .app_en (app_en), // input app_en
                  .app_wdf_data (app_wdf_data), // input [255:0] app_wdf_data
                  .app_wdf_end (app_wdf_wren), // input app_wdf_end
                  .app_wdf_wren (app_wdf_wren), // input app_wdf_wren
                  .app_rd_data (app_rd_data), // output [255:0] app_rd_data
                  .app_rd_data_end (app_rd_data_end), // output app_rd_data_end
                  .app_rd_data_valid (app_rd_data_valid), // output app_rd_data_valid
                  .app_rdy (app_rdy), // output app_rdy
                  .app_wdf_rdy (app_wdf_rdy), // output app_wdf_rdy
                  .app_sr_req (0), // input app_sr_req
                  .app_ref_req (0), // input app_ref_req
                  .app_zq_req (0), // input app_zq_req
                  // .app_sr_active (app_sr_active), // output app_sr_active
                  // .app_ref_ack (app_ref_ack), // output app_ref_ack
                  // .app_zq_ack (app_zq_ack), // output app_zq_ack
                  .ui_clk (ui_clk), // output ui_clk
                  .ui_clk_sync_rst (ui_clk_sync_rst), // output ui_clk_sync_rst
                  .app_wdf_mask (app_wdf_mask), // input [31:0] app_wdf_mask
                  // System Clock Ports
                  .sys_clk_i (sys_clk_i),
                  // Reference Clock Ports
                  .clk_ref_i (clk_ref_i),
                  .sys_rst (sys_rst) // input sys_rst
              );

endmodule
