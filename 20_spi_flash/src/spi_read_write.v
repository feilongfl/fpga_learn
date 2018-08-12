/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module spi_read_write (
           input start_trig,
           input[7:0] dataLength,
           input[127:0] indata,
           output reg [127:0] recvdata,
           output isbusy,

           input  spi_clk,
           output reg spi_o,
           input spi_i,
           output reg switch = 0
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter

// regs or wires
reg[127:0] indata_temp = 0;
reg[7:0] data_length_remain = 0;
reg [127:0] recvdata_temp = 0;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////

assign isbusy = ~(switch);
always @ (posedge spi_clk or posedge start_trig) begin
    if(start_trig) begin
        data_length_remain <= dataLength;
    end
    else begin
        data_length_remain <= data_length_remain - 1;
        recvdata_temp <= {recvdata_temp[126:0],spi_i};
    end
end

always @ (negedge spi_clk or posedge start_trig) begin
    if(start_trig) begin
        indata_temp <= indata;
        switch <= 1;
        spi_o <= 1;
        // isbusy <= 1;
    end
    else begin
        if(data_length_remain == 0) begin
            switch <= 0;
            // isbusy <= 0;
            recvdata <= recvdata_temp;
        end
        else begin
            spi_o <= indata[data_length_remain - 1];
        end
    end
end


/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
