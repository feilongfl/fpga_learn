module fakeRx(
           input clk_i,
           input uart_rx_i,

           output reg [7:0] uart_rx_data_o = 0,
           output reg uart_rx_done = 0
       );

reg[6:0] cnt = 0;

always @ (posedge clk_i) begin
    cnt <= (cnt[6] == 1)? 0 : cnt + 1;
end

always@(posedge clk_i) begin
    uart_rx_done <= (cnt[6] == 1)? 1:0;
    if(uart_rx_done) begin
        uart_rx_data_o <= uart_rx_data_o + 1;
        //$display("uart fake rx => %d",uart_rx_data_o);
    end
end

endmodule
