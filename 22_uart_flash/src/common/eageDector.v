/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module eageDector (
           input  clk,
           input signal,
           output signal_posedge,
           output signal_negedge,
           output signal_dual_eage
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter
parameter BuffLength = 3;
parameter BuffInital = 1'b0;
// regs or wires
reg [(BuffLength - 1):0] buff = BuffInital;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
always @ (posedge clk) begin
    buff <=	{buff[(BuffLength - 2):0],signal};
end

assign signal_negedge = ~buff[BuffLength - 2] & buff[BuffLength - 1];
assign signal_posedge = buff[BuffLength - 2] & ~buff[BuffLength - 1];
assign signal_dual_eage = signal_negedge | signal_posedge;
/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
