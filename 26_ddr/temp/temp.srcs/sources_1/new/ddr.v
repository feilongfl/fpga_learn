`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2018/08/20 14:23:13
// Design Name:
// Module Name: ddr
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
           input sclk,

           //ddr
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

           //uart
           input uart_rx,
           output uart_tx
       );

// user interface signals
wire [27:0] app_addr;
wire [2:0] app_cmd;
wire app_en;
wire [127:0] app_wdf_data;
// wire app_wdf_end;
wire [15:0] app_wdf_mask;
wire app_wdf_wren;
wire [127:0] app_rd_data;
wire app_rd_data_end;
wire app_rd_data_valid;
wire app_rdy;
wire app_wdf_rdy;
// wire app_sr_req;
// wire app_ref_req;
// wire app_zq_req;
// wire app_sr_active;
// wire app_ref_ack;
// wire app_zq_ack;
wire ui_clk;
wire ui_clk_sync_rst;

clk_wiz_0 clk_inst
          (
              // Clock out ports
              .clk_out1(sys_clk_i), // output clk_out1
              .clk_out2(clk_ref_i), // output clk_out2
              // Status and control signals
              .locked(sys_rst), // output locked
              // Clock in ports
              .clk_in1(sclk)); // input clk_in1

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
                  // .init_calib_complete (init_calib_complete), // output init_calib_complete

                  .ddr3_cs_n (ddr3_cs_n), // output [0:0] ddr3_cs_n
                  .ddr3_dm (ddr3_dm), // output [3:0] ddr3_dm
                  .ddr3_odt (ddr3_odt), // output [0:0] ddr3_odt
                  // Application interface ports
                  .app_addr (app_addr), // input [27:0] app_addr
                  .app_cmd (app_cmd), // input [2:0] app_cmd
                  .app_en (app_en), // input app_en
                  .app_wdf_data (app_wdf_data), // input [127:0] app_wdf_data
                  .app_wdf_end (app_wdf_wren), // input app_wdf_end
                  .app_wdf_wren (app_wdf_wren), // input app_wdf_wren
                  .app_rd_data (app_rd_data), // output [127:0] app_rd_data
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
                  .app_wdf_mask (app_wdf_mask), // input [15:0] app_wdf_mask
                  // System Clock Ports
                  .sys_clk_i (sys_clk_i),
                  // Reference Clock Ports
                  .clk_ref_i (clk_ref_i),
                  .sys_rst (sys_rst) // input sys_rst
              );
wire[7:0] uart_rx_data;
wire uart_rx_done;

wire[63:0] uart_fifo_out;

assign app_wdf_data = {uart_fifo_out,uart_fifo_out};
assign app_wdf_wren = rd_en;
assign rd_en = ~empty;

assign app_cmd = (app_wdf_wren)? 3'b000 : 3'b001;

fifo_generator_0 fifo_uart_ddr (
                     .clk(ui_clk), // input wire clk
                     .din(uart_rx_data), // input wire [7 : 0] din
                     .wr_en(uart_rx_done), // input wire wr_en
                     .rd_en(rd_en), // input wire rd_en
                     .dout(uart_fifo_out), // output wire [63 : 0] dout
                     // .full(full), // output wire full
                     .empty(empty) // output wire empty
                 );

uart_rx_path uart_rx_path_u (
                 .clk_i(ui_clk),
                 .uart_rx_i(uart_rx),

                 .uart_rx_data_o(uart_rx_data),
                 .uart_rx_done(uart_rx_done)
             );

// uart_tx_path uart_tx_path_u (
//                  .clk_i(ui_clk),
//                  .uart_tx_data_i(),
//                  .uart_tx_en_i(uart_rx_done),
//                  .uart_tx_o(uart_tx)
//              );

endmodule
