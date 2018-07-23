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

reg[43:0] txdata = 'b11111111_0_10111001_1_11111111_0_11001011_1_11111111;
wire test_clk;
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


// models
clock test_clock(
          .clk(sclk),
          .en(srst_n),
          .oclk(test_clk)
      );

always @ (negedge test_clk) begin
    txdata <= {txdata[42:0],txdata[43]};
end

wire [7:0] dataout;
uart uart_inst(
         .sclk(sclk),
         .rx(txdata[25]),
         .data(dataout)
     );
/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
