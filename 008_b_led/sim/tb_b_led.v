`timescale 1ns/100ps

module tb_b_led();

  reg clk = 0;
  reg s_rst_n = 0;
  wire[3:0] oclk;

  initial begin
    #0
    s_rst_n <= 0;
    #20
    s_rst_n <= 1;
  end

  always #10 clk <= ~clk;

	
  b_led_selector b_led_selector_ins(
	.clk(clk),
	.rst_n(s_rst_n),
	.led_ctl(oclk)
  );

endmodule
