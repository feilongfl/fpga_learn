/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module iic_data_provider (
           input trig,
           input  changeDataFlag,
           output reg en,
           output reg[7:0] data
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter
parameter communityByteLength = 4;// DeviceAddress + commandLength + write or read length
parameter DeviceAddress = 7'b1010000;
parameter isRead = 1'b0;
parameter commandLength = 1;
parameter [(((isRead)? commandLength : communityByteLength - 1) * 8 - 1) : 0] writeDate
          = 24'hff_00_ff;
// regs or wires
reg[31:0] rwcnt = 0;
reg [(((isRead)? commandLength : communityByteLength - 1) * 8 - 1) : 0] writeDateTemp = writeDate;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
always @ (posedge changeDataFlag or posedge trig) begin
    if (trig) begin
        data <= {DeviceAddress,isRead};
        en <= 1'b1;
        rwcnt <= 0;
    end
    else if(rwcnt + 1 == communityByteLength) begin
        data <= {DeviceAddress,isRead};
        en <= 0;
    end
    else begin
        data <= writeDateTemp [(((isRead)? commandLength : communityByteLength - 1) * 8 - 1)
                               : ((isRead)? commandLength : communityByteLength - 1) * 8 - 8];
        writeDateTemp <= (writeDateTemp << 8);
        rwcnt <= rwcnt + 1;
    end
end


/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
