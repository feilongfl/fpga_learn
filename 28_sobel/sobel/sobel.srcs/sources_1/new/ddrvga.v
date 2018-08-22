/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module ddrvga (
           // system clock
           input clk_50m,
           // hdmi output
           output HDMI_CLK_P,
           output HDMI_CLK_N,
           output HDMI_D2_P,
           output HDMI_D2_N,
           output HDMI_D1_P,
           output HDMI_D1_N,
           output HDMI_D0_P,
           output HDMI_D0_N,
           //ddr3
           inout [31:0] ddr3_dq,
           inout [3:0] ddr3_dqs_n,
           inout [3:0] ddr3_dqs_p,
           output [13:0] ddr3_addr,
           output [2:0] ddr3_ba,
           output ddr3_ras_n,
           output ddr3_cas_n,
           output ddr3_we_n,
           output ddr3_reset_n,
           output [0:0] ddr3_ck_p,
           output [0:0] ddr3_ck_n,
           output [0:0] ddr3_cke,
           output [3:0] ddr3_dm,
           output [0:0] ddr3_odt
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter

// regs or wires
//hdmi
wire [15:0] HPixel, VPixel;
wire [7:0] R, G, B;
wire pixClk;

wire hdmi_clk,hdmi_clk_5x,clk_200m,clk_500m,plllocked;

// ddr
wire [27:0] app_addr;
wire [2:0] app_cmd;
wire app_en;
wire [127:0] app_wdf_data;
wire app_wdf_end;
wire [15:0] app_wdf_mask;
wire app_wdf_wren;
wire [127:0] app_rd_data;
wire app_rd_data_end;
wire app_rd_data_valid;
wire app_rdy;
wire app_wdf_rdy;

wire ddr_clk;
wire ddr_rst;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////

// clock
clk_wiz_0 instance_name
          (
              // Clock out ports
              .hdmi_clk(hdmi_clk), // output hdmi_clk
              .hdmi_clk_5x(hdmi_clk_5x), // output hdmi_clk_5x
              .clk_200m(clk_200m), // output clk_200m
              .clk_500m(clk_500m), // output clk_500m
              // Status and control signals
              .locked(plllocked), // output locked
              // Clock in ports
              .clk_50m(clk_50m)); // input clk_50m

//hdmi
hdmi hdmi_inst (
         .hdmi_clk(hdmi_clk),
         .hdmi_clk_5x(hdmi_clk_5x),
         .clk_locked(plllocked),
         .inR(R),
         .inG(G),
         .inB(B),

         .HDMI_CLK_P(HDMI_CLK_P),
         .HDMI_CLK_N(HDMI_CLK_N),
         .HDMI_D2_P(HDMI_D2_P),
         .HDMI_D2_N(HDMI_D2_N),
         .HDMI_D1_P(HDMI_D1_P),
         .HDMI_D1_N(HDMI_D1_N),
         .HDMI_D0_P(HDMI_D0_P),
         .HDMI_D0_N(HDMI_D0_N),

         .HPixel(HPixel),
         .VPixel(VPixel),

         .pixelClk(pixClk)
     );

// ddr inst
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
                  //.init_calib_complete (init_calib_complete), // output init_calib_complete

                  .ddr3_dm (ddr3_dm), // output [3:0] ddr3_dm
                  .ddr3_odt (ddr3_odt), // output [0:0] ddr3_odt
                  // Application interface ports
                  .app_addr (app_addr), // input [27:0] app_addr
                  .app_cmd (app_cmd), // input [2:0] app_cmd
                  .app_en (app_en), // input app_en
                  .app_wdf_data (app_wdf_data), // input [127:0] app_wdf_data
                  .app_wdf_end (app_wdf_end), // input app_wdf_end
                  .app_wdf_wren (app_wdf_wren), // input app_wdf_wren
                  .app_wdf_mask (app_wdf_mask), // input [15:0] app_wdf_mask
                  .app_rd_data (app_rd_data), // output [127:0] app_rd_data
                  .app_rd_data_end (app_rd_data_end), // output app_rd_data_end
                  .app_rd_data_valid (app_rd_data_valid), // output app_rd_data_valid
                  .app_rdy (app_rdy), // output app_rdy
                  .app_wdf_rdy (app_wdf_rdy), // output app_wdf_rdy
                  .app_sr_req (1'b0), // input app_sr_req
                  .app_ref_req (1'b0), // input app_ref_req
                  .app_zq_req (1'b0), // input app_zq_req
                  // .app_sr_active (app_sr_active), // output app_sr_active
                  // .app_ref_ack (app_ref_ack), // output app_ref_ack
                  // .app_zq_ack (app_zq_ack), // output app_zq_ack
                  .ui_clk (ddr_clk), // output ui_clk
                  .ui_clk_sync_rst (ddr_rst), // output ui_clk_sync_rst
                  // System Clock Ports
                  .sys_clk_i (clk_500m),
                  // Reference Clock Ports
                  .clk_ref_i (clk_200m),
                  .sys_rst (plllocked) // input sys_rst
              );

ddrapp ddrapp_inst(
           .app_addr (app_addr),
           .app_cmd (app_cmd),
           .app_en (app_en),
           .app_wdf_data (app_wdf_data),
           .app_wdf_end (app_wdf_end),
           .app_wdf_wren (app_wdf_wren),
           .app_wdf_mask (app_wdf_mask),
           .app_rd_data (app_rd_data),
           .app_rd_data_end (app_rd_data_end),
           .app_rd_data_valid (app_rd_data_valid),
           .app_rdy (app_rdy),
           .app_wdf_rdy (app_wdf_rdy),

           .ddr_clk(ddr_clk),
           .ddr_rst_n(~ddr_rst)
       );

// vga data generator
assign R = (HPixel < 200) ? 8'hff : 8'h0;
assign G = (HPixel < 600 && HPixel > 200) ? 8'hff : 8'h0;
assign B = (HPixel > 600) ? 8'hff : 8'h0;
/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
