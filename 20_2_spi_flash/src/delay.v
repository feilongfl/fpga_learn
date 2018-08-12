/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module delay (
           input  clk,
           input signal,
           output reg sig_delaied
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter
parameter DELAY_CYCLE = 10;
parameter INITIAL_VALUE = 0;
// `define WORK_AT_CLK_NEGEDGE

// regs or wires
reg[DELAY_CYCLE - 1:0] buff = INITIAL_VALUE;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
`ifdef WORK_AT_CLK_NEGEDGE
always @ (negedge clk) begin
    buff = {buff[DELAY_CYCLE - 2 : 0],signal};
    sig_delaied <= buff[DELAY_CYCLE - 1];
end
`else
always @ (posedge clk) begin
    buff = {buff[DELAY_CYCLE - 2 : 0],signal};
    sig_delaied <= buff[DELAY_CYCLE - 1];
end
`endif


/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
