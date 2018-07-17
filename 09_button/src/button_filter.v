module button_filter(
    input clk,
    input button,
    output button_flag
    );

    reg[2:0] button_sig_fifo = 3'b0;
    always @ ( posedge clk ) begin
        button_sig_fifo[2] <= button_sig_fifo[1];
        button_sig_fifo[1] <= button_sig_fifo[0];
        button_sig_fifo[0] <= button;
    end

    // wire button_fifo_out;
    assign button_flag = button_sig_fifo[2] & (~button_sig_fifo[1]);

endmodule
