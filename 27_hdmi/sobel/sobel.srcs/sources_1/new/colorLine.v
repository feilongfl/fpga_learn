/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module colorLine (
           input  clk_50m,

           output HDMI_CLK_P,
           output HDMI_CLK_N,
           output HDMI_D2_P,
           output HDMI_D2_N,
           output HDMI_D1_P,
           output HDMI_D1_N,
           output HDMI_D0_P,
           output HDMI_D0_N
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter

// regs or wires
wire [15:0] HPixel, VPixel;
wire [7:0] R, G, B;
wire pixClk;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
hdmi hdmi_inst (
         .clk_50m(clk_50m),
         .rst_n(1'b1),
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

assign R = (HPixel < 200) ? 8'hff : 8'h0;
assign G = (HPixel < 600 && HPixel > 200) ? 8'hff : 8'h0;
assign B = (HPixel > 600) ? 8'hff : 8'h0;
/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
