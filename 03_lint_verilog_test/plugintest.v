

module pluginTest();

uart uart_inst (
         .clk(clk),
         .tx_trig(tx_trig),
         .rx_flag(rx_flag),
         .busy(busy),
         .data_tx(data_tx),
         .data_rx(data_rx),
         .tx(tx),
         .rx(rx)
     );

endmodule
