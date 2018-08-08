

`ifdef Quartus
// `include "../sdram_status.sv"
`else
`include "../src/sdram_status.sv"
`endif

module sdram(
	input clock,

	input [12:0] row,
	input [7:0] col,
	input [1:0] ba,
	input [15:0]writeData[3:0],
	input writeDataTrig,
	output logic writeDataClk,

	input readEnable,
	output outdataClk,
	output [15:0] readData,

	SDRAM.sdram sdram
);

StatusSdram_t status_sdram = S_SDRAM_Initial;

// finish flags
logic sdram_flag_initialfin;
logic sdram_flag_writeoncefin;
// logic sdram_flag_writefin = 0;
logic sdram_flag_refershfin;

// requests
logic sdram_request_write = 0;
logic sdram_request_refersh;

// enabler
logic sdram_enable_initial = 0;
logic sdram_enable_writeOnce = 0;
logic sdram_enable_writeOnce_last = 0;
logic sdram_enable_read = 0;
logic sdram_enable_read_quit = 0;
logic sdram_enable_refersh = 0;
logic sdram_enable_refersh_last = 0;

always_comb begin
	sdram_enable_initial = (status_sdram == S_SDRAM_Initial)? 1 : 0;
	sdram_enable_writeOnce = (status_sdram == S_SDRAM_Write_once)? 1 : 0;
	// sdram_enable_write = (status_sdram == S_SDRAM_Write)? 1 : 0;
	sdram_enable_refersh = (status_sdram == S_SDRAM_AutoRefresh)? 1 : 0;
	sdram_enable_read = (status_sdram == S_SDRAM_READ)? 1 : 0;
	sdram_enable_read_quit = (status_sdram == S_SDRAM_READ
		|| status_sdram == S_SDRAM_READ_Quiting)? 1 : 0;
end

always_ff @ (posedge clock) begin
	sdram_enable_refersh_last <= sdram_enable_refersh;
	sdram_enable_writeOnce_last <= sdram_enable_writeOnce;
end

SDRAM init_sdram();
SDRAM refresh_sdram();
SDRAM write_sdram();
SDRAM read_sdram();

sdram_init sdram_init_inst (
	.clock(clock),
	.enable(sdram_enable_initial),
	.finishFlag(sdram_flag_initialfin),
	.sdram(init_sdram.sdram)
);

sdram_refersh sdram_refersh_inst (
	.clock(clock),
	.refershTrig(sdram_enable_refersh & (~sdram_enable_refersh_last)),
	.refershRequest(sdram_request_refersh),
	.refershFinishFlag(sdram_flag_refershfin),
	.sdram(refresh_sdram.sdram)
);

sdram_wronce sdram_wronce_inst(
	.clock(clock),

	.Trig(sdram_enable_writeOnce & (~sdram_enable_writeOnce_last)),
	.finFlag(sdram_flag_writeoncefin),

	.data(writeData),
	.rowAddr(row),
	.colAddr(col),
	.BA(ba),

	.sdram(write_sdram.sdram)
);

sdram_read sdram_read_inst(
	.clock(clock),

	.enable(sdram_enable_read),

	.data(readData),
	.rowAddr(row),
	.colAddr(col),
	.BA(ba),

	.readDataClk(outdataClk),

	.sdram(read_sdram.sdram)
);

sdramSel sdramsel_inst(
	.sdram(sdram),

	.sel({
		sdram_enable_read | sdram_enable_read_quit,
		sdram_enable_writeOnce,
		sdram_enable_refersh,
		sdram_enable_initial
	}),

	.sdram_init(init_sdram.tb),
	.sdram_write(refresh_sdram.tb),
	.sdram_refersh(write_sdram.tb),
	.sdram_read(read_sdram.tb)
	);

// int debug_i = 0;
// always_ff @ (posedge sdram_flag_refershfin) begin
// 	debug_i <= debug_i + 1;
// 	if (debug_i == 2) begin
// 		$finish;
// 	end
// end
logic[1:0] read_quit_delay_counter = 0;
always_ff @ (posedge clock) begin
	case (status_sdram)
		S_SDRAM_Initial:
			if(sdram_flag_initialfin)
				status_sdram <= S_SDRAM_ARBIT;

		S_SDRAM_ARBIT: begin
			if(sdram_request_refersh) begin
				status_sdram <= S_SDRAM_AutoRefresh;
			end
			else if(sdram_request_write)
				status_sdram <= S_SDRAM_Write_once;
			else if(readEnable)
				status_sdram <= S_SDRAM_READ;
		end
		// S_SDRAM_Write: ;
		S_SDRAM_Write_once:
			if(sdram_flag_writeoncefin)
				status_sdram <= S_SDRAM_ARBIT;
		S_SDRAM_AutoRefresh:
			if(sdram_flag_refershfin)
				status_sdram <= S_SDRAM_ARBIT;

		S_SDRAM_READ:
			if(!readEnable || sdram_request_refersh) begin
				status_sdram <= S_SDRAM_READ_Quiting;
				read_quit_delay_counter <= 0;
			end

		S_SDRAM_READ_Quiting: begin
			read_quit_delay_counter <= read_quit_delay_counter + 1;
			status_sdram <= (read_quit_delay_counter == 2)? S_SDRAM_ARBIT : status_sdram;
		end
		default:
			status_sdram <= S_SDRAM_Initial;
	endcase
end

// write data
// input [3:0]writeData,
// input writeDataEnable,
// output writeDataClk,
logic writeDataTrigLast = 0;
logic[15:0] writeDataBuff[3:0];

always_ff @ (posedge clock) begin
	writeDataTrigLast <= writeDataTrig;
end

// always_ff @ (posedge clock or posedge writeDataEnable or posedge sdram_flag_writefin) begin
always_ff @ (posedge clock) begin
	if(writeDataTrig & (~writeDataTrigLast)) begin
		writeDataClk <= 1;
		// sdram_request_write <= 1;
	end
	else if(sdram_flag_writeoncefin & writeDataTrig) begin
		writeDataClk <= 1;
	end else begin
		writeDataClk <= 0;
	end
end

always_ff @ (negedge writeDataClk or posedge sdram_flag_writeoncefin) begin
	if(sdram_flag_writeoncefin) begin
		sdram_request_write <= 0;
	end else begin
		writeDataBuff <= writeData;
		sdram_request_write <= 1;
	end
end

endmodule
