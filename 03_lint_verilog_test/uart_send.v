/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module uart_send (
           //clock
           input  clk,
           //in data
           input trig,
           input [7:0] data,
           //out data
           output reg busy = 0,
           output reg tx = 1
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter

// regs or wires
reg [3:0] sendCounter = 10;
reg enabled = 0;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
always @ (posedge clk or posedge trig) begin
    if(trig) begin
        sendCounter <= 0;
        busy <= 1;
        enabled <= 1;
    end
    else begin
        if(enabled)
            sendCounter <= (sendCounter == 10)? 10 : sendCounter + 1;
        case (sendCounter)
            0://start byte
                tx <= 0;
            1,2,3,4,5,6,7,8://data byte
                tx <= data[sendCounter - 1];
            9://stop bit
                tx<=1;
            default: begin
                tx <= 1;
                busy <= 0;
                enabled <= 0;
            end
        endcase
    end
end


/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
