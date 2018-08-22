/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module ramsobel (
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

           //uart
           input uart_rx
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter

// regs or wires
//hdmi
wire [15:0] HPixel, VPixel;
wire [7:0] R, G, B;
wire pixClk;

wire hdmi_clk,hdmi_clk_5x,clk_200m,clk_500m,plllocked;


/////////////////////////////////////////////
// main code
/////////////////////////////////////////////

// clock
clk_wiz_0 instance_name
          (
              // Clock out ports
              .hdmi_clk(hdmi_clk), // output hdmi_clk
              .hdmi_clk_5x(hdmi_clk_5x), // output hdmi_clk_5x
              .clk_200m(clk_200m), // output clk_200m
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

reg [17:0] uartWrAddr = 0;
wire[7:0]uart_rx_data;
wire rx_done;

uart_rx_path uart_rx_inst(
                 .clk_i(clk_200m),
                 .uart_rx_i(uart_rx),

                 .uart_rx_data_o(uart_rx_data),
                 .uart_rx_done(rx_done)
             );
wire[15:0]rgb565;
wire[16:0] ori_addr;
pic_320x240_rgb565 picRam (
                       .clka(clk_200m),    // input wire clka
                       .wea(rx_done),      // input wire [0 : 0] wea
                       .addra(uartWrAddr),  // input wire [17 : 0] addra
                       .dina(uart_rx_data),    // input wire [7 : 0] dina
                       .clkb(hdmi_clk),    // input wire clkb
                       .addrb(ori_addr),  // input wire [16 : 0] addrb
                       .doutb(rgb565)  // output wire [15 : 0] doutb
                   );

// vga data generator
//assign R = (HPixel < 200) ? 8'hff : 8'h0;
//assign G = (HPixel < 600 && HPixel > 200) ? 8'hff : 8'h0;
//assign B = (HPixel > 600) ? 8'hff : 8'h0;
localparam  HMAX = 320;
localparam  VMAX = 240;
assign R = (HPixel < HMAX && VPixel < VMAX)? {rgb565[15:11],3'b000} : 8'h00;
assign G = (HPixel < HMAX && VPixel < VMAX)? {rgb565[10:5],2'b00} : 8'h00;
assign B = (HPixel < HMAX && VPixel < VMAX)? {rgb565[4:0],3'b000} : 8'h00;
assign ori_addr = (HPixel < HMAX && VPixel < VMAX)? HPixel + HMAX * VPixel : 8'h00;
/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
