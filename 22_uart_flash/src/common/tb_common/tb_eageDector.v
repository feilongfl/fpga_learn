/////////////////////////////////////////////
//               Test Bench
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

`timescale 10ns / 10ns
module tb_eageDector ();
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter

// regs or wires
reg sclk = 0;
reg srst_n = 0;
reg trig = 0;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
// System clock
always #10 sclk = ~sclk;

//inital
initial begin
    #0
     srst_n = 0;
    trig = 0;
    #30
     srst_n = 1;
    #50
     trig = 1;
    #100
     trig = 0;
end

wire n,p,np;
// models
eageDector ed_test_inst(
               .clk(sclk),
               .signal(trig),
               .signal_posedge(p),
               .signal_negedge(n),
               .signal_dual_eage(np)
           );

/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
