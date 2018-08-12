/////////////////////////////////////////////
//               Test Bench
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

`timescale 10ns / 10ns
module tb_top ();
	/////////////////////////////////////////////
	// parameter and signals
	/////////////////////////////////////////////
	// parameter

	// regs or wires
	reg sclk = 0;
	reg srst_n = 0;

	reg [3:0] money_in;
	reg 	  button_in;
	reg 	  drink_output_fin;
	/////////////////////////////////////////////
	// main code
	/////////////////////////////////////////////
	// System clock
	always #10 sclk = ~sclk;

	//inital
	initial begin
		#0
			srst_n = 0;
		#0 money_in = 4'b0000;
		#0 button_in = 1;
		#0 drink_output_fin = 1;
		#30
			srst_n = 1;
		#20 money_in = 4'b1000;
		#10 money_in = 4'b0000;
		#20 button_in = 0;
		#100 button_in = 1;
		#30 drink_output_fin = 0;
		#10 drink_output_fin = 1;
	end

	wire drink_contral;
	wire [3:0] money_out_contral;
	// models
	top top_inst(
		     .clk(sclk),
		     .money_in(money_in),
		     .button_in(button_in),
		     .drink_output_fin,
		     .rst(srst_n),
		     .drink_contral(drink_contral),
		     .money_out_contral(money_out_contral)
   		     );

	/////////////////////////////////////////////
	// code end
	/////////////////////////////////////////////
endmodule
