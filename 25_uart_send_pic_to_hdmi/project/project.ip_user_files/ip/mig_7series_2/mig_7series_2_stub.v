// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Tue Aug 14 15:24:10 2018
// Host        : DESKTOP-B3SJCBK running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/fpga/25_uart_send_pic_to_hdmi/project/project.srcs/sources_1/ip/mig_7series_2/mig_7series_2_stub.v
// Design      : mig_7series_2
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tfgg484-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module mig_7series_2(ddr3_dq, ddr3_dqs_n, ddr3_dqs_p, ddr3_addr, 
  ddr3_ba, ddr3_ras_n, ddr3_cas_n, ddr3_we_n, ddr3_reset_n, ddr3_ck_p, ddr3_ck_n, ddr3_cke, 
  ddr3_cs_n, ddr3_dm, ddr3_odt, sys_clk_p, sys_clk_n, clk_ref_p, clk_ref_n, app_addr, app_cmd, 
  app_en, app_wdf_data, app_wdf_end, app_wdf_mask, app_wdf_wren, app_rd_data, app_rd_data_end, 
  app_rd_data_valid, app_rdy, app_wdf_rdy, app_sr_req, app_ref_req, app_zq_req, app_sr_active, 
  app_ref_ack, app_zq_ack, ui_clk, ui_clk_sync_rst, init_calib_complete, device_temp, sys_rst)
/* synthesis syn_black_box black_box_pad_pin="ddr3_dq[7:0],ddr3_dqs_n[0:0],ddr3_dqs_p[0:0],ddr3_addr[13:0],ddr3_ba[2:0],ddr3_ras_n,ddr3_cas_n,ddr3_we_n,ddr3_reset_n,ddr3_ck_p[0:0],ddr3_ck_n[0:0],ddr3_cke[0:0],ddr3_cs_n[0:0],ddr3_dm[0:0],ddr3_odt[0:0],sys_clk_p,sys_clk_n,clk_ref_p,clk_ref_n,app_addr[27:0],app_cmd[2:0],app_en,app_wdf_data[31:0],app_wdf_end,app_wdf_mask[3:0],app_wdf_wren,app_rd_data[31:0],app_rd_data_end,app_rd_data_valid,app_rdy,app_wdf_rdy,app_sr_req,app_ref_req,app_zq_req,app_sr_active,app_ref_ack,app_zq_ack,ui_clk,ui_clk_sync_rst,init_calib_complete,device_temp[11:0],sys_rst" */;
  inout [7:0]ddr3_dq;
  inout [0:0]ddr3_dqs_n;
  inout [0:0]ddr3_dqs_p;
  output [13:0]ddr3_addr;
  output [2:0]ddr3_ba;
  output ddr3_ras_n;
  output ddr3_cas_n;
  output ddr3_we_n;
  output ddr3_reset_n;
  output [0:0]ddr3_ck_p;
  output [0:0]ddr3_ck_n;
  output [0:0]ddr3_cke;
  output [0:0]ddr3_cs_n;
  output [0:0]ddr3_dm;
  output [0:0]ddr3_odt;
  input sys_clk_p;
  input sys_clk_n;
  input clk_ref_p;
  input clk_ref_n;
  input [27:0]app_addr;
  input [2:0]app_cmd;
  input app_en;
  input [31:0]app_wdf_data;
  input app_wdf_end;
  input [3:0]app_wdf_mask;
  input app_wdf_wren;
  output [31:0]app_rd_data;
  output app_rd_data_end;
  output app_rd_data_valid;
  output app_rdy;
  output app_wdf_rdy;
  input app_sr_req;
  input app_ref_req;
  input app_zq_req;
  output app_sr_active;
  output app_ref_ack;
  output app_zq_ack;
  output ui_clk;
  output ui_clk_sync_rst;
  output init_calib_complete;
  output [11:0]device_temp;
  input sys_rst;
endmodule