/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module iic (
           input clk,
           input en,

           input [7:0] data,
           output reg [7:0] readdata,

           output reg flag,

           output reg iclk,
           output reg failed = 0,
           inout sdata
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter
localparam  S_IIC_START = 8'b0000_0001;
localparam  S_IIC_WRITE_DEVICE = 8'b0000_0010;
localparam  S_IIC_WRITE_COMMAND = 8'b0000_0100;
localparam  S_IIC_READ = 8'b0000_1000;
localparam  S_IIC_STOP = 8'b0001_0000;
// localparam  S_IIC_ACK = 8'b0010_0000;

localparam  S_IIC_IDLE = 8'b1000_0000;
reg[7:0]status = S_IIC_IDLE;

// regs or wires
reg [2:0] en_buff = 0;
// reg iclk_delaied = 0;
// reg data_w_temp;
reg[7:0] data_r_temp;

reg iodata_temp;

reg[2:0] start_sig_cnt = 0;
reg[4:0] rw_cnt = 0;
reg[2:0] end_sig_cnt = 0;

// reg needRead = 0;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
// push data
assign sdata = (iodata_temp == 1) ? 1'bz : 0;

// push data gengrator
always @ (posedge clk) begin
    case (status)
        S_IIC_IDLE:
            iodata_temp <= 1;
        S_IIC_START:
            iodata_temp = (start_sig_cnt == 0)? 1 : 0 ;
        S_IIC_WRITE_DEVICE, S_IIC_WRITE_COMMAND: begin
            // if(rw_cnt[0])
            iodata_temp <= (rw_cnt >= 16)? 1 : data[7 - rw_cnt / 2];
        end
        S_IIC_READ: begin // ack sig
            iodata_temp <= (
                ((rw_cnt == 17) && (iodata_temp == 0))
                || rw_cnt == 16
            )? 0 : 1;
        end
        S_IIC_STOP:
            iodata_temp <= (end_sig_cnt == 0)? 0 : 1 ;
        default:
            iodata_temp <= 1;
    endcase
end

// readdata
always @ ( posedge clk ) begin
    if(status == S_IIC_READ) begin
        case (rw_cnt)
            1,3,5,7,9,11,13,15:
                data_r_temp <= {data_r_temp[7:1],sdata};
            default:
                ;
        endcase
    end
end

always @ (posedge flag) begin
    if(status == S_IIC_READ)
        readdata <= data_r_temp;
end

// gen en eage
assign en_posedge = en & (~en_buff[1]);
assign en_negedge = (~en) & (en_buff[1]);

// gen clk
always @ (negedge clk) begin
    iclk <= (status != S_IIC_IDLE)? ~iclk : 0;
    // iclk_delaied <= iclk;
    en_buff <= {en_buff[1:0], en};
end

// gen start signals
always @ (posedge clk) begin
    start_sig_cnt <= (status == S_IIC_START )? start_sig_cnt + 1 : 0;
end

// gen stop signals
always @ (posedge clk) begin
    end_sig_cnt <= (status == S_IIC_STOP )? end_sig_cnt + 1 : 0;
end

// read write counter adder and cycle finish signal
always @ (posedge clk) begin
    rw_cnt <= (
               status == S_IIC_WRITE_DEVICE
               || status == S_IIC_WRITE_COMMAND
               || status == S_IIC_READ
           )? ((rw_cnt == 17)? 0 : rw_cnt + 1) : 0;
    flag <= (rw_cnt == 17)? 1 : 0;
end

// failed check,check ack signal
always @ (posedge clk) begin
    if(rw_cnt == 17)
        failed <= sdata; // if failed this signal will set to 1.
end

// status mechine
always @ (negedge clk) begin
    case (status)
        S_IIC_IDLE: begin
            if(en_posedge)
                status <= S_IIC_START;
        end
        S_IIC_START: begin
            status <= (start_sig_cnt == 2)? S_IIC_WRITE_DEVICE : S_IIC_START;
        end
        S_IIC_WRITE_DEVICE: begin
            status <= (rw_cnt == 17)?
            ((data[0])? S_IIC_READ : S_IIC_WRITE_COMMAND)
            : S_IIC_WRITE_DEVICE;
        end
        S_IIC_WRITE_COMMAND, S_IIC_READ: begin
            if(en_negedge)
                status <= S_IIC_STOP;
        end
        S_IIC_STOP: begin
            status <= (end_sig_cnt == 2)? S_IIC_IDLE : S_IIC_STOP;
        end
        default:
            status <= S_IIC_IDLE;
    endcase
end


/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
