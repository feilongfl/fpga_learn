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

	reg[31:0] wave_gen = 32'b10101010101011001101100110101010;
	reg [31:0] cnt = 0;
	wire 	   wave;

	always @ (posedge sclk) begin
		cnt <= (cnt == 31) ? 0 : cnt + 1;
	end

	assign wave = (wave_gen[cnt]);

	// models
	wire out_wave;

	fsm fsm_inst(
		     .clk(sclk),
		     .rst_n(srst_n),

		     //
		     .i_val(wave),
		     .o_val(out_wave)
		     );

	/////////////////////////////////////////////
		// code end
	/////////////////////////////////////////////
endmodule
