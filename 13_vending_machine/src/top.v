/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module top (
	    input 	 clk,
	    input 	 rst,
	    input [3:0]  money_in,
	    input 	 buy_sig,
	    output reg 	 drink_out,
	    output [3:0] change_out
	    );
	/////////////////////////////////////////////
	// parameter and signals
	/////////////////////////////////////////////
	// parameter
	localparam  drink_value = 8'd25;
	// regs or wires
	wire 		 money_value;
	wire 		 buy_sig_debounced;
	wire 		 reset_money_count;

	reg [7:0] 	 change_value;
	/////////////////////////////////////////////
	// main code
	/////////////////////////////////////////////
	money money_inst (
			  .money_in(money_in),
			  .rst(reset_money_count),
			  .value(money_value)
			  );

	assign reset_money_count = (rst | buy_sig_debounced);

	button buy_sig_debounce(
				.clk(clk),
				.button_in(buy_sig),
				.button_out(buy_sig_debounced)
				);



	/////////////////////////////////////////////
	// code end
	/////////////////////////////////////////////
endmodule
