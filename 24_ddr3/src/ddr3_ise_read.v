/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module ddr3_ise_read (
           input  clock,

           output reg c3_px_cmd_en,
           output reg [2:0] c3_px_cmd_instr = 3'b001,
           output reg [29:0] c3_px_cmd_byte_addr = 30'b0,

           output reg c3_px_rd_en,
           input [63:0] c3_px_rd_data,

           output reg [63:0] data,

           input prepareFin
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter

// regs or wires
reg[31:0] i = 0;
reg read_wait = 0;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
always @ ( posedge clock ) begin
    i <= (prepareFin == 1)? ((i == 10)? 0 : i + 1) : 0;
end

always @ (posedge clock) begin
    case (i)
        1,2,3,4: begin
            c3_px_rd_en <= 1;
            data <= c3_px_rd_data;
        end
        6: begin
            c3_px_cmd_en <= 1;
        end
        8: begin
            c3_px_cmd_byte_addr <= (read_wait) ? c3_px_cmd_byte_addr + 64 : 0;
            read_wait <= 1;
        end
        default: begin
            c3_px_rd_en <= 0;
            c3_px_cmd_en <= 0;
        end
    endcase
end


/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
