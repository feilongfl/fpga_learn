//*****************************************************************************
// (c) Copyright 2009 - 2013 Xilinx, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
//
//*****************************************************************************
// ____ ____
// / /\/ /
// /___/ \ / Vendor : Xilinx
// \ \ \/ Version : 4.1
// \ \ Application : MIG
// / / Filename : example_top.v
// /___/ /\ Date Last Modified : $Date: 2011/06/02 08:35:03 $
// \ \ / \ Date Created : Tue Sept 21 2010
// \___\/\___\
//
// Device : 7 Series
// Design Name : DDR3 SDRAM
// Purpose :
// Top-level module. This module serves as an example,
// and allows the user to synthesize a self-contained design,
// which they can be used to test their hardware.
// In addition to the memory controller, the module instantiates:
// 1. Synthesizable testbench - used to model user's backend logic
// and generate different traffic patterns
// Reference :
// Revision History :
//*****************************************************************************

//`define SKIP_CALIB
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

           //////////////////////////////////////////////////////////
           // uart
           input uart_rx,
           output uart_tx
       );





//***************************************************************************



wire sclk_200m;
wire sclk_50m;
wire pllLock;

clk_wiz_0 instance_name
          (
              // Clock out ports
              .clk_out1(sclk_200m), // output clk_out1
              .clk_out2(sclk_50m),     // output clk_out2
              // Status and control signals
              .reset(sys_rst), // input reset
              .locked(pllLock), // output locked
              // Clock in ports
              .clk_in1(sys_clk_i)); // input clk_in1

// Start of User Design top instance
//***************************************************************************
// The User design is instantiated below. The memory interface ports are
// connected to the top-level and the application interface ports are
// connected to the traffic generator module. This provides a reference
// for connecting the memory controller to system.
//***************************************************************************

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
                  .app_addr (0), // input [27:0] app_addr
                  .app_cmd (0), // input [2:0] app_cmd
                  .app_en (1), // input app_en
                  .app_wdf_data (0), // input [255:0] app_wdf_data
                  .app_wdf_end (0), // input app_wdf_end
                  .app_wdf_wren (1), // input app_wdf_wren
                  .app_rd_data (app_rd_data), // output [255:0] app_rd_data
                  .app_rd_data_end (app_rd_data_end), // output app_rd_data_end
                  .app_rd_data_valid (app_rd_data_valid), // output app_rd_data_valid
                  .app_rdy (app_rdy), // output app_rdy
                  .app_wdf_rdy (app_wdf_rdy), // output app_wdf_rdy
                  .app_sr_req (0), // input app_sr_req
                  .app_ref_req (0), // input app_ref_req
                  .app_zq_req (0), // input app_zq_req
                  .app_sr_active (app_sr_active), // output app_sr_active
                  .app_ref_ack (app_ref_ack), // output app_ref_ack
                  .app_zq_ack (app_zq_ack), // output app_zq_ack
                  .ui_clk (ui_clk), // output ui_clk
                  .ui_clk_sync_rst (ui_clk_sync_rst), // output ui_clk_sync_rst
                  .app_wdf_mask (0), // input [31:0] app_wdf_mask
                  // System Clock Ports
                  .sys_clk_i (sclk_200m),
                  // Reference Clock Ports
                  .clk_ref_i (sclk_200m),
                  .sys_rst (pllLock) // input sys_rst
              );
// End of User Design top instance


uart_rx_path uart_rx_path_u (
    .clk_i(sclk_50m), 
    .uart_rx_i(uart_rx), 

    .uart_rx_data_o(uart_rx_data_o), 
    .uart_rx_done(uart_rx_done)
    );
    
uart_tx_path uart_tx_path_u (
    .clk_i(sclk_50m), 
    .uart_tx_data_i(uart_tx), 
    .uart_tx_en_i(0), 
    .uart_tx_o(uart_tx_o)
    );

endmodule
