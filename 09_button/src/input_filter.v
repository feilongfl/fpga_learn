module input_filter(
		    input  clk,
		    input  sig_in,
		    output pos_flag,
		    output neg_flag
		    );

	reg [2:0] 	   fifo = 3'b1;

    always @ ( posedge clk ) begin
	    fifo <= {fifo[1:0], sig_in};
    end

    assign neg_flag = (fifo[2]) & (~fifo[1]);
    assign pos_flag = (~fifo[2]) & (fifo[1]);

endmodule
