/opt/intelFPGA/18.0/modelsim_ase/bin/vlib /home/feilong/Storages/fpga/000_vivado_sim_linux32/sd_fec_v1_1_1
/opt/intelFPGA/18.0/modelsim_ase/bin/vmap sd_fec_v1_1_1 /home/feilong/Storages/fpga/000_vivado_sim_linux32/sd_fec_v1_1_1
/opt/intelFPGA/18.0/modelsim_ase/bin/vlog  -32 -L fec_5g_common_v1_1_0 -L sd_fec_v1_1_1 +incdir+/home/feilong/.cxl.ip/incl -sv -work sd_fec_v1_1_1 -f /home/feilong/Storages/fpga/000_vivado_sim_linux32/sd_fec_v1_1_1/.cxl.systemverilog.sd_fec_v1_1_1.sd_fec_v1_1_1.lin64.cmf
