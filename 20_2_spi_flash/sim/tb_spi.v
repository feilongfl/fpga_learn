/////////////////////////////////////////////
//               Test Bench
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

`timescale 10ns / 10ns
module tb_top ();
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
    #50
     srst_n = 1;
    #400
     srst_n = 0;
end


wire spi_clk,spi_do,spi_cs;
reg spi_di = 1;

initial begin
    #300 spi_di = 0;
end

wire flag;
wire[7:0]rdata;

reg [7:0]sdata = 8'h06;
// models
spi spi_inst(
        .  sclk(sclk),
        . en(srst_n),
        .  dataflag(flag),
        .  datasend(sdata),
        . datarecv(rdata),

        // to hardware
        . spi_clk(spi_clk),
        . spi_di(spi_di),
        .  spi_do(spi_do),
        . spi_cs(spi_cs)
    );

/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
