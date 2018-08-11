/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module xy2addr (
           input [15:0] x,
           input [15:0] y,
           output [13:0] addr
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter
parameter WIDTH = 100;

// regs or wires

/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
assign addr = (x >= 0 && y >= 0)?
       x + WIDTH * y : 0;



/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
