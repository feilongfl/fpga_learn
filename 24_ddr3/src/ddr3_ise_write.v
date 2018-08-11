/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module ddr3_ise_write (
           input  clock,

           output reg c3_p0_cmd_en,
           output reg [2:0] c3_p0_cmd_instr = 3'b0,
           output reg [29:0] c3_p0_cmd_byte_addr = 30'b0,

           output reg c3_p0_wr_en,
           output reg [63:0] c3_p0_wr_data = 64'b0,

           input prepareFin
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter

// regs or wires
reg[31:0] i = 0;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
always @ ( posedge clock ) begin
    i <= (prepareFin == 1)? ((i == 10)? 0 : i + 1) : 0;
end

always @ (posedge clock) begin
    case (i)
        1,2,3,4: begin
            c3_p0_wr_en <= 1;
            c3_p0_wr_data <= c3_p0_wr_data + 64'b1;
        end
        6: begin
            c3_p0_cmd_en <= 1;
        end
        8:
            c3_p0_cmd_byte_addr <= c3_p0_cmd_byte_addr + 64;
        default: begin
            c3_p0_wr_en <= 0;
            c3_p0_cmd_en <= 0;
        end
    endcase
end


/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
