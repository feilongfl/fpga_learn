/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////
// `include "../src/sdram_iface.sv"

`ifdef Quartus
// `include "../sdramCommand.sv"
`else
`include "../src/sdramCommand.sv"
`endif

module sdram_init (
	input clock,
	input enable,
	output logic finishFlag,
	SDRAM.sdram sdram
);

	//values
	int unsigned 	 timecounter = 0;
	parameter CLK_Time_ns = 20;

	// always blocks
always_ff @ (posedge clock) begin
	timecounter <= (enable)? timecounter + 1 : 0;
end

assign sdram.DRAM_CLK = ~clock;

SDRAM_COMMAND command = NoOperation;

always_ff @ (negedge clock) begin
//CKEn-1 CKEn CS RAS CAS WE DQM ADDR A10/AP BA
	case (timecounter)
		200000 / CLK_Time_ns: begin
			command <= PrechargeAllBanks;
			$display("At time %t: Command => PrechargeAllBanks",$time);
		end
		200000 / CLK_Time_ns + 2,
		200000 / CLK_Time_ns + 6: begin
			command <= AutoRefresh;
			$display("At time %t: Command => AutoRefresh",$time);
		end
		200000 / CLK_Time_ns + 10: begin
			command <= ModeRegisterSet;
			$display("At time %t: Command => ModeRegisterSet",$time);
		end
		200000 / CLK_Time_ns + 12: begin
			finishFlag <= 1;
			$display("At time %t: FLAG => INITIAL FINISH",$time);
		end
		default: begin
			finishFlag <= 0;
			command <= NoOperation;
		end
	endcase
end

always @ (posedge clock) begin
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

always_ff @ (posedge clock) begin
	case (command)
		ModeRegisterSet: begin
			// sdram.DRAM_ADDR <= 13'b000_0_00_010_0_010;//todo
			// sdram.DRAM_BA <= 2'b00;
			{sdram.DRAM_BA,sdram.DRAM_ADDR} <= 15'b00000_0_00_010_0_010;
		end
		PrechargeAllBanks:
			sdram.DRAM_ADDR[10] <= 1;
		default: ;
	endcase
end

endmodule//sdram_init
