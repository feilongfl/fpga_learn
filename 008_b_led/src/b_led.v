module b_led(
	input clk,
	input rst_n,
	output led_ctl,
	output reg b_dir = 1'b0
);
	
	reg[15:0] b_light = 0;
	
	reg[15:0] pwm_cnt = 0;
	
	reg duty_clk = 1'b0;
	
	localparam duty_max = 'hff;
	
	
	always @ (posedge duty_clk or negedge rst_n) begin
		if(!rst_n) begin
			b_dir <= 1'b0;
			b_light <= 0;
		end
		else if (b_light == duty_max || b_light == 0) begin
			b_dir <= ~b_dir;
			b_light <= (!b_dir)? 
								b_light + 1 : 
								b_light - 1;
		end
		else
			b_light <= (b_dir)? 
								b_light + 1 : 
								b_light - 1;
	end
	
	always @ (posedge clk or negedge rst_n) begin
		if(!rst_n)
			pwm_cnt <= 0;
		else if(pwm_cnt == duty_max) begin
			pwm_cnt <= 0; 
			duty_clk <= 1;
		end
		else begin
			pwm_cnt <= pwm_cnt + 1;
			duty_clk <= 0;
		end
	end
	
	assign led_ctl = (pwm_cnt > b_light)? 0 : 1;

endmodule
