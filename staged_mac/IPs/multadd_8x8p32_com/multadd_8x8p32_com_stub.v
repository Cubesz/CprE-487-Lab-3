// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
// Date        : Tue Oct  7 21:14:10 2025
// Host        : linuxvdi-f25-40.ece.iastate.edu running 64-bit unknown
// Command     : write_verilog -force -mode synth_stub -rename_top multadd_8x8p32_com -prefix
//               multadd_8x8p32_com_ multadd_8x8p32_comb_stub.v
// Design      : multadd_8x8p32_comb
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "xbip_multadd_v3_0_15,Vivado 2020.1" *)
module multadd_8x8p32_com(A, B, C, SUBTRACT, P, PCOUT)
/* synthesis syn_black_box black_box_pad_pin="A[7:0],B[7:0],C[31:0],SUBTRACT,P[31:0],PCOUT[47:0]" */;
  input [7:0]A;
  input [7:0]B;
  input [31:0]C;
  input SUBTRACT;
  output [31:0]P;
  output [47:0]PCOUT;
endmodule
