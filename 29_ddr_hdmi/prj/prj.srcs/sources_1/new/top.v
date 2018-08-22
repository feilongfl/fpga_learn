/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module top (
           // Inouts
           inout [31:0] ddr3_dq,
           inout [3:0] ddr3_dqs_n,
           inout [3:0] ddr3_dqs_p,
           // Outputs
           output [13:0] ddr3_addr,
           output [2:0] ddr3_ba,
           output ddr3_ras_n,
           output ddr3_cas_n,
           output ddr3_we_n,
           output ddr3_reset_n,
           output [0:0] ddr3_ck_p,
           output [0:0] ddr3_ck_n,
           output [0:0] ddr3_cke,
           output [0:0] ddr3_cs_n,
           output [3:0] ddr3_dm,
           output [0:0] ddr3_odt,

           output HDMI_CLK_P,
           output HDMI_CLK_N,
           output HDMI_D2_P,
           output HDMI_D2_N,
           output HDMI_D1_P,
           output HDMI_D1_N,
           output HDMI_D0_P,
           output HDMI_D0_N,

           input uart_rx,
           // Inputs
           // Single-ended system clock
           input sys_clk_i,
           // Single-ended iodelayctrl clk (reference clock)
           input sys_rst

       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter

// regs or wires
wire [31:0]read_data;
wire [7:0] uart_data;
reg req_write = 0;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////

clk_wiz_0 instance_name
          (
              // Clock out ports
              .clk_200m(clk_200m),     // output clk_200m
              .clk_500m(clk_500m),     // output clk_500m
              .clk_hdmi(clk_hdmi),     // output clk_hdmi
              .clk_hdmi_5x(clk_hdmi_5x),     // output clk_hdmi_5x
              // Status and control signals
              .reset(0), // input reset
              .locked(locked),       // output locked
              // Clock in ports
              .clk_50m(sys_clk_i));      // input clk_50m

ddr ddr_inst(
        // Inouts
        .ddr3_dq(ddr3_dq),
        .ddr3_dqs_n(ddr3_dqs_n),
        .ddr3_dqs_p(ddr3_dqs_p),
        // Outputs
        .ddr3_addr(ddr3_addr),
        .ddr3_ba(ddr3_ba),
        .ddr3_ras_n(ddr3_ras_n),
        .ddr3_cas_n(ddr3_cas_n),
        .ddr3_we_n(ddr3_we_n),
        .ddr3_reset_n(ddr3_reset_n),
        .ddr3_ck_p(ddr3_ck_p),
        .ddr3_ck_n(ddr3_ck_n),
        .ddr3_cke(ddr3_cke),
        .ddr3_cs_n(ddr3_cs_n),
        .ddr3_dm(ddr3_dm),
        .ddr3_odt(ddr3_odt),
        // Inputs
        // Single-ended system clock
        .sys_clk_i(clk_200m),
        // Single-ended iodelayctrl clk (reference clock)
        .clk_ref_i(clk_200m),
        .sys_rst(locked),

        .req_read(inPix),
        .req_write(req_write),
        .ack_write(ack_write),
        .read_data(read_data),
        .write_data(uart_data),
        .readClk(pixelClk),
        .fifo_reset(Vsync)
    );

hdmi hdmi_inst(
         .hdmi_clk(clk_hdmi),
         .hdmi_clk_5x(clk_hdmi_5x),
         .reset(locked),
         .RGB(read_data[23:0]),
         // .RGB(24'hff_ffff),

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
         .inPix(inPix),

         .Vs(Vsync),

         .pixelClk(pixelClk)
     );

uart_rx_path #(
                 .CLKSPEED(200_000_000),
                 .BANDRATE(115200)
             ) uart_rx_inst(
                 .clk_i(clk_200m),
                 .uart_rx_i(uart_rx),

                 .uart_rx_data_o(uart_data),
                 .uart_rx_done(uart_rx_done)
             );

always @ (posedge clk_200m) begin
    if(uart_rx_done)
        req_write <= 1;
    if(ack_write)
        req_write <= 0;
end

/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
