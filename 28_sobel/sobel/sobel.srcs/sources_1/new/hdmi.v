`timescale 1ns / 1ps


module hdmi (
           input hdmi_clk,
           input hdmi_clk_5x,
           input clk_locked,
           //input rst_n,
           input [7:0] inR,
           input [7:0] inG,
           input [7:0] inB,
           // output reg Hsync,
           // output reg Vsync,

           output HDMI_CLK_P,
           output HDMI_CLK_N,
           output HDMI_D2_P,
           output HDMI_D2_N,
           output HDMI_D1_P,
           output HDMI_D1_N,
           output HDMI_D0_P,
           output HDMI_D0_N,

           output [15:0] HPixel,
           output [15:0] VPixel,

           output pixelClk
       );
//wire hdmi_clk_5x,hdmi_clk,locked;
wire[7:0] R,G,B;
wire Hs,Vs,De;
vga #(
        .HorTotal(2200),
        .HorAddr(1920),
        .HorBlankStart(1920),
        .HorBlankTime(280),
        .HorSyncStart(2008),
        .HRightBorder(0),
        .HFrontPorch(88),
        .HorSyncTime(44),
        .HBackPorch(148),
        .HLeftBoader(0),
        .VerTotal(1125),
        .VerAddr(1080),
        .VerBlankStart(1080),
        .VerBlankTime(45),
        .VerSyncStart(1084),
        .VBottomBorder(0),
        .VFrontPorch(4),
        .VerSyncTime(5),
        .VBackPorch(36),
        .VTopBorder(0)
    ) vga_inst(
        .clk(hdmi_clk),
        .rst_n(clk_locked),
        .inR(inR),
        .inG(inG),
        .inB(inB),
        .Hsync(Hs),
        .Vsync(Vs),
        .Ro(R),
        .Go(G),
        .Bo(B),
        .de(De),

        .HPixel(HPixel),
        .VPixel(VPixel)
    );

HDMI_FPGA_ML_A7_0 u_HDMI
                  (
                      .PXLCLK_I (hdmi_clk),
                      .PXLCLK_5X_I (hdmi_clk_5x),
                      .LOCKED_I (clk_locked),
                      .RST_N (1'b1),
                      .VGA_HS (Hs),
                      .VGA_VS (Vs),
                      .VGA_DE (De),
                      .VGA_RGB ({R,G,B}),
                      .HDMI_CLK_P (HDMI_CLK_P),
                      .HDMI_CLK_N (HDMI_CLK_N),
                      .HDMI_D2_P (HDMI_D2_P),
                      .HDMI_D2_N (HDMI_D2_N),
                      .HDMI_D1_P (HDMI_D1_P),
                      .HDMI_D1_N (HDMI_D1_N),
                      .HDMI_D0_P (HDMI_D0_P),
                      .HDMI_D0_N (HDMI_D0_N)
                  );

assign pixelClk = ~hdmi_clk;

endmodule
