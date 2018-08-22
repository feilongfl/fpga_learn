vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/xpm

vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap xpm questa_lib/msim/xpm

vlog -work xil_defaultlib -64 -sv "+incdir+../../../../mig_7series_0_ex.srcs/sources_1/ip/vio_0/hdl/verilog" "+incdir+../../../../mig_7series_0_ex.srcs/sources_1/ip/vio_0/hdl" "+incdir+../../../../mig_7series_0_ex.srcs/sources_1/ip/vio_0/hdl/verilog" "+incdir+../../../../mig_7series_0_ex.srcs/sources_1/ip/vio_0/hdl" \
"D:/Xilinx/vivado/Vivado/2018.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/Xilinx/vivado/Vivado/2018.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"D:/Xilinx/vivado/Vivado/2018.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 "+incdir+../../../../mig_7series_0_ex.srcs/sources_1/ip/vio_0/hdl/verilog" "+incdir+../../../../mig_7series_0_ex.srcs/sources_1/ip/vio_0/hdl" "+incdir+../../../../mig_7series_0_ex.srcs/sources_1/ip/vio_0/hdl/verilog" "+incdir+../../../../mig_7series_0_ex.srcs/sources_1/ip/vio_0/hdl" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/vio_0/sim/vio_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

