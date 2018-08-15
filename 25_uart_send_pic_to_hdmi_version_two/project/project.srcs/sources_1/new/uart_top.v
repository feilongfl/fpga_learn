`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/07/25 13:37:32
// Design Name: 
// Module Name: uart_top
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


module uart_top(
	input clk_i,
	input rst_n_i,
	
	input uart_rx_i,
	
	output uart_tx_o
    );

wire [7:0] uart_rx_data_o;
wire uart_rx_done;
    
uart_rx_path uart_rx_path_u (
    .clk_i(clk_i), 
    .uart_rx_i(uart_rx_i), 

    .uart_rx_data_o(uart_rx_data_o), 
    .uart_rx_done(uart_rx_done)
    );
    
uart_tx_path uart_tx_path_u (
    .clk_i(clk_i), 
    .uart_tx_data_i(uart_rx_data_o), 
    .uart_tx_en_i(uart_rx_done), 
    .uart_tx_o(uart_tx_o)
    );
    
endmodule

