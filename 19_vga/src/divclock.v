/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module divclk (
           input  clk,
           input rst_n,
           output reg oclk
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter
parameter div_count = 10;

// regs or wires
reg[63:0] counter = 0;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n)
        counter = 0;
    else
        counter = (counter == div_count - 1)? 0 : counter + 1;
end

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n)
        oclk = 0;
    else
        oclk = (counter < (div_count / 2))? 1 : 0;
end


/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
