#!/usr/bin/env vsim

# close sim run before and clear console
quit -sim
.main clear

# compile verilog files
vlog ./altera_mf.v
vlog ./tb_adder.v
vlog ../src/*.v

# setup sim and add log wave
vsim -novopt work.tb_top
add wave /tb_top/*

# run
run 1ms

# close sim run before and clear console
quit -sim
.main clear

# compile verilog files
vlog ./*.v
vlog ../src/*.v

# setup sim and add log wave
vsim -novopt work.tb_top
add wave /tb_top/*
# run
run 1ms
