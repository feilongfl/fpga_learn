/////////////////////////////////////////////
//               Test Bench
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

`timescale 10ns / 10ns
module tb_spi_read_write ();
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
    #90
     srst_n = 0;
end

wire spi_clk;
wire spi_cs;
wire spi_do;
wire isbusy;
wire [127:0] recvdata;

reg spi_di = 1;
reg [7:0] datalength = 8;
reg [127:0] senddata = 8'hc7;

// models
spictl earseflash_inst(
           .sclk(sclk),
           .spi_di(spi_di),
           .trig(srst_n),
           .datalength(datalength),
           .senddata(senddata),
           .spi_clk(spi_clk),
           .spi_cs(spi_cs),
           .spi_do(spi_do),
           .isbusy(isbusy),
           .recvdata(recvdata)
       );

/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
