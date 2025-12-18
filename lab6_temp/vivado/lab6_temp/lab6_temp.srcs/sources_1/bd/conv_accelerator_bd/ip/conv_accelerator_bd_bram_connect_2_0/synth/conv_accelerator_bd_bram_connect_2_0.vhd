-- (c) Copyright 1995-2025 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: xilinx.com:module_ref:bram_connect:1.0
-- IP Revision: 1

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY conv_accelerator_bd_bram_connect_2_0 IS
  PORT (
    M_BRAM0_addr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    M_BRAM0_clk : OUT STD_LOGIC;
    M_BRAM0_din : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    M_BRAM0_dout : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    M_BRAM0_en : OUT STD_LOGIC;
    M_BRAM0_we : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    M_BRAM0_rst : OUT STD_LOGIC;
    M_BRAM1_addr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    M_BRAM1_clk : OUT STD_LOGIC;
    M_BRAM1_din : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    M_BRAM1_dout : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    M_BRAM1_en : OUT STD_LOGIC;
    M_BRAM1_we : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    M_BRAM1_rst : OUT STD_LOGIC;
    S_BRAM_addr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    S_BRAM_clk : IN STD_LOGIC;
    S_BRAM_din : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    S_BRAM_dout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    S_BRAM_en : IN STD_LOGIC;
    S_BRAM_we : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    S_BRAM_rst : IN STD_LOGIC
  );
END conv_accelerator_bd_bram_connect_2_0;

ARCHITECTURE conv_accelerator_bd_bram_connect_2_0_arch OF conv_accelerator_bd_bram_connect_2_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF conv_accelerator_bd_bram_connect_2_0_arch: ARCHITECTURE IS "yes";
  COMPONENT bram_connect IS
    GENERIC (
      M_ADDR_WIDTH : INTEGER;
      ADDR_WIDTH : INTEGER;
      DATA_WIDTH : INTEGER
    );
    PORT (
      M_BRAM0_addr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      M_BRAM0_clk : OUT STD_LOGIC;
      M_BRAM0_din : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      M_BRAM0_dout : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      M_BRAM0_en : OUT STD_LOGIC;
      M_BRAM0_we : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      M_BRAM0_rst : OUT STD_LOGIC;
      M_BRAM1_addr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      M_BRAM1_clk : OUT STD_LOGIC;
      M_BRAM1_din : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      M_BRAM1_dout : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      M_BRAM1_en : OUT STD_LOGIC;
      M_BRAM1_we : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      M_BRAM1_rst : OUT STD_LOGIC;
      S_BRAM_addr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      S_BRAM_clk : IN STD_LOGIC;
      S_BRAM_din : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      S_BRAM_dout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      S_BRAM_en : IN STD_LOGIC;
      S_BRAM_we : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      S_BRAM_rst : IN STD_LOGIC
    );
  END COMPONENT bram_connect;
  ATTRIBUTE X_CORE_INFO : STRING;
  ATTRIBUTE X_CORE_INFO OF conv_accelerator_bd_bram_connect_2_0_arch: ARCHITECTURE IS "bram_connect,Vivado 2020.1";
  ATTRIBUTE CHECK_LICENSE_TYPE : STRING;
  ATTRIBUTE CHECK_LICENSE_TYPE OF conv_accelerator_bd_bram_connect_2_0_arch : ARCHITECTURE IS "conv_accelerator_bd_bram_connect_2_0,bram_connect,{}";
  ATTRIBUTE CORE_GENERATION_INFO : STRING;
  ATTRIBUTE CORE_GENERATION_INFO OF conv_accelerator_bd_bram_connect_2_0_arch: ARCHITECTURE IS "conv_accelerator_bd_bram_connect_2_0,bram_connect,{x_ipProduct=Vivado 2020.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=bram_connect,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VHDL,x_ipSimLanguage=MIXED,M_ADDR_WIDTH=17,ADDR_WIDTH=32,DATA_WIDTH=32}";
  ATTRIBUTE IP_DEFINITION_SOURCE : STRING;
  ATTRIBUTE IP_DEFINITION_SOURCE OF conv_accelerator_bd_bram_connect_2_0_arch: ARCHITECTURE IS "module_ref";
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER : STRING;
  ATTRIBUTE X_INTERFACE_INFO OF S_BRAM_rst: SIGNAL IS "xilinx.com:interface:bram:1.0 S_BRAM RST";
  ATTRIBUTE X_INTERFACE_INFO OF S_BRAM_we: SIGNAL IS "xilinx.com:interface:bram:1.0 S_BRAM WE";
  ATTRIBUTE X_INTERFACE_INFO OF S_BRAM_en: SIGNAL IS "xilinx.com:interface:bram:1.0 S_BRAM EN";
  ATTRIBUTE X_INTERFACE_INFO OF S_BRAM_dout: SIGNAL IS "xilinx.com:interface:bram:1.0 S_BRAM DOUT";
  ATTRIBUTE X_INTERFACE_INFO OF S_BRAM_din: SIGNAL IS "xilinx.com:interface:bram:1.0 S_BRAM DIN";
  ATTRIBUTE X_INTERFACE_INFO OF S_BRAM_clk: SIGNAL IS "xilinx.com:interface:bram:1.0 S_BRAM CLK";
  ATTRIBUTE X_INTERFACE_PARAMETER OF S_BRAM_addr: SIGNAL IS "XIL_INTERFACENAME S_BRAM, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1";
  ATTRIBUTE X_INTERFACE_INFO OF S_BRAM_addr: SIGNAL IS "xilinx.com:interface:bram:1.0 S_BRAM ADDR";
  ATTRIBUTE X_INTERFACE_INFO OF M_BRAM1_rst: SIGNAL IS "xilinx.com:interface:bram:1.0 M_BRAM1 RST";
  ATTRIBUTE X_INTERFACE_INFO OF M_BRAM1_we: SIGNAL IS "xilinx.com:interface:bram:1.0 M_BRAM1 WE";
  ATTRIBUTE X_INTERFACE_INFO OF M_BRAM1_en: SIGNAL IS "xilinx.com:interface:bram:1.0 M_BRAM1 EN";
  ATTRIBUTE X_INTERFACE_INFO OF M_BRAM1_dout: SIGNAL IS "xilinx.com:interface:bram:1.0 M_BRAM1 DOUT";
  ATTRIBUTE X_INTERFACE_INFO OF M_BRAM1_din: SIGNAL IS "xilinx.com:interface:bram:1.0 M_BRAM1 DIN";
  ATTRIBUTE X_INTERFACE_INFO OF M_BRAM1_clk: SIGNAL IS "xilinx.com:interface:bram:1.0 M_BRAM1 CLK";
  ATTRIBUTE X_INTERFACE_PARAMETER OF M_BRAM1_addr: SIGNAL IS "XIL_INTERFACENAME M_BRAM1, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1";
  ATTRIBUTE X_INTERFACE_INFO OF M_BRAM1_addr: SIGNAL IS "xilinx.com:interface:bram:1.0 M_BRAM1 ADDR";
  ATTRIBUTE X_INTERFACE_INFO OF M_BRAM0_rst: SIGNAL IS "xilinx.com:interface:bram:1.0 M_BRAM0 RST";
  ATTRIBUTE X_INTERFACE_INFO OF M_BRAM0_we: SIGNAL IS "xilinx.com:interface:bram:1.0 M_BRAM0 WE";
  ATTRIBUTE X_INTERFACE_INFO OF M_BRAM0_en: SIGNAL IS "xilinx.com:interface:bram:1.0 M_BRAM0 EN";
  ATTRIBUTE X_INTERFACE_INFO OF M_BRAM0_dout: SIGNAL IS "xilinx.com:interface:bram:1.0 M_BRAM0 DOUT";
  ATTRIBUTE X_INTERFACE_INFO OF M_BRAM0_din: SIGNAL IS "xilinx.com:interface:bram:1.0 M_BRAM0 DIN";
  ATTRIBUTE X_INTERFACE_INFO OF M_BRAM0_clk: SIGNAL IS "xilinx.com:interface:bram:1.0 M_BRAM0 CLK";
  ATTRIBUTE X_INTERFACE_PARAMETER OF M_BRAM0_addr: SIGNAL IS "XIL_INTERFACENAME M_BRAM0, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1";
  ATTRIBUTE X_INTERFACE_INFO OF M_BRAM0_addr: SIGNAL IS "xilinx.com:interface:bram:1.0 M_BRAM0 ADDR";
