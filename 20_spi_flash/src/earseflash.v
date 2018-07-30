/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module earseflash (
           input  button,
           input sclk,

           output spi_clk,
           output spi_do,
           input spi_di,
           output spi_cs
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter

// regs or wires
wire trig,isbusy;
reg [7:0] datalength = 8;
reg [127:0] senddata = 8'hc7;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
assign trig = (!button) & isbusy;

spictl earseflash_inst(
           .sclk(sclk),
           .spi_di(spi_di),
           .trig(trig),
           .datalength(datalength),
           .senddata(senddata),
           .spi_clk(spi_clk),
           .spi_cs(spi_cs),
           .spi_do(spi_do),
           .isbusy(isbusy),
           .recvdata()
       );


/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
