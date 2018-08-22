/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module martix_3x3 (
           input clock,
           input reset,

           input[23:0] martix_1x3,
           output [9:0] resault
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter
parameter val_1x1 = 1;
parameter val_1x2 = 2;
parameter val_1x3 = 1;
parameter val_2x1 = 0;
parameter val_2x2 = 0;
parameter val_2x3 = 0;
parameter val_3x1 = -1;
parameter val_3x2 = -2;
parameter val_3x3 = -1;
// regs or wires
reg[23:0] martix_col1 = 0;
reg[23:0] martix_col2 = 0;

reg signed [31:0] gx,gy;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
always @ (posedge clock or posedge reset) begin
    if(reset) begin
        martix_col1 <= 0;
        martix_col2 <= 0;
    end
    else begin
        martix_col2 <= martix_1x3;
        martix_col1 <= martix_col2;
    end
end

always @ (posedge clock or posedge reset) begin
    if(reset) begin
        gx <= 0;
        gy <= 0;
    end
    else begin
        gx <= val_1x1 * martix_col1[23:16] + val_1x2 * martix_col1[15:8] + val_1x3 * martix_col1[7:0]
           + val_2x1 * martix_col2[23:16] + val_2x2 * martix_col2[15:8] + val_2x3 * martix_col2[7:0]
           + val_3x1 * martix_1x3[23:16] + val_3x2 * martix_1x3[15:8] + val_3x3 * martix_1x3[7:0];
        gy <= val_1x1 * martix_col1[23:16] + val_2x1 * martix_col1[15:8] + val_3x1 * martix_col1[7:0]
           + val_1x2 * martix_col2[23:16] + val_2x2 * martix_col2[15:8] + val_3x2 * martix_col2[7:0]
           + val_1x3 * martix_1x3[23:16] + val_2x3 * martix_1x3[15:8] + val_3x3 * martix_1x3[7:0];
    end
end

assign resault = ((gx[31])? -gx : gx) + ((gy[31])? -gy : gy);

/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
