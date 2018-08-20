
module uartaddr (
           input ui_clk,
           input ui_clk_sync_rst,

           // input dataRecvFlag,

           input app_rdy,
           input app_wdf_rdy,

           output reg [27:0] app_addr,
           output reg [2:0] app_cmd,

           output reg app_en,
           output app_wdf_end,
           output reg app_wdf_wren,
           output reg [31:0] app_wdf_mask = 32'b11111111_11111111_11111111_11111110,
           // output reg [255:0] app_wdf_data,

           input app_rd_data_valid,
           input [255:0] app_rd_data,

           input uart_rx_done,
           output reg uart_tx_en = 0,
           output reg [7:0] uart_tx_data,
           input[7:0] uartdata,//debug only
           input uart_tx_busy
       );

// parameter
parameter Length = 10;
reg [31:0] saveCounter = 0;
// regs or wires

localparam Status_Idle = 5'b00001;
localparam Status_Write_DDR = 5'b00010;
localparam Status_READ_DDR = 5'b00100;
localparam Status_READ_END = 5'b01000;
localparam Status_Err = 5'b10000;

reg[4:0] status = Status_Idle;

// reg writeFlag = 0;

localparam  RS_SEND_CMD = 5'b00001;
localparam  RS_WAIT_DATA = 5'b00010;
localparam  RS_PRE_UART = 5'b00100;
localparam  RS_TX_TRIG = 5'b01000;
localparam  RS_FIN = 5'b10000;
reg [4:0] readStatus = RS_SEND_CMD;

reg [255:0] recvDataTemp = 0;

// reg[15:0]readTime = 0;
localparam  WS_WAIT_RX = 5'b00001;
localparam  WS_CACHE_DATA = 5'b00010;
localparam  WS_TRIG_CMD = 5'b00100;
localparam  WS_FIN = 5'b01000;
reg [4:0] writeStatus = WS_WAIT_RX;

reg[4:0] rdTime = 0;
parameter rdTimeLim = 100;

reg trigedrx = 0;

ila_0 ila0 (
          .clk(ui_clk), // input wire clk

          .probe0(app_en),
          .probe1(app_rdy),
          .probe2(app_wdf_rdy),
          .probe3(app_rd_data_valid),
          .probe4(saveCounter[6:0]),
          .probe5(status),
          .probe6(readStatus),
          .probe7(writeStatus)
      );

assign app_wdf_end = app_wdf_wren;

always @ (posedge ui_clk or posedge ui_clk_sync_rst) begin
    if(ui_clk_sync_rst) begin
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
                status <= Status_READ_END;
        Status_READ_END:
            status <= Status_Idle;
        default:
            status <= Status_Idle;
    endcase
end

always @ (posedge ui_clk or posedge ui_clk_sync_rst) begin
    if(ui_clk_sync_rst) begin
        app_wdf_mask <= 32'b11111111_11111111_11111111_11111110;
        saveCounter <= 0;
        // app_wdf_end <= 0;
        app_wdf_wren <= 0;
        app_en <= 0;
        app_addr <= 0;
    end
    else begin
        if(status == Status_Write_DDR) begin
            app_cmd <= 3'b000;
            case (writeStatus)
                WS_WAIT_RX: begin
                    app_en <= 0;
                    if(uart_rx_done) begin
                        writeStatus <= WS_TRIG_CMD;
                        app_wdf_mask <= {app_wdf_mask[0],app_wdf_mask[31:1]};
                        app_addr <= saveCounter / 32;
                    end
                end
                WS_TRIG_CMD: begin
                    // app_wdf_end <= 1;
                    app_wdf_wren <= 1;
                    app_en <= 1;
                    writeStatus <= WS_FIN;
                    $display("[%d]uart fake rx => %h,mask => %b",saveCounter,uartdata,app_wdf_mask);
                end
                WS_FIN: begin
                    if(app_rdy && app_wdf_rdy) begin
                        // app_wdf_end <= 0;
                        app_wdf_wren <= 0;
                        app_en <= 0;
                        saveCounter <= saveCounter + 1;
                        writeStatus <= WS_WAIT_RX;
                    end
                end
                default:
                    writeStatus = WS_WAIT_RX;
            endcase
        end
        else if(status == Status_READ_DDR) begin
            app_cmd <= 3'b001;
            case (readStatus)
                RS_SEND_CMD: begin
                    if(saveCounter != 0 && app_rdy && app_cmd == 3'b001) begin
                        app_en <= 1;
                        app_addr <= (saveCounter - 1) / 32;
                        rdTime <= 0;
                        readStatus <= RS_WAIT_DATA;
                    end
                end
                RS_WAIT_DATA: begin
                    app_en <= 0;
                    if(app_rd_data_valid) begin
                        recvDataTemp <= app_rd_data;
                        readStatus <= RS_PRE_UART;
                        rdTime <= 0;
                    end
                    else if(rdTime == rdTimeLim) begin // err when send cmd but no data return
                        rdTime <= 0;
                        readStatus <= RS_SEND_CMD;
                    end
                    else
                        rdTime <= rdTime + 1;
                end
                RS_PRE_UART: begin
                    uart_tx_data <= (recvDataTemp >> ((31 - (saveCounter - 1) % 32) * 8)) & 8'hff;
                    $display("[%d]uart fake tx => %h,orig => %h",saveCounter,(recvDataTemp >> ((31 - (saveCounter - 1) % 32) * 8)) & 8'hff,recvDataTemp);

                    // uart_tx_data <= readTime;
                    // readTime <= readTime + 1;
                    readStatus <= RS_TX_TRIG;
                end
                RS_TX_TRIG: begin
                    if(!uart_tx_busy) begin
                        uart_tx_en <= 1;
                        readStatus <= RS_FIN;
                        trigedrx <= 0;
                    end
                end
                RS_FIN: begin
                    uart_tx_en <= 0;

                    if(uart_tx_busy)
                        trigedrx <= 1;

                    if(!uart_tx_busy && trigedrx) begin
                        app_wdf_mask <= {app_wdf_mask[30:0],app_wdf_mask[31]};
                        saveCounter <= (saveCounter == 0)? 0 : saveCounter - 1;
                        readStatus <= RS_SEND_CMD;
                    end
                end
                default:
                    readStatus <= RS_SEND_CMD;
            endcase
        end
    end
end

endmodule
