
`timescale 1ps/1ps

module top
       (

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
           // input clk_ref_i,

           output tg_compare_error,
           output init_calib_complete,



           // System reset - Default polarity of sys_rst pin is Active Low.
           // System reset polarity will change based on the option
           // selected in GUI.
           input sys_rst,

           // uart
           input uart_rx,
           output uart_tx
       );


wire sclk_200m;
//wire sclk_50m;
wire pllLock;

wire ui_clk_100m;
wire app_en;

wire[255:0]app_wdf_data;
wire[255:0]app_rd_data;

wire[27:0] app_addr;
wire[2:0] app_cmd;
wire [31:0] app_wdf_mask;
wire app_wdf_end,app_wdf_wren,app_rd_data_valid,app_rdy,app_wdf_rdy,ui_clk_100m_sync_rst;

wire[7:0]uart_rx_data_o;
wire [7:0] uart_tx_data_i;
wire uart_tx_busy,uart_tx_en;
wire uart_rx_done;


bit8to256 bit8to256_inst(
              .I (uart_rx_data_o),
              .O (app_wdf_data)
          );


clk_wiz_0 clk_wiz_inst
          (
              // Clock out ports
              .clk_out1(sclk_200m), // output clk_out1
              //              .clk_out2(sclk_50m),     // output clk_out2
              // Status and control signals
              .reset(0), // input reset
              .locked(pllLock), // output locked
              // Clock in ports
              .clk_in1(sys_clk_i)
              ); // input clk_in1

mig_7series_0 u_mig_7series_inst (

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

                  /////////////////////////////////////////////////
                  // Application interface ports
                  /////////////////////////////////////////////////
                  .app_addr (app_addr), // input [27:0] app_addr
                  .app_cmd (app_cmd), // input [2:0] app_cmd
                  .app_en (app_en), // input app_en
                  .app_wdf_data (app_wdf_data), // input [255:0] app_wdf_data
                  .app_wdf_end (app_wdf_end), // input app_wdf_end
                  .app_wdf_mask (app_wdf_mask), // input [31:0] app_wdf_mask
                  .app_wdf_wren (app_wdf_wren), // input app_wdf_wren
                  .app_rd_data (app_rd_data), // output [255:0] app_rd_data
                  // .app_rd_data_end (app_rd_data_end), // output app_rd_data_end
                  .app_rd_data_valid (app_rd_data_valid), // output app_rd_data_valid
                  .app_rdy (app_rdy), // output app_rdy
                  .app_wdf_rdy (app_wdf_rdy), // output app_wdf_rdy

                  // not use
                  .app_sr_req (0), // input app_sr_req
                  .app_ref_req (0), // input app_ref_req
                  .app_zq_req (0), // input app_zq_req
                  // .app_sr_active (app_sr_active), // output app_sr_active
                  // .app_ref_ack (app_ref_ack), // output app_ref_ack
                  // .app_zq_ack (app_zq_ack), // output app_zq_ack

                  //clock
                  .ui_clk (ui_clk_100m), // output ui_clk_100m
                  .ui_clk_sync_rst (ui_clk_100m_sync_rst), // output ui_clk_100m_sync_rst
                  // System Clock Ports
                  .sys_clk_i (sclk_200m),
                  // Reference Clock Ports
                  .clk_ref_i (sclk_200m),
                  .sys_rst (pllLock) // input sys_rst
              );
              
uartaddr uartaddr_inst (
             .ui_clk(ui_clk_100m),
             .ui_clk_sync_rst(ui_clk_100m_sync_rst),
             .app_rdy(app_rdy),
             .app_wdf_rdy(app_wdf_rdy),
             .app_addr(app_addr),
             .app_cmd(app_cmd),
             .app_en(app_en),
             .app_wdf_end(app_wdf_end),
             .app_wdf_wren(app_wdf_wren),
             .app_wdf_mask(app_wdf_mask),
             .app_rd_data_valid(app_rd_data_valid),
             .app_rd_data(app_rd_data),
             .uart_rx_done(uart_rx_done),
             .uart_tx_en(uart_tx_en),
             .uart_tx_data(uart_tx_data_i),
             .uart_tx_busy(uart_tx_busy)
         );


uart_rx_path uart_rx_path_u (
                 .clk_i(ui_clk_100m),
                 .uart_rx_i(uart_rx),

                 .uart_rx_data_o(uart_rx_data_o),
                 .uart_rx_done(uart_rx_done)
             );
             

uart_tx_path uart_tx_path_u (
                 .clk_i(ui_clk_100m),
                 .uart_tx_data_i(uart_tx_data_i),
                 .uart_tx_en_i(uart_tx_en),
                 .uart_tx_o(uart_tx),
                 .uart_send_flag(uart_tx_busy)
             );

endmodule
