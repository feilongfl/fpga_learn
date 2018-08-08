module sdramSel(
	SDRAM.sdram sdram,

	input [2:0] sel,

	SDRAM.tb sdram_init,
	SDRAM.tb sdram_write,
	SDRAM.tb sdram_refersh
	);

// assign	sdram.DRAM_DQ = (sdram_init.DRAM_DQ & sel[0]) | (sdram_write.DRAM_DQ & sel[1]) | (sdram_refersh.DRAM_DQ & sel[2]);
// assign	sdram.DRAM_ADDR = (sdram_init.DRAM_ADDR & sel[0]) | (sdram_write.DRAM_ADDR & sel[1]) | (sdram_refersh.DRAM_ADDR & sel[2]);
// assign	sdram.DRAM_BA = (sdram_init.DRAM_BA & sel[0]) | (sdram_write.DRAM_BA & sel[1]) | (sdram_refersh.DRAM_BA & sel[2]);
assign	sdram.DRAM_DQ = (sel == 3'b001)? sdram_init.DRAM_DQ :
						((sel == 3'b010)? sdram_write.DRAM_DQ :
						sdram_refersh.DRAM_DQ);

assign	sdram.DRAM_ADDR = (sel == 3'b001)? sdram_init.DRAM_ADDR :
						((sel == 3'b010)? sdram_write.DRAM_ADDR :
						sdram_refersh.DRAM_ADDR);

assign	sdram.DRAM_BA = (sel == 3'b001)? sdram_init.DRAM_BA :
						((sel == 3'b010)? sdram_write.DRAM_BA :
						sdram_refersh.DRAM_BA);

assign	sdram.DRAM_CLK = (sdram_init.DRAM_CLK & sel[0]) | (sdram_write.DRAM_CLK & sel[1]) | (sdram_refersh.DRAM_CLK & sel[2]);
assign	sdram.DRAM_CKE = (sdram_init.DRAM_CKE & sel[0]) | (sdram_write.DRAM_CKE & sel[1]) | (sdram_refersh.DRAM_CKE & sel[2]);
assign	sdram.DRAM_LDQM = (sdram_init.DRAM_LDQM & sel[0]) | (sdram_write.DRAM_LDQM & sel[1]) | (sdram_refersh.DRAM_LDQM & sel[2]);
assign	sdram.DRAM_UDQM = (sdram_init.DRAM_UDQM & sel[0]) | (sdram_write.DRAM_UDQM & sel[1]) | (sdram_refersh.DRAM_UDQM & sel[2]);
assign	sdram.DRAM_WE_N = (sdram_init.DRAM_WE_N & sel[0]) | (sdram_write.DRAM_WE_N & sel[1]) | (sdram_refersh.DRAM_WE_N & sel[2]);
assign	sdram.DRAM_CAS_N = (sdram_init.DRAM_CAS_N & sel[0]) | (sdram_write.DRAM_CAS_N & sel[1]) | (sdram_refersh.DRAM_CAS_N & sel[2]);
assign	sdram.DRAM_RAS_N = (sdram_init.DRAM_RAS_N & sel[0]) | (sdram_write.DRAM_RAS_N & sel[1]) | (sdram_refersh.DRAM_RAS_N & sel[2]);
assign	sdram.DRAM_CS_N = (sdram_init.DRAM_CS_N & sel[0]) | (sdram_write.DRAM_CS_N & sel[1]) | (sdram_refersh.DRAM_CS_N & sel[2]);

endmodule