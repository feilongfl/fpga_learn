/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////
module vga (
           input  clk,
           input rst_n,
           input [7:0] inR,
           input [7:0] inG,
           input [7:0] inB,
           output reg Hsync,
           output reg Vsync,
           output reg [7:0] Ro,
           output reg [7:0] Go,
           output reg [7:0] Bo,

           output reg[15:0] HPixel = 0,
           output reg[15:0] VPixel = 0
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter

// Timing Name = 640 x 480 @ 60Hz;
// Hor Frequency = 31.469; // KHz = 31.8 usec / line
// Ver Frequency = 59.940; // Hz = 16.7 msec / frame
// Pixel Clock = 25.175; // MHz = 39.7 nsec ± 0.5%
// Character Width = 8; // Pixels = 317.8 nsec
// Scan Type = NONINTERLACED; // H Phase = 2.0 %
// Hor Sync Polarity = NEGATIVE; // HBlank = 18.0% of HTotal
// Ver Sync Polarity = NEGATIVE; // VBlank = 5.5% of VTotal
// Hor Total Time = 31.778; // (usec) = 100 chars = 800 Pixels
parameter HorTotal = 800;
// Hor Addr Time = 25.422; // (usec) = 80 chars = 640 Pixels
parameter HorAddr = 640;
// Hor Blank Start = 25.740; // (usec) = 81 chars = 648 Pixels
parameter HorBlankStart = 648;
// Hor Blank Time = 5.720; // (usec) = 18 chars = 144 Pixels
parameter HorBlankTime = 144;
// Hor Sync Start = 26.058; // (usec) = 82 chars = 656 Pixels
parameter HorSyncStart = 656;
// H Right Border = 0.318; // (usec) = 1 chars = 8 Pixels
parameter HRightBorder = 8;
// H Front Porch = 0.318; // (usec) = 1 chars = 8 Pixels
parameter HFrontPorch = 8;
// Hor Sync Time = 3.813; // (usec) = 12 chars = 96 Pixels
parameter HorSyncTime = 96;
// H Back Porch = 1.589; // (usec) = 5 chars = 40 Pixels
parameter HBackPorch = 40;
// H Left Border = 0.318; // (usec) = 1 chars = 8 Pixels
parameter HLeftBoader = 8;
// Ver Total Time = 16.683; // (msec) = 525 lines HT – (1.06xHA)
parameter VerTotal = 525;
// Ver Addr Time = 15.253; // (msec) = 480 lines = 4.83
parameter VerAddr = 480;
// Ver Blank Start = 15.507; // (msec) = 488 lines
parameter VerBlankStart = 488;
// Ver Blank Time = 0.922; // (msec) = 29 lines
parameter VerBlankTime = 29;
// Ver Sync Start = 15.571; // (msec) = 490 lines
parameter VerSyncStart = 490;
// V Bottom Border = 0.254; // (msec) = 8 lines
parameter VBottomBorder = 8;
// V Front Porch = 0.064; // (msec) = 2 lines
parameter VFrontPorch = 2;
// Ver Sync Time = 0.064; // (msec) = 2 lines
parameter VerSyncTime = 2;
// V Back Porch = 0.794; // (msec) = 25 lines
parameter VBackPorch = 25;
// V Top Border = 0.254; // (msec) = 8 lines
parameter VTopBorder = 8;
// regs or wires
reg [31:0] h_counter = 0;
reg [31:0] v_counter = 0;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////

// hor counter adder
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n)
        h_counter <= 0;
    else
        h_counter <= (h_counter == HorTotal - 1)? 0 : h_counter + 1;
end

//hsync gen
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n)
        Hsync <= 0;
    else
        Hsync <= (h_counter < HorTotal - HorSyncTime)? 0 : 1;
end

// ver counter adder
always @ (posedge Hsync or negedge rst_n) begin
    if(!rst_n)
        v_counter <= 0;
    else
        v_counter <= (v_counter == VerTotal - 1)? 0 : v_counter + 1;
end
//vsync gen
always @ (posedge clk) begin
    Vsync <= (v_counter < VerTotal - VerSyncTime)? 0 : 1;
end

// output rgb data
always @ (posedge clk) begin
    if(v_counter > (VBackPorch + VTopBorder)
            && v_counter < (VBackPorch + VTopBorder + VerAddr)
            && h_counter > (HBackPorch + HLeftBoader)
            && h_counter < (HBackPorch + HLeftBoader + HorAddr)) begin
        Ro <= inR;
        Go <= inG;
        Bo <= inB;
        HPixel <= HPixel + 1;
    end
    else begin
        Ro <= 0;
        Go <= 0;
        Bo <= 0;
        HPixel <= 0;
    end
end

always @ (posedge Hsync or negedge rst_n) begin
    if(!rst_n)
        VPixel <= 0;
    else if(v_counter > (VBackPorch + VTopBorder)
            && v_counter < (VBackPorch + VTopBorder + VerAddr)
           )
        VPixel <= VPixel + 1;
    else
        VPixel <= 0;
end

/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
