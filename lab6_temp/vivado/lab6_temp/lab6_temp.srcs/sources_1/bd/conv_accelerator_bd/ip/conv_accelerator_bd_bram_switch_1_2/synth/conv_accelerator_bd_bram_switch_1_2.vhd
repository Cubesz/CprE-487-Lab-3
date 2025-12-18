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

-- IP VLNV: xilinx.com:module_ref:bram_switch:1.0
-- IP Revision: 1

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY conv_accelerator_bd_bram_switch_1_2 IS
  PORT (
    BRAM_PORT0_addr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    BRAM_PORT0_clk : IN STD_LOGIC;
    BRAM_PORT0_din : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    BRAM_PORT0_dout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    BRAM_PORT0_en : IN STD_LOGIC;
    BRAM_PORT0_we : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    BRAM_PORT0_rst : IN STD_LOGIC;
    BRAM_PORT1_addr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    BRAM_PORT1_clk : IN STD_LOGIC;
    BRAM_PORT1_din : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    BRAM_PORT1_dout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    BRAM_PORT1_en : IN STD_LOGIC;
    BRAM_PORT1_we : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    BRAM_PORT1_rst : IN STD_LOGIC;
    BLK_MEM_PORT0_addr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    BLK_MEM_PORT0_clk : OUT STD_LOGIC;
    BLK_MEM_PORT0_din : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    BLK_MEM_PORT0_dout : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    BLK_MEM_PORT0_en : OUT STD_LOGIC;
    BLK_MEM_PORT0_we : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    BLK_MEM_PORT0_rst : OUT STD_LOGIC;
    BLK_MEM_PORT1_addr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    BLK_MEM_PORT1_clk : OUT STD_LOGIC;
    BLK_MEM_PORT1_din : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    BLK_MEM_PORT1_dout : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    BLK_MEM_PORT1_en : OUT STD_LOGIC;
    BLK_MEM_PORT1_we : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    BLK_MEM_PORT1_rst : OUT STD_LOGIC;
    invert_banks : IN STD_LOGIC
  );
END conv_accelerator_bd_bram_switch_1_2;

