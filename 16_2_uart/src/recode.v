/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module recode (
           input  rx,
           input  clk,
           output reg[7:0] data = 0
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter

// regs or wires
reg recode_enable = 0;
reg [2:0] data_recv_length = 0;
reg [7:0] data_temp = 0;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////

always @ (negedge clk) begin
    if(!recode_enable && !rx) begin
        data_recv_length <= 0;
        recode_enable <= 1;
    end
    else if(recode_enable) begin
        data_temp[data_recv_length] <= rx;
        if (data_recv_length == 7) begin
            data_recv_length <= 0;
            recode_enable <= 0;
            data <= data_temp;
        end
        else begin
            data_recv_length <= data_recv_length + 1;
        end
    end
    else begin
        data_recv_length <= 0;
        recode_enable <= 1;
    end
end

/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
