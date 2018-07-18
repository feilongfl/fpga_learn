module button_filter(
		     input 	clk,
		     input 	button_pos,
		     input 	button_neg,
		     output reg button_flag
		     );

	reg [7:0] 		button_cnt = 0;

	reg 			flag = 0;
	reg 			flag_hl = 1;

    //button release or push
    always @ (posedge button_pos or posedge button_neg or posedge clk) begin
	    if (button_neg || button_pos) begin
		    button_cnt <= 0;
		    flag <= 1;
		    flag_hl <= (button_pos) ? 1:0;
	    end else begin
		    button_cnt <= (!flag) ? 0 :
				  ((button_cnt[7]) ? button_cnt : button_cnt + 1) ;
		    flag <= (button_cnt[7]) ? 0 : flag;
	    end
    end

    always @ (negedge flag) begin
            button_flag <= flag_hl;
    end




endmodule
