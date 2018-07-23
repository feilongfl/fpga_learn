/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module recode (
           input  clk,
           input  en,
           input rx,
           output reg [7:0] data = 0
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter

// regs or wires

/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
always @ (posedge clk) begin
    if(!en)
        data <= 0;
    else begin
        data <= {data[6:0],rx};
    end
end


/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
