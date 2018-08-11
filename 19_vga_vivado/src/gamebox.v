/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module gamebox (
           input clk,
           input rst_n,
           input [15:0] x,
           input [15:0] y,
           output [7:0]r,
           output [7:0]g,
           output [7:0]b,
           input data_box,
           input data_board,
           output [15:0]px,py,
           output [15:0]bx,by,
           input button_clk,
           input button_left,button_right
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter
parameter box_w = 100;
parameter box_h = 100;

parameter drawable_w = 640;
parameter drawable_h = 480;

parameter box_x_speed = 1;
parameter box_y_speed = 1;

parameter board_y = 400;
parameter board_height = 50;
parameter board_width = 100;

parameter board_x_speed = 3;

// regs or wires
reg [15:0] box_x = 0;
reg [15:0] box_y = 0;

reg box_x_inv_flag = 0;
reg box_y_inv_flag = 0;

reg [15:0] board_x = 0.5 * (drawable_w - board_width);
// reg [15:0]board_x = 100;

/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
always @ (posedge button_clk or negedge rst_n) begin
    if(!rst_n)
        board_x <= 0.5 * (drawable_w - board_width);
    else begin
        if(!button_left)
            board_x <= (board_x == 0)?
                    0 : board_x - board_x_speed;
        // board_x <= board_x - 1;
        else if(!button_right)
            board_x <= (board_x == drawable_w - board_width)?
                    drawable_w - board_width : board_x + board_x_speed;
        // board_x <= board_x + 1;
        else
            board_x <= board_x;
    end
end

always @ (negedge clk) begin
    if (box_x + box_w == drawable_w) begin
        box_x_inv_flag <= 1;
    end
    else if (box_x == 0) begin
        box_x_inv_flag <= 0;
    end
end

always @ (negedge clk) begin
    if (box_y + box_h == drawable_h) begin
        box_y_inv_flag <= 1;
    end
    else if (box_y == 0) begin
        box_y_inv_flag <= 0;
    end
    else if(
        (box_x + box_w > board_x)
        && (box_x < board_x + board_width)
        && (box_y + box_h > board_y)
    ) begin
        box_y_inv_flag <= 1;
    end
end

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        box_x <= 0;
        box_y <= 0;
    end
    else begin
        box_x <= (box_x_inv_flag == 1)?
              box_x - box_x_speed : box_x + box_x_speed;
        box_y <= (box_y_inv_flag == 1)?
              box_y - box_y_speed : box_y + box_y_speed;
    end
end

assign g = (box_y + box_h - box_y_speed <= board_y)? r : b;
assign b = (x >= board_x
            && x < (board_x + board_width)
            && y >= (board_y)
            && y < (board_y + board_height)
           )? {data_board,data_board,data_board,data_board,data_board,data_board,data_board,data_board} : 0;
assign r = (x >= box_x
            && x < (box_x + box_w)
            && y >= (box_y)
            && y < (box_y + box_h)
           )? {data_box,data_box,data_box,data_box,data_box,data_box,data_box,data_box} : 0;

assign px = (x >= box_x && x < (box_x + box_w))?
       x - box_x : 0;
assign py = (y >= (box_y) && y < (box_y + box_h))?
       y - box_y : 0;


assign bx = (x >= board_x && x < (board_x + board_width))?
       x - board_x : 0;
assign by = (y >= (board_y) && y < (board_y + board_height))?
       board_height - (y - board_y) : 0;

/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
