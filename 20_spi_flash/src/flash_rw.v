/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module flash_rw (
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
wire isbusy;
wire [7:0] datalength = 8;
wire [127:0] senddata = 8'hc7;

reg [31:0]cnt = 0;
reg trig = 0;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
always@(posedge sclk) begin
    cnt <= (cnt == 2000000)? 0 :cnt + 1;
    trig <= (cnt == 10 || cnt == 11)? 1 : 0;
    //datalength <= 8;
    //senddata <= 8'hc7;
end


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
