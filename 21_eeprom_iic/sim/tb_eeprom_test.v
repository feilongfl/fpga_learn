/////////////////////////////////////////////
//               Test Bench
// author: feilong
// version: 1.0.0
/////////////////////////////////////////////

`timescale 10ns / 10ns
module tb_eeprom_test ();
/////////////////////////////////////////////
// parameter and signals
/////////////////////////////////////////////
// parameter

// regs or wires
reg sclk = 0;
reg srst_n = 0;
/////////////////////////////////////////////
// main code
/////////////////////////////////////////////
// System clock
always #10 sclk = ~sclk;

//inital
initial begin
    #0
     srst_n = 0;
    #30
     srst_n = 1;
end

reg trig = 0;
initial begin
    #0 trig = 0;
    #50 trig = 1;
    #10 trig = 0;
end
// models
wire [7:0]d;
wire scl,sda,ifail;
eeprom_test eeprom_test_inst(
                .s_rst_n(srst_n),
                .sclk_50m(sclk),
                .trig(trig),
                .iic_scl(scl),
                .iic_failed(ifail),
                .iic_sda(sda),
                .readData(d)
            );
/////////////////////////////////////////////
// code end
/////////////////////////////////////////////
endmodule
