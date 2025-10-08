// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
// Date        : Tue Oct  7 21:14:10 2025
// Host        : linuxvdi-f25-40.ece.iastate.edu running 64-bit unknown
// Command     : write_verilog -force -mode funcsim -rename_top multadd_8x8p32_com -prefix
//               multadd_8x8p32_com_ multadd_8x8p32_comb_sim_netlist.v
// Design      : multadd_8x8p32_comb
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "multadd_8x8p32_comb,xbip_multadd_v3_0_15,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_multadd_v3_0_15,Vivado 2020.1" *) 
(* NotValidForBitStream *)
module multadd_8x8p32_com
   (A,
    B,
    C,
    SUBTRACT,
    P,
    PCOUT);
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [7:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [7:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 c_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME c_intf, LAYERED_METADATA undef" *) input [31:0]C;
  (* x_interface_info = "xilinx.com:signal:data:1.0 subtract_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME subtract_intf, LAYERED_METADATA undef" *) input SUBTRACT;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [31:0]P;
  (* x_interface_info = "xilinx.com:signal:data:1.0 pcout_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME pcout_intf, LAYERED_METADATA undef" *) output [47:0]PCOUT;

  wire [7:0]A;
  wire [7:0]B;
  wire [31:0]C;
  wire [31:0]P;
  wire [47:0]PCOUT;
  wire SUBTRACT;

  (* C_AB_LATENCY = "0" *) 
  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "8" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_WIDTH = "8" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_C_LATENCY = "0" *) 
  (* C_C_TYPE = "0" *) 
  (* C_C_WIDTH = "32" *) 
  (* C_OUT_HIGH = "31" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_USE_PCIN = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* KEEP_HIERARCHY = "soft" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  multadd_8x8p32_com_xbip_multadd_v3_0_15 U0
       (.A(A),
        .B(B),
        .C(C),
        .CE(1'b0),
        .CLK(1'b0),
        .P(P),
        .PCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCOUT(PCOUT),
        .SCLR(1'b0),
        .SUBTRACT(SUBTRACT));
endmodule

(* C_AB_LATENCY = "0" *) (* C_A_TYPE = "0" *) (* C_A_WIDTH = "8" *) 
(* C_B_TYPE = "0" *) (* C_B_WIDTH = "8" *) (* C_CE_OVERRIDES_SCLR = "0" *) 
(* C_C_LATENCY = "0" *) (* C_C_TYPE = "0" *) (* C_C_WIDTH = "32" *) 
(* C_OUT_HIGH = "31" *) (* C_OUT_LOW = "0" *) (* C_TEST_CORE = "0" *) 
(* C_USE_PCIN = "0" *) (* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "zynq" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module multadd_8x8p32_com_xbip_multadd_v3_0_15
   (CLK,
    CE,
    SCLR,
    A,
    B,
    C,
    PCIN,
    SUBTRACT,
    P,
    PCOUT);
  input CLK;
  input CE;
  input SCLR;
  input [7:0]A;
  input [7:0]B;
  input [31:0]C;
  input [47:0]PCIN;
  input SUBTRACT;
  output [31:0]P;
  output [47:0]PCOUT;

  wire [7:0]A;
  wire [7:0]B;
  wire [31:0]C;
  wire [31:0]P;
  wire [47:0]PCOUT;
  wire SUBTRACT;

  (* C_AB_LATENCY = "0" *) 
  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "8" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_WIDTH = "8" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_C_LATENCY = "0" *) 
  (* C_C_TYPE = "0" *) 
  (* C_C_WIDTH = "32" *) 
  (* C_OUT_HIGH = "31" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_USE_PCIN = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* KEEP_HIERARCHY = "soft" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  multadd_8x8p32_com_xbip_multadd_v3_0_15_viv i_synth
       (.A(A),
        .B(B),
        .C(C),
        .CE(1'b0),
        .CLK(1'b0),
        .P(P),
        .PCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCOUT(PCOUT),
        .SCLR(1'b0),
        .SUBTRACT(SUBTRACT));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2020.1"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
oPPBmdjVxxQgYqTPHO0IY5hg5KMAb7EBJLCGgBUYq08ZIfUX8ndg1Eiqv2dFWIRo3mt/OQsTLY1S
ZPHug+wO0Q==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
O2N1mQ5zhVgmtFXaAPAwvL2k+ycbd56UvLowFGIBaAOuFgVryTcW6hBGXBBEB58r47F2cJUl+V8q
5v9YWBAXGFm9aknUEJ9zcXZ4EK1EA/Xir5blfta+j8IxsqdLQpqab63J0gxmbaWuaxJpIStQqP1Z
UWOQgzSjIOuaLpp76p8=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
jB0psSt7+yYPqTjcOfKqfOAZTSTbCNlMvEm4VRZHWBSrXg/D5x+6oQxJ1MwXCyNvW46g+Yfm+XHf
9jJJhsIkBuaYAfEngj9iV2PbYubWLfBOSPjs3QRn8FqFW1MpRAGv4oKgvT2aMG+xhmcZtQ82QBuC
GUVBztfbA0dd7AcqiPG5peJOZ5iMr1U10duOTfrQ8HUSuwInNflbZtqZNLGpTVHBlZhhO0jxCdDY
QOqm37/9z+sZElWCbTfdarzEPwccjoUl8e6y6aAcGCdRcmgusSci0/D431QlyEBCAAxGK3JvZUsF
Kf8WzBvr2W19eun24XFvpfhgC89d/VhubWD9ww==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
qwh+XXGxTUHeH6kldJdH/ZfvLKe0buzXRPKSUak+BQq54vBafi6lJqg1V89dBIPQ64RZRn3a3rfP
vwblASDB7ynllBzhkNR/JYkNLwtiLB1fx9ZrxFbLouaDHdLgonLMMk9paLYLIwjESipPNB1Tjj97
wLv5OFCvFygRFJWC7V8ql0Xn0fWEEL2H85xNLtC/Vx6zvcY06Tc4pOhBA14Yg1IX2ci7GBFaEBR9
UKM82IYIAVjwz3iJvEH/Fh7OLv7rRifYGVUfW1LuJ0OnkfzWNrYM4FMvVaECIsP8jLWraVLHygHM
Rjs4eFfc0edJpZvFaoZaDmoDBJOzj/8spqqnJg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
iQ4VmTylxQ1J2QyAZBzI4TSDIFkbArdLXWKz2YLqq6D2esS5w7IJDG77FiV7khPlE8o4RqFia3zt
GYntd1KVZWz9whLaXoFmIXMQ+C0HInJ6Ow9f2OkRx3Jo/y9KfvLGQhCytDaLe/G7KLItsx1emkO9
r230p0iDzCX0NcTRap0=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Jo1LukfQIZ4+tL1i3tj2SLJ5Cqfg6q6cJeJzw7zeVbbkSXANWzMqU362P0kfRQC3BGVOWZqYRmzt
ifxxiGgZz+mOCMKE5GSqji7V9P2o3LYOSdO34vFQNTcS0angvb90zmZCmUeHtmgAYHyjsHhKE6uE
4TMqy4wjwc1P2phyK3+Dn5zywq61/02+3eHpeYL3aRAD7qFg2AbcLUznHcGd9BSMiEZE6z0ZyB6f
2RgDLBp2oPqo7vJC/maqM0R5/7GCoiGIoBFq60cKtD7kAUeeyuRGPZuR4o/5/dIRswF0ovMHb1gY
PhuJJQbP+26afzCpMTaZtHwB9wiic+zyKlA+KQ==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
NxUc//wt4b27/ZO3BT+IO7PjgX2k0SdQl3fxsCqQfrEJyp5zqNZTLNox5mxgtWiAtYlLryJstwEv
V5khBk4tQA9ybob6ETgBp3es9fmkcoJ0kFo7kAbiGupx94zUU06hNpW3yh+nT7HnEEUivdALUanI
N8oiclpWdq67XI1baxM1nc2hvgfbF7oD6uo8/S2RP+r7wYuH+LGIsDpEinNSefF8q4pxiTuQ1JWI
Hnkq0gP49gNBxQAE8HAUL3HdFqmLyvqM1+h2YveplFRw/YWVj9rRoWjogoypIsR28DBIgG0kZSv2
0LaFz1+uxGCUqeUHl2O8MiM4bnFB0Eu53WUeCg==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2019_11", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
T247l9ZTWcyAfNCDFW6sINHv9gSjVxvdQgjd3+yL66BsCz+N8y+fBh8/bJq+a3LvMUEZislY+RAz
m6IsvWzXAJZ+nJR1T33Ze1V/0A/hg4SjgiCI4FxB1scShneaAdiEp/17LmoN5LFdjo/OfpqG8CsG
Jx/8KePeXWJxRYZETm/DfttXqTX5n5SA7cKpB8ytqTiP5CLO4ahI71k24YFbUK4U0GhVB7QJ57IL
xhTg5fdqqfZRp53EQ/9ytrea0iwurfDDiE5v7YzXY4yCUo3P4qS4rEkFC/MallqMX+z4E4lCgL1w
GBcooqZKVw0PNLyHcjrxBhjse0+BHOEByIQOHg==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
qoIFn8X5jnle3ONbIM699hZ2OBgRp5157ijj0xig7Li8V5roRXokRqYy/Ov5omTosQi8NWzwI2sL
+nGmt4ethMuzhVJgMKoik+tUMO1dc5UgT4Jm2JYXNyWXZS5r8OaNijEUK+OZpLKB5cedP8Tk3BuL
u1adICr8cQk4ndopmzmyDg/Ro9PekMV8QlkHXD3ouu4eQPraoUz2q38AznNUCMq3IHdgL/4Ba9mm
IKEE8k58KfSus/tB60qoN920bxYvqe2EpSheFs69Pq8PA/4NTDcvffptGVpuIyO9Wz/QYDbRoMMn
Q1mAFHt9t6szp1TyfqEzH7a9ok7IjQbSCXnMRg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
NUEcI56Dfo4OaDExnqCDr6eFWNrcmWbJ0ixHvOnKC3Lbjb1G08wW/tC7B9scJRM5iWQVE/HDmGkZ
2Pwc/JpHA3CnsgfcKHNJwya0RAopPL3ycZ8BVf4wC5xgcYir4zXKW86M6KeUEg2ytItZVfm5sExm
el5iA+xbcHm90rvX2hNu3MKDoPoxi+E4LqQDsWGREbm519PZhBZ8G23gTtryUhSBRSRQM/M95Nd8
joI3rmuTVDTWKftjcpKFwqoJxFn8LKRbKyI1aQwnJUofrDK1MuAZXQsHuQTIiQfUN1Bnxg7ocFkv
9jsqBDFluu1LhEw5EbMCYuyKD/HwGqQPBf/aKg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Wog0Ivqmr7GyPfFd5EagA28pLtAhvSdBzfSA29P7yoZNPWxTOYJkTrcNcX4af1g2xW8VGsMZnEeZ
MI6LMPyTsSPPNQWNKQh6FCEClo49F+gXdX/Ju4Zkho+FCp9Bm/ChhIqh2nsCeMw/z+9Yy7/vTpMI
gvS43O3XyXQiP/IorGtA9TNeU3cSs3odiz/Se7iCe/Xw4MV5IECuVdDeARTP4Zhycs9zMVUEa3xH
oH6nNQx3tvRR2asdTGub/fhDv0z3/2/pXIxCz0xMWD3z0GrinJHha2/T3Ff8MBzIeaFttEvoBb6T
DS/8tJh6UZUcbf36G0KUKOLZ4ngj782w99yDag==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 9136)
`pragma protect data_block
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
lp1zW9YYgXYX8UfFhRhCdw==
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
