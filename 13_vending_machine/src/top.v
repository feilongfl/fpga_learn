/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module top (
	    input 	clk,
	    input [3:0] money_in,
	    input 	button_in,
	    input 	rst,
	    output 	drink_contral
	    );
	/////////////////////////////////////////////
	// parameter and signals
	/////////////////////////////////////////////
	// state mechine

	// parameter
	// regs or wires
	wire [7:0] 	money_value;
	wire 		button_in_debounce;
	wire [3:0] 	S_state;
	wire 		state_flag;
	wire 		money_rst;
	/////////////////////////////////////////////
	// main code
	/////////////////////////////////////////////
	//button filter
	button buy_button_filter(
				 .clk(clk),
				 .button_in(button_in),
				 .button_out(button_in_debounce)
				 );

	//state mechine
	sm sm_inst(
		   .flag(state_flag),
		   .rst(rst),
		   .money_value(money_value),
		   .S_state(S_state)
		   );

	//S_MONEY_EATER
	money money_eater(
			  .money_in(money_in),
			  .en(S_state[0]),
			  .flag(state_flag),
			  .rst(money_rst),
			  .button(button_in_debounce),
			  .in_money_val(money_value)
			  );

	//S_DRINK_OUTER
	// drinkouter drink_outer(
	// 		       .en(S_state[1]),
	// 		       .drink_contral(drink_contral)
	// 		       );


	/////////////////////////////////////////////
	// code end
	/////////////////////////////////////////////
endmodule
