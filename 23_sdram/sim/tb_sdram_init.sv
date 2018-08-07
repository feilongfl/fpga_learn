/////////////////////////////////////////////
//               Test Bench
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////
// `include "../src/sdram_iface.sv"
`timescale 10ns / 10ns
module tb_top ();
	/////////////////////////////////////////////
	// parameter and signals
	/////////////////////////////////////////////
	// parameter

	// regs or wires
    bit sclk = 0;
    bit srst_n = 0;
    bit trig = 0;
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

	wire [15:0]DRAM_DQ;
	wire[11:0] DRAM_ADDR;
	wire[1:0] DRAM_BA;
	wire DRAM_CLK;
	wire DRAM_CKE;
	wire DRAM_LDQM;
	wire DRAM_UDQM;
	wire DRAM_WE_N;
	wire DRAM_CAS_N;
	wire DRAM_RAS_N;
	wire DRAM_CS_N;

	SDRAM sdram();

	// models
	sdram_init sdram_init_inst (
		sclk,srst_n,
		sdram.sdram
	);

	sdram_model_plus sdram_model_plus_inst (
		.Dq(DRAM_DQ),
		.Addr(DRAM_ADDR),
		.Ba(DRAM_BA),
		.Clk(DRAM_CLK),
		.Cke(DRAM_CKE),
		.Cs_n(DRAM_CS_N),
		.Ras_n(DRAM_RAS_N),
		.Cas_n(DRAM_CAS_N),
		.We_n(DRAM_WE_N),
		// .Dqm(),
		.Debug(1'b1)
	);
	defparam sdram_model_plus_inst.addr_bits = 12;
	defparam sdram_model_plus_inst.data_bits = 16;
	defparam sdram_model_plus_inst.col_bits = 8;
	defparam sdram_model_plus_inst.mem_sizes = 64 * 1024 * 1024 - 1;
	/////////////////////////////////////////////
	// code end
	/////////////////////////////////////////////
endmodule
