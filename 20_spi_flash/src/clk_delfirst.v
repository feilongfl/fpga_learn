/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module clk_delfirst (
           input  clk,
           input clear,
           output oclk
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter

// regs or wires
reg [1:0] en = 0;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
always @ (posedge clk or posedge clear) begin
    if(clear)
        en <= 0;
    else begin
        en <= (en == 2)? 2 : en + 1;
    end
end

assign oclk = (en == 2) ? clk : 0;




/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
