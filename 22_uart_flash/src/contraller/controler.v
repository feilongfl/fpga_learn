/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////
// `define quartus
`ifdef quartus
`include "../contraller/State.v"
`else
`include "../State.v"
`endif

module controler (
           input  rx_flag,

           input[7:0] rx_data,
           input transFinish,

           output reg[7:0] status = 8'b0000_0001,
           output reg[7:0] dataTransLength = 0
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter

parameter HEAD_BYTE = 8'haa;
parameter COMMAND_READ_RAM = 8'b0000_0001;
parameter COMMAND_WRITE_RAM = 8'b0000_0010;
parameter COMMAND_WRITE_FLASH = 8'b0000_0100;
parameter COMMAND_READ_FLASH = 8'b0000_1000;

// regs or wires
// reg[7:0] status = `S_WAIT_HEAD;
// reg[7:0] dataTransCounter = 0;
// reg[7:0] dataTransLength = 0;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
always @ (posedge rx_flag or posedge transFinish) begin
    if(transFinish) begin
        status <= `S_WAIT_HEAD;
        // dataTransCounter = 0;
    end
    case (status)
        `S_WAIT_HEAD:
            if (rx_data == HEAD_BYTE) begin
                status <= `S_WAIT_BYTELENGTH;
            end
        `S_WAIT_BYTELENGTH: begin
            status <= `S_WAIT_COMMAND;
            dataTransLength <= rx_data;
        end
        `S_WAIT_COMMAND:
        case (rx_data)
            COMMAND_READ_RAM:
                status <= `S_READING_RAM;
            COMMAND_WRITE_RAM:
                status <= `S_WRITING_RAM;
            COMMAND_READ_FLASH:
                status <= `S_READING_FLASH;
            COMMAND_WRITE_FLASH:
                status <= `S_WRITING_FLASH;
            default:
                status <= `S_WAIT_HEAD;
        endcase
        COMMAND_READ_RAM,COMMAND_WRITE_RAM: begin
            // if(dataTransLength == dataTransCounter + 1) begin
            // status <= `S_WAIT_HEAD;
            // dataTransLength <= 0;
            // end
            // else
            // dataTransCounter <= dataTransCounter + 1;
            ;
        end
        COMMAND_READ_FLASH,COMMAND_WRITE_FLASH:
            ;
        // status <= `S_WAIT_HEAD;
        default:
            status <= `S_WAIT_HEAD;
    endcase
end



/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
