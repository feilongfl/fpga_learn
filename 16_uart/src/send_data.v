/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module send_data (
           input  flag,
           input[7:0] data,
           input clk,
           output reg clk_en = 0,
           output reg data_o = 1
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter
localparam  S_WAITING = 4'b0001;
localparam  S_START = 4'b0010;
localparam  S_SENDING = 4'b0100;
localparam  S_STOP = 4'b1000;

parameter DATA_LENGTH = 8;

// regs or wires
reg [7:0] cnt = 0;
reg [3:0] state = S_WAITING;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
always @ (posedge clk or posedge flag) begin
    case (state)
        S_WAITING:
            if(flag) begin
                state <= S_START;
                clk_en <= 1;
            end
        S_START:
            if(clk) begin
                state <= S_SENDING;
                data_o <= 0;
            end
        S_SENDING:
            if(clk) begin
                data_o <= data[cnt];
                if(cnt == DATA_LENGTH - 1) begin
                    state <= S_STOP;
                    cnt <= 0;
                end
                else begin
                    cnt <= cnt + 1'b1;
                end
            end
        S_STOP:
            if (clk) begin
                state <= S_WAITING;
                clk_en <= 0;
                data_o <= 1;
            end
        default: begin
            state <= S_WAITING;
            clk_en <= 0;
            data_o <= 1;
        end
    endcase
end


/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
