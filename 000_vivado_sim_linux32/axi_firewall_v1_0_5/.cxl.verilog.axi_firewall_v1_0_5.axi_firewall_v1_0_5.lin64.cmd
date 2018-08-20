/opt/intelFPGA/18.0/modelsim_ase/bin/vlib /home/feilong/Storages/fpga/000_vivado_sim_linux32/axi_firewall_v1_0_5
/opt/intelFPGA/18.0/modelsim_ase/bin/vmap axi_firewall_v1_0_5 /home/feilong/Storages/fpga/000_vivado_sim_linux32/axi_firewall_v1_0_5
/opt/intelFPGA/18.0/modelsim_ase/bin/vlog  -32 -L smartconnect_v1_0 -L axi_firewall_v1_0_5 +incdir+/home/feilong/.cxl.ip/incl -sv -work axi_firewall_v1_0_5 -f /home/feilong/Storages/fpga/000_vivado_sim_linux32/axi_firewall_v1_0_5/.cxl.systemverilog.axi_firewall_v1_0_5.axi_firewall_v1_0_5.lin64.cmf
