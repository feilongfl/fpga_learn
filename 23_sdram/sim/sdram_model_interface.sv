
module sdram_model (
	SDRAM.tb sdram
	);

sdram_model_plus sdram_model_plus_inst (
	.Dq(sdram.DRAM_DQ),
	.Addr(sdram.DRAM_ADDR),
	.Ba(sdram.DRAM_BA),
	.Clk(sdram.DRAM_CLK),
	.Cke(sdram.DRAM_CKE),
	.Cs_n(sdram.DRAM_CS_N),
	.Ras_n(sdram.DRAM_RAS_N),
	.Cas_n(sdram.DRAM_CAS_N),
	.We_n(sdram.DRAM_WE_N),
	// .Dqm(Dqm),
	.Debug(1'b1)
);
defparam sdram_model_plus_inst.addr_bits = 12;
defparam sdram_model_plus_inst.data_bits = 16;
defparam sdram_model_plus_inst.col_bits = 8;
// defparam sdram_model_plus_inst.mem_sizes = 64 * 1024 * 1024 - 1;

endmodule // sdram_model
