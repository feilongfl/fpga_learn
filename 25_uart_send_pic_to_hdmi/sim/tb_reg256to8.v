/////////////////////////////////////////////
//               Test Bench
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

`timescale 10ns / 10ns
module tb_reg256to8 ();
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
    #10
     trig = 1;
    #10
     trig = 0;
    #30
     srst_n = 1;
end

reg [255:0]data256_wire = 256'haf00ae00ac00_ab00aa00a900a800_a700a600a500a000_a400a300a200a100_a000;
// wire[255:0]data256;
wire[7:0]data8;
wire last_wire;
// models
reg256to8 reg256to8_inst (
              .rdclock(sclk & srst_n),
              // .wren(trig),
              .data256(data256_wire),
              .last(last_wire),
              .data8(data8)
          );
/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
