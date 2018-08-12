# close sim run before and clear console
quit -sim
.main clear

project open ./sim/vga

# compile verilog files
vlog ./sim/*.v
vlog ../src/*.v

# setup sim and add log wave
vsim -novopt work.tb_top
add wave /tb_top/*

# run
run 1ms
