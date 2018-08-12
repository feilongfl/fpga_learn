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
	reg srst = 0;

	wire button;
	reg [31:0] button_timer = 0;

	wire [3:0] leds;
	/////////////////////////////////////////////
	// main code
	/////////////////////////////////////////////
	// System clock
	always #10 sclk = ~sclk;

	//inital
	initial begin
		#0
			srst = 0;
		#30
			srst = 1;
	end

	always @ (posedge sclk) begin
		button_timer <= (button_timer[10] == 1) ? 0 : button_timer + 1;
	end

	assign button = ((button_timer < 70 && button_timer > 10) || (button_timer > 500 && button_timer < 560))  ?
			$random % 2 :
			(button_timer > 70 && button_timer < 500)? 0 : 1;

	// models
	top top_inst(
		     .clk(sclk),
		     .rst(srst),
		     .button(button),
		     .leds(leds)
    		     );

	/////////////////////////////////////////////
	// code end
	/////////////////////////////////////////////
endmodule
