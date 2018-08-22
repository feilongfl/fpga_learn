/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module splitHdmi (
           // system clock
           input clk_50m,
           // hdmi output
           output HDMI_CLK_P,
           output HDMI_CLK_N,
           output HDMI_D2_P,
           output HDMI_D2_N,
           output HDMI_D1_P,
           output HDMI_D1_N,
           output HDMI_D0_P,
           output HDMI_D0_N,

           output x1,y1,en1,
           input[23:0] rgb1,

           output x2,y2,en2,
           input[23:0] rgb2,

           output x3,y3,en3,
           input[23:0] rgb3,

           output x4,y4,en4,
           input[23:0] rgb4
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter
parameter width = 960;
parameter height = 540;
// regs or wires
wire hdmi_clk,hdmi_clk_5x,plllocked;

/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
clk_wiz_0 hdmi_clock_wiz
          (
              // Clock out ports
              .hdmi_clk(hdmi_clk), // output hdmi_clk
              .hdmi_clk_5x(hdmi_clk_5x), // output hdmi_clk_5x
              // .clk_200m(clk_200m), // output clk_200m
              // .clk_500m(clk_500m), // output clk_500m
              // Status and control signals
              .locked(plllocked), // output locked
              // Clock in ports
              .clk_50m(clk_50m)); // input clk_50m

//hdmi
hdmi hdmi_inst (
         .hdmi_clk(hdmi_clk),
         .hdmi_clk_5x(hdmi_clk_5x),
         .clk_locked(plllocked),
         .inR(R),
         .inG(G),
         .inB(B),

         .HDMI_CLK_P(HDMI_CLK_P),
         .HDMI_CLK_N(HDMI_CLK_N),
         .HDMI_D2_P(HDMI_D2_P),
         .HDMI_D2_N(HDMI_D2_N),
         .HDMI_D1_P(HDMI_D1_P),
         .HDMI_D1_N(HDMI_D1_N),
         .HDMI_D0_P(HDMI_D0_P),
         .HDMI_D0_N(HDMI_D0_N),

         .HPixel(HPixel),
         .VPixel(VPixel),

         .pixelClk(pixClk)
     );


/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
