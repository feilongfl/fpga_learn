/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module button (
	       input  clk,
	       input  button_in,
	       output button_out
	       );
	/////////////////////////////////////////////
	// parameter and signals
	/////////////////////////////////////////////
	// parameter

	// regs
	// reg [7:0]     cnt = 0;
	/////////////////////////////////////////////
	// main code
	/////////////////////////////////////////////
	// always @ (posedge clk) begin
	// 	if (!button_in) begin
	// 		cnt <= (cnt[7] == 1)? cnt : cnt +1;
	// 	end else begin
	// 		cnt = 0;
	// 	end
	// end
	//
	// assign button_out = (cnt[7] == 1) ? 0 : 1;

	assign button_out = (button_in);

	/////////////////////////////////////////////
	// code end
	/////////////////////////////////////////////
endmodule
