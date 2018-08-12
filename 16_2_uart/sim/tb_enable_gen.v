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
    #30
     srst_n = 1;
end

reg rx = 1;

initial begin
    #0 rx = 1;
    #10 rx = 1;
    #23 rx = 0;
    #20 rx = 0;
    #20 rx = 1;
    #10 rx = 0;
    #20 rx = 1;
end

wire out;
// models
rx_recode_enable_gen rr_inst(
                         .clk(sclk),
                         .rx(rx),
                         .en(out)
                     );

/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
