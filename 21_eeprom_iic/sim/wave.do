onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /tb_iic/iic_test_inst/clk
add wave -noupdate -radix hexadecimal /tb_iic/iic_test_inst/data
add wave -noupdate -radix hexadecimal /tb_iic/iic_test_inst/readdata
add wave -noupdate -radix unsigned /tb_iic/iic_test_inst/flag
add wave -noupdate -radix unsigned /tb_iic/iic_test_inst/sdata
add wave -noupdate -radix unsigned /tb_iic/iic_test_inst/en_buff
add wave -noupdate -radix unsigned /tb_iic/iic_test_inst/needRead
add wave -noupdate -radix unsigned /tb_iic/iic_test_inst/en_posedge
add wave -noupdate -radix unsigned /tb_iic/iic_test_inst/en_negedge
add wave -noupdate -radix unsigned /tb_iic/iic_test_inst/en
add wave -noupdate -radix unsigned /tb_iic/iic_test_inst/iodata_temp
add wave -noupdate -radix unsigned /tb_iic/iic_test_inst/iclk
add wave -noupdate -radix unsigned /tb_iic/iic_test_inst/status
add wave -noupdate -radix unsigned /tb_iic/iic_test_inst/start_sig_cnt
add wave -noupdate -radix unsigned /tb_iic/iic_test_inst/write_cnt
add wave -noupdate -radix unsigned /tb_iic/iic_test_inst/end_sig_cnt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4520 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {21040 ns}
