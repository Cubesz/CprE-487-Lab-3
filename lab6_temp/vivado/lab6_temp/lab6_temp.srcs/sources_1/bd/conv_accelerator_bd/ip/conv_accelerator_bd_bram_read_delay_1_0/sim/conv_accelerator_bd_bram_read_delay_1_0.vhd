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

-- IP VLNV: xilinx.com:module_ref:bram_read_delay:1.0
-- IP Revision: 1

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY conv_accelerator_bd_bram_read_delay_1_0 IS
  PORT (
    M_BRAM_addr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    M_BRAM_clk : IN STD_LOGIC;
    M_BRAM_din : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    M_BRAM_dout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    M_BRAM_en : IN STD_LOGIC;
    M_BRAM_we : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    M_BRAM_rst : IN STD_LOGIC;
    S_BRAM_addr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    S_BRAM_clk : OUT STD_LOGIC;
    S_BRAM_din : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    S_BRAM_dout : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    S_BRAM_en : OUT STD_LOGIC;
    S_BRAM_we : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    S_BRAM_rst : OUT STD_LOGIC
  );
END conv_accelerator_bd_bram_read_delay_1_0;

ARCHITECTURE conv_accelerator_bd_bram_read_delay_1_0_arch OF conv_accelerator_bd_bram_read_delay_1_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF conv_accelerator_bd_bram_read_delay_1_0_arch: ARCHITECTURE IS "yes";
  COMPONENT bram_read_delay IS
    GENERIC (
      ADDR_WIDTH : INTEGER;
      DATA_WIDTH : INTEGER
    );
    PORT (
      M_BRAM_addr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      M_BRAM_clk : IN STD_LOGIC;
      M_BRAM_din : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      M_BRAM_dout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      M_BRAM_en : IN STD_LOGIC;
      M_BRAM_we : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      M_BRAM_rst : IN STD_LOGIC;
      S_BRAM_addr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      S_BRAM_clk : OUT STD_LOGIC;
      S_BRAM_din : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      S_BRAM_dout : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      S_BRAM_en : OUT STD_LOGIC;
      S_BRAM_we : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      S_BRAM_rst : OUT STD_LOGIC
    );
  END COMPONENT bram_read_delay;
  ATTRIBUTE IP_DEFINITION_SOURCE : STRING;
  ATTRIBUTE IP_DEFINITION_SOURCE OF conv_accelerator_bd_bram_read_delay_1_0_arch: ARCHITECTURE IS "module_ref";
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
  ATTRIBUTE X_INTERFACE_INFO OF M_BRAM_rst: SIGNAL IS "xilinx.com:interface:bram:1.0 M_BRAM RST";
  ATTRIBUTE X_INTERFACE_INFO OF M_BRAM_we: SIGNAL IS "xilinx.com:interface:bram:1.0 M_BRAM WE";
  ATTRIBUTE X_INTERFACE_INFO OF M_BRAM_en: SIGNAL IS "xilinx.com:interface:bram:1.0 M_BRAM EN";
  ATTRIBUTE X_INTERFACE_INFO OF M_BRAM_dout: SIGNAL IS "xilinx.com:interface:bram:1.0 M_BRAM DOUT";
  ATTRIBUTE X_INTERFACE_INFO OF M_BRAM_din: SIGNAL IS "xilinx.com:interface:bram:1.0 M_BRAM DIN";
  ATTRIBUTE X_INTERFACE_INFO OF M_BRAM_clk: SIGNAL IS "xilinx.com:interface:bram:1.0 M_BRAM CLK";
  ATTRIBUTE X_INTERFACE_PARAMETER OF M_BRAM_addr: SIGNAL IS "XIL_INTERFACENAME M_BRAM, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1";
  ATTRIBUTE X_INTERFACE_INFO OF M_BRAM_addr: SIGNAL IS "xilinx.com:interface:bram:1.0 M_BRAM ADDR";
BEGIN
  U0 : bram_read_delay
    GENERIC MAP (
      ADDR_WIDTH => 32,
      DATA_WIDTH => 32
    )
    PORT MAP (
      M_BRAM_addr => M_BRAM_addr,
      M_BRAM_clk => M_BRAM_clk,
      M_BRAM_din => M_BRAM_din,
      M_BRAM_dout => M_BRAM_dout,
      M_BRAM_en => M_BRAM_en,
      M_BRAM_we => M_BRAM_we,
      M_BRAM_rst => M_BRAM_rst,
      S_BRAM_addr => S_BRAM_addr,
      S_BRAM_clk => S_BRAM_clk,
      S_BRAM_din => S_BRAM_din,
      S_BRAM_dout => S_BRAM_dout,
      S_BRAM_en => S_BRAM_en,
      S_BRAM_we => S_BRAM_we,
      S_BRAM_rst => S_BRAM_rst
    );
END conv_accelerator_bd_bram_read_delay_1_0_arch;