BEGIN
  U0 : bram_connect
    GENERIC MAP (
      M_ADDR_WIDTH => 17,
      ADDR_WIDTH => 32,
      DATA_WIDTH => 32
    )
    PORT MAP (
      M_BRAM0_addr => M_BRAM0_addr,
      M_BRAM0_clk => M_BRAM0_clk,
      M_BRAM0_din => M_BRAM0_din,
      M_BRAM0_dout => M_BRAM0_dout,
      M_BRAM0_en => M_BRAM0_en,
      M_BRAM0_we => M_BRAM0_we,
      M_BRAM0_rst => M_BRAM0_rst,
      M_BRAM1_addr => M_BRAM1_addr,
      M_BRAM1_clk => M_BRAM1_clk,
      M_BRAM1_din => M_BRAM1_din,
      M_BRAM1_dout => M_BRAM1_dout,
      M_BRAM1_en => M_BRAM1_en,
      M_BRAM1_we => M_BRAM1_we,
      M_BRAM1_rst => M_BRAM1_rst,
      S_BRAM_addr => S_BRAM_addr,
      S_BRAM_clk => S_BRAM_clk,
      S_BRAM_din => S_BRAM_din,
      S_BRAM_dout => S_BRAM_dout,
      S_BRAM_en => S_BRAM_en,
      S_BRAM_we => S_BRAM_we,
      S_BRAM_rst => S_BRAM_rst
    );
END conv_accelerator_bd_bram_connect_2_0_arch;
