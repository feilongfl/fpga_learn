`ifdef Quartus
// `include "../sdramCommand.sv"
`else
`include "../src/sdramCommand.sv"
`endif

module sdram_refersh (
	input clock,
	// input enable,

	input refershTrig,
	output logic refershRequest,
	output logic refershFinishFlag,

	SDRAM.sdram sdram
);

int unsigned refershClock = 0;
logic [2:0]  refershCtlClock = 0;
SDRAM_COMMAND command = NoOperation;

assign sdram.DRAM_CLK = ~clock;

always_ff @ (posedge clock or posedge refershFinishFlag) begin
	refershClock <= (refershFinishFlag)? 0 : refershClock + 1;
end

always_ff @ (posedge clock) begin
	refershRequest <= (refershClock <= 7700)? 0 : 1;
end

always_ff @ (negedge clock or posedge refershTrig) begin
	if(refershTrig) begin
		refershCtlClock <= 1;
	end else begin
		refershCtlClock <= (refershCtlClock == 0 || refershCtlClock == 4)? 0 : refershCtlClock + 1;
		case (refershCtlClock)
			1: begin
				command <= AutoRefresh;
				$display("At time %t: Command => AutoRefresh",$time);
			end
			// 2,3: command <= NoOperation;
			4: begin
				refershFinishFlag <= 1;
				$display("At time %t: Flag => refershFinishFlag",$time);
			end
			default: begin
				command <= NoOperation;
				refershFinishFlag <= 0;
			end
		endcase
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
	} <= command;
end



endmodule // sdram_refersh
