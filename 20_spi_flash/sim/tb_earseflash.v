/////////////////////////////////////////////
//               Test Bench
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

`timescale 10ns / 10ns
module tb_earseflash ();
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
     srst_n = 1;
    #30
     srst_n = 0;
    #5
     srst_n = 1;
end
reg temp = 1;

wire spi_clk,spi_do,spi_cs;
// models
earseflash ef_inst(
               . button(srst_n),
               . sclk(sclk),

               . spi_clk(spi_clk),
               . spi_do(spi_do),
               . spi_di(temp),
               . spi_cs(spi_cs)
           );

/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
