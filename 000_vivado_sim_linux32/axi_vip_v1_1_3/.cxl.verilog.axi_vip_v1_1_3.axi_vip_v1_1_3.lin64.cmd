/opt/intelFPGA/18.0/modelsim_ase/bin/vlib /home/feilong/Storages/fpga/000_vivado_sim_linux32/axi_vip_v1_1_3
/opt/intelFPGA/18.0/modelsim_ase/bin/vmap axi_vip_v1_1_3 /home/feilong/Storages/fpga/000_vivado_sim_linux32/axi_vip_v1_1_3
/opt/intelFPGA/18.0/modelsim_ase/bin/vlog  -32 -L smartconnect_v1_0 -L axi_protocol_checker_v2_0_3 -L axi_vip_v1_1_3 -L xilinx_vip +incdir+/home/feilong/.cxl.ip/incl -sv -work axi_vip_v1_1_3 -f /home/feilong/Storages/fpga/000_vivado_sim_linux32/axi_vip_v1_1_3/.cxl.systemverilog.axi_vip_v1_1_3.axi_vip_v1_1_3.lin64.cmf
