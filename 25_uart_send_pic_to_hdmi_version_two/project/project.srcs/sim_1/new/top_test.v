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

module top_test
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
           output uart_tx,

           output ui_clk_100m,
           output ui_clk_100m_sync_rst
       );





//***************************************************************************



wire sclk_200m;
//wire sclk_50m;
wire pllLock;

wire app_en;

// ila_0 ila_0 (
//           .clk(sclk_200m), // input wire clk
//
//           .probe0(init_calib_complete),
//           .probe1(ui_clk_100m)
//       );

wire[255:0]app_wdf_data,app_rd_data;
wire[7:0]uart_rx_data_o;

wire[27:0] app_addr;
wire[2:0] app_cmd;
wire [31:0] app_wdf_mask;

wire [7:0] uart_tx_data_i;

wire uart_tx_busy,uart_tx_en;

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
              .clk_in1(sys_clk_i)); // input clk_in1

// Start of User Design top instance
//***************************************************************************
// The User design is instantiated below. The memory interface ports are
// connected to the top-level and the application interface ports are
// connected to the traffic generator module. This provides a reference
// for connecting the memory controller to system.
//***************************************************************************

parameter SIMULATION            = "TRUE";
parameter PORT_MODE             = "BI_MODE";
parameter DATA_MODE             = 4'b0010;
parameter TST_MEM_INSTR_MODE    = "R_W_INSTR_MODE";
parameter EYE_TEST              = "FALSE";
// set EYE_TEST = "TRUE" to probe memory
// signals. Traffic Generator will only
// write to one single location and no
// read transactions will be generated.
parameter DATA_PATTERN          = "DGEN_ALL";
// For small devices, choose one only.
// For large device, choose "DGEN_ALL"
// "DGEN_HAMMER", "DGEN_WALKING1",
// "DGEN_WALKING0","DGEN_ADDR","
// "DGEN_NEIGHBOR","DGEN_PRBS","DGEN_ALL"
parameter CMD_PATTERN           = "CGEN_ALL";
// "CGEN_PRBS","CGEN_FIXED","CGEN_BRAM",
// "CGEN_SEQUENTIAL", "CGEN_ALL"
parameter BEGIN_ADDRESS         = 32'h00000000;
parameter END_ADDRESS           = 32'h00000fff;
parameter PRBS_EADDR_MASK_POS   = 32'hff000000;

//***************************************************************************
// The following parameters refer to width of various ports
//***************************************************************************
parameter COL_WIDTH             = 10;
// # of memory Column Address bits.
parameter CS_WIDTH              = 1;
// # of unique CS outputs to memory.
parameter DM_WIDTH              = 4;
// # of DM (data mask)
parameter DQ_WIDTH              = 32;
// # of DQ (data)
parameter DQS_WIDTH             = 4;
parameter DQS_CNT_WIDTH         = 2;
// = ceil(log2(DQS_WIDTH))
parameter DRAM_WIDTH            = 8;
// # of DQ per DQS
parameter ECC                   = "OFF";
parameter RANKS                 = 1;
// # of Ranks.
parameter ODT_WIDTH             = 1;
// # of ODT outputs to memory.
parameter ROW_WIDTH             = 14;
// # of memory Row Address bits.
parameter ADDR_WIDTH            = 28;
// # = RANK_WIDTH + BANK_WIDTH
//     + ROW_WIDTH + COL_WIDTH;
// Chip Select is always tied to low for
// single rank devices
//***************************************************************************
// The following parameters are mode register settings
//***************************************************************************
parameter BURST_MODE            = "8";
// DDR3 SDRAM:
// Burst Length (Mode Register 0).
// # = "8", "4", "OTF".
// DDR2 SDRAM:
// Burst Length (Mode Register).
// # = "8", "4".
parameter CA_MIRROR             = "OFF";
// C/A mirror opt for DDR3 dual rank

//***************************************************************************
// The following parameters are multiplier and divisor factors for PLLE2.
// Based on the selected design frequency these parameters vary.
//***************************************************************************
parameter CLKIN_PERIOD          = 5000;
// Input Clock Period


//***************************************************************************
// Simulation parameters
//***************************************************************************
parameter SIM_BYPASS_INIT_CAL   = "FAST";
// # = "SIM_INIT_CAL_FULL" -  Complete
//              memory init &
//              calibration sequence
// # = "SKIP" - Not supported
// # = "FAST" - Complete memory init & use
//              abbreviated calib sequence

//***************************************************************************
// IODELAY and PHY related parameters
//***************************************************************************
parameter TCQ                   = 100;
//***************************************************************************
// IODELAY and PHY related parameters
//***************************************************************************
parameter RST_ACT_LOW           = 1;
// =1 for active low reset,
// =0 for active high.

