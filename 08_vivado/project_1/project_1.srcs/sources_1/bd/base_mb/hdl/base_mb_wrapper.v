//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
//Date        : Fri Aug 10 08:55:09 2018
//Host        : DESKTOP-B3SJCBK running 64-bit major release  (build 9200)
//Command     : generate_target base_mb_wrapper.bd
//Design      : base_mb_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module base_mb_wrapper
   (led_4bits_tri_o,
    reset,
    rs232_uart_rxd,
    rs232_uart_txd,
    sys_diff_clock_clk_n,
    sys_diff_clock_clk_p);
  output [3:0]led_4bits_tri_o;
  input reset;
  input rs232_uart_rxd;
  output rs232_uart_txd;
  input sys_diff_clock_clk_n;
  input sys_diff_clock_clk_p;

  wire [3:0]led_4bits_tri_o;
  wire reset;
  wire rs232_uart_rxd;
  wire rs232_uart_txd;
  wire sys_diff_clock_clk_n;
  wire sys_diff_clock_clk_p;

  base_mb base_mb_i
       (.led_4bits_tri_o(led_4bits_tri_o),
        .reset(reset),
        .rs232_uart_rxd(rs232_uart_rxd),
        .rs232_uart_txd(rs232_uart_txd),
        .sys_diff_clock_clk_n(sys_diff_clock_clk_n),
        .sys_diff_clock_clk_p(sys_diff_clock_clk_p));
endmodule
