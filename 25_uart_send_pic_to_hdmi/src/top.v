module top (
           //ddr3
           inout [31:0]       ddr3_dq,
           inout [3:0]        ddr3_dqs_n,
           inout [3:0]        ddr3_dqs_p,
           output [13:0]     ddr3_addr,
           output [2:0]        ddr3_ba,
           output            ddr3_ras_n,
           output            ddr3_cas_n,
           output            ddr3_we_n,
           output            ddr3_reset_n,
           output [0:0]       ddr3_ck_p,
           output [0:0]       ddr3_ck_n,
           output [0:0]       ddr3_cke,
           output [3:0]     ddr3_dm,
           output [0:0]       ddr3_odt,
           //hdmi

           //uart
           input  uart_rx,
           output uart_tx,
           //system
           input systemClock,
           input rst_n
       );
//clock
// wire systemClockBufG;
// IBUFG system_clock_buf (
//           .O (systemClockBufG),
//           .I (systemClock));

// clk_wiz_0 system_clock_wiz (
//               // Clock out ports
//               .clk_25m(clk_25m_bufg),     // output clk_25m
//               // Clock in ports
//               .clk_in1(systemClockBufG));      // input clk_in1

//ddr
wire fin_ddr;

wire [27:0]       app_addr;
wire [2:0]       app_cmd;
wire             app_en;
wire [255:0]        app_wdf_data;
wire             app_wdf_end;
wire [31:0]        app_wdf_mask;
wire             app_wdf_wren;
wire [255:0]       app_rd_data;
wire            app_rd_data_end;
wire            app_rd_data_valid;
wire            app_rdy;
wire            app_wdf_rdy;
wire         app_sr_req;
wire         app_ref_req;
wire         app_zq_req;
wire            app_sr_active;
wire            app_ref_ack;
wire            app_zq_ack;
wire            ui_clk;
wire            ui_clk_sync_rst;
//wire            init_calib_complete;

mig_7series_0 u_mig_7series_0 (
                  // Memory interface ports
                  .ddr3_addr                      (ddr3_addr),  // output [13:0]		ddr3_addr
                  .ddr3_ba                        (ddr3_ba),  // output [2:0]		ddr3_ba
                  .ddr3_cas_n                     (ddr3_cas_n),  // output			ddr3_cas_n
                  .ddr3_ck_n                      (ddr3_ck_n),  // output [0:0]		ddr3_ck_n
                  .ddr3_ck_p                      (ddr3_ck_p),  // output [0:0]		ddr3_ck_p
                  .ddr3_cke                       (ddr3_cke),  // output [0:0]		ddr3_cke
                  .ddr3_ras_n                     (ddr3_ras_n),  // output			ddr3_ras_n
                  .ddr3_reset_n                   (ddr3_reset_n),  // output			ddr3_reset_n
                  .ddr3_we_n                      (ddr3_we_n),  // output			ddr3_we_n
                  .ddr3_dq                        (ddr3_dq),  // inout [31:0]		ddr3_dq
                  .ddr3_dqs_n                     (ddr3_dqs_n),  // inout [3:0]		ddr3_dqs_n
                  .ddr3_dqs_p                     (ddr3_dqs_p),  // inout [3:0]		ddr3_dqs_p
                  .ddr3_dm                        (ddr3_dm),  // output [3:0]		ddr3_dm
                  .ddr3_odt                       (ddr3_odt),  // output [0:0]		ddr3_odt
                  // Application interface ports
                  .init_calib_complete            (fin_ddr),  // output			init_calib_complete
                  .app_addr                       (0),  // input [27:0]		app_addr
                  .app_cmd                        (0),  // input [2:0]		app_cmd
                  .app_en                         (0),  // input				app_en
                  .app_wdf_data                   (0),  // input [255:0]		app_wdf_data
                  .app_wdf_end                    (0),  // input				app_wdf_end
                  .app_wdf_wren                   (0),  // input				app_wdf_wren
                  .app_rd_data                    (),  // output [255:0]		app_rd_data
                  .app_rd_data_end                (app_rd_data_end),  // output			app_rd_data_end
                  .app_rd_data_valid              (app_rd_data_valid),  // output			app_rd_data_valid
                  .app_rdy                        (app_rdy),  // output			app_rdy
                  .app_wdf_rdy                    (app_wdf_rdy),  // output			app_wdf_rdy
                  .app_sr_req                     (0),  // input			app_sr_req
                  .app_ref_req                    (0),  // input			app_ref_req
                  .app_zq_req                     (0),  // input			app_zq_req
                  .app_sr_active                  (app_sr_active),  // output			app_sr_active
                  .app_ref_ack                    (app_ref_ack),  // output			app_ref_ack
                  .app_zq_ack                     (app_zq_ack),  // output			app_zq_ack
                  .ui_clk                         (ui_clk),  // output			ui_clk
                  .ui_clk_sync_rst                (ui_clk_sync_rst),  // output			ui_clk_sync_rst
                  .app_wdf_mask                   (0),  // input [31:0]		app_wdf_mask
                  // System Clock Ports
                  .sys_clk_i                       (systemClock),
                  .sys_rst                        (rst_n) // input sys_rst
              );

