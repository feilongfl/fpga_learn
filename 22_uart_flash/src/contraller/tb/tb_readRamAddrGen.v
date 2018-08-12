/////////////////////////////////////////////
//               Test Bench
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

`timescale 10ns / 10ns
module tb_readRamAddrGen ();
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter

// regs or wires
reg sclk = 0;
reg srst_n = 0;
wire txBusy;
reg[15:0] counter = 0;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
// System clock
always #10 sclk = ~sclk;

//inital
initial begin
    #0
     srst_n = 0;
    //txBusy = 0;
    #30
     srst_n = 1;
    //#10
    //txBusy = 1;
    //#10
    //txBusy = 0;
end

always @ (posedge sclk) begin
    counter <= (counter == 50)? 0 : counter + 1;
end

assign txBusy = (counter >= 40)? 0 : 1;
reg[7:0] dataLength = 3;

wire[7:0] addr;
wire fin,txtrig;

wire p,n,np;
// models
eageDector ed_test_inst(
               .clk(sclk),
               .signal(srst_n),
               .signal_posedge(p),
               .signal_negedge(n),
               .signal_dual_eage(np)
           );

readRamAddrGen rrag_inst(
                   .enable(p),
                   .txBusy(txBusy & ~fin),

                   .dataLength(dataLength),
                   .txTrig(txtrig),

                   .ramAddress(addr),
                   .finishFlag(fin)
               );

/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