ARCHITECTURE conv_accelerator_bd_bram_switch_1_2_arch OF conv_accelerator_bd_bram_switch_1_2 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF conv_accelerator_bd_bram_switch_1_2_arch: ARCHITECTURE IS "yes";
  COMPONENT bram_switch IS
    GENERIC (
      ADDR_WIDTH : INTEGER;
      DATA_WIDTH : INTEGER
    );
    PORT (
      BRAM_PORT0_addr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      BRAM_PORT0_clk : IN STD_LOGIC;
      BRAM_PORT0_din : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      BRAM_PORT0_dout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      BRAM_PORT0_en : IN STD_LOGIC;
      BRAM_PORT0_we : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      BRAM_PORT0_rst : IN STD_LOGIC;
      BRAM_PORT1_addr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      BRAM_PORT1_clk : IN STD_LOGIC;
      BRAM_PORT1_din : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      BRAM_PORT1_dout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      BRAM_PORT1_en : IN STD_LOGIC;
      BRAM_PORT1_we : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      BRAM_PORT1_rst : IN STD_LOGIC;
      BLK_MEM_PORT0_addr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      BLK_MEM_PORT0_clk : OUT STD_LOGIC;
      BLK_MEM_PORT0_din : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      BLK_MEM_PORT0_dout : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      BLK_MEM_PORT0_en : OUT STD_LOGIC;
      BLK_MEM_PORT0_we : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      BLK_MEM_PORT0_rst : OUT STD_LOGIC;
      BLK_MEM_PORT1_addr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      BLK_MEM_PORT1_clk : OUT STD_LOGIC;
      BLK_MEM_PORT1_din : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      BLK_MEM_PORT1_dout : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      BLK_MEM_PORT1_en : OUT STD_LOGIC;
      BLK_MEM_PORT1_we : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      BLK_MEM_PORT1_rst : OUT STD_LOGIC;
      invert_banks : IN STD_LOGIC
    );
  END COMPONENT bram_switch;
  ATTRIBUTE X_CORE_INFO : STRING;
  ATTRIBUTE X_CORE_INFO OF conv_accelerator_bd_bram_switch_1_2_arch: ARCHITECTURE IS "bram_switch,Vivado 2020.1";
  ATTRIBUTE CHECK_LICENSE_TYPE : STRING;
  ATTRIBUTE CHECK_LICENSE_TYPE OF conv_accelerator_bd_bram_switch_1_2_arch : ARCHITECTURE IS "conv_accelerator_bd_bram_switch_1_2,bram_switch,{}";
  ATTRIBUTE CORE_GENERATION_INFO : STRING;
  ATTRIBUTE CORE_GENERATION_INFO OF conv_accelerator_bd_bram_switch_1_2_arch: ARCHITECTURE IS "conv_accelerator_bd_bram_switch_1_2,bram_switch,{x_ipProduct=Vivado 2020.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=bram_switch,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VHDL,x_ipSimLanguage=MIXED,ADDR_WIDTH=32,DATA_WIDTH=32}";
  ATTRIBUTE IP_DEFINITION_SOURCE : STRING;
  ATTRIBUTE IP_DEFINITION_SOURCE OF conv_accelerator_bd_bram_switch_1_2_arch: ARCHITECTURE IS "module_ref";
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER : STRING;
  ATTRIBUTE X_INTERFACE_INFO OF BLK_MEM_PORT1_rst: SIGNAL IS "xilinx.com:interface:bram:1.0 BLK_MEM_PORT1 RST";
  ATTRIBUTE X_INTERFACE_INFO OF BLK_MEM_PORT1_we: SIGNAL IS "xilinx.com:interface:bram:1.0 BLK_MEM_PORT1 WE";
  ATTRIBUTE X_INTERFACE_INFO OF BLK_MEM_PORT1_en: SIGNAL IS "xilinx.com:interface:bram:1.0 BLK_MEM_PORT1 EN";
  ATTRIBUTE X_INTERFACE_INFO OF BLK_MEM_PORT1_dout: SIGNAL IS "xilinx.com:interface:bram:1.0 BLK_MEM_PORT1 DOUT";
  ATTRIBUTE X_INTERFACE_INFO OF BLK_MEM_PORT1_din: SIGNAL IS "xilinx.com:interface:bram:1.0 BLK_MEM_PORT1 DIN";
  ATTRIBUTE X_INTERFACE_INFO OF BLK_MEM_PORT1_clk: SIGNAL IS "xilinx.com:interface:bram:1.0 BLK_MEM_PORT1 CLK";
  ATTRIBUTE X_INTERFACE_PARAMETER OF BLK_MEM_PORT1_addr: SIGNAL IS "XIL_INTERFACENAME BLK_MEM_PORT1, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1";
  ATTRIBUTE X_INTERFACE_INFO OF BLK_MEM_PORT1_addr: SIGNAL IS "xilinx.com:interface:bram:1.0 BLK_MEM_PORT1 ADDR";
  ATTRIBUTE X_INTERFACE_INFO OF BLK_MEM_PORT0_rst: SIGNAL IS "xilinx.com:interface:bram:1.0 BLK_MEM_PORT0 RST";
  ATTRIBUTE X_INTERFACE_INFO OF BLK_MEM_PORT0_we: SIGNAL IS "xilinx.com:interface:bram:1.0 BLK_MEM_PORT0 WE";
  ATTRIBUTE X_INTERFACE_INFO OF BLK_MEM_PORT0_en: SIGNAL IS "xilinx.com:interface:bram:1.0 BLK_MEM_PORT0 EN";
  ATTRIBUTE X_INTERFACE_INFO OF BLK_MEM_PORT0_dout: SIGNAL IS "xilinx.com:interface:bram:1.0 BLK_MEM_PORT0 DOUT";
  ATTRIBUTE X_INTERFACE_INFO OF BLK_MEM_PORT0_din: SIGNAL IS "xilinx.com:interface:bram:1.0 BLK_MEM_PORT0 DIN";
  ATTRIBUTE X_INTERFACE_INFO OF BLK_MEM_PORT0_clk: SIGNAL IS "xilinx.com:interface:bram:1.0 BLK_MEM_PORT0 CLK";
  ATTRIBUTE X_INTERFACE_PARAMETER OF BLK_MEM_PORT0_addr: SIGNAL IS "XIL_INTERFACENAME BLK_MEM_PORT0, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1";
  ATTRIBUTE X_INTERFACE_INFO OF BLK_MEM_PORT0_addr: SIGNAL IS "xilinx.com:interface:bram:1.0 BLK_MEM_PORT0 ADDR";
  ATTRIBUTE X_INTERFACE_INFO OF BRAM_PORT1_rst: SIGNAL IS "xilinx.com:interface:bram:1.0 BRAM_PORT1 RST";
  ATTRIBUTE X_INTERFACE_INFO OF BRAM_PORT1_we: SIGNAL IS "xilinx.com:interface:bram:1.0 BRAM_PORT1 WE";
  ATTRIBUTE X_INTERFACE_INFO OF BRAM_PORT1_en: SIGNAL IS "xilinx.com:interface:bram:1.0 BRAM_PORT1 EN";
  ATTRIBUTE X_INTERFACE_INFO OF BRAM_PORT1_dout: SIGNAL IS "xilinx.com:interface:bram:1.0 BRAM_PORT1 DOUT";
  ATTRIBUTE X_INTERFACE_INFO OF BRAM_PORT1_din: SIGNAL IS "xilinx.com:interface:bram:1.0 BRAM_PORT1 DIN";
  ATTRIBUTE X_INTERFACE_INFO OF BRAM_PORT1_clk: SIGNAL IS "xilinx.com:interface:bram:1.0 BRAM_PORT1 CLK";
  ATTRIBUTE X_INTERFACE_PARAMETER OF BRAM_PORT1_addr: SIGNAL IS "XIL_INTERFACENAME BRAM_PORT1, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1";
  ATTRIBUTE X_INTERFACE_INFO OF BRAM_PORT1_addr: SIGNAL IS "xilinx.com:interface:bram:1.0 BRAM_PORT1 ADDR";
  ATTRIBUTE X_INTERFACE_INFO OF BRAM_PORT0_rst: SIGNAL IS "xilinx.com:interface:bram:1.0 BRAM_PORT0 RST";
  ATTRIBUTE X_INTERFACE_INFO OF BRAM_PORT0_we: SIGNAL IS "xilinx.com:interface:bram:1.0 BRAM_PORT0 WE";
  ATTRIBUTE X_INTERFACE_INFO OF BRAM_PORT0_en: SIGNAL IS "xilinx.com:interface:bram:1.0 BRAM_PORT0 EN";
  ATTRIBUTE X_INTERFACE_INFO OF BRAM_PORT0_dout: SIGNAL IS "xilinx.com:interface:bram:1.0 BRAM_PORT0 DOUT";
  ATTRIBUTE X_INTERFACE_INFO OF BRAM_PORT0_din: SIGNAL IS "xilinx.com:interface:bram:1.0 BRAM_PORT0 DIN";
  ATTRIBUTE X_INTERFACE_INFO OF BRAM_PORT0_clk: SIGNAL IS "xilinx.com:interface:bram:1.0 BRAM_PORT0 CLK";
  ATTRIBUTE X_INTERFACE_PARAMETER OF BRAM_PORT0_addr: SIGNAL IS "XIL_INTERFACENAME BRAM_PORT0, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1";
  ATTRIBUTE X_INTERFACE_INFO OF BRAM_PORT0_addr: SIGNAL IS "xilinx.com:interface:bram:1.0 BRAM_PORT0 ADDR";
