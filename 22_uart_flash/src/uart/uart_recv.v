/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module uart_recv (
           input  clk,

           output reg flag,

           //read
           output reg [7:0] data,
           input rx
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter
localparam  StatusIDLE = 2'b01;
localparam  StatusREAD = 2'b10;
// regs or wires
reg[3:0] readCounter = 0;
reg [1:0] status = 2'b01;

reg[7:0] dataTemp = 0;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
always @ (posedge clk) begin
    case (status)
        StatusIDLE: begin
            if(rx == 0) begin
                status <= StatusREAD;
                readCounter <= 0;
            end
            flag <= 0;
        end
        StatusREAD: begin
            if(readCounter == 8) begin
                status <= StatusIDLE;
                data <= dataTemp;
                flag <= 1;
            end
            else begin
                dataTemp[readCounter] <= rx;
                readCounter <= readCounter + 1;
                flag <= 0;
            end
        end
        default:
            status <= StatusIDLE;
    endcase
end


/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
