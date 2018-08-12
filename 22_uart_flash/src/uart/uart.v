/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module uart (
           //clock
           input  clk,

           //flags
           input tx_trig,
           output rx_flag,
           output busy,

           //data interface
           input[7:0] data_tx,
           output [7:0] data_rx,

           //interface
           output tx,
           input rx
       );
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter

// regs or wires
wire SerialClk;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
// initial serial port clock
uart_clk uart_clk_inst(
             .clk(clk),
             .oclk(SerialClk)
         );
//recv module
uart_recv uart_recv_inst(
              .clk(SerialClk),

              .flag(rx_flag),

              //read
              .data(data_rx),
              .rx(rx)
          );

//send module
uart_send uart_send_inst(
              //clock
              .clk(SerialClk),
              //in data
              .trig(tx_trig),
              .data(data_tx),
              //out data
              .busy(busy),
              .tx(tx)
          );

/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
