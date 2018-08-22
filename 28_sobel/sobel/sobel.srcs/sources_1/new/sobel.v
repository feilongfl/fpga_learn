/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module sobel (
           input clock,
           input reset,

           input [15:0] x,
           input [15:0] y,
           input [7:0] grayPic,
           output [9:0] resault
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter
parameter width = 320;
parameter height = 240;

parameter threadhold = 110;
// regs or wires
wire[7:0] line1_do,line2_do;
wire line1_full,line2_full;
wire fifo_en;
wire[9:0] resault_temp;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
assign resault = (x < width && y < height && (~reset) && x > 2 && y >= 2)? resault_temp : 0;
assign fifo_en = (x < width && y < height && (~reset))? 1 : 0;

fifo_vgaline fifo_line1 (
                 .clk(clock),      // input wire clk
                 .srst(reset),    // input wire srst
                 .din(grayPic),      // input wire [7 : 0] din
                 .wr_en(fifo_en),  // input wire wr_en
                 .rd_en(fifo_en & line1_full),  // input wire rd_en
                 .dout(line1_do),    // output wire [7 : 0] dout
                 .prog_full(line1_full)    // output wire prog_full
             );

fifo_vgaline fifo_line2 (
                 .clk(clock),      // input wire clk
                 .srst(reset),    // input wire srst
                 .din(line1_do),      // input wire [7 : 0] din
                 .wr_en(fifo_en & line1_full),  // input wire wr_en
                 .rd_en(fifo_en & line2_full),  // input wire rd_en
                 .dout(line2_do),    // output wire [7 : 0] dout
                 .prog_full(line2_full)    // output wire prog_full
             );

martix_3x3 martix_inst(
               .clock(clock),
               .reset(reset),
               .martix_1x3({line2_do,line1_do,grayPic}),
               .resault(resault_temp)
           );

/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
