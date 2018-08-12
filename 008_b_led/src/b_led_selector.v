module b_led_selector(
	input clk,
	input rst_n,
	output[3:0] led_ctl
);

wire led_chg_clk;
wire led_ctl_sig;

reg [1:0]cnt = 0;

b_led b_led_inst(
	.clk(clk),
	.rst_n(rst_n),
	.led_ctl(led_ctl_sig),
	.b_dir(led_chg_clk)
);

always @(posedge led_chg_clk or negedge rst_n) begin
	if(!rst_n)
		cnt <= 0;
	else
		cnt <= cnt + 1;
end

assign led_ctl[0] = (cnt == 0)? led_ctl_sig : 1;
assign led_ctl[1] = (cnt == 1)? led_ctl_sig : 1;
assign led_ctl[2] = (cnt == 2)? led_ctl_sig : 1;
assign led_ctl[3] = (cnt == 3)? led_ctl_sig : 1;


endmodule
