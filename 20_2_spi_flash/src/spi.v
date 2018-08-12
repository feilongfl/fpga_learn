/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module spi (
           input  sclk,
           input en,
           output dataflag,
           input [7:0] datasend,
           output reg[7:0]datarecv = 0,

           // to hardware
           output spi_clk,
           input spi_di,
           output reg spi_do = 0,
           output spi_cs
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter
localparam  byteLength = 8;
// regs or wires
reg[2:0] en_buff = 0;
wire en_posedge,en_negedge;

reg[7:0] data_send_temp;
reg[7:0] data_recv_temp = 0;

reg[3:0] data_cnt = 0;

reg dataflag_temp = 0;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
always @ (posedge sclk) begin
    en_buff = {en_buff[1:0],en};
end
assign en_posedge = en & (~en_buff[1]);
assign en_negedge = (~en) & (en_buff[1]);

always @ (posedge sclk or posedge en_posedge or posedge en_negedge) begin
    if(en_posedge) begin
        data_send_temp <= datasend;
        data_cnt <= 0;
        // dataflag_temp <= 1;
    end
    else if(en_negedge) begin
        datarecv <= data_recv_temp;
        data_cnt <= 0;
        // dataflag_temp <= 0;
    end
    else begin
        if(en_buff[1]) begin
            if(data_cnt == 7) begin
                // dataflag_temp <= 1;
                data_cnt <= 0;
                // spi_do <= data_send_temp[byteLength - data_cnt - 1];
                // data_recv_temp[byteLength - data_cnt] <= spi_di;
                data_send_temp <= datasend;
            end
            else if(data_cnt == 0) begin
                // dataflag_temp <= 0;
                data_cnt <= data_cnt + 1;
                // spi_do <= data_send_temp[byteLength - data_cnt - 1];
                // data_recv_temp[byteLength - data_cnt] <= spi_di;
                datarecv <= data_recv_temp;
            end
            else begin
                // dataflag <= 0;
                data_cnt <= data_cnt + 1;
                // spi_do <= data_send_temp[byteLength - data_cnt];
                // data_recv_temp[byteLength - data_cnt] <= spi_di;
            end
        end
    end
end

always @ (negedge sclk or posedge en_posedge or posedge en_negedge) begin
    if(en_posedge) begin
        dataflag_temp <= 1;
    end
    if(en_negedge) begin
        dataflag_temp <= 0;
    end
    else begin
        // if(en_buff[1]) begin
        case (data_cnt)
            7:
                dataflag_temp <= (en_buff[1] == 1)? 1 : dataflag_temp;
            0:
                dataflag_temp <= (en_buff[1] == 1)? 0 : dataflag_temp;
            default:
                dataflag_temp <= (en_buff[1] == 1)? 0 : dataflag_temp;
        endcase
        // end

        // if(en_buff[1] == 1) begin
        //     case (data_cnt)
        //         7:
        //             dataflag_temp <= 1;
        //         0:
        //             dataflag_temp <= 0;
        //         default:
        //             dataflag_temp <= 0;
        //     endcase
        // end
    end
end
assign dataflag = dataflag_temp | en_posedge;

always @ (negedge sclk) begin
    spi_do <= data_send_temp[byteLength - data_cnt - 1];
end

always @ (posedge sclk) begin
    data_recv_temp[byteLength - data_cnt - 1] <= spi_di;
end

assign spi_clk = ((en_buff[2] & en)) & sclk;
assign spi_cs = (~en_buff[1]) | en_negedge;



/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
