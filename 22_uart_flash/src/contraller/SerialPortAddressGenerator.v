/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module SerialPortAddressGenerator (
           // input  clk,
           input [7:0]status,
           input[7:0] dataTransLength,

           input rxflag,txbusy,
           output txtrig,
           output ramClk,

           output finishFlag,
           output[7:0] Address
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter

// regs or wires
wire writeFinishFlag;
wire readFinishFlag;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
assign finishFlag = (writeFinishFlag & status[4])
       | (readFinishFlag & status[5]);

//write ram
writeRamAddrGen wrag_inst(
                    .enable(status[4]),
                    .rxflag(rxflag),

                    .dataLength(dataTransLength),

                    .ramAddress(ramAddress),
                    .finishFlag(writeFinishFlag)
                );
// read ram

/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
