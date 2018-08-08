/////////////////////////////////////////////
//               Test Bench
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

`timescale 1ns / 1ns
module tb_sdram_ctl ();
	/////////////////////////////////////////////
	// parameter and signals
	/////////////////////////////////////////////
	// parameter

	// regs or wires
    reg sclk = 0;
    reg srst_n = 0;
    reg trig = 0;
    /////////////////////////////////////////////
    // main code
    /////////////////////////////////////////////
    // System clock
    always #10 sclk = ~sclk;

    //inital
    initial begin
        #0
         srst_n = 0;
        trig = 0;
        #30
         srst_n = 1;
        #10
         trig = 1;
        #10
         trig = 0;
    end

	// models


	SDRAM sdram();


	logic [15:0]writeData[3:0];
	logic writeDataEnable = 0;
	logic writeDataClk;

	int unsigned i = 0;

	logic [8:0] col;
	logic [13:0]row;
	logic [2:0]ba;
	always_ff @ (posedge writeDataClk) begin
		i <= i + 1;

		{ba,row,col} <= 4 * i;

		writeData[0] <= 4*i;
		writeData[1] <= 4*i+1;
		writeData[2] <= 4*i+2;
		writeData[3] <= 4*i+3;
	end

	always_ff @ (posedge sclk) begin
		writeDataEnable = (writeDataClk || i > 1000)? 0 : 1;
	end

logic[15:0] rData;
logic outdataclk;
logic readEnable = 0;

initial begin
	#300us
	readEnable = 1;
	{ba,row,col} = 0;
	#100us
	readEnable = 0;
end

	sdram sdram_ctl_inst(
		.clock(sclk),

		.row(row),
		.col(col),
		.ba(ba),

		.writeData(writeData),
		.writeDataTrig(writeDataEnable),
		.writeDataClk(writeDataClk),

		.readEnable(readEnable),
		.outdataClk(outdataclk),
		.readData(rData),

		.sdram(sdram.sdram)
	);

	sdram_model sdram_model_inst(
		.sdram(sdram.tb)
	);

	/////////////////////////////////////////////
	// code end
	/////////////////////////////////////////////
endmodule
