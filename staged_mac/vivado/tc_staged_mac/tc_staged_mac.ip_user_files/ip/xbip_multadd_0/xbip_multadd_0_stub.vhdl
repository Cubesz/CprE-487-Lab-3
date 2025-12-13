-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
-- Date        : Wed Oct 29 09:28:05 2025
-- Host        : linuxvdi-f25-17.ece.iastate.edu running 64-bit unknown
-- Command     : write_vhdl -force -mode synth_stub
--               /home/osamman/487/CprE-487-Lab-3/staged_mac/vivado/tc_staged_mac/tc_staged_mac.srcs/sources_1/ip/xbip_multadd_0/xbip_multadd_0_stub.vhdl
-- Design      : xbip_multadd_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xbip_multadd_0 is
  Port ( 
    CLK : in STD_LOGIC;
    CE : in STD_LOGIC;
    SCLR : in STD_LOGIC;
    A : in STD_LOGIC_VECTOR ( 7 downto 0 );
    B : in STD_LOGIC_VECTOR ( 7 downto 0 );
    C : in STD_LOGIC_VECTOR ( 47 downto 0 );
    PCIN : in STD_LOGIC_VECTOR ( 47 downto 0 );
    SUBTRACT : in STD_LOGIC;
    P : out STD_LOGIC_VECTOR ( 31 downto 0 );
    PCOUT : out STD_LOGIC_VECTOR ( 47 downto 0 )
  );

end xbip_multadd_0;

architecture stub of xbip_multadd_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "CLK,CE,SCLR,A[7:0],B[7:0],C[47:0],PCIN[47:0],SUBTRACT,P[31:0],PCOUT[47:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "xbip_multadd_v3_0_15,Vivado 2020.1";
begin
end;
