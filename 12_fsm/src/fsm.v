/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module fsm (
	    input  clk,
	    input  rst_n,

	    //
	    input  i_val,
	    output o_val
	    );
	/////////////////////////////////////////////
	// parameter and signals
	/////////////////////////////////////////////
	// parameter
	// origin
	localparam  S_BYTE_1 = 3'd0;
	localparam  S_BYTE_2 = 3'd1;
	localparam  S_BYTE_3 = 3'd2;
	localparam  S_BYTE_4 = 3'd3;
	localparam  S_BYTE_5 = 3'd4;
	localparam  S_BYTE_6 = 3'd5;
	localparam  S_BYTE_7 = 3'd6;
	localparam  S_BYTE_MATCH = 3'd7;
	reg [2:0]  state = S_BYTE_1;
	// regs or wires

	/////////////////////////////////////////////
	// main code
	/////////////////////////////////////////////
	// 1001101
	always @ (posedge clk or negedge rst_n) begin
		if(!rst_n)
			state <= 0;
		else case(state)
			     S_BYTE_1:
				     state <= (i_val)? S_BYTE_2 : S_BYTE_1;
			     S_BYTE_2:
				     // unlimit wave langth
				     state <= (!i_val)? S_BYTE_3 : S_BYTE_2;
			     S_BYTE_3:
				     // same as top
				     state <= (!i_val)? S_BYTE_4 : S_BYTE_2;
			     S_BYTE_4:
				     state <= (i_val)? S_BYTE_5 : S_BYTE_1;
			     S_BYTE_5:
				     state <= (i_val)? S_BYTE_6 : S_BYTE_3;
			     S_BYTE_6:
				     state <= (!i_val)? S_BYTE_7 : S_BYTE_2;
			     S_BYTE_7:
				     state <= (i_val)? S_BYTE_MATCH : S_BYTE_1;
			     S_BYTE_MATCH:
				     state <= (i_val)? S_BYTE_2 : S_BYTE_1;
			     default:
				     state <= S_BYTE_1;
		     endcase
	end

	assign o_val = (S_BYTE_MATCH == state) ? 1 : 0;



	/////////////////////////////////////////////
				     // code end
	/////////////////////////////////////////////
endmodule