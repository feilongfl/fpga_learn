module div5clk(
	input sclk,
	input s_rst_n,
	output oclk
);
	//reg init
	reg [2:0] p_cnt = 3'b0;
	reg [2:0] n_cnt = 3'b0;
	reg p_clk = 1;
	reg n_clk = 1;
	
	//p_cnt
	always @(posedge sclk or negedge s_rst_n) begin
		if(!s_rst_n)
			p_cnt <= 3'b0;
		else if (p_cnt == 1) begin
			p_cnt <= p_cnt + 1;
			p_clk <= ~p_clk;
		end
		else if (p_cnt == 4) begin
			p_cnt <= 3'b0;
			p_clk <= ~p_clk;
		end
		else
			p_cnt <= p_cnt + 1;
	end
	
	//p_cnt
	always @(negedge sclk or negedge s_rst_n) begin
		if(!s_rst_n)
			n_cnt <= 3'b0;
		else if (n_cnt == 1) begin
			n_cnt <= n_cnt + 1;
			n_clk <= ~n_clk;
		end
		else if (n_cnt == 4) begin
			n_cnt <= 3'b0;
			n_clk <= ~n_clk;
		end
		else
			n_cnt <= n_cnt + 1;
	end
	
	assign oclk = p_clk | n_clk;

endmodule
