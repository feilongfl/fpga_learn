/////////////////////////////////////////////
//               Test Bench
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

`timescale 10ns / 10ns
module tb_sobel ();
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter

// regs or wires
reg sclk = 0;
reg srst_n = 0;
reg trig = 0;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
// System clock
always #10 sclk = ~sclk;

//inital
initial begin
    #0
     srst_n = 0;
    #20
     srst_n = 1;

end
wire[9:0] r;

reg [15:0] x,y;
reg [7:0] grayPix = 0;

always @ (posedge sclk) begin
    if(!srst_n) begin
        x <= 0;
        y <= 0;
        grayPix <= 0;
    end
    else begin
        x <= (x == 350)? 0 : x + 1;
        y <= (y == 260)? 0 : ((x == 350)?y + 1 : y);
        grayPix <= grayPix + 1;
    end
end

// models
sobel sobel_inst(
          .clock(sclk),
          .reset(~srst_n),

          .x(x),
          .y(y),
          .grayPic(x),
          .resault(r)
      );

/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
