/////////////////////////////////////////////
//               Test Bench
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

`timescale 10ns / 10ns
module tb_ram_2port ();
	/////////////////////////////////////////////
	// parameter and signals
	/////////////////////////////////////////////
	// parameter

	// regs or wires
	reg sclk = 0;
	reg srst_n = 0;

	reg [7:0] address;
	reg [7:0] data;
	reg 	  rden,wden;
	wire [7:0] q;
	/////////////////////////////////////////////
	// main code
	/////////////////////////////////////////////
	// System clock
	always #10 sclk = ~sclk;

	//inital
	initial begin
		#0
			rden = 0;
		wden = 0;
		#30
			wden = 1;
		#40
			wden = 0;
		#20
			rden = 1;
		#40
			rden = 0;
	end

	initial begin
		#0
			address = 0;
		data = 0;
		#30
			address = 1;
		data = 1;
		#20
			address = 2;
		data = 0;
		#20
			address = 0;
		#20
			address = 1;
		#20
			address = 2;
	end

	// models
	ram2_port	ram2_port_inst (
					.data ( data ),
					.rdaddress ( address ),
					.rdclock ( sclk ),
					.wraddress ( address ),
					.wrclock ( sclk ),
					.wren ( wden ),
					.q ( q )
					);



	/////////////////////////////////////////////
	// code end
	/////////////////////////////////////////////
endmodule
