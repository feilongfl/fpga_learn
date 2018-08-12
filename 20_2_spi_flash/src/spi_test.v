/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module spi_test (
           input  sclk,
           output st_clk,
           output[7:0] datarecv,

           output spi_clk,
           output spi_cs,
           output spi_do,
           input spi_di
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter

// regs or wires
reg [31:0]cnt = 0;
reg en = 0;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
always @ (posedge sclk) begin
    cnt <= (cnt == 1000)? 0 : cnt + 1;
    en <= (cnt > 100 && cnt < 500)? 1:0;
end

wire dataflag;
reg [7:0]datasend = 0;
always @ (posedge dataflag) begin
    datasend <= (datasend == 255)? 0 : datasend + 1;
end


spi spi_inst(
        .sclk(sclk),
        .en(en),
        .dataflag(dataflag),
        .datasend(datasend),
        .datarecv(datarecv),

        // to hardware
        .spi_clk(spi_clk),
        .spi_di(spi_di),
        .spi_do(spi_do),
        .spi_cs(spi_cs)
    );

pll pll_inst(
        . refclk(sclk),   //  refclk.clk
        . rst(0),      //   reset.reset
        . outclk_0(st_clk)  // outclk0.clk
    );

/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
