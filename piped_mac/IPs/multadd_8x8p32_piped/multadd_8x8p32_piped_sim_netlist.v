// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
// Date        : Tue Oct  7 22:58:32 2025
// Host        : linuxvdi-f25-40.ece.iastate.edu running 64-bit unknown
// Command     : write_verilog -force -mode funcsim
//               /home/zfsalti/487/lab3/CprE-487-Lab-3/piped_mac/IPs/multadd_8x8p32_piped/multadd_8x8p32_piped_sim_netlist.v
// Design      : multadd_8x8p32_piped
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "multadd_8x8p32_piped,xbip_multadd_v3_0_15,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_multadd_v3_0_15,Vivado 2020.1" *) 
(* NotValidForBitStream *)
module multadd_8x8p32_piped
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
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF pcout_intf:p_intf:subtract_intf:pcin_intf:c_intf:b_intf:a_intf, ASSOCIATED_RESET SCLR, ASSOCIATED_CLKEN CE, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 ce_intf CE" *) (* x_interface_parameter = "XIL_INTERFACENAME ce_intf, POLARITY ACTIVE_HIGH" *) input CE;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 sclr_intf RST" *) (* x_interface_parameter = "XIL_INTERFACENAME sclr_intf, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *) input SCLR;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [7:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [7:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 c_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME c_intf, LAYERED_METADATA undef" *) input [47:0]C;
  (* x_interface_info = "xilinx.com:signal:data:1.0 pcin_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME pcin_intf, LAYERED_METADATA undef" *) input [47:0]PCIN;
  (* x_interface_info = "xilinx.com:signal:data:1.0 subtract_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME subtract_intf, LAYERED_METADATA undef" *) input SUBTRACT;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [31:0]P;
  (* x_interface_info = "xilinx.com:signal:data:1.0 pcout_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME pcout_intf, LAYERED_METADATA undef" *) output [47:0]PCOUT;

  wire [7:0]A;
  wire [7:0]B;
  wire [47:0]C;
  wire CE;
  wire CLK;
  wire [31:0]P;
  wire [47:0]PCIN;
  wire [47:0]PCOUT;
  wire SCLR;
  wire SUBTRACT;

  (* C_AB_LATENCY = "-1" *) 
  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "8" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_WIDTH = "8" *) 
  (* C_CE_OVERRIDES_SCLR = "1" *) 
  (* C_C_LATENCY = "0" *) 
  (* C_C_TYPE = "0" *) 
  (* C_C_WIDTH = "48" *) 
  (* C_OUT_HIGH = "31" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_USE_PCIN = "1" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* KEEP_HIERARCHY = "soft" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  multadd_8x8p32_piped_xbip_multadd_v3_0_15 U0
       (.A(A),
        .B(B),
        .C(C),
        .CE(CE),
        .CLK(CLK),
        .P(P),
        .PCIN(PCIN),
        .PCOUT(PCOUT),
        .SCLR(SCLR),
        .SUBTRACT(SUBTRACT));
endmodule

(* C_AB_LATENCY = "-1" *) (* C_A_TYPE = "0" *) (* C_A_WIDTH = "8" *) 
(* C_B_TYPE = "0" *) (* C_B_WIDTH = "8" *) (* C_CE_OVERRIDES_SCLR = "1" *) 
(* C_C_LATENCY = "0" *) (* C_C_TYPE = "0" *) (* C_C_WIDTH = "48" *) 
(* C_OUT_HIGH = "31" *) (* C_OUT_LOW = "0" *) (* C_TEST_CORE = "0" *) 
(* C_USE_PCIN = "1" *) (* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "zynq" *) 
(* ORIG_REF_NAME = "xbip_multadd_v3_0_15" *) (* downgradeipidentifiedwarnings = "yes" *) 
module multadd_8x8p32_piped_xbip_multadd_v3_0_15
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
  input [47:0]C;
  input [47:0]PCIN;
  input SUBTRACT;
  output [31:0]P;
  output [47:0]PCOUT;

  wire [7:0]A;
  wire [7:0]B;
  wire CE;
  wire CLK;
  wire [31:0]P;
  wire [47:0]PCIN;
  wire [47:0]PCOUT;
  wire SCLR;
  wire SUBTRACT;

  (* C_AB_LATENCY = "-1" *) 
  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "8" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_WIDTH = "8" *) 
  (* C_CE_OVERRIDES_SCLR = "1" *) 
  (* C_C_LATENCY = "0" *) 
  (* C_C_TYPE = "0" *) 
  (* C_C_WIDTH = "48" *) 
  (* C_OUT_HIGH = "31" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_USE_PCIN = "1" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* KEEP_HIERARCHY = "soft" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  multadd_8x8p32_piped_xbip_multadd_v3_0_15_viv i_synth
       (.A(A),
        .B(B),
        .C({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CE(CE),
        .CLK(CLK),
        .P(P),
        .PCIN(PCIN),
        .PCOUT(PCOUT),
        .SCLR(SCLR),
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
l4nf/P3Y8BKhiD1XI/ChEKh2dBfgBEdKHDZ7+TtNYiUkfX7R4uu08ZplCN6oeCuG1EsiDX6Mhwdr
aQZyxImX9QOPZuoYFlD+DvxGKNryAqppqZrgQSKPkNz7H+1odm+RT2Os/b0DWcyBd9sYE7zmFP17
6WeErrn8viNWAGKlz5xp0EokzKL2z/yS1CA+nQpSKQXLrx0OYHEwY3MOa+v6UlMAcU1tcza7s9v8
1M72lNki8I96tMBucxAfGRwFYhKHJiey38MIDuTdKppUEXg1v83mVtnbSINJgGrWk+5NRNKqcAas
kmJK9yBGbwzrfvcsnmNJ/kJHp8DoQrZPvYHIgA==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
ePHBbbnCK9syi/bHl0qg5fZdO8/9nPcnqKx0eZpxpmXIvZeRpL/0e0SQ4DwGHq3rM1GYCnmTfXdp
KXR46LGGlPUXtJ9wO3UTlpYPc3NohH6Ml2NmCoUwpY9Es1B8LmRJxxGlXmN+ddvMwRrhyV8AEaPd
q5BfbKPWm7d6h/RFyp70ofsigSxEXu6Gy0zrwuUGTfAUkCLZczB6lVodtbSRw2sSbA2GK/LttugL
Q9QqQqUpUKs/W/DkQ8kaXKoko1t6ni8kj5sUhYJ9JUohRGo9D5i27oyiahmcILSbdtaPIYrVbYxZ
ryxkQxT9QDDZpM7+DCthhjjaNyRtOtp/thE3wg==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 10096)
`pragma protect data_block
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
JNMNJyL6Kw==
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
