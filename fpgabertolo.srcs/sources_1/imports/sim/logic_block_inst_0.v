//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
//Date        : Fri Apr  8 14:45:25 2022
//Host        : DESKTOP-IRVT8TJ running 64-bit major release  (build 9200)
//Command     : generate_target logic_block_inst_0.bd
//Design      : logic_block_inst_0
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "logic_block_inst_0,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=logic_block_inst_0,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=36,numReposBlks=36,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=18,numPkgbdBlks=0,bdsource=C_/Users/Admin/Documents/Tesis/fpgabertolo/fpgabertolo.srcs/sources_1/bd/logic_block/logic_block.bd,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "logic_block_inst_0.hwdef" *) 
module logic_block_inst_0
   (clk,
    gpi1,
    gpo1,
    gpo2,
    int_mcs,
    muon_count,
    reset);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK, ASSOCIATED_RESET reset, CLK_DOMAIN /clk_wiz_0_clk_out1, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) input clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.GPI1 DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.GPI1, LAYERED_METADATA undef" *) output [31:0]gpi1;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.GPO1 DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.GPO1, LAYERED_METADATA undef" *) input [31:0]gpo1;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.GPO2 DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.GPO2, LAYERED_METADATA undef" *) input [31:0]gpo2;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.INT_MCS DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.INT_MCS, LAYERED_METADATA undef" *) output int_mcs;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.MUON_COUNT DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.MUON_COUNT, LAYERED_METADATA undef" *) input [2:0]muon_count;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RESET RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RESET, INSERT_VIP 0, POLARITY ACTIVE_HIGH" *) input reset;

  wire [0:0]Net;
  wire [0:0]Net2;
  wire clk_1;
  wire [31:0]counter_0_Q;
  wire [31:0]counter_0_Q1;
  wire [31:0]counter_2_Q;
  wire [31:0]counter_3_Q;
  wire [31:0]counter_4_Q;
  wire freq_divider_0_clk_out;
  wire [31:0]gpo1_1;
  wire [31:0]gpo2_1;
  wire [4:0]match_detector_0_matchs;
  wire [2:0]muon_count_1;
  wire [31:0]mux_0_Q;
  wire posedge_detect_0_det;
  wire posedge_detect_1_det;
  wire posedge_detect_2_det;
  wire posedge_detect_3_det;
  wire [31:0]reg32_0_Q;
  wire [31:0]reg32_1_Q;
  wire [31:0]reg32_2_Q;
  wire [31:0]reg32_3_Q;
  wire [31:0]reg32_4_Q;
  wire [31:0]reg32_5_Q;
  wire reset_1;
  wire [0:0]util_vector_logic_0_Res;
  wire [0:0]util_vector_logic_1_Res;
  wire [2:0]xlconcat_0_dout;
  wire [0:0]xlslice_0_Dout;
  wire [0:0]xlslice_10_Dout;
  wire [7:0]xlslice_11_Dout;
  wire [0:0]xlslice_12_Dout;
  wire [0:0]xlslice_1_Dout;
  wire [0:0]xlslice_2_Dout;
  wire [0:0]xlslice_2_Dout1;
  wire [0:0]xlslice_3_Dout;
  wire [0:0]xlslice_4_Dout;
  wire [0:0]xlslice_6_Dout;
  wire [0:0]xlslice_7_Dout;
  wire [0:0]xlslice_8_Dout;
  wire [0:0]xlslice_9_Dout;

  assign clk_1 = clk;
  assign gpi1[31:0] = mux_0_Q;
  assign gpo1_1 = gpo1[31:0];
  assign gpo2_1 = gpo2[31:0];
  assign int_mcs = posedge_detect_3_det;
  assign muon_count_1 = muon_count[2:0];
  assign reset_1 = reset;
  logic_block_inst_0_counter_0_0 counter_0
       (.Q(counter_0_Q),
        .clk(clk_1),
        .en(xlslice_2_Dout),
        .reset(Net));
  logic_block_inst_0_counter_1_0 counter_1
       (.Q(counter_0_Q1),
        .clk(clk_1),
        .en(xlslice_2_Dout1),
        .reset(Net));
  logic_block_inst_0_counter_2_0 counter_2
       (.Q(counter_2_Q),
        .clk(clk_1),
        .en(xlslice_6_Dout),
        .reset(Net));
  logic_block_inst_0_counter_3_0 counter_3
       (.Q(counter_3_Q),
        .clk(clk_1),
        .en(xlslice_7_Dout),
        .reset(Net));
  logic_block_inst_0_counter_4_0 counter_4
       (.Q(counter_4_Q),
        .clk(clk_1),
        .en(xlslice_8_Dout),
        .reset(Net));
  logic_block_inst_0_freq_divider_0_0 freq_divider_0
       (.clk(clk_1),
        .clk_out(freq_divider_0_clk_out),
        .div(reg32_5_Q),
        .reset(reset_1));
  logic_block_inst_0_match_detector_0_0 match_detector_0
       (.clk(clk_1),
        .matchs(match_detector_0_matchs),
        .up(xlconcat_0_dout));
  logic_block_inst_0_mux_0_0 mux_0
       (.Q(mux_0_Q),
        .data0(reg32_0_Q),
        .data1(reg32_1_Q),
        .data2(reg32_2_Q),
        .data3(reg32_3_Q),
        .data4(reg32_4_Q),
        .sel(xlslice_11_Dout));
  logic_block_inst_0_posedge_detect_0_0 posedge_detect_0
       (.clk(clk_1),
        .det(posedge_detect_0_det),
        .pulse(xlslice_0_Dout));
  logic_block_inst_0_posedge_detect_1_0 posedge_detect_1
       (.clk(clk_1),
        .det(posedge_detect_1_det),
        .pulse(xlslice_3_Dout));
  logic_block_inst_0_posedge_detect_2_0 posedge_detect_2
       (.clk(clk_1),
        .det(posedge_detect_2_det),
        .pulse(xlslice_4_Dout));
  logic_block_inst_0_posedge_detect_3_0 posedge_detect_3
       (.clk(clk_1),
        .det(posedge_detect_3_det),
        .pulse(freq_divider_0_clk_out));
  logic_block_inst_0_reg32_0_0 reg32_0
       (.D(counter_0_Q),
        .Q(reg32_0_Q),
        .clk(clk_1),
        .enable(Net),
        .reset(Net2));
  logic_block_inst_0_reg32_1_0 reg32_1
       (.D(counter_0_Q1),
        .Q(reg32_1_Q),
        .clk(clk_1),
        .enable(Net),
        .reset(Net2));
  logic_block_inst_0_reg32_2_0 reg32_2
       (.D(counter_2_Q),
        .Q(reg32_2_Q),
        .clk(clk_1),
        .enable(Net),
        .reset(Net2));
  logic_block_inst_0_reg32_3_0 reg32_3
       (.D(counter_3_Q),
        .Q(reg32_3_Q),
        .clk(clk_1),
        .enable(Net),
        .reset(Net2));
  logic_block_inst_0_reg32_4_0 reg32_4
       (.D(counter_4_Q),
        .Q(reg32_4_Q),
        .clk(clk_1),
        .enable(Net),
        .reset(Net2));
  logic_block_inst_0_reg32_5_0 reg32_5
       (.D(gpo2_1),
        .Q(reg32_5_Q),
        .clk(clk_1),
        .enable(xlslice_12_Dout),
        .reset(reset_1));
  logic_block_inst_0_util_vector_logic_0_0 util_vector_logic_0
       (.Op1(xlslice_1_Dout),
        .Op2(xlslice_9_Dout),
        .Res(util_vector_logic_0_Res));
  logic_block_inst_0_util_vector_logic_1_0 util_vector_logic_1
       (.Op1(util_vector_logic_0_Res),
        .Op2(xlslice_10_Dout),
        .Res(util_vector_logic_1_Res));
  logic_block_inst_0_util_vector_logic_2_0 util_vector_logic_2
       (.Op1(util_vector_logic_1_Res),
        .Op2(reset_1),
        .Res(Net2));
  logic_block_inst_0_util_vector_logic_3_0 util_vector_logic_3
       (.Op1(reset_1),
        .Op2(posedge_detect_3_det),
        .Res(Net));
  logic_block_inst_0_xlconcat_0_0 xlconcat_0
       (.In0(posedge_detect_2_det),
        .In1(posedge_detect_1_det),
        .In2(posedge_detect_0_det),
        .dout(xlconcat_0_dout));
  logic_block_inst_0_xlslice_0_0 xlslice_0
       (.Din(muon_count_1),
        .Dout(xlslice_0_Dout));
  logic_block_inst_0_xlslice_1_0 xlslice_1
       (.Din(gpo1_1),
        .Dout(xlslice_1_Dout));
  logic_block_inst_0_xlslice_10_0 xlslice_10
       (.Din(gpo1_1),
        .Dout(xlslice_10_Dout));
  logic_block_inst_0_xlslice_11_0 xlslice_11
       (.Din(gpo1_1),
        .Dout(xlslice_11_Dout));
  logic_block_inst_0_xlslice_12_0 xlslice_12
       (.Din(gpo1_1),
        .Dout(xlslice_12_Dout));
  logic_block_inst_0_xlslice_2_0 xlslice_2
       (.Din(match_detector_0_matchs),
        .Dout(xlslice_2_Dout));
  logic_block_inst_0_xlslice_3_0 xlslice_3
       (.Din(muon_count_1),
        .Dout(xlslice_3_Dout));
  logic_block_inst_0_xlslice_4_0 xlslice_4
       (.Din(muon_count_1),
        .Dout(xlslice_4_Dout));
  logic_block_inst_0_xlslice_5_0 xlslice_5
       (.Din(match_detector_0_matchs),
        .Dout(xlslice_2_Dout1));
  logic_block_inst_0_xlslice_6_0 xlslice_6
       (.Din(match_detector_0_matchs),
        .Dout(xlslice_6_Dout));
  logic_block_inst_0_xlslice_7_0 xlslice_7
       (.Din(match_detector_0_matchs),
        .Dout(xlslice_7_Dout));
  logic_block_inst_0_xlslice_8_0 xlslice_8
       (.Din(match_detector_0_matchs),
        .Dout(xlslice_8_Dout));
  logic_block_inst_0_xlslice_9_0 xlslice_9
       (.Din(gpo1_1),
        .Dout(xlslice_9_Dout));
endmodule
