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
	/////////////////////////////////////////////
	// main code
	/////////////////////////////////////////////
	// System clock
	always #10 sclk = ~sclk;

	//inital
	initial begin
		#0
			srst_n = 0;
		#30
			srst_n = 1;
	end

	// models
	wire[15:0] do1;
	wire [15:0] do2;
	dual_ram dual_ram_inst (
				.clk(sclk),
				.data_out1(do1),
				.data_out2(do2)
				);

	/////////////////////////////////////////////
	// code end
	/////////////////////////////////////////////
endmodule