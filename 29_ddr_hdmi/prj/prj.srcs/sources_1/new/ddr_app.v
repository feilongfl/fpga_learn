/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module ddr_app (
           // ctl
           input req_read,
           input req_write,
           output reg ack_write = 0,
           output[31:0] read_data,
           input[7:0] write_data,
           input readClk,
           input fifo_reset,

           // ddr3 user interface signals
           output reg [27:0] app_addr,
           output reg [2:0] app_cmd,
           output reg app_en,
           output reg [255:0] app_wdf_data,
           output app_wdf_end,
           output reg [31:0] app_wdf_mask,
           output reg app_wdf_wren,
           input [255:0] app_rd_data,
           input app_rd_data_end,
           input app_rd_data_valid,
           input app_rdy,
           input app_wdf_rdy,
           input ui_clk,
           input ui_clk_sync_rst
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter
parameter readTimeout = 100;
reg [15:0] readtime = 0;

localparam  S_INITIAL = 7'b000_0001;
localparam  S_IDLE = 7'b000_0010;
localparam  S_Write_Send_cmd = 7'b000_0100;
localparam  S_Write_finish = 7'b000_1000;
localparam  S_Read_wait_apprdy = 7'b001_0000;
localparam  S_ReadWaitData = 7'b010_0000;
localparam  S_Read_finish = 7'b100_0000;
reg [6:0] status = S_INITIAL;

localparam  appaddrwdfmaskinitial = 32'hffff_fffe;
localparam  appaddrwdfmaskfull = 32'h7fff_ffff;
// regs or wires
wire fifo_full,fifo_empty;
reg [255:0]ddrDataOut = 256'h0;
reg [27:0] app_addr_write = 27'h0;
reg [27:0] app_addr_read = 27'h0;

//
localparam readNumAll = 40;
reg [7:0] readNum = 0;
reg [7:0] recvNum = 0;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
assign app_wdf_end = app_wdf_wren;

// ila_1 ddr_ila (
//           .clk(ui_clk),
//
//           .probe0(ui_clk_sync_rst),
//           .probe1(fifo_reset),
//           .probe2(status),
//           .probe3(app_en),
//           .probe4(app_wdf_wren),
//           .probe5(app_wdf_mask),
//           .probe6(app_addr),
//           .probe7(ack_write),
//           .probe8(app_cmd),
//           .probe9(app_rdy),
//           .probe10(app_wdf_rdy),
//           .probe11(app_rd_data_valid),
//           .probe12(readNum)
//       );

always @ (posedge ui_clk or posedge ui_clk_sync_rst or posedge fifo_reset) begin
    if (ui_clk_sync_rst) begin
        status <= S_INITIAL;
        app_en <= 0;
        ack_write <= 0;
    end
    else if(fifo_reset) begin
        app_addr_read <= 0;
    end
    else
    case (status)
        S_INITIAL: begin
            app_en <= 0;
            app_wdf_wren <= 0;
            app_wdf_mask <= appaddrwdfmaskinitial;
            app_addr <= 0;
            app_addr_read <= 0;
            app_addr_write <= 0;
            ack_write <= 0;
            if(app_rdy) begin
                status <= S_IDLE;
                $display("ddr_app init finish!");
            end
        end
        S_IDLE: begin
            app_en <= 0;
            app_wdf_wren <= 0;
            ack_write <= 0;

            if (~fifo_full) begin
                status <= S_Read_wait_apprdy;
                app_cmd <= 3'b001;
                app_addr <= app_addr_read;
                readNum <= 0;
                recvNum <= 0;
                $display("ddr_app read addr => %h",app_addr_read);
            end
            else if (req_write) begin
                status <= S_Write_Send_cmd;
                app_cmd <= 3'b000;
                app_wdf_mask <= {app_wdf_mask[0],app_wdf_mask[31:1]};
                app_addr <= app_addr_write;
                app_wdf_data <= {32{write_data}};
                $display("ddr_app write => %h",write_data);
                $display("ddr_app write addr => %h",app_addr_write);
                $display("ddr_app write mask => %b",app_wdf_mask);
            end
            else begin
                status <= S_IDLE;
            end
        end
        S_Write_Send_cmd: begin
            app_en <= 1;
            app_wdf_wren <= 1;
            if(app_rdy && app_wdf_rdy)
                status <= S_Write_finish;
        end
        S_Write_finish: begin
            app_en <= 0;
            app_wdf_wren <= 0;
            ack_write <= 1;
            status <= S_IDLE;
            if(app_wdf_mask == appaddrwdfmaskfull)
                app_addr_write <= app_addr_write + 1;
            $display("ddr_app write finish!");
        end
        S_Read_wait_apprdy: begin
            app_en <= 1;
            if(app_rdy) begin
                app_addr <= app_addr_read + 1;
                app_addr_read <= app_addr_read + 1;
                readNum <= readNum + 1;
                if(!app_rd_data_valid)
                    recvNum <= recvNum + 1;
                if(readNumAll == readNum + 1) begin
                    status <= S_ReadWaitData;
                    // readtime <= 0;
                end
            end
        end
        S_ReadWaitData: begin
            app_en <= 0;
            if(app_rd_data_valid) begin
                recvNum <= recvNum + 1;
                readtime <= 0;
                if(readNumAll == recvNum + 1) begin
                    status <= S_Read_finish;
                end
            end
            else if(readtime == readTimeout) begin
                readNum <= 0;
                readtime <= 0;
                status <= S_Read_finish;
            end
            else begin
                readtime <= readtime + 1;
            end
        end
        S_Read_finish: begin
            app_en <= 0;
            // app_addr_read <= app_addr_read + 1;
            $display("ddr_app read finish!");
            // if (~fifo_full) begin
            //     status <= S_Read_wait_apprdy;
            //     // app_cmd <= 3'b001;
            //     app_addr <= app_addr_read + 1;
            //     $display("ddr_app read addr => %h",app_addr_read);
            // end
            // else begin
            status <= S_IDLE;
            // end
        end

        //
        default:
            status <= S_INITIAL;
    endcase
end

wire [6 : 0] rd_data_count;
wire [3 : 0] wr_data_count;

fifo_generator_0 ddr_read_fifo (
                     .wr_clk(ui_clk),  // input wire wr_clk
                     .wr_rst(fifo_reset),  // input wire wr_rst
                     .rd_clk(readClk),  // input wire rd_clk
                     .rd_rst(fifo_reset),  // input wire rd_rst
                     .din(app_rd_data),        // input wire [255 : 0] din
                     .wr_en(app_rd_data_valid),    // input wire wr_en
                     .rd_en(req_read & (~fifo_empty)),    // input wire rd_en
                     .dout(read_data),      // output wire [31 : 0] dout
                     .prog_full(fifo_full),      // output wire full
                     // .rd_data_count(rd_data_count),  // output wire [6 : 0] rd_data_count
                     // .wr_data_count(wr_data_count),  // output wire [3 : 0] wr_data_count
                     .empty(fifo_empty)    // output wire empty
                 );

// ila_0 fifo_ila (
//           .clk(readClk), // input wire clk
//
//           .probe0(fifo_full), // input wire [0:0]  probe0
//           .probe1(fifo_empty), // input wire [0:0]  probe1
//           .probe2(req_read & (~fifo_empty)), // input wire [0:0]  probe2
//           .probe3(fifo_reset) // input wire [0:0]  probe3
//       );
/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
