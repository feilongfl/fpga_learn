/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////


`ifdef quartus
`include "../contraller/State.v"
`else
`include "../State.v"
`endif

module SerialPortAddressGenerator (
           input  clk,
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
wire writeFinishFlag,writeFinishFlagEage;
wire readFinishFlag,readFinishFlagEage;
wire status_Read_pos;

wire[7:0] writeAddr,readAddr;

wire txtrigSig;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
assign finishFlag = (writeFinishFlagEage && status == `S_WRITING_RAM)
       | (readFinishFlagEage && status == `S_READING_RAM);

assign Address = (status == `S_WRITING_RAM)?
       writeAddr :
       ((status == `S_READING_RAM)? readAddr : 0);

//write ram
writeRamAddrGen wrag_inst(
                    .enable(status[4]),
                    .rxflag(rxflag),

                    .dataLength(dataTransLength),

                    .ramAddress(writeAddr),
                    .finishFlag(writeFinishFlag)
                );
eageDector ed_wrff_inst(
               .clk(clk),
               .signal(writeFinishFlag),
               .signal_dual_eage(writeFinishFlagEage)
           );
// read ram
eageDector ed_sg_inst(
               .clk(clk),
               .signal(status[5]),
               .signal_posedge(status_Read_pos)
           );

readRamAddrGen rrag_inst(
                   .enable(status_Read_pos),
                   .txBusy(txbusy),

                   .dataLength(dataTransLength),
                   .txTrig(txtrigSig),

                   .ramAddress(readAddr),
                   .finishFlag(readFinishFlag)
               );

eageDector ed_rrff_inst(
               .clk(clk),
               .signal(readFinishFlag),
               .signal_dual_eage(readFinishFlagEage)
           );

eageDector ed_txtg_inst(
               .clk(clk),
               .signal(txtrigSig),
               .signal_dual_eage(txtrig)
           );

/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
