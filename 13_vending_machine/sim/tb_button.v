/////////////////////////////////////////////
//               Test Bench
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

`timescale 10ns / 10ns
module tb_button ();
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

	wire button_out;
	wire button_in;
	reg [31:0] button_timer = 0;

	always @ (posedge sclk) begin
		button_timer <= (button_timer[10] == 1) ? 0 : button_timer + 1;
	end

	assign button_in = ((button_timer < 70 && button_timer > 10) || (button_timer > 500 && button_timer < 560))  ?
			   $random % 2 :
			   (button_timer > 70 && button_timer < 500)? 0 : 1;
	// models
	button button_inst(
			   .clk(sclk),
			   .button_in(button_in),
			   .button_out(button_out)
    			   );

	/////////////////////////////////////////////
	// code end
	/////////////////////////////////////////////
endmodule
