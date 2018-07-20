/////////////////////////////////////////////
//               Test Bench
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

`timescale 10ns / 10ns
module tb_drinkouter ();
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
		#200
			srst_n = 0;
		#30
			srst_n = 1;
	end

	reg of;
	wire ctl;
	wire flag;

	initial begin
		#0
			of = 1;
		#50
			of = 0;
		#10
			of = 1;
		#250
			of = 0;
		#10
			of = 1;
	end

	// models
	drinkouter do_inst (
			    .en(srst_n),
			    .drink_out_fin(of),
			    .drink_contral(ctl),
			    .flag(flag)
    			    );

	/////////////////////////////////////////////
	// code end
	/////////////////////////////////////////////
endmodule
