/* Quartus II 64-Bit Version 13.1.0 Build 162 10/23/2013 SJ Web Edition */
JedecChain;
	FileRevision(JESD32A);
	DefaultMfr(6E);

	P ActionCode(Ign)
		Device PartName(EP4CE6E22) MfrSpec(OpMask(0) FullPath("D:/fpga/19_vga/src/output_files/vga.sof"));
	P ActionCode(Cfg)
		Device PartName(EP4CE6) Path("D:/fpga/19_vga/src/") File("output_file.jic") MfrSpec(OpMask(1) SEC_Device(EPCS4) Child_OpMask(1 1));

ChainEnd;

AlteraBegin;
	ChainType(JTAG);
AlteraEnd;
