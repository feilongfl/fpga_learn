module ddr_app (
           output reg [27:0]       app_addr,
           output [2:0]       app_cmd,
           output             app_en,
           output [255:0]        app_wdf_data,
           output             app_wdf_end,
           output [31:0]        app_wdf_mask,
           output             app_wdf_wren,
           input [255:0]       app_rd_data,
           input            app_rd_data_end,
           input            app_rd_data_valid,
           input            app_rdy,
           input            app_wdf_rdy,
           output         app_sr_req,
           output         app_ref_req,
           output         app_zq_req,
           input            app_sr_active,
           input            app_ref_ack,
           input            app_zq_ack,
           input            ui_clk,
           input            ui_clk_sync_rst,
           input            init_calib_complete
       );



endmodule // ddr_app
