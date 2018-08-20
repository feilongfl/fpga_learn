/opt/intelFPGA/18.0/modelsim_ase/bin/vlib /home/feilong/Storages/fpga/000_vivado_sim_linux32/ldpc_v2_0_1
/opt/intelFPGA/18.0/modelsim_ase/bin/vmap ldpc_v2_0_1 /home/feilong/Storages/fpga/000_vivado_sim_linux32/ldpc_v2_0_1
/opt/intelFPGA/18.0/modelsim_ase/bin/vlog  -32 -L fec_5g_common_v1_1_0 -L ldpc_v2_0_1 +incdir+/home/feilong/.cxl.ip/incl -sv -work ldpc_v2_0_1 -f /home/feilong/Storages/fpga/000_vivado_sim_linux32/ldpc_v2_0_1/.cxl.systemverilog.ldpc_v2_0_1.ldpc_v2_0_1.lin64.cmf
