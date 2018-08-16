/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module readSent (
           input ui_clk,
           input ui_clk_sync_rst,

           // input dataRecvFlag,

           input app_rdy,
           input app_wdf_rdy,

           output reg [27:0] app_addr,
           output reg [2:0] app_cmd,

           output reg app_en,
           output reg app_wdf_end,
           output reg app_wdf_wren,
           output reg [31:0] app_wdf_mask,
           // output reg [255:0] app_wdf_data,

           input app_rd_data_valid,
           input [255:0] app_rd_data,

           input uart_rx_done,
           output reg uart_tx_en,
           output reg uart_tx_data,
           input uart_tx_busy
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter
parameter Length = 10;
reg [31:0] saveCounter = 0;
// regs or wires

localparam Status_Idle = 5'b00001;
localparam Status_Write_DDR = 5'b00010;
localparam Status_READ_DDR = 5'b00100;
localparam Status_SendData = 5'b01000;
localparam Status_Err = 5'b10000;

reg[4:0] status = Status_Idle;

reg [255:0] recvDataTemp = 0;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
always @ ( posedge ui_clk or posedge ui_clk_sync_rst ) begin
    if (ui_clk_sync_rst) begin
        status <= Status_Idle;
    end
    else
    case (status)
        Status_Idle:
            if( app_rdy && app_wdf_rdy )
                status <= Status_Write_DDR;
        Status_Write_DDR:
            if(saveCounter == Length)
                status <= Status_READ_DDR;
        Status_READ_DDR:
            if(saveCounter == 0)
                status <= Status_Write_DDR;
            else if(app_rd_data_valid) begin
                status <= Status_SendData;
                recvDataTemp <= app_rd_data;
            end
        Status_SendData:
            if(app_addr % 32 == 0) begin
                status <= Status_SendData;
            end
        Status_Err:
                    status <= Status_Idle;
default:
            status <= Status_Idle;
    endcase
end


always @ (posedge ui_clk) begin
    case (status)
        Status_Write_DDR: begin
            app_cmd <= 3'b000;
            if(uart_rx_done) begin
                saveCounter <= saveCounter + 1;
                app_wdf_end <= 1;
                app_wdf_wren <= 1;
                app_en <= 1;
            end
            else begin
                app_wdf_end <= 0;
                app_wdf_wren <= 0;
                app_en <= 0;
            end
        end
        Status_READ_DDR: begin
            app_cmd <= 3'b001;
            app_wdf_wren <= 0;
        end
        Status_SendData: begin
            if(!uart_tx_busy) begin
                // saveCounter <= saveCounter - 1;
                uart_tx_en <= 1;
//                uart_tx_data <= app_rd_data[(recvDataTemp % 32) * 8 + 7 : (recvDataTemp % 32) * 8];
            end
            else begin
                uart_tx_en <= 0;
            end
        end
        default: begin
            saveCounter <= 0;
        end
    endcase
end

always @ ( * ) begin
    app_addr = saveCounter / 32;
    case (app_addr % 32)
        0:
            app_wdf_mask = 32'b11111111_11111111_11111111_11111110;
        1:
            app_wdf_mask = 32'b11111111_11111111_11111111_11111101;
        2:
            app_wdf_mask = 32'b11111111_11111111_11111111_11111011;
        3:
            app_wdf_mask = 32'b11111111_11111111_11111111_11110111;
        4:
            app_wdf_mask = 32'b11111111_11111111_11111111_11101111;
        5:
            app_wdf_mask = 32'b11111111_11111111_11111111_11011111;
        6:
            app_wdf_mask = 32'b11111111_11111111_11111111_10111111;
        7:
            app_wdf_mask = 32'b11111111_11111111_11111111_01111111;
        8:
            app_wdf_mask = 32'b11111111_11111111_11111110_11111111;
        9:
            app_wdf_mask = 32'b11111111_11111111_11111101_11111111;
        10:
            app_wdf_mask = 32'b11111111_11111111_11111011_11111111;
        11:
            app_wdf_mask = 32'b11111111_11111111_11110111_11111111;
        12:
            app_wdf_mask = 32'b11111111_11111111_11101111_11111111;
        13:
            app_wdf_mask = 32'b11111111_11111111_11011111_11111111;
        14:
            app_wdf_mask = 32'b11111111_11111111_10111111_11111111;
        15:
            app_wdf_mask = 32'b11111111_11111111_01111111_11111111;
        16:
            app_wdf_mask = 32'b11111111_11111110_11111111_11111111;
        17:
            app_wdf_mask = 32'b11111111_11111101_11111111_11111111;
        18:
            app_wdf_mask = 32'b11111111_11111011_11111111_11111111;
        19:
            app_wdf_mask = 32'b11111111_11110111_11111111_11111111;
        20:
            app_wdf_mask = 32'b11111111_11101111_11111111_11111111;
        21:
            app_wdf_mask = 32'b11111111_11011111_11111111_11111111;
        22:
            app_wdf_mask = 32'b11111111_10111111_11111111_11111111;
        23:
            app_wdf_mask = 32'b11111111_01111111_11111111_11111111;
        24:
            app_wdf_mask = 32'b11111110_11111111_11111111_11111111;
        25:
            app_wdf_mask = 32'b11111101_11111111_11111111_11111111;
        26:
            app_wdf_mask = 32'b11111011_11111111_11111111_11111111;
        27:
            app_wdf_mask = 32'b11110111_11111111_11111111_11111111;
        28:
            app_wdf_mask = 32'b11101111_11111111_11111111_11111111;
        29:
            app_wdf_mask = 32'b11011111_11111111_11111111_11111111;
        30:
            app_wdf_mask = 32'b10111111_11111111_11111111_11111111;
        31:
            app_wdf_mask = 32'b01111111_11111111_11111111_11111111;

        default:
            app_wdf_mask = 32'b11111111_11111111_11111111_11111111;
    endcase
end

/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
