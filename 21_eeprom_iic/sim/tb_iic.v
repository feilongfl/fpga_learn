/////////////////////////////////////////////
//               Test Bench
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

`timescale 10ns / 10ns
module tb_iic ();
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
    #760
     srst_n = 0;
end

wire[7:0] rdata;
wire flag,iclk;
wire sdata;

// models
iic iic_test_inst(
        . clk(sclk),
        . en(srst_n),

        . data(8'b1010_1010),
        . readdata(rdata),

        . flag,

        .  iclk,
        . sdata(sdata)
    );

/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
