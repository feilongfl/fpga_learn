vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vcom -work xil_defaultlib -64 -93 \
"../../../ipstatic/src/TMDSEncoder.vhd" \
"../../../ipstatic/src/SerializerN_1.vhd" \
"../../../ipstatic/src/DVITransmitter.vhd" \
"../../../ipstatic/src/hdmi_tx.vhd" \
"../../../../sobel.srcs/sources_1/ip/HDMI_FPGA_ML_A7_0/sim/HDMI_FPGA_ML_A7_0.vhd" \


vlog -work xil_defaultlib \
"glbl.v"

