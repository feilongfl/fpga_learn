
`ifdef Quartus
// `include "../sdramCommand.sv"
`else
`include "../src/sdramCommand.sv"
`endif

module sdram_read (
	input clock,

	input enable,
	// output logic finFlag = 0,
	// input preStop,

	output logic[15:0] data,
	input [12:0] rowAddr,
	input [7:0] colAddr,
	input [1:0] BA,

	output readDataClk,

	SDRAM.sdram sdram
);

typedef enum bit[3:0] {
	readSM_idle,
	readSM_initialread,
	readSM_reading,
	readSM_prefinish
} readSM_t;

readSM_t readsm = readSM_idle;

logic[7:0] initcounter = 0;
logic[7:0] prefincounter = 0;
SDRAM_COMMAND sdramCommand = NoOperation;
always_ff @ (negedge clock) begin
	case (readsm)
		readSM_idle: begin
			initcounter <= 0;
			prefincounter <= 0;
			if(enable)
				readsm <= readSM_initialread;
		end

		readSM_initialread: begin
			initcounter <= initcounter + 1;
			case (initcounter)
				1: begin
					sdramCommand <= BankActive;
					$display("At time %t: Command => BankActive",$time);
					sdram.DRAM_ADDR <= rowAddr;
					sdram.DRAM_BA <= BA;
				end
				3: begin
					sdramCommand <= Read;
					$display("At time %t: Command => Read",$time);
					sdram.DRAM_ADDR <= colAddr;
				end
				4: begin
					readsm <= readSM_reading;
				end
				default:
					sdramCommand <= NoOperation;
			endcase
		end

		readSM_reading: begin
			if(!enable)
				readsm <= readSM_prefinish;
		end

		readSM_prefinish: begin
			prefincounter <= prefincounter + 1;
			case (prefincounter)
				0: begin
					sdramCommand <= PrechargeAllBanks;
					sdram.DRAM_ADDR[10] <= 1;
					$display("At time %t: Command => PrechargeAllBanks",$time);
				end
				2: begin
					readsm <= readSM_idle;
				end
				default:
					sdramCommand <= NoOperation;
			endcase
		end

		default:
			readsm <= readSM_idle;
	endcase
end

assign sdram.DRAM_CLK = ~clock;

// logic [15:0] DQtemp = 0;
logic DQWrite = 0;

assign sdram.DRAM_DQ = 15'hzzzz;

assign readDataClk = (readsm == readSM_reading ||
						readsm == readSM_prefinish)? clock : 0;

always_ff @ (posedge clock) begin
	case (readsm)
		readSM_reading,readSM_prefinish: begin
			data <= sdram.DRAM_DQ;
		end
	endcase
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

endmodule
