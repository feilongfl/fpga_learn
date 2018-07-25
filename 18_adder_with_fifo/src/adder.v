/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module adder (
           input  clk,
           input en,
           input [7:0] indata,
           output reg [9:0] sum
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter

// regs or wires
wire [7:0]q1,q2;
wire full1,full2;
reg full1_last,full2_last;

reg [7:0] indata_hold;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
always @ (posedge clk) begin
    indata_hold <= indata;
end
always @ (posedge clk) begin
    full1_last <= full1;
    full2_last <= full2;
end

fifo	fifo_1 (
         .clock ( clk ),
         .data ( indata ),
         .rdreq ( en & full1 ),
         .wrreq ( en ),
         .almost_full ( full1 ),
         .q ( q1 )
     );

fifo	fifo_2 (
         .clock ( ~clk ),
         .data ( q1 ),
         .rdreq ( en & full2 ),
         .wrreq ( en & full1_last ),
         .almost_full ( full2 ),
         .q ( q2 )
     );

always @ (posedge clk) begin
    if(full2_last & full2_last)
        sum <= q1 + q2 + indata_hold;
end
// assign sum = q1 + q2 + indata;
// assign sum = (full1 & full2)? q1 + q2 + indata : 0;
/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
