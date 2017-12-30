// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.1 (lin64) Build 1846317 Fri Apr 14 18:54:47 MDT 2017
// Date        : Sat Dec 30 00:54:27 2017
// Host        : nuc6i7 running 64-bit Ubuntu 16.04.3 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/zhang/pynq-hdmi-in-out/pynq-hdmi-in-out.srcs/sources_1/bd/ps_blk/ip/ps_blk_processing_system7_0_0/ps_blk_processing_system7_0_0_stub.v
// Design      : ps_blk_processing_system7_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "processing_system7_v5_5_processing_system7,Vivado 2017.1" *)
module ps_blk_processing_system7_0_0(FCLK_CLK0, FCLK_RESET0_N, MIO, PS_SRSTB, PS_CLK, 
  PS_PORB)
/* synthesis syn_black_box black_box_pad_pin="FCLK_CLK0,FCLK_RESET0_N,MIO[53:0],PS_SRSTB,PS_CLK,PS_PORB" */;
  output FCLK_CLK0;
  output FCLK_RESET0_N;
  inout [53:0]MIO;
  inout PS_SRSTB;
  inout PS_CLK;
  inout PS_PORB;
endmodule
