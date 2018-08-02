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
        data <= {DeviceAddress,1'b0};
        en <= 1'b1;
        rwcnt <= 0;
    end
    else if(rwcnt + 1 == communityByteLength) begin
        data <= {DeviceAddress,1'b0};
        en <= 0;
    end
    else begin
        if(!isRead) begin
            data <=
                 writeDateTemp [((communityByteLength - 1) * 8 - 1)
                                : ((communityByteLength - 1) * 8 - 8)];

            writeDateTemp <= (writeDateTemp << 8);
        end
        if(isRead) begin
            if (rwcnt < commandLength) begin
                data <=  writeDateTemp [((commandLength - 1) * 8 + 7)
                                        : ((commandLength - 1) * 8)];
                writeDateTemp <= (writeDateTemp << 8);
            end
            else if (rwcnt == commandLength) begin
                data <= {DeviceAddress,1'b1};
            end
            else begin
                data = 8'hff;
            end
        end

        rwcnt <= rwcnt + 1;
    end
end


/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
