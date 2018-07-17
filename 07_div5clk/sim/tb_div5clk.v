`timescale 1ns/100ps

module tb_div5clk();

  reg clk = 0;
  reg s_rst_n = 0;
  wire oclk;

  initial begin
    #0
    s_rst_n <= 0;
    #20
    s_rst_n <= 1;
  end

  always #10 clk <= ~clk;

  div5clk div5_clk_inst(
      .sclk (clk),
      .s_rst_n (s_rst_n),
      .oclk (oclk)
    );

endmodule
