	uart u0 (
		.address    (<connected-to-address>),    // avalon_rs232_slave.address
		.chipselect (<connected-to-chipselect>), //                   .chipselect
		.byteenable (<connected-to-byteenable>), //                   .byteenable
		.read       (<connected-to-read>),       //                   .read
		.write      (<connected-to-write>),      //                   .write
		.writedata  (<connected-to-writedata>),  //                   .writedata
		.readdata   (<connected-to-readdata>),   //                   .readdata
		.clk        (<connected-to-clk>),        //                clk.clk
		.UART_RXD   (<connected-to-UART_RXD>),   // external_interface.RXD
		.UART_TXD   (<connected-to-UART_TXD>),   //                   .TXD
		.irq        (<connected-to-irq>),        //          interrupt.irq
		.reset      (<connected-to-reset>)       //              reset.reset
	);

