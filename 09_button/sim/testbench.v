`timescale 10ns / 10ns

module testbench ();

//gen system clk
reg clk = 0;
always #5 clk = ~clk;

reg sig_in = 1;
//gen input signal
initial begin
    #0
    sig_in = 1;
    #10
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #10
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = 0;
    #100
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #10
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = ~sig_in;
    #1
    sig_in = 1;
end

wire pos_flag_out;
wire neg_flag_out;
input_filter if_inst(
    .clk (clk),
    .sig_in (sig_in),
    .pos_flag (pos_flag_out),
    .neg_flag (neg_flag_out)
);

endmodule
