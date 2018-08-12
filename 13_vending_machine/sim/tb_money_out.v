/////////////////////////////////////////////
//               Test Bench
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

`timescale 10ns / 10ns
module tb_money_out ();
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
		#100
			srst_n = 0;
		#30
			srst_n = 1;
	end

	reg [7:0] money = 135;
	reg 	  move25 = 0;
	wire [3:0] money_out;
	wire 	   flag;
	// models
	moneyouter moneyouter_tb(
				 .money(money),
				 .clk(sclk),
				 .en(srst_n),
				 .move25(move25),
				 .money_out(money_out),
				 .flag(flag)
				 );

	/////////////////////////////////////////////
	// code end
	/////////////////////////////////////////////
endmodule
