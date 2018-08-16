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


