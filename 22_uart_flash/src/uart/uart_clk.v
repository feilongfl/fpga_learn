/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module uart_clk (
           input  clk,
           output oclk
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter
parameter BandRate = 115200;
parameter InclkFreq = 50_000_000;

parameter ClkWidth = InclkFreq / BandRate / 2;
// regs or wires
reg serialClk = 0;
reg [15:0] serialClkCounter = 0;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
always @ (posedge clk) begin
    serialClkCounter <= (serialClkCounter == ClkWidth)? 0 : serialClkCounter + 1;
    serialClk <= (serialClkCounter == 0)? serialClk : ~serialClk;
end

assign oclk = serialClk;
/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
