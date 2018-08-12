/////////////////////////////////////////////
//               Test Bench
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////
`define sim
`timescale 10ns / 10ns
module tb_SerialPortAddresssGenerator ();
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter
`include "../State.v"

// regs or wires
reg sclk = 0;
reg srst_n = 0;
reg trig = 0;
reg[7:0] status = `S_WAIT_HEAD;

reg[7:0] datalength = 5;

reg rxflag;
reg txbusy;

wire txtrig;
wire ramclk;

wire fin;
wire[7:0] addr;
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
    #300
     srst_n = 1;
    status = `S_READING_RAM;
    #10
     trig = 1;
    #10
     trig = 0;
end

// initial begin
//     #300 status = `S_READING_RAM;
//     #5000 status = `S_WRITING_RAM;
// end

always @ (posedge fin) begin
    status = (status == `S_WRITING_RAM)? `S_READING_RAM : `S_WRITING_RAM;
end

always @ (posedge txtrig) begin
    txbusy = 1;
    #300 txbusy = 0;
end

reg[7:0] counter = 0;
always @ (posedge sclk) begin
    counter <= (counter == 30)? 0 : counter + 1;
    rxflag <= (counter == 30);
end
// models

SerialPortAddressGenerator spag_test_inst(
                               .clk(sclk),
                               .status(status),
                               .dataTransLength(datalength),

                               .rxflag(rxflag),
                               .txbusy(txbusy),
                               .txtrig(txtrig),
                               .ramClk(ramclk),

                               .finishFlag(fin),
                               .Address(addr)
                           );
/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
