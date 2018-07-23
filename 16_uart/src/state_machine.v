/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module uart_state (
           input  rx,
           input clk,
           output reg [3:0] state = 4'b0001
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter
localparam  S_IDLE = 4'b0001;
localparam  S_START = 4'b0010;
localparam  S_READING = 4'b0100;
localparam  S_STOP = 4'b1000;

parameter DATA_BYTE_LENGTH = 8;

// regs or wires
reg[3:0] byte_count = 0;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
always @ (posedge clk or negedge rx) begin
    if(!rx) begin
        case(state)
            S_IDLE:
                state <= S_START;
            S_START:
                if(clk)
                    state <= S_READING;
            S_READING:
                if(clk)
                    if (byte_count == (DATA_BYTE_LENGTH - 1)) begin
                        state <= S_IDLE;
                    end
                    else begin
                        byte_count <= byte_count + 1;
                    end
            default:
                ;
        endcase
    end
    else
    case (state)
        S_IDLE: begin
            if(!rx)
                state <= S_IDLE;
        end
        S_START: begin
            state <= S_READING;
            byte_count <= 0;
        end
        S_READING:
            if (byte_count == (DATA_BYTE_LENGTH - 1)) begin
                state <= S_IDLE;
            end
            else begin
                byte_count <= byte_count + 1;
            end
        S_STOP:
            state <= S_IDLE;
        default:
            state <= S_IDLE;
    endcase
end


/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule