/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module rx_recode_enable_gen (
           input  clk,
           input rx,
           output en
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter
parameter  Max = 8;

// regs or wires
reg [3:0] count = 0;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////

always @ (posedge clk) begin
    if(!rx) begin
        count <= count + 1;
    end
    else begin
        if(count == 0 || count == Max)
            count <= 0;
        else
            count <= count + 1;
    end
end

assign en = (count == 0)? 0 : 1;

/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
