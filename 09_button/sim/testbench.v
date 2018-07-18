`timescale 10ns / 10ns

module testbench ();

    //gen system clk
	reg clk = 0;
    always #5 clk = ~clk;

	wire sig_in;
    //gen input signal
	reg [15:0] cnt = 0;

    always @ ( posedge clk ) begin
	    cnt <= (cnt == 700)? 700 : cnt + 1;
    end

    assign sig_in = ((cnt < 70 && cnt > 10) || (cnt > 500 && cnt < 560))  ?
		    $random % 2 :
		    (cnt > 70 && cnt < 500)? 0 : 1;



	wire pos_flag_out;
	wire neg_flag_out;
    input_filter if_inst(
			 .clk (clk),
			 .sig_in (sig_in),
			 .pos_flag (pos_flag_out),
			 .neg_flag (neg_flag_out)
			 );
	wire button_after;
    button_filter button_filter_inst(
                 		     .clk(clk),
             			     .button_pos(pos_flag_out),
                 		     .button_neg(neg_flag_out),
				     .button_flag(button_after)
				     );

endmodule
