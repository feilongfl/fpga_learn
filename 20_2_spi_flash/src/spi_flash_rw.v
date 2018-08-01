/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module spi_flash_rw (
           input  en,
           input rst_n,

           output reg en_spi = 0,
           input spi_flag,
           output reg [7:0] data_write,
           input [7:0] data_read,

           output [7:0] data_read_out
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter
parameter datalength = 1;
parameter DATA = 8'hc7;

// regs or wires
reg[7:0] cnt = 0;

reg[(8 * datalength - 1):0] data = DATA;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
always @ (negedge spi_flag or posedge en) begin
    if(en) begin
        en_spi <= 1;
    end
    else begin
        if(cnt == datalength + 1)
            en_spi <= 0;
    end
end

always @ (posedge spi_flag) begin
    // if(en) begin
    //     data <= DATA;
    //     cnt <= 0;
    // end
    // else begin
    if (cnt != datalength + 1) begin
        data_write <= data[(datalength * 8 - 1):(datalength * 8 - 8)];
        data <= data << 8;
        cnt <= cnt + 1;
        // en_spi <= 1;
    end
    // end
end

assign data_read_out = data_read;
// assign data_read_out = (cnt == 1)? 0 : data_read;



/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
