/opt/intelFPGA/18.0/modelsim_ase/bin/vlib /home/feilong/Storages/fpga/000_vivado_sim_linux32/processing_system7_vip_v1_0_5
/opt/intelFPGA/18.0/modelsim_ase/bin/vmap processing_system7_vip_v1_0_5 /home/feilong/Storages/fpga/000_vivado_sim_linux32/processing_system7_vip_v1_0_5
/opt/intelFPGA/18.0/modelsim_ase/bin/vlog  -32 -L smartconnect_v1_0 -L axi_protocol_checker_v2_0_3 -L axi_vip_v1_1_3 -L processing_system7_vip_v1_0_5 -L xilinx_vip +incdir+/home/feilong/.cxl.ip/incl -sv -work processing_system7_vip_v1_0_5 -f /home/feilong/Storages/fpga/000_vivado_sim_linux32/processing_system7_vip_v1_0_5/.cxl.systemverilog.processing_system7_vip_v1_0_5.processing_system7_vip_v1_0_5.lin64.cmf