/////////////////////////////////////////////
//               Test Bench
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

`timescale 10ns / 10ns
module tb_flash_rw ();
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
    #30 srst_n = 0;
end

wire spi_clk,spi_do,spi_cs;
wire[7:0] spi_dro;
// models
flash flash_test_inst(
          .  sclk(sclk),
          .  en(srst_n),
          .  spi_di(1),
          .  spi_clk(spi_clk),
          .  spi_do(spi_do),
          .  spi_cs(spi_cs),
          .  datareadout(spi_dro)
      );

/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
