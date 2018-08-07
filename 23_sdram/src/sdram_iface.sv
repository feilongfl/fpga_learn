interface SDRAM (
);
wire [15:0] DRAM_DQ;
logic [12:0] DRAM_ADDR;
logic [1:0] DRAM_BA;
logic DRAM_CLK;
logic DRAM_CKE;
logic DRAM_LDQM;
logic DRAM_UDQM;
logic DRAM_WE_N;
logic DRAM_CAS_N;
logic DRAM_RAS_N;
logic DRAM_CS_N;

modport sdram(
            inout DRAM_DQ,
            output DRAM_ADDR,
            output DRAM_BA,
            output DRAM_CLK,
            output DRAM_CKE,
            output DRAM_LDQM,
            output DRAM_UDQM,
            output DRAM_WE_N,
            output DRAM_CAS_N,
            output DRAM_RAS_N,
            output DRAM_CS_N
        );

modport tb(
            inout DRAM_DQ,
            input DRAM_ADDR,
            input DRAM_BA,
            input DRAM_CLK,
            input DRAM_CKE,
            input DRAM_LDQM,
            input DRAM_UDQM,
            input DRAM_WE_N,
            input DRAM_CAS_N,
            input DRAM_RAS_N,
            input DRAM_CS_N
        );

endinterface
// interface SDRAM(
//             inout[15:0] DRAM_DQ,
//             output[11:0] DRAM_ADDR,
//             output[1:0] DRAM_BA,
//             output DRAM_CLK,
//             output DRAM_CKE,
//             output DRAM_LDQM,
//             output DRAM_UDQM,
//             output DRAM_WE_N,
//             output DRAM_CAS_N,
//             output DRAM_RAS_N,
//             output DRAM_CS_N
//         );
//
// modport sdram(
//             inout DRAM_DQ,
//             output DRAM_ADDR,
//             output DRAM_BA,
//             output DRAM_CLK,
//             output DRAM_CKE,
//             output DRAM_LDQM,
//             output DRAM_UDQM,
//             output DRAM_WE_N,
//             output DRAM_CAS_N,
//             output DRAM_RAS_N,
//             output DRAM_CS_N
//         );
// endinterface
