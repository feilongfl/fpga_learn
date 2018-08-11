vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 -incr \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/clocking/mig_7series_v4_1_clk_ibuf.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/clocking/mig_7series_v4_1_infrastructure.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/clocking/mig_7series_v4_1_iodelay_ctrl.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/clocking/mig_7series_v4_1_tempmon.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/controller/mig_7series_v4_1_arb_mux.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/controller/mig_7series_v4_1_arb_row_col.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/controller/mig_7series_v4_1_arb_select.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/controller/mig_7series_v4_1_bank_cntrl.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/controller/mig_7series_v4_1_bank_common.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/controller/mig_7series_v4_1_bank_compare.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/controller/mig_7series_v4_1_bank_mach.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/controller/mig_7series_v4_1_bank_queue.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/controller/mig_7series_v4_1_bank_state.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/controller/mig_7series_v4_1_col_mach.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/controller/mig_7series_v4_1_mc.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/controller/mig_7series_v4_1_rank_cntrl.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/controller/mig_7series_v4_1_rank_common.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/controller/mig_7series_v4_1_rank_mach.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/controller/mig_7series_v4_1_round_robin_arb.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/ecc/mig_7series_v4_1_ecc_buf.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/ecc/mig_7series_v4_1_ecc_dec_fix.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/ecc/mig_7series_v4_1_ecc_gen.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/ecc/mig_7series_v4_1_ecc_merge_enc.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/ecc/mig_7series_v4_1_fi_xor.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/ip_top/mig_7series_v4_1_memc_ui_top_std.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/ip_top/mig_7series_v4_1_mem_intfc.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_byte_group_io.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_byte_lane.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_calib_top.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_if_post_fifo.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_mc_phy.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_mc_phy_wrapper.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_of_pre_fifo.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_4lanes.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_ck_addr_cmd_delay.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_dqs_found_cal.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_dqs_found_cal_hr.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_init.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_ocd_cntlr.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_ocd_data.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_ocd_edge.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_ocd_lim.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_ocd_mux.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_ocd_po_cntlr.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_ocd_samp.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_oclkdelay_cal.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_prbs_rdlvl.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_rdlvl.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_tempmon.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_top.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_wrcal.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_wrlvl.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_wrlvl_off_delay.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_prbs_gen.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_skip_calib_tap.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/phy/mig_7series_v4_1_poc_cc.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/phy/mig_7series_v4_1_poc_edge_store.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/phy/mig_7series_v4_1_poc_meta.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/phy/mig_7series_v4_1_poc_pd.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/phy/mig_7series_v4_1_poc_tap_base.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/phy/mig_7series_v4_1_poc_top.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/ui/mig_7series_v4_1_ui_cmd.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/ui/mig_7series_v4_1_ui_rd_data.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/ui/mig_7series_v4_1_ui_top.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/ui/mig_7series_v4_1_ui_wr_data.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/ddr_mig_mig_sim.v" \
"../../../../ddr3.srcs/sources_1/ip/ddr_mig/ddr_mig/user_design/rtl/ddr_mig.v" \


vlog -work xil_defaultlib \
"glbl.v"
