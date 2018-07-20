/////////////////////////////////////////////
//               Test Bench
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

`timescale 10ns / 10ns
module tb_money ();
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
		#150
			srst_n = 0;
		#10 srst_n = 1;
	end

	wire flag;
	wire [7:0] money_value;

	reg [3:0]  money_in;
	reg 	   rst = 1;
	reg 	   button;

	initial begin
		#0
			button = 1;
		#100
			button = 0;
		#20
			button = 1;
	end

	initial begin
		#150 rst = 0;
		#10 rst = 1;
	end

	initial begin
		#0
			money_in = 4'b0000;
		#50
			money_in = 4'b1000;
		#10
			money_in = 4'b0000;
		#20
			money_in = 4'b0100;
		#10
			money_in = 4'b0000;
	end

	// models
	money money_inst(
			 .money_in(money_in),
			 .en(srst_n),
			 .rst(rst),
			 .button(button),
			 .flag(flag),
			 .in_money_val(money_value)
			 );

	/////////////////////////////////////////////
	// code end
	/////////////////////////////////////////////
endmodule
