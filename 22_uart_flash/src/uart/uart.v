/////////////////////////////////////////////
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

module uart (
           //clock
           input  clk,

           //flags
           tx_trig,
           rx_flag,

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
parameter BandRate = 115200;
parameter InclkFreq = 50_000_000;

parameter ClkWidth = InclkFreq / BandRate / 2;
// regs or wires
reg serialClk = 0;
reg [15:0] serialClkCounter = 0;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
// initial serial port clock
always @ (posedge clk) begin
    serialClkCounter <= (serialClkCounter == ClkWidth)? 0 : serialClkCounter + 1;
    serialClk <= (serialClkCounter == 0)? serialClk : ~serialClk;
end

//recv module
uart_recv uart_recv_inst(
              .clk(clk),

              .flag(rx_flag),

              //read
              .data(data_rx),
              .rx(rx)
          );

//send module
uart_send uart_send_inst(
              //clock
              .clk(clk),
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
