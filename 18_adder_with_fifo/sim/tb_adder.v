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
    #10
     srst_n = 1;
end

reg [7:0] data_gen = 0;
wire[9:0] sum;

always @ (negedge sclk) begin
    data_gen <= (data_gen == 55)? 1 : data_gen + 1;
end
// models
adder adder_test(
          .clk(sclk),
          .en(srst_n),
          .indata(data_gen),
          .sum(sum)
      );

/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
