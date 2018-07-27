/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module box (
           input clk,
           input rst_n,
           input  x,
           input  y,
           output [7:0]r,
           output [7:0]g,
           output [7:0]b
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter
parameter box_w = 50;
parameter box_h = 50;

parameter drawable_w = 640;
parameter drawable_h = 480;

parameter box_x_speed = 1;
parameter box_y_speed = 1;

// regs or wires
reg [15:0] box_x = 0;
reg [15:0] box_y = 0;

reg box_x_inv_flag = 0;
reg box_y_inv_flag = 0;

/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        box_x <= 0;
        box_y <= 0;
    end
    else begin
        if (box_x + box_w == drawable_w) begin
            box_x_inv_flag = 1;
        end
        if (box_x == 0) begin
            box_x_inv_flag = 0;
        end
        if (box_y + box_h == drawable_h) begin
            box_y_inv_flag = 1;
        end
        if (box_y == 0) begin
            box_y_inv_flag = 0;
        end
        box_x <= (box_x_inv_flag == 1)?
              box_x - box_x_speed : box_x + box_x_speed;
        box_y <= (box_y_inv_flag == 1)?
              box_y - box_y_speed : box_y + box_y_speed;
    end
end

assign g = r;
assign b = r;
assign r = (x >= box_x
            && x < (box_x + box_w)
            && y >= (box_y)
            && y < (box_y + box_h)
           )? 8'hff : 0;


/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
