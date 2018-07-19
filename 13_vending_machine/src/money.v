/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module money (
	      input [3:0]      money_in,
	      input 	       rst,
	      output reg [7:0] value = 0
	      );
	/////////////////////////////////////////////
	// parameter and signals
	/////////////////////////////////////////////
	// parameter

	// regs or wires
	wire 		       in_money_sig;
	/////////////////////////////////////////////
	// main code
	/////////////////////////////////////////////
	assign in_money_sig = (money_in == 4'b1111)? 1 : 0;

	always @ (negedge in_money_sig or negedge rst) begin
		if (!rst) begin
			value<=0;
		end else begin
			value <= value
				 + 50 * money_in[3]
				 + 20 * money_in[2]
				 + 10 * money_in[1]
				 + 5 * money_in[0];
		end
	end

	/////////////////////////////////////////////
	// code end
	/////////////////////////////////////////////
endmodule
