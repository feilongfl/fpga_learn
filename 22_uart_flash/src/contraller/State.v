`ifndef STATE_MACHINE_VALUE
`define STATE_MACHINE_VALUE

`define  S_WAIT_HEAD 8'b0000_0001
`define  S_WAIT_COMMAND 8'b0000_0010
`define  S_WAIT_BYTELENGTH 8'b0000_1000
`define  S_WRITING_RAM 8'b0001_0000
`define  S_READING_RAM 8'b0010_0000
`define  S_WRITING_FLASH 8'b0100_0000
`define  S_READING_FLASH 8'b1000_0000

`endif //STATE_MACHINE_VALUE
