/////////////////////////////////////////////
//               Test Bench
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

`timescale 10ns / 10ns
module tb_uart ();
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter

// regs or wires
reg sclk = 0;
reg srst_n = 0;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
// System clock
always #10 sclk = ~sclk;

//inital
initial begin
    #0
     srst_n = 0;
    #30
     srst_n = 1;
    #10 srst_n = 0;
end

reg [7:0]data_tx = 8'b10101010;
wire[7:0]data_rx;
wire datareadFlag;

reg [31 : 0] databuffer;
wire tx;
always @ (posedge sclk) begin
    databuffer <= {databuffer[30:0],tx};
end
// models
uart uart_test_inst(
         //clock
         .clk(sclk),

         //flags
         .tx_trig(srst_n),
         .rx_flag(datareadFlag),

         //data interface
         .data_tx(data_tx),
         .data_rx(data_rx),

         //interface
         .tx(tx),
         .rx(databuffer[31])
     );

/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
