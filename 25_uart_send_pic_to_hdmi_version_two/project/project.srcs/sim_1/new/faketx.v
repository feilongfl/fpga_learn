module fakeTx(
           input clk_i,

           input [7:0] uart_tx_data_i,
           input uart_tx_en_i,

           output reg uart_send_flag=0,
           output uart_tx_o
       );

always @ (posedge clk_i) begin
    if(uart_tx_en_i) begin
        uart_send_flag <= 1;
        $display("uart fake tx => %d",uart_tx_data_i);
    end
    else begin
        uart_send_flag <= 0;
    end
end

endmodule
