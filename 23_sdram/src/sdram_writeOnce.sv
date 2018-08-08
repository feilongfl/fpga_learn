
`ifdef Quartus
// `include "../sdramCommand.sv"
`else
`include "../src/sdramCommand.sv"
`endif

module sdram_wronce(
	input clock,

	input Trig,
	output logic finFlag = 0,

	input[15:0] data[3:0],
	input [12:0] rowAddr,
	input [7:0] colAddr,
	input [1:0] BA,

	SDRAM.sdram sdram
);

int unsigned 	 timecounter = 0;
parameter CLK_Time_ns = 20;
SDRAM_COMMAND sdramCommand = NoOperation;

logic enable = 0;

assign sdram.DRAM_CLK = ~clock;

always_ff @ (posedge Trig or posedge finFlag) begin
	if(Trig) begin
		enable <= 1;
		$display("At time %t: Trig => writeonce",$time);
	end else if(finFlag) begin
		enable <= 0;
	end
end

always_ff @ (posedge clock) begin
	timecounter <= (enable)? timecounter + 1 : 0;
end
logic [15:0] DQtemp = 0;
assign sdram.DRAM_DQ = (enable) ? DQtemp : 16'hzzzz;

always_ff @ (negedge clock) begin
	case (timecounter)
		1:begin
			sdramCommand <= BankActive;
			$display("At time %t: Command => BankActive",$time);
			finFlag <= 0;
		end
		3:begin
			sdramCommand <= Write;
			$display("At time %t: Command => sdram_write",$time);
			finFlag <= 0;
		end
		4,5,6: begin
			sdramCommand <= NoOperation;
			finFlag <= 0;
		end
		7: begin
			sdramCommand <= PrechargeAllBanks;
			$display("At time %t: Command => PrechargeAllBanks",$time);
		end
		8: begin
			finFlag <= 1;
			$display("At time %t: Flag => writeonce fin",$time);
		end
		default: begin
			sdramCommand <= NoOperation;
			finFlag <= 0;
		end
	endcase
end

always_ff @ (posedge clock) begin
	if(timecounter >= 3 && timecounter < 3 + 4)begin
		DQtemp <= data[timecounter - 3];
		$display("At time %t: write => %d",$time,data[timecounter - 3]);
	end
end

always_ff @ (posedge clock) begin
	{
		sdram.DRAM_CKE,
		sdram.DRAM_CS_N,
		sdram.DRAM_RAS_N,
		sdram.DRAM_CAS_N,
		sdram.DRAM_WE_N,
		sdram.DRAM_LDQM,
		sdram.DRAM_UDQM
	} <= sdramCommand;
end

always_ff @ (posedge clock) begin
case (sdramCommand)
	BankActive: begin
		sdram.DRAM_ADDR <= rowAddr;
		sdram.DRAM_BA <= BA;
	end
	Write: begin
		sdram.DRAM_ADDR <= colAddr;
		sdram.DRAM_BA <= BA;
	end
	PrechargeAllBanks: begin
		sdram.DRAM_ADDR[10] <= 1;//all bank
	end
	default: ;
endcase
end

endmodule
