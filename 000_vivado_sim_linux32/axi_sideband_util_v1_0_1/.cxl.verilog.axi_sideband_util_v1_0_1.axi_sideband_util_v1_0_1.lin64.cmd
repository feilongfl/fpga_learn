/opt/intelFPGA/18.0/modelsim_ase/bin/vlib /home/feilong/Storages/fpga/000_vivado_sim_linux32/axi_sideband_util_v1_0_1
/opt/intelFPGA/18.0/modelsim_ase/bin/vmap axi_sideband_util_v1_0_1 /home/feilong/Storages/fpga/000_vivado_sim_linux32/axi_sideband_util_v1_0_1
/opt/intelFPGA/18.0/modelsim_ase/bin/vlog  -32 -L smartconnect_v1_0 -L axi_sideband_util_v1_0_1 +incdir+/home/feilong/.cxl.ip/incl -sv -work axi_sideband_util_v1_0_1 -f /home/feilong/Storages/fpga/000_vivado_sim_linux32/axi_sideband_util_v1_0_1/.cxl.systemverilog.axi_sideband_util_v1_0_1.axi_sideband_util_v1_0_1.lin64.cmf
