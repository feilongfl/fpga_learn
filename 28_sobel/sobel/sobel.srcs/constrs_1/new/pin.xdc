set_property PACKAGE_PIN L19 [get_ports clk_50m]

set_property IOSTANDARD LVCMOS33 [get_ports clk_50m]
set_property IOSTANDARD TMDS_33 [get_ports HDMI_CLK_P]
set_property PACKAGE_PIN K18 [get_ports HDMI_CLK_P]
set_property IOSTANDARD TMDS_33 [get_ports HDMI_D0_P]
set_property PACKAGE_PIN M18 [get_ports HDMI_D0_P]
set_property IOSTANDARD TMDS_33 [get_ports HDMI_D1_P]
set_property PACKAGE_PIN N20 [get_ports HDMI_D1_P]
set_property IOSTANDARD TMDS_33 [get_ports HDMI_D2_P]
set_property PACKAGE_PIN N22 [get_ports HDMI_D2_P]

create_interface hdmi
set_property INTERFACE hdmi [get_ports { HDMI_CLK_P HDMI_CLK_N HDMI_D0_P HDMI_D0_N HDMI_D1_P HDMI_D1_N HDMI_D2_P HDMI_D2_N }]

create_interface ddr3
set_property INTERFACE ddr3 [get_ports { ddr3_addr[13] ddr3_addr[12] ddr3_addr[11] ddr3_addr[10] ddr3_addr[9] ddr3_addr[8] ddr3_addr[7] ddr3_addr[6] ddr3_addr[5] ddr3_addr[4] ddr3_addr[3] ddr3_addr[2] ddr3_addr[1] ddr3_addr[0] ddr3_ba[2] ddr3_ba[1] ddr3_ba[0] ddr3_ck_p[0] ddr3_ck_n[0] ddr3_cke[0] ddr3_dm[3] ddr3_dm[2] ddr3_dm[1] ddr3_dm[0] ddr3_dq[31] ddr3_dq[30] ddr3_dq[29] ddr3_dq[28] ddr3_dq[27] ddr3_dq[26] ddr3_dq[25] ddr3_dq[24] ddr3_dq[23] ddr3_dq[22] ddr3_dq[21] ddr3_dq[20] ddr3_dq[19] ddr3_dq[18] ddr3_dq[17] ddr3_dq[16] ddr3_dq[15] ddr3_dq[14] ddr3_dq[13] ddr3_dq[12] ddr3_dq[11] ddr3_dq[10] ddr3_dq[9] ddr3_dq[8] ddr3_dq[7] ddr3_dq[6] ddr3_dq[5] ddr3_dq[4] ddr3_dq[3] ddr3_dq[2] ddr3_dq[1] ddr3_dq[0] ddr3_dqs_p[3] ddr3_dqs_p[2] ddr3_dqs_p[1] ddr3_dqs_p[0] ddr3_dqs_n[3] ddr3_dqs_n[2] ddr3_dqs_n[1] ddr3_dqs_n[0] ddr3_odt[0] ddr3_cas_n ddr3_ras_n ddr3_reset_n ddr3_we_n }]
