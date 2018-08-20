-makelib xcelium_lib/xil_defaultlib -sv \
  "D:/Xilinx/vivado/Vivado/2018.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "D:/Xilinx/vivado/Vivado/2018.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../ipstatic/src/TMDSEncoder.vhd" \
  "../../../ipstatic/src/SerializerN_1.vhd" \
  "../../../ipstatic/src/DVITransmitter.vhd" \
  "../../../ipstatic/src/hdmi_tx.vhd" \
  "../../../../sobel.srcs/sources_1/ip/HDMI_FPGA_ML_A7_0/sim/HDMI_FPGA_ML_A7_0.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

