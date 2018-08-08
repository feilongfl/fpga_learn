
typedef enum {
	S_SDRAM_Initial,
	S_SDRAM_ARBIT,
	S_SDRAM_AutoRefresh,
	// S_SDRAM_Write,
	S_SDRAM_Write_once,
	S_SDRAM_READ
} StatusSdram_t;

module sdram_ctl(
	input clock,

	input [15:0]writeData[3:0],
	input writeDataEnable,
	output logic writeDataClk,

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
// logic sdram_enable_write = 0;
logic sdram_enable_refersh = 0;
logic sdram_enable_refersh_last = 0;

always_comb begin
	sdram_enable_initial = (status_sdram == S_SDRAM_Initial)? 1 : 0;
	sdram_enable_writeOnce = (status_sdram == S_SDRAM_Write_once)? 1 : 0;
	// sdram_enable_write = (status_sdram == S_SDRAM_Write)? 1 : 0;
	sdram_enable_refersh = (status_sdram == S_SDRAM_AutoRefresh)? 1 : 0;
end

always_ff @ (posedge clock) begin
	sdram_enable_refersh_last <= sdram_enable_refersh;
	sdram_enable_writeOnce_last <= sdram_enable_writeOnce;
end

SDRAM init_sdram();
SDRAM refresh_sdram();
SDRAM write_sdram();

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
	.rowAddr(0),
	.colAddr(0),
	.BA(0),

	.sdram(write_sdram)
);

sdramSel sdramsel_inst(
	.sdram(sdram),

	.sel({sdram_enable_writeOnce,sdram_enable_refersh,sdram_enable_initial}),

	.sdram_init(init_sdram.tb),
	.sdram_write(refresh_sdram.tb),
	.sdram_refersh(write_sdram.tb)
	);

always_ff @ (posedge clock) begin
	case (status_sdram)
		S_SDRAM_Initial:
			if(sdram_flag_initialfin)
				status_sdram <= S_SDRAM_ARBIT;

		S_SDRAM_ARBIT: begin
			if(sdram_request_refersh)
				status_sdram <= S_SDRAM_AutoRefresh;
			else if(sdram_request_write)
				status_sdram <= S_SDRAM_Write_once;
		end
		// S_SDRAM_Write: ;
		S_SDRAM_Write_once:
			if(sdram_flag_writeoncefin)
				status_sdram <= S_SDRAM_ARBIT;
		S_SDRAM_AutoRefresh:
			if(sdram_flag_refershfin)
				status_sdram <= S_SDRAM_ARBIT;

		default:
			status_sdram <= S_SDRAM_Initial;
	endcase
end

// write data
// input [3:0]writeData,
// input writeDataEnable,
// output writeDataClk,
logic writeDataEnableLast = 0;
logic[15:0] writeDataBuff[3:0];

always_ff @ (posedge clock) begin
	writeDataEnableLast <= writeDataEnable;
end

// always_ff @ (posedge clock or posedge writeDataEnable or posedge sdram_flag_writefin) begin
always_ff @ (posedge clock) begin
	if(writeDataEnable & (~writeDataEnableLast)) begin
		writeDataClk <= 1;
		// sdram_request_write <= 1;
	end
	else if(sdram_flag_writeoncefin & writeDataEnable) begin
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
