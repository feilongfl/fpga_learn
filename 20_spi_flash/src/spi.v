/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module spi (
           input clk,
           input en,
           output data_recv,
           input data_send,
           // output reg[63:0] data_cnt = 0,

           output reg spi_clk = 0,
           input spi_di,
           output spi_do,
           output cs_n
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter

// regs or wires


/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
// half clock
always @ (posedge clk) begin
    if(en)
        spi_clk <= ~spi_clk;
    else
        spi_clk <= 0;
end

assign cs_n = ~(en);

// always @ (negedge spi_clk or posedge en) begin
//     spi_do <= data_send;
//     data_recv <= spi_di;
// end

assign spi_do = data_send;
assign data_recv = spi_di;

// always @ (posedge spi_clk) begin
//     if(en)
//         data_cnt <= data_cnt + 1;
//     else
//         data_cnt <= 0;
// end

/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
