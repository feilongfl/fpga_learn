/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module reg256to8 (
           input  rdclock,

           // input wren,rden,
           input [255:0] data256,
           output reg last,
           output reg [7:0] data8
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter
parameter cntMax = 32;
// regs or wires
reg [5:0] cnt = cntMax - 1;
// reg[256]
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
always @ (posedge rdclock) begin
    cnt <= (cnt == 0)? cntMax - 1 : cnt - 1;
    last <= (cnt == 1)? 1 : 0;
    data8 <= ((data256 >> (cnt * 8)) & 8'hff);
end

/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
