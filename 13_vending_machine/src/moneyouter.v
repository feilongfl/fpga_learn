/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module moneyouter (
		   input [7:0] 	    money,
		   input 	    clk,
		   input 	    en,
		   input 	    move25,
		   output reg [3:0] money_out,
		   output reg 	    flag
		   );
	/////////////////////////////////////////////
	// parameter and signals
	/////////////////////////////////////////////
	// parameter

	// regs or wires
	reg [7:0] 		    money_remain = 0;
	/////////////////////////////////////////////
	// main code
	/////////////////////////////////////////////
	reg 			    en_sig = 0;
	reg 			    en_last = 0;

	// posedge en checker
	always @ (posedge clk) begin
		en_sig <= en & (~en_last);
		en_last <= en;
	end
	
	always @ (posedge clk or posedge en_sig) begin
		if (en_sig & ~flag) begin
			money_out = 4'b1111;
			money_remain = (move25)? money - 25 : money;
			flag = 1;
		end else begin
			money_out = 4'b1111;
			if (money_remain >= 50) begin
				money_remain = money_remain - 50;
				money_out[3] = 0;
			end  if (money_remain >= 20) begin
				money_remain = money_remain - 20;
				money_out[2] = 0;
			end  if (money_remain >= 10) begin
				money_remain = money_remain - 10;
				money_out[1] = 0;
			end  if (money_remain >= 5) begin
				money_remain = money_remain - 5;
				money_out[0] = 0;
			end if (money_out == 4'b1111) begin
				flag = 0;
			end
		end
	end


	/////////////////////////////////////////////
	// code end
	/////////////////////////////////////////////
endmodule
