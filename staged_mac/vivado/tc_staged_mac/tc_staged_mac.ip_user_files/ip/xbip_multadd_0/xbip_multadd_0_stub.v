// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
// Date        : Wed Oct 29 09:28:05 2025
// Host        : linuxvdi-f25-17.ece.iastate.edu running 64-bit unknown
// Command     : write_verilog -force -mode synth_stub
//               /home/osamman/487/CprE-487-Lab-3/staged_mac/vivado/tc_staged_mac/tc_staged_mac.srcs/sources_1/ip/xbip_multadd_0/xbip_multadd_0_stub.v
// Design      : xbip_multadd_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "xbip_multadd_v3_0_15,Vivado 2020.1" *)
module xbip_multadd_0(CLK, CE, SCLR, A, B, C, PCIN, SUBTRACT, P, PCOUT)
/* synthesis syn_black_box black_box_pad_pin="CLK,CE,SCLR,A[7:0],B[7:0],C[47:0],PCIN[47:0],SUBTRACT,P[31:0],PCOUT[47:0]" */;
  input CLK;
  input CE;
  input SCLR;
  input [7:0]A;
  input [7:0]B;
  input [47:0]C;
  input [47:0]PCIN;
  input SUBTRACT;
  output [31:0]P;
  output [47:0]PCOUT;
endmodule
