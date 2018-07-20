/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module sm (
	   input 	    flag,
	   input 	    rst,
	   input 	    money_value,
	   output reg [3:0] S_state = 4'b0001
	   );
	/////////////////////////////////////////////
	// parameter and signals
	/////////////////////////////////////////////
	// parameter
	localparam  S_MONEY_EATER = 4'b0001;
	localparam  S_DRINK_OUTER = 4'b0010;
	localparam  S_MONEY_OUTER = 4'b0100;
	localparam  S_MONEY_OUTER_ALL = 4'b1000;
	// reg 		S_state = S_MONEY_EATER;

	localparam  DRINK_VALUE = 25;

	// regs or wires

	/////////////////////////////////////////////
	// main code
	/////////////////////////////////////////////
	always @ ( negedge flag or negedge rst ) begin
		if (!rst) begin
			S_state <= S_MONEY_EATER;
		end else case(S_state)
				 S_MONEY_EATER:
					 S_state <= (money_value >= DRINK_VALUE)?
						    S_DRINK_OUTER : S_MONEY_OUTER_ALL;
				 S_DRINK_OUTER:
					 S_state <= S_MONEY_OUTER;
				 S_MONEY_OUTER:
					 S_state <= S_MONEY_EATER;
				 default:
					 S_state <= S_MONEY_EATER;
			 endcase
	end


	/////////////////////////////////////////////
	// code end
	/////////////////////////////////////////////
endmodule
