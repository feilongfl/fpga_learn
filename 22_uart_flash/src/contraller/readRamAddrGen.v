/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module readRamAddrGen (
           input enable,
           input  txBusy,

           input[7:0] dataLength,
           output txTrig = 0,

           output reg [7:0] ramAddress,
           output reg finishFlag = 0
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter

// regs or wires

/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
always @ (negedge txBusy or posedge enable) begin
    if(enable) begin
        ramAddress <= 0;
        txTrig <= ~txTrig;
    end
    else begin
        ramAddress <= ramAddress + 1;
        txTrig <= txTrig;

        if(ramAddress + 1 == dataLength)
            finishFlag <= ~finishFlag;
    end
end


/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
