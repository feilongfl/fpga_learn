/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module sm (
           input  clk,
           input rx,
           output reg [3:0] state = 4'b0001
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter
parameter DATA_LENGTH = 8;

// regs or wires
localparam  S_IDLE = 4'b0001;
localparam  S_START = 4'b0010;
localparam  S_READING = 4'b0100;
localparam  S_STOP = 4'b1000;

reg[3:0] count = 0;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
always @ (posedge clk or negedge rx) begin
    case (state)
        S_IDLE: begin
            if(!rx)
                state <= S_START;
        end
        S_START: begin
            if(clk)
                state <= S_READING;
        end
        S_READING: begin
            if(clk) begin
                if(count == DATA_LENGTH - 1) begin
                    count = 0;
                    state <= S_STOP;
                end
                else begin
                    count <= count + 1;
                end
            end
        end
        S_STOP: begin
            if(clk)
                state <= S_IDLE;
        end
        default: begin
            state <= S_IDLE;
        end
    endcase
end


/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
