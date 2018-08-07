module svtest(input i,output[2:0] o);
typedef enum logic [2:0] {
            RED, GREEN, BLUE, CYAN, MAGENTA, YELLOW
        } color_t;

color_t   my_color = MAGENTA;
//initial $display("The color is %s", my_color.name());
always_ff @ (posedge i) begin
              ;
          end
          endmodule
