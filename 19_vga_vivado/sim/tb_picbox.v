/////////////////////////////////////////////
//               Test Bench
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

`timescale 1ns / 1ns
module tb_picbox ();
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
end

wire hsync,vsync,r,g,b;
// models
hj_move temp_inst(
            .srst(srst_n),
            .sclk(sclk),
            .hsync(hsync),
            .vsync(vsync),
            .r(r),
            .g(g),
            .b(b)
        );

/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
