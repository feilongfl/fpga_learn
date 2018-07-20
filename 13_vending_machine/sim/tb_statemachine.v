/////////////////////////////////////////////
//               Test Bench
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

`timescale 10ns / 10ns
module tb_state_machine ();
	/////////////////////////////////////////////
	// parameter and signals
	/////////////////////////////////////////////
	// parameter

	// regs or wires
	reg sclk = 0;
	reg srst_n = 0;

	reg [7:0] money_value = 0;
	wire [3:0] state;
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
		#10 money_value = 50;
		#30 money_value = 0;
	end

	// models
	sm sm_inst(
		   .flag(sclk),
		   .rst(srst_n),
		   .money_value(money_value),
		   .S_state(state)
		   );

	/////////////////////////////////////////////
	// code end
	/////////////////////////////////////////////
endmodule
