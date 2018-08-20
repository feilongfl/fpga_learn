module fakeTx(
           input clk_i,

           input [7:0] uart_tx_data_i,
           input uart_tx_en_i,

           output reg uart_send_flag=0,
           output uart_tx_o
       );

reg [7:0] waitCnt = 0;

always @ (posedge clk_i) begin
    if(uart_tx_en_i) begin
        waitCnt <= 0;
        uart_send_flag <= 1;
        $display("uart fake tx => %h",uart_tx_data_i);
    end
    else if(waitCnt == 10) begin
        uart_send_flag <= 0;
    end
    else begin
        waitCnt <= waitCnt + 1;
    end
end

endmodule
