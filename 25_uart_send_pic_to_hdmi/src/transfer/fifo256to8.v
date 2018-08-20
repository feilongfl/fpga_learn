/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module fifo256to8 (
           input clock,

           input[255:0] data256,
           input wren,
           output empty,
           input rden,
           output [7:0] data8
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter

// regs or wires
wire[31:0] data32;
wire empty_fifo1;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
fifo_w256to32 fifo_w256to32_inst (
                  .clk(clock),      // input wire clk
                  .din(data256),      // input wire [255 : 0] din
                  .wr_en(wren),  // input wire wr_en
                  .rd_en(empty),  // input wire rd_en
                  .dout(data32),    // output wire [31 : 0] dout
                  // .full(full),    // output wire full
                  .empty(empty_fifo1)  // output wire empty
              );

fifo_w32to8 fifo_w32to8_inst (
                .clk(clock),      // input wire clk
                .din(data32),      // input wire [31 : 0] din
                .wr_en(empty),  // input wire wr_en
                .rd_en(empty),  // input wire rd_en
                .dout(data8),    // output wire [7 : 0] dout
                // .full(full),    // output wire full
                .empty(empty)  // output wire empty
            );

/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
