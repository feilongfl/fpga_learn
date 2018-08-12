/////////////////////////////////////////////
//               Test Bench
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

`timescale 10ns / 10ns
module tb_writeRamAddrGen ();
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter

// regs or wires
reg sclk = 0;
reg srst_n = 0;
reg trig = 0;

reg [7:0]dataLength = 2;
wire fin;
wire [7:0] addr;
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
    #1200 srst_n = 0;
    // #200 srst_n = 1;
    // #500 srst_n = 0;
end

reg[15:0] counter = 0;
always @ (posedge sclk) begin
    counter <= (counter == 10)? 0 : counter + 1;
    trig <= (counter == 10)? 1 : 0;
end

// models
writeRamAddrGen wrag_test_inst(
                    .enable(srst_n & ~fin),
                    .rxflag(trig),

                    .dataLength(dataLength),

                    .ramAddress(addr),
                    .finishFlag(fin)
                );

/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
