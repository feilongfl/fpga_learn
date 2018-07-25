
module uart (
	address,
	chipselect,
	byteenable,
	read,
	write,
	writedata,
	readdata,
	clk,
	UART_RXD,
	UART_TXD,
	irq,
	reset);	

	input		address;
	input		chipselect;
	input	[3:0]	byteenable;
	input		read;
	input		write;
	input	[31:0]	writedata;
	output	[31:0]	readdata;
	input		clk;
	input		UART_RXD;
	output		UART_TXD;
	output		irq;
	input		reset;
endmodule
