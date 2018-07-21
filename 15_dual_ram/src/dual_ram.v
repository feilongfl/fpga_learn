/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module dual_ram (
		 input 	       clk,
		 output [15:0] data_out1,
		 output [15:0] data_out2
		 );
	/////////////////////////////////////////////
	// parameter and signals
	/////////////////////////////////////////////
	// parameter

	// regs or wires
	reg [15:0] 	       data = 16'b0;
	reg [9:0] 	       address = 10'b0;
	/////////////////////////////////////////////
	// main code
	/////////////////////////////////////////////
	always @ (posedge clk) begin
		data <= (data == 1023)? 0 : data + 1;
	end

	always @ (posedge clk) begin
		address <= address + 1;
	end

	ram_2port	ram1 (
			      .data ( data ),
			      .rdaddress ( address[8:0] ),
			      .rdclock ( clk ),
			      .wraddress ( address[8:0] ),
			      .wrclock ( clk ),
			      .wren ( ~address[8] ),
			      .q ( data_out1 )
			      );


	ram_2port	ram2 (
			      .data ( data ),
			      .rdaddress ( address[8:0] ),
			      .rdclock ( clk ),
			      .wraddress ( address[8:0] ),
			      .wrclock ( clk ),
			      .wren ( address[8] ),
			      .q ( data_out2)
			      );


	/////////////////////////////////////////////
	// code end
	/////////////////////////////////////////////
endmodule
