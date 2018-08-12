/////////////////////////////////////////////
//               Test Bench
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

`timescale 10ns / 10ns
module tb_sm ();
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
wire[3:0] state;

reg rx = 1;

initial begin
    #0 rx = 1;
    #43 rx = 0;

    #20 rx = 1;
    #20 rx = 0;
    #20 rx = 1;
end
// models
sm sm_inst(
       .clk(sclk),
       .rx(rx),
       .state(state)
   );

/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
