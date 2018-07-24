/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module clock (
           input  clk,
           input en,
           output reg oclk = 0
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter
parameter clock_max = 5207;

// regs or wires
reg [15:0] count = 0;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
always @ (posedge clk) begin
    if(!en) begin
        count <= 0;
        oclk <= 0;
    end
    else if(count == clock_max) begin
        count <= 0;
        oclk <= 0;
    end
    else if (count == ((clock_max + 1) / 2)) begin
        count <= count + 1'b1;
        oclk <= 1;
    end
    else begin
        count <= count + 1'b1;
    end
end


/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
