/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module top (
	    input 	clk,
	    input [3:0] money_in,
	    input 	button_in,
	    input 	drink_output_fin,
	    input 	rst,
	    output 	drink_contral,
	    output 	money_out_contral
	    );
	/////////////////////////////////////////////
	// parameter and signals
	/////////////////////////////////////////////
	// state mechine

	// parameter
	// regs or wires
	wire [7:0] 	money_value;
	wire 		button_in_debounce;
	wire 		drink_output_fin_debounce;
	wire [3:0] 	S_state;
	wire 		state_flag;
	wire [3:0] 	state_flags;
	wire 		money_rst;
	wire 		move25;
	wire 		outMoneyState;
	/////////////////////////////////////////////
	// main code
	/////////////////////////////////////////////
	//button filter
	button buy_button_filter(
				 .clk(clk),
				 .button_in(button_in),
				 .button_out(button_in_debounce)
				 );

	button drink_out_fin_filter(
				    .clk(clk),
				    .button_in(drink_output_fin),
				    .button_out(drink_output_fin_debounce)
				    );

	//state mechine
	sm sm_inst(
		   .flag(state_flag),
		   .rst(rst),
		   .money_value(money_value),
		   .S_state(S_state)
		   );

	assign state_flag = ((state_flags & S_state) == 4'b0)? 1'b0 : 1'b1;


	//S_MONEY_EATER
	assign money_rst = ~(
			     ~(state_flags[2] & state_flags[3])
			     & (S_state[2] | S_state[3] )
			     );
	money money_eater(
			  .money_in(money_in),
			  .en(S_state[0]),
			  .flag(state_flags[0]),
			  .rst(money_rst),
			  .button(button_in_debounce),
			  .in_money_val(money_value)
			  );

	//S_DRINK_OUTER
	drinkouter do_inst (
			    .en(S_state[1]),
			    .drink_out_fin(drink_output_fin_debounce),
			    .drink_contral(drink_contral),
			    .flag(state_flags[1])
			    );

	assign move25 = S_state[2];
	assign outMoneyState = S_state[2] | S_state[3];
	//moneyouter
	moneyouter money_outer_inst (
				     .money(money_value),
				     .clk(clk),
				     .en(outMoneyState),
				     .move25(move25),
				     .money_out(money_out_contral),
				     .flag(state_flags[2])
				     );
	assign state_flags[3] = state_flags[2];

	/////////////////////////////////////////////
	// code end
	/////////////////////////////////////////////
endmodule
