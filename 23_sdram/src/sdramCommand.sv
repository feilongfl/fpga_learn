typedef enum bit[6:0]{
	NoOperation = 7'b1100000,
	PrechargeAllBanks = 7'b1001000,
	AutoRefresh = 7'b1000100,
	ModeRegisterSet = 7'b1000000,

	BankActive = 7'b1001100,
	Write = 7'b1010000,
	Read = 7'b1010100
	// Precharge = 7'b1001000
}
SDRAM_COMMAND;