// ddr_app ddr_app_inst(
//             .app_addr(app_addr),
//             .app_cmd(app_cmd),
//             .app_en(app_en),
//             .app_wdf_data(app_wdf_data),
//             .app_wdf_end(app_wdf_end),
//             .app_wdf_mask(app_wdf_mask),
//             .app_wdf_wren(app_wdf_wren),
//             .app_rd_data(app_rd_data),
//             .app_rd_data_end(app_rd_data_end),
//             .app_rd_data_valid(app_rd_data_valid),
//             .app_rdy(app_rdy),
//             .app_wdf_rdy(app_wdf_rdy),
//             .app_sr_req(app_sr_req),
//             .app_ref_req(app_ref_req),
//             .app_zq_req(app_zq_req),
//             .app_sr_active(app_sr_active),
//             .app_ref_ack(app_ref_ack),
//             .app_zq_ack(app_zq_ack),
//             .ui_clk(ui_clk),
//             .ui_clk_sync_rst(ui_clk_sync_rst),
//             .init_calib_complete(fin_ddr)
//         );

//uart
wire uart_data_send;
wire uart_data_send_trig;
wire[7:0] uart_data_recv;
wire uart_data_recv_flag;

// uart uart_inst (
//          .uart_rx(uart_rx),
//          .uart_tx(uart_tx),
//          // .data_send(uart_data_send),
//          // .data_send_trig(uart_data_send_trig),
//          .data_recv(uart_data_recv),
//          .data_recv_flag(uart_data_recv_flag),
//          .clock(systemClockBufG)
//      );

// uart_rx_path uart_rx_path_u (
//                  .clk_i(systemClockBufG),
//                  .uart_rx_i(uart_rx),
//
//                  .uart_rx_data_o(uart_data_recv),
//                  .uart_rx_done(uart_data_recv_flag)
//              );
//
// ddrAddrGen ddrAddrGen_inst (
//                .flags(uart_data_recv_flag),
//                .Addr(app_addr),
//                .mask(app_wdf_mask)
//            );
//
// bit8mask256 bit8mask256_inst (
//                 .I(uart_data_recv),
//                 .O(app_wdf_data)
//             );
// wire[7:0] uart_tx_data_i_wire;
// wire uart_send_flag;
// uart_tx_path uart_tx_path_inst (
//                  .clk_i(systemClockBufG),
//                  .uart_tx_data_i(uart_tx_data_i_wire),
//                  .uart_tx_en_i(uart_tx_en_i_wire),
//                  .uart_tx_o(uart_tx),
//                  .uart_send_flag(uart_send_flag)
//              );
// wire fifo256to8_empty;
// fifo256to8 fifo256to8_inst (
//                .clock(systemClockBufG),
//                .wren(wren_wire),
//                .empty(empty_wire),
//                .rden(rden_wire),
//                .data8(uart_tx_data_i_wire),
//                .data256(app_rd_data)
//            );

endmodule // top
