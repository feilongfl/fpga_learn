vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 -incr \
"../../../../sobel.srcs/sources_1/ip/fifo_vgaline/sim/fifo_vgaline.v" \


vlog -work xil_defaultlib \
"glbl.v"