BEGIN
  U0 : bram_switch
    GENERIC MAP (
      ADDR_WIDTH => 32,
      DATA_WIDTH => 32
    )
    PORT MAP (
      BRAM_PORT0_addr => BRAM_PORT0_addr,
      BRAM_PORT0_clk => BRAM_PORT0_clk,
      BRAM_PORT0_din => BRAM_PORT0_din,
      BRAM_PORT0_dout => BRAM_PORT0_dout,
      BRAM_PORT0_en => BRAM_PORT0_en,
      BRAM_PORT0_we => BRAM_PORT0_we,
      BRAM_PORT0_rst => BRAM_PORT0_rst,
      BRAM_PORT1_addr => BRAM_PORT1_addr,
      BRAM_PORT1_clk => BRAM_PORT1_clk,
      BRAM_PORT1_din => BRAM_PORT1_din,
      BRAM_PORT1_dout => BRAM_PORT1_dout,
      BRAM_PORT1_en => BRAM_PORT1_en,
      BRAM_PORT1_we => BRAM_PORT1_we,
      BRAM_PORT1_rst => BRAM_PORT1_rst,
      BLK_MEM_PORT0_addr => BLK_MEM_PORT0_addr,
      BLK_MEM_PORT0_clk => BLK_MEM_PORT0_clk,
      BLK_MEM_PORT0_din => BLK_MEM_PORT0_din,
      BLK_MEM_PORT0_dout => BLK_MEM_PORT0_dout,
      BLK_MEM_PORT0_en => BLK_MEM_PORT0_en,
      BLK_MEM_PORT0_we => BLK_MEM_PORT0_we,
      BLK_MEM_PORT0_rst => BLK_MEM_PORT0_rst,
      BLK_MEM_PORT1_addr => BLK_MEM_PORT1_addr,
      BLK_MEM_PORT1_clk => BLK_MEM_PORT1_clk,
      BLK_MEM_PORT1_din => BLK_MEM_PORT1_din,
      BLK_MEM_PORT1_dout => BLK_MEM_PORT1_dout,
      BLK_MEM_PORT1_en => BLK_MEM_PORT1_en,
      BLK_MEM_PORT1_we => BLK_MEM_PORT1_we,
      BLK_MEM_PORT1_rst => BLK_MEM_PORT1_rst,
      invert_banks => invert_banks
    );
END conv_accelerator_bd_bram_switch_1_2_arch;
