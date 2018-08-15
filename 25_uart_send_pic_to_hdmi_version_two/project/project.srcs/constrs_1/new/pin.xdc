set_property PACKAGE_PIN L19 [get_ports sys_clk_i]
set_property IOSTANDARD LVCMOS33 [get_ports sys_clk_i]
set_property PACKAGE_PIN J16 [get_ports init_calib_complete]
set_property IOSTANDARD LVCMOS33 [get_ports init_calib_complete]
set_property PACKAGE_PIN M16 [get_ports sys_rst]
set_property IOSTANDARD LVCMOS33 [get_ports sys_rst]
set_property PACKAGE_PIN K16 [get_ports tg_compare_error]
set_property IOSTANDARD LVCMOS33 [get_ports tg_compare_error]
set_property PACKAGE_PIN AA10 [get_ports uart_rx]
set_property IOSTANDARD LVCMOS33 [get_ports uart_rx]
set_property PACKAGE_PIN AB10 [get_ports uart_tx]
set_property IOSTANDARD LVCMOS33 [get_ports uart_tx]


set_operating_conditions -ambient_temp 45.0
set_operating_conditions -board_layers 4to7
set_operating_conditions -heatsink low

set_property MARK_DEBUG true [get_nets init_calib_complete_OBUF]


set_property PACKAGE_PIN M17 [get_ports sclk_50m]
set_property IOSTANDARD LVCMOS33 [get_ports sclk_50m]

create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 32768 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list instance_name/inst/clkfbout_buf_clk_wiz_0]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 1 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list init_calib_complete_OBUF]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets u_ila_0_clkfbout_buf_clk_wiz_0]
