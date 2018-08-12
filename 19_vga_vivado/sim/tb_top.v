/////////////////////////////////////////////
//               Test Bench
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

`timescale 1ns / 1ns
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
    #30
     srst_n = 1;
end

wire hsync,vsync;
wire ro,go,bo;
wire [7:0] roarr;
wire [7:0] goarr;
wire [7:0] boarr;

wire [15:0] hpixel;
wire [15:0] vpixel;

reg [7:0] r;
reg [7:0] g;
reg [7:0] b;

initial begin
    #0
     r = 255;
    g = 255;
    b = 255;
end

// models
vga vga_test(
        .clk(sclk),
        .rst_n(srst_n),
        .inR(r),
        .inG(g),
        .inB(b),

        .Hsync(hsync),
        .Vsync(vsync),
        .Ro(roarr),
        .Go(goarr),
        .Bo(boarr),

        .HPixel(hpixel),
        .VPixel(vpixel)
    );

/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
