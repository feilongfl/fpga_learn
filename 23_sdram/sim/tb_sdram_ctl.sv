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

	initial begin
		writeData[0] = 1;
		writeData[1] = 2;
		writeData[2] = 3;
		writeData[3] = 4;
		#300us
		writeDataEnable = 1;
	end

	sdram_ctl sdram_ctl_inst(
		.clock(sclk),

		.writeData(writeData),
		.writeDataEnable(writeDataEnable),
		.writeDataClk(writeDataClk),

		.sdram(sdram.sdram)
	);

	sdram_model sdram_model_inst(
		.sdram(sdram.tb)
	);

	/////////////////////////////////////////////
	// code end
	/////////////////////////////////////////////
endmodule
