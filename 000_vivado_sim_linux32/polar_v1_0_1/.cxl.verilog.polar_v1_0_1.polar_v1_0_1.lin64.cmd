/opt/intelFPGA/18.0/modelsim_ase/bin/vlib /home/feilong/Storages/fpga/000_vivado_sim_linux32/polar_v1_0_1
/opt/intelFPGA/18.0/modelsim_ase/bin/vmap polar_v1_0_1 /home/feilong/Storages/fpga/000_vivado_sim_linux32/polar_v1_0_1
/opt/intelFPGA/18.0/modelsim_ase/bin/vlog  -32 -L fec_5g_common_v1_1_0 -L polar_v1_0_1 +incdir+/home/feilong/.cxl.ip/incl -sv -work polar_v1_0_1 -f /home/feilong/Storages/fpga/000_vivado_sim_linux32/polar_v1_0_1/.cxl.systemverilog.polar_v1_0_1.polar_v1_0_1.lin64.cmf