//***************************************************************************
// Referece clock frequency parameters
//***************************************************************************
parameter REFCLK_FREQ           = 200.0;
// IODELAYCTRL reference clock frequency
//***************************************************************************
// System clock frequency parameters
//***************************************************************************
parameter tCK                   = 2500;
// memory tCK paramter.
// # = Clock Period in pS.
parameter nCK_PER_CLK           = 4;
// # of memory CKs per fabric CLK



//***************************************************************************
// Debug and Internal parameters
//***************************************************************************
parameter DEBUG_PORT            = "OFF";
// # = "ON" Enable debug signals/controls.
//   = "OFF" Disable debug signals/controls.
//***************************************************************************
// Debug and Internal parameters
//***************************************************************************
parameter DRAM_TYPE             = "DDR3";



//**************************************************************************//
// Local parameters Declarations
//**************************************************************************//

localparam real TPROP_DQS          = 0.00;
// Delay for DQS signal during Write Operation
localparam real TPROP_DQS_RD       = 0.00;
// Delay for DQS signal during Read Operation
localparam real TPROP_PCB_CTRL     = 0.00;
// Delay for Address and Ctrl signals
localparam real TPROP_PCB_DATA     = 0.00;
// Delay for data signal during Write operation
localparam real TPROP_PCB_DATA_RD  = 0.00;
// Delay for data signal during Read operation

localparam MEMORY_WIDTH            = 16;
localparam NUM_COMP                = DQ_WIDTH/MEMORY_WIDTH;
localparam ECC_TEST 		   	= "OFF" ;
localparam ERR_INSERT = (ECC_TEST == "ON") ? "OFF" : ECC ;


localparam real REFCLK_PERIOD = (1000000.0/(2*REFCLK_FREQ));
localparam RESET_PERIOD = 200000; //in pSec
localparam real SYSCLK_PERIOD = tCK;

mig_7series_1 #(
                  .SIMULATION                (SIMULATION),
                  .PORT_MODE                 (PORT_MODE),
                  .DATA_MODE                 (DATA_MODE),
                  .TST_MEM_INSTR_MODE        (TST_MEM_INSTR_MODE),
                  .EYE_TEST                  (EYE_TEST),
                  .DATA_PATTERN              (DATA_PATTERN),
                  .CMD_PATTERN               (CMD_PATTERN),
                  .BEGIN_ADDRESS             (BEGIN_ADDRESS),
                  .END_ADDRESS               (END_ADDRESS),
                  .PRBS_EADDR_MASK_POS       (PRBS_EADDR_MASK_POS),

                  .COL_WIDTH                 (COL_WIDTH),
                  .CS_WIDTH                  (CS_WIDTH),
                  .DM_WIDTH                  (DM_WIDTH),

                  .DQ_WIDTH                  (DQ_WIDTH),
                  .DQS_CNT_WIDTH             (DQS_CNT_WIDTH),
                  .DRAM_WIDTH                (DRAM_WIDTH),
                  .ECC_TEST                  (ECC_TEST),
                  .RANKS                     (RANKS),
                  .ROW_WIDTH                 (ROW_WIDTH),
                  .ADDR_WIDTH                (ADDR_WIDTH),
                  .BURST_MODE                (BURST_MODE),
                  .TCQ                       (TCQ),


                  .DRAM_TYPE                 (DRAM_TYPE),


                  .nCK_PER_CLK               (nCK_PER_CLK),


                  .DEBUG_PORT                (DEBUG_PORT),

                  .RST_ACT_LOW               (RST_ACT_LOW)
              ) u_mig_7series_inst (

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
                  .sys_clk_i (sys_clk_i),
                  // Reference Clock Ports
                  .clk_ref_i (sys_clk_i),
                  .sys_rst (sys_rst) // input sys_rst
              );
// End of User Design top instance
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


ila_uart rx_dbg(
             .clk(ui_clk_100m),
             .probe0(uart_rx_data_o),
             .probe1(uart_rx_done)
         );

ila_uart tx_dbg(
             .clk(ui_clk_100m),
             .probe0(uart_tx_data_i),
             .probe1(uart_tx_en)
         );

uart_tx_path uart_tx_path_u (
                 .clk_i(ui_clk_100m),
                 .uart_tx_data_i(uart_tx_data_i),
                 .uart_tx_en_i(uart_tx_en),
                 .uart_tx_o(uart_tx),
                 .uart_send_flag(uart_tx_busy)
             );

endmodule
