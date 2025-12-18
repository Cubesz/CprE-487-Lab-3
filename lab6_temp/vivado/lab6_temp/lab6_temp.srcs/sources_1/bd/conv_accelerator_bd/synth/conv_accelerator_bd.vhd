--Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
--Date        : Thu Dec 18 04:43:49 2025
--Host        : linuxvdi-f25-05.ece.iastate.edu running 64-bit unknown
--Command     : generate_target conv_accelerator_bd.bd
--Design      : conv_accelerator_bd
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bram_filter_0_imp_8ZJM6 is
  port (
    BRAM_PORT0_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT0_clk : in STD_LOGIC;
    BRAM_PORT0_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT0_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT0_en : in STD_LOGIC;
    BRAM_PORT0_rst : in STD_LOGIC;
    BRAM_PORT0_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    BRAM_PORT_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT_clk : in STD_LOGIC;
    BRAM_PORT_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT_en : in STD_LOGIC;
    BRAM_PORT_rst : in STD_LOGIC;
    BRAM_PORT_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    invert_banks : in STD_LOGIC
  );
end bram_filter_0_imp_8ZJM6;

architecture STRUCTURE of bram_filter_0_imp_8ZJM6 is
  component conv_accelerator_bd_blk_mem_gen_0_0 is
  port (
    clka : in STD_LOGIC;
    rsta : in STD_LOGIC;
    ena : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 3 downto 0 );
    addra : in STD_LOGIC_VECTOR ( 31 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 31 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component conv_accelerator_bd_blk_mem_gen_0_0;
  component conv_accelerator_bd_blk_mem_gen_1_0 is
  port (
    clka : in STD_LOGIC;
    rsta : in STD_LOGIC;
    ena : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 3 downto 0 );
    addra : in STD_LOGIC_VECTOR ( 31 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 31 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component conv_accelerator_bd_blk_mem_gen_1_0;
  component conv_accelerator_bd_bram_switch_1_0 is
  port (
    BRAM_PORT0_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT0_clk : in STD_LOGIC;
    BRAM_PORT0_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT0_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT0_en : in STD_LOGIC;
    BRAM_PORT0_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    BRAM_PORT0_rst : in STD_LOGIC;
    BRAM_PORT1_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT1_clk : in STD_LOGIC;
    BRAM_PORT1_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT1_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT1_en : in STD_LOGIC;
    BRAM_PORT1_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    BRAM_PORT1_rst : in STD_LOGIC;
    BLK_MEM_PORT0_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BLK_MEM_PORT0_clk : out STD_LOGIC;
    BLK_MEM_PORT0_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BLK_MEM_PORT0_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BLK_MEM_PORT0_en : out STD_LOGIC;
    BLK_MEM_PORT0_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    BLK_MEM_PORT0_rst : out STD_LOGIC;
    BLK_MEM_PORT1_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BLK_MEM_PORT1_clk : out STD_LOGIC;
    BLK_MEM_PORT1_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BLK_MEM_PORT1_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BLK_MEM_PORT1_en : out STD_LOGIC;
    BLK_MEM_PORT1_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    BLK_MEM_PORT1_rst : out STD_LOGIC;
    invert_banks : in STD_LOGIC
  );
  end component conv_accelerator_bd_bram_switch_1_0;
  signal BRAM_PORT_1_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_PORT_1_CLK : STD_LOGIC;
  signal BRAM_PORT_1_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_PORT_1_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_PORT_1_EN : STD_LOGIC;
  signal BRAM_PORT_1_RST : STD_LOGIC;
  signal BRAM_PORT_1_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal Conn1_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal Conn1_CLK : STD_LOGIC;
  signal Conn1_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal Conn1_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal Conn1_EN : STD_LOGIC;
  signal Conn1_RST : STD_LOGIC;
  signal Conn1_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal bram_switch_0_BLK_MEM_PORTA0_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_switch_0_BLK_MEM_PORTA0_CLK : STD_LOGIC;
  signal bram_switch_0_BLK_MEM_PORTA0_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_switch_0_BLK_MEM_PORTA0_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_switch_0_BLK_MEM_PORTA0_EN : STD_LOGIC;
  signal bram_switch_0_BLK_MEM_PORTA0_RST : STD_LOGIC;
  signal bram_switch_0_BLK_MEM_PORTA0_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal bram_switch_0_BLK_MEM_PORTA1_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_switch_0_BLK_MEM_PORTA1_CLK : STD_LOGIC;
  signal bram_switch_0_BLK_MEM_PORTA1_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_switch_0_BLK_MEM_PORTA1_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_switch_0_BLK_MEM_PORTA1_EN : STD_LOGIC;
  signal bram_switch_0_BLK_MEM_PORTA1_RST : STD_LOGIC;
  signal bram_switch_0_BLK_MEM_PORTA1_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal invert_banks_0_2 : STD_LOGIC;
begin
  BRAM_PORT0_dout(31 downto 0) <= Conn1_DOUT(31 downto 0);
  BRAM_PORT_1_ADDR(31 downto 0) <= BRAM_PORT_addr(31 downto 0);
  BRAM_PORT_1_CLK <= BRAM_PORT_clk;
  BRAM_PORT_1_DIN(31 downto 0) <= BRAM_PORT_din(31 downto 0);
  BRAM_PORT_1_EN <= BRAM_PORT_en;
  BRAM_PORT_1_RST <= BRAM_PORT_rst;
  BRAM_PORT_1_WE(3 downto 0) <= BRAM_PORT_we(3 downto 0);
  BRAM_PORT_dout(31 downto 0) <= BRAM_PORT_1_DOUT(31 downto 0);
  Conn1_ADDR(31 downto 0) <= BRAM_PORT0_addr(31 downto 0);
  Conn1_CLK <= BRAM_PORT0_clk;
  Conn1_DIN(31 downto 0) <= BRAM_PORT0_din(31 downto 0);
  Conn1_EN <= BRAM_PORT0_en;
  Conn1_RST <= BRAM_PORT0_rst;
  Conn1_WE(3 downto 0) <= BRAM_PORT0_we(3 downto 0);
  invert_banks_0_2 <= invert_banks;
blk_mem_gen_0: component conv_accelerator_bd_blk_mem_gen_0_0
     port map (
      addra(31 downto 0) => bram_switch_0_BLK_MEM_PORTA0_ADDR(31 downto 0),
      clka => bram_switch_0_BLK_MEM_PORTA0_CLK,
      dina(31 downto 0) => bram_switch_0_BLK_MEM_PORTA0_DIN(31 downto 0),
      douta(31 downto 0) => bram_switch_0_BLK_MEM_PORTA0_DOUT(31 downto 0),
      ena => bram_switch_0_BLK_MEM_PORTA0_EN,
      rsta => bram_switch_0_BLK_MEM_PORTA0_RST,
      wea(3 downto 0) => bram_switch_0_BLK_MEM_PORTA0_WE(3 downto 0)
    );
blk_mem_gen_1: component conv_accelerator_bd_blk_mem_gen_1_0
     port map (
      addra(31 downto 0) => bram_switch_0_BLK_MEM_PORTA1_ADDR(31 downto 0),
      clka => bram_switch_0_BLK_MEM_PORTA1_CLK,
      dina(31 downto 0) => bram_switch_0_BLK_MEM_PORTA1_DIN(31 downto 0),
      douta(31 downto 0) => bram_switch_0_BLK_MEM_PORTA1_DOUT(31 downto 0),
      ena => bram_switch_0_BLK_MEM_PORTA1_EN,
      rsta => bram_switch_0_BLK_MEM_PORTA1_RST,
      wea(3 downto 0) => bram_switch_0_BLK_MEM_PORTA1_WE(3 downto 0)
    );
bram_switch_1: component conv_accelerator_bd_bram_switch_1_0
     port map (
      BLK_MEM_PORT0_addr(31 downto 0) => bram_switch_0_BLK_MEM_PORTA0_ADDR(31 downto 0),
      BLK_MEM_PORT0_clk => bram_switch_0_BLK_MEM_PORTA0_CLK,
      BLK_MEM_PORT0_din(31 downto 0) => bram_switch_0_BLK_MEM_PORTA0_DIN(31 downto 0),
      BLK_MEM_PORT0_dout(31 downto 0) => bram_switch_0_BLK_MEM_PORTA0_DOUT(31 downto 0),
      BLK_MEM_PORT0_en => bram_switch_0_BLK_MEM_PORTA0_EN,
      BLK_MEM_PORT0_rst => bram_switch_0_BLK_MEM_PORTA0_RST,
      BLK_MEM_PORT0_we(3 downto 0) => bram_switch_0_BLK_MEM_PORTA0_WE(3 downto 0),
      BLK_MEM_PORT1_addr(31 downto 0) => bram_switch_0_BLK_MEM_PORTA1_ADDR(31 downto 0),
      BLK_MEM_PORT1_clk => bram_switch_0_BLK_MEM_PORTA1_CLK,
      BLK_MEM_PORT1_din(31 downto 0) => bram_switch_0_BLK_MEM_PORTA1_DIN(31 downto 0),
      BLK_MEM_PORT1_dout(31 downto 0) => bram_switch_0_BLK_MEM_PORTA1_DOUT(31 downto 0),
      BLK_MEM_PORT1_en => bram_switch_0_BLK_MEM_PORTA1_EN,
      BLK_MEM_PORT1_rst => bram_switch_0_BLK_MEM_PORTA1_RST,
      BLK_MEM_PORT1_we(3 downto 0) => bram_switch_0_BLK_MEM_PORTA1_WE(3 downto 0),
      BRAM_PORT0_addr(31 downto 0) => Conn1_ADDR(31 downto 0),
      BRAM_PORT0_clk => Conn1_CLK,
      BRAM_PORT0_din(31 downto 0) => Conn1_DIN(31 downto 0),
      BRAM_PORT0_dout(31 downto 0) => Conn1_DOUT(31 downto 0),
      BRAM_PORT0_en => Conn1_EN,
      BRAM_PORT0_rst => Conn1_RST,
      BRAM_PORT0_we(3 downto 0) => Conn1_WE(3 downto 0),
      BRAM_PORT1_addr(31 downto 0) => BRAM_PORT_1_ADDR(31 downto 0),
      BRAM_PORT1_clk => BRAM_PORT_1_CLK,
      BRAM_PORT1_din(31 downto 0) => BRAM_PORT_1_DIN(31 downto 0),
      BRAM_PORT1_dout(31 downto 0) => BRAM_PORT_1_DOUT(31 downto 0),
      BRAM_PORT1_en => BRAM_PORT_1_EN,
      BRAM_PORT1_rst => BRAM_PORT_1_RST,
      BRAM_PORT1_we(3 downto 0) => BRAM_PORT_1_WE(3 downto 0),
      invert_banks => invert_banks_0_2
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bram_filter_1_imp_S5WSI0 is
  port (
    BRAM_PORT0_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT0_clk : in STD_LOGIC;
    BRAM_PORT0_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT0_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT0_en : in STD_LOGIC;
    BRAM_PORT0_rst : in STD_LOGIC;
    BRAM_PORT0_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    BRAM_PORT_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT_clk : in STD_LOGIC;
    BRAM_PORT_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT_en : in STD_LOGIC;
    BRAM_PORT_rst : in STD_LOGIC;
    BRAM_PORT_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    invert_banks : in STD_LOGIC
  );
end bram_filter_1_imp_S5WSI0;

architecture STRUCTURE of bram_filter_1_imp_S5WSI0 is
  component conv_accelerator_bd_blk_mem_gen_0_1 is
  port (
    clka : in STD_LOGIC;
    rsta : in STD_LOGIC;
    ena : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 3 downto 0 );
    addra : in STD_LOGIC_VECTOR ( 31 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 31 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component conv_accelerator_bd_blk_mem_gen_0_1;
  component conv_accelerator_bd_blk_mem_gen_1_1 is
  port (
    clka : in STD_LOGIC;
    rsta : in STD_LOGIC;
    ena : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 3 downto 0 );
    addra : in STD_LOGIC_VECTOR ( 31 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 31 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component conv_accelerator_bd_blk_mem_gen_1_1;
  component conv_accelerator_bd_bram_switch_1_1 is
  port (
    BRAM_PORT0_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT0_clk : in STD_LOGIC;
    BRAM_PORT0_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT0_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT0_en : in STD_LOGIC;
    BRAM_PORT0_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    BRAM_PORT0_rst : in STD_LOGIC;
    BRAM_PORT1_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT1_clk : in STD_LOGIC;
    BRAM_PORT1_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT1_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT1_en : in STD_LOGIC;
    BRAM_PORT1_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    BRAM_PORT1_rst : in STD_LOGIC;
    BLK_MEM_PORT0_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BLK_MEM_PORT0_clk : out STD_LOGIC;
    BLK_MEM_PORT0_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BLK_MEM_PORT0_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BLK_MEM_PORT0_en : out STD_LOGIC;
    BLK_MEM_PORT0_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    BLK_MEM_PORT0_rst : out STD_LOGIC;
    BLK_MEM_PORT1_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BLK_MEM_PORT1_clk : out STD_LOGIC;
    BLK_MEM_PORT1_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BLK_MEM_PORT1_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BLK_MEM_PORT1_en : out STD_LOGIC;
    BLK_MEM_PORT1_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    BLK_MEM_PORT1_rst : out STD_LOGIC;
    invert_banks : in STD_LOGIC
  );
  end component conv_accelerator_bd_bram_switch_1_1;
  signal BRAM_PORT_1_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_PORT_1_CLK : STD_LOGIC;
  signal BRAM_PORT_1_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_PORT_1_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_PORT_1_EN : STD_LOGIC;
  signal BRAM_PORT_1_RST : STD_LOGIC;
  signal BRAM_PORT_1_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal Conn1_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal Conn1_CLK : STD_LOGIC;
  signal Conn1_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal Conn1_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal Conn1_EN : STD_LOGIC;
  signal Conn1_RST : STD_LOGIC;
  signal Conn1_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal bram_switch_0_BLK_MEM_PORTA0_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_switch_0_BLK_MEM_PORTA0_CLK : STD_LOGIC;
  signal bram_switch_0_BLK_MEM_PORTA0_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_switch_0_BLK_MEM_PORTA0_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_switch_0_BLK_MEM_PORTA0_EN : STD_LOGIC;
  signal bram_switch_0_BLK_MEM_PORTA0_RST : STD_LOGIC;
  signal bram_switch_0_BLK_MEM_PORTA0_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal bram_switch_0_BLK_MEM_PORTA1_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_switch_0_BLK_MEM_PORTA1_CLK : STD_LOGIC;
  signal bram_switch_0_BLK_MEM_PORTA1_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_switch_0_BLK_MEM_PORTA1_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_switch_0_BLK_MEM_PORTA1_EN : STD_LOGIC;
  signal bram_switch_0_BLK_MEM_PORTA1_RST : STD_LOGIC;
  signal bram_switch_0_BLK_MEM_PORTA1_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal invert_banks_0_2 : STD_LOGIC;
begin
  BRAM_PORT0_dout(31 downto 0) <= Conn1_DOUT(31 downto 0);
  BRAM_PORT_1_ADDR(31 downto 0) <= BRAM_PORT_addr(31 downto 0);
  BRAM_PORT_1_CLK <= BRAM_PORT_clk;
  BRAM_PORT_1_DIN(31 downto 0) <= BRAM_PORT_din(31 downto 0);
  BRAM_PORT_1_EN <= BRAM_PORT_en;
  BRAM_PORT_1_RST <= BRAM_PORT_rst;
  BRAM_PORT_1_WE(3 downto 0) <= BRAM_PORT_we(3 downto 0);
  BRAM_PORT_dout(31 downto 0) <= BRAM_PORT_1_DOUT(31 downto 0);
  Conn1_ADDR(31 downto 0) <= BRAM_PORT0_addr(31 downto 0);
  Conn1_CLK <= BRAM_PORT0_clk;
  Conn1_DIN(31 downto 0) <= BRAM_PORT0_din(31 downto 0);
  Conn1_EN <= BRAM_PORT0_en;
  Conn1_RST <= BRAM_PORT0_rst;
  Conn1_WE(3 downto 0) <= BRAM_PORT0_we(3 downto 0);
  invert_banks_0_2 <= invert_banks;
blk_mem_gen_0: component conv_accelerator_bd_blk_mem_gen_0_1
     port map (
      addra(31 downto 0) => bram_switch_0_BLK_MEM_PORTA0_ADDR(31 downto 0),
      clka => bram_switch_0_BLK_MEM_PORTA0_CLK,
      dina(31 downto 0) => bram_switch_0_BLK_MEM_PORTA0_DIN(31 downto 0),
      douta(31 downto 0) => bram_switch_0_BLK_MEM_PORTA0_DOUT(31 downto 0),
      ena => bram_switch_0_BLK_MEM_PORTA0_EN,
      rsta => bram_switch_0_BLK_MEM_PORTA0_RST,
      wea(3 downto 0) => bram_switch_0_BLK_MEM_PORTA0_WE(3 downto 0)
    );
blk_mem_gen_1: component conv_accelerator_bd_blk_mem_gen_1_1
     port map (
      addra(31 downto 0) => bram_switch_0_BLK_MEM_PORTA1_ADDR(31 downto 0),
      clka => bram_switch_0_BLK_MEM_PORTA1_CLK,
      dina(31 downto 0) => bram_switch_0_BLK_MEM_PORTA1_DIN(31 downto 0),
      douta(31 downto 0) => bram_switch_0_BLK_MEM_PORTA1_DOUT(31 downto 0),
      ena => bram_switch_0_BLK_MEM_PORTA1_EN,
      rsta => bram_switch_0_BLK_MEM_PORTA1_RST,
      wea(3 downto 0) => bram_switch_0_BLK_MEM_PORTA1_WE(3 downto 0)
    );
bram_switch_1: component conv_accelerator_bd_bram_switch_1_1
     port map (
      BLK_MEM_PORT0_addr(31 downto 0) => bram_switch_0_BLK_MEM_PORTA0_ADDR(31 downto 0),
      BLK_MEM_PORT0_clk => bram_switch_0_BLK_MEM_PORTA0_CLK,
      BLK_MEM_PORT0_din(31 downto 0) => bram_switch_0_BLK_MEM_PORTA0_DIN(31 downto 0),
      BLK_MEM_PORT0_dout(31 downto 0) => bram_switch_0_BLK_MEM_PORTA0_DOUT(31 downto 0),
      BLK_MEM_PORT0_en => bram_switch_0_BLK_MEM_PORTA0_EN,
      BLK_MEM_PORT0_rst => bram_switch_0_BLK_MEM_PORTA0_RST,
      BLK_MEM_PORT0_we(3 downto 0) => bram_switch_0_BLK_MEM_PORTA0_WE(3 downto 0),
      BLK_MEM_PORT1_addr(31 downto 0) => bram_switch_0_BLK_MEM_PORTA1_ADDR(31 downto 0),
      BLK_MEM_PORT1_clk => bram_switch_0_BLK_MEM_PORTA1_CLK,
      BLK_MEM_PORT1_din(31 downto 0) => bram_switch_0_BLK_MEM_PORTA1_DIN(31 downto 0),
      BLK_MEM_PORT1_dout(31 downto 0) => bram_switch_0_BLK_MEM_PORTA1_DOUT(31 downto 0),
      BLK_MEM_PORT1_en => bram_switch_0_BLK_MEM_PORTA1_EN,
      BLK_MEM_PORT1_rst => bram_switch_0_BLK_MEM_PORTA1_RST,
      BLK_MEM_PORT1_we(3 downto 0) => bram_switch_0_BLK_MEM_PORTA1_WE(3 downto 0),
      BRAM_PORT0_addr(31 downto 0) => Conn1_ADDR(31 downto 0),
      BRAM_PORT0_clk => Conn1_CLK,
      BRAM_PORT0_din(31 downto 0) => Conn1_DIN(31 downto 0),
      BRAM_PORT0_dout(31 downto 0) => Conn1_DOUT(31 downto 0),
      BRAM_PORT0_en => Conn1_EN,
      BRAM_PORT0_rst => Conn1_RST,
      BRAM_PORT0_we(3 downto 0) => Conn1_WE(3 downto 0),
      BRAM_PORT1_addr(31 downto 0) => BRAM_PORT_1_ADDR(31 downto 0),
      BRAM_PORT1_clk => BRAM_PORT_1_CLK,
      BRAM_PORT1_din(31 downto 0) => BRAM_PORT_1_DIN(31 downto 0),
      BRAM_PORT1_dout(31 downto 0) => BRAM_PORT_1_DOUT(31 downto 0),
      BRAM_PORT1_en => BRAM_PORT_1_EN,
      BRAM_PORT1_rst => BRAM_PORT_1_RST,
      BRAM_PORT1_we(3 downto 0) => BRAM_PORT_1_WE(3 downto 0),
      invert_banks => invert_banks_0_2
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bram_filter_2_imp_1K3ACG2 is
  port (
    BRAM_PORT0_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT0_clk : in STD_LOGIC;
    BRAM_PORT0_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT0_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT0_en : in STD_LOGIC;
    BRAM_PORT0_rst : in STD_LOGIC;
    BRAM_PORT0_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    BRAM_PORT_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT_clk : in STD_LOGIC;
    BRAM_PORT_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT_en : in STD_LOGIC;
    BRAM_PORT_rst : in STD_LOGIC;
    BRAM_PORT_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    invert_banks : in STD_LOGIC
  );
end bram_filter_2_imp_1K3ACG2;

architecture STRUCTURE of bram_filter_2_imp_1K3ACG2 is
  component conv_accelerator_bd_blk_mem_gen_0_2 is
  port (
    clka : in STD_LOGIC;
    rsta : in STD_LOGIC;
    ena : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 3 downto 0 );
    addra : in STD_LOGIC_VECTOR ( 31 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 31 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component conv_accelerator_bd_blk_mem_gen_0_2;
  component conv_accelerator_bd_blk_mem_gen_1_2 is
  port (
    clka : in STD_LOGIC;
    rsta : in STD_LOGIC;
    ena : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 3 downto 0 );
    addra : in STD_LOGIC_VECTOR ( 31 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 31 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component conv_accelerator_bd_blk_mem_gen_1_2;
  component conv_accelerator_bd_bram_switch_1_2 is
  port (
    BRAM_PORT0_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT0_clk : in STD_LOGIC;
    BRAM_PORT0_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT0_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT0_en : in STD_LOGIC;
    BRAM_PORT0_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    BRAM_PORT0_rst : in STD_LOGIC;
    BRAM_PORT1_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT1_clk : in STD_LOGIC;
    BRAM_PORT1_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT1_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT1_en : in STD_LOGIC;
    BRAM_PORT1_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    BRAM_PORT1_rst : in STD_LOGIC;
    BLK_MEM_PORT0_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BLK_MEM_PORT0_clk : out STD_LOGIC;
    BLK_MEM_PORT0_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BLK_MEM_PORT0_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BLK_MEM_PORT0_en : out STD_LOGIC;
    BLK_MEM_PORT0_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    BLK_MEM_PORT0_rst : out STD_LOGIC;
    BLK_MEM_PORT1_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BLK_MEM_PORT1_clk : out STD_LOGIC;
    BLK_MEM_PORT1_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BLK_MEM_PORT1_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BLK_MEM_PORT1_en : out STD_LOGIC;
    BLK_MEM_PORT1_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    BLK_MEM_PORT1_rst : out STD_LOGIC;
    invert_banks : in STD_LOGIC
  );
  end component conv_accelerator_bd_bram_switch_1_2;
  signal BRAM_PORT_1_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_PORT_1_CLK : STD_LOGIC;
  signal BRAM_PORT_1_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_PORT_1_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_PORT_1_EN : STD_LOGIC;
  signal BRAM_PORT_1_RST : STD_LOGIC;
  signal BRAM_PORT_1_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal Conn1_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal Conn1_CLK : STD_LOGIC;
  signal Conn1_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal Conn1_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal Conn1_EN : STD_LOGIC;
  signal Conn1_RST : STD_LOGIC;
  signal Conn1_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal bram_switch_0_BLK_MEM_PORTA0_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_switch_0_BLK_MEM_PORTA0_CLK : STD_LOGIC;
  signal bram_switch_0_BLK_MEM_PORTA0_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_switch_0_BLK_MEM_PORTA0_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_switch_0_BLK_MEM_PORTA0_EN : STD_LOGIC;
  signal bram_switch_0_BLK_MEM_PORTA0_RST : STD_LOGIC;
  signal bram_switch_0_BLK_MEM_PORTA0_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal bram_switch_0_BLK_MEM_PORTA1_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_switch_0_BLK_MEM_PORTA1_CLK : STD_LOGIC;
  signal bram_switch_0_BLK_MEM_PORTA1_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_switch_0_BLK_MEM_PORTA1_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_switch_0_BLK_MEM_PORTA1_EN : STD_LOGIC;
  signal bram_switch_0_BLK_MEM_PORTA1_RST : STD_LOGIC;
  signal bram_switch_0_BLK_MEM_PORTA1_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal invert_banks_0_2 : STD_LOGIC;
begin
  BRAM_PORT0_dout(31 downto 0) <= Conn1_DOUT(31 downto 0);
  BRAM_PORT_1_ADDR(31 downto 0) <= BRAM_PORT_addr(31 downto 0);
  BRAM_PORT_1_CLK <= BRAM_PORT_clk;
  BRAM_PORT_1_DIN(31 downto 0) <= BRAM_PORT_din(31 downto 0);
  BRAM_PORT_1_EN <= BRAM_PORT_en;
  BRAM_PORT_1_RST <= BRAM_PORT_rst;
  BRAM_PORT_1_WE(3 downto 0) <= BRAM_PORT_we(3 downto 0);
  BRAM_PORT_dout(31 downto 0) <= BRAM_PORT_1_DOUT(31 downto 0);
  Conn1_ADDR(31 downto 0) <= BRAM_PORT0_addr(31 downto 0);
  Conn1_CLK <= BRAM_PORT0_clk;
  Conn1_DIN(31 downto 0) <= BRAM_PORT0_din(31 downto 0);
  Conn1_EN <= BRAM_PORT0_en;
  Conn1_RST <= BRAM_PORT0_rst;
  Conn1_WE(3 downto 0) <= BRAM_PORT0_we(3 downto 0);
  invert_banks_0_2 <= invert_banks;
blk_mem_gen_0: component conv_accelerator_bd_blk_mem_gen_0_2
     port map (
      addra(31 downto 0) => bram_switch_0_BLK_MEM_PORTA0_ADDR(31 downto 0),
      clka => bram_switch_0_BLK_MEM_PORTA0_CLK,
      dina(31 downto 0) => bram_switch_0_BLK_MEM_PORTA0_DIN(31 downto 0),
      douta(31 downto 0) => bram_switch_0_BLK_MEM_PORTA0_DOUT(31 downto 0),
      ena => bram_switch_0_BLK_MEM_PORTA0_EN,
      rsta => bram_switch_0_BLK_MEM_PORTA0_RST,
      wea(3 downto 0) => bram_switch_0_BLK_MEM_PORTA0_WE(3 downto 0)
    );
blk_mem_gen_1: component conv_accelerator_bd_blk_mem_gen_1_2
     port map (
      addra(31 downto 0) => bram_switch_0_BLK_MEM_PORTA1_ADDR(31 downto 0),
      clka => bram_switch_0_BLK_MEM_PORTA1_CLK,
      dina(31 downto 0) => bram_switch_0_BLK_MEM_PORTA1_DIN(31 downto 0),
      douta(31 downto 0) => bram_switch_0_BLK_MEM_PORTA1_DOUT(31 downto 0),
      ena => bram_switch_0_BLK_MEM_PORTA1_EN,
      rsta => bram_switch_0_BLK_MEM_PORTA1_RST,
      wea(3 downto 0) => bram_switch_0_BLK_MEM_PORTA1_WE(3 downto 0)
    );
bram_switch_1: component conv_accelerator_bd_bram_switch_1_2
     port map (
      BLK_MEM_PORT0_addr(31 downto 0) => bram_switch_0_BLK_MEM_PORTA0_ADDR(31 downto 0),
      BLK_MEM_PORT0_clk => bram_switch_0_BLK_MEM_PORTA0_CLK,
      BLK_MEM_PORT0_din(31 downto 0) => bram_switch_0_BLK_MEM_PORTA0_DIN(31 downto 0),
      BLK_MEM_PORT0_dout(31 downto 0) => bram_switch_0_BLK_MEM_PORTA0_DOUT(31 downto 0),
      BLK_MEM_PORT0_en => bram_switch_0_BLK_MEM_PORTA0_EN,
      BLK_MEM_PORT0_rst => bram_switch_0_BLK_MEM_PORTA0_RST,
      BLK_MEM_PORT0_we(3 downto 0) => bram_switch_0_BLK_MEM_PORTA0_WE(3 downto 0),
      BLK_MEM_PORT1_addr(31 downto 0) => bram_switch_0_BLK_MEM_PORTA1_ADDR(31 downto 0),
      BLK_MEM_PORT1_clk => bram_switch_0_BLK_MEM_PORTA1_CLK,
      BLK_MEM_PORT1_din(31 downto 0) => bram_switch_0_BLK_MEM_PORTA1_DIN(31 downto 0),
      BLK_MEM_PORT1_dout(31 downto 0) => bram_switch_0_BLK_MEM_PORTA1_DOUT(31 downto 0),
      BLK_MEM_PORT1_en => bram_switch_0_BLK_MEM_PORTA1_EN,
      BLK_MEM_PORT1_rst => bram_switch_0_BLK_MEM_PORTA1_RST,
      BLK_MEM_PORT1_we(3 downto 0) => bram_switch_0_BLK_MEM_PORTA1_WE(3 downto 0),
      BRAM_PORT0_addr(31 downto 0) => Conn1_ADDR(31 downto 0),
      BRAM_PORT0_clk => Conn1_CLK,
      BRAM_PORT0_din(31 downto 0) => Conn1_DIN(31 downto 0),
      BRAM_PORT0_dout(31 downto 0) => Conn1_DOUT(31 downto 0),
      BRAM_PORT0_en => Conn1_EN,
      BRAM_PORT0_rst => Conn1_RST,
      BRAM_PORT0_we(3 downto 0) => Conn1_WE(3 downto 0),
      BRAM_PORT1_addr(31 downto 0) => BRAM_PORT_1_ADDR(31 downto 0),
      BRAM_PORT1_clk => BRAM_PORT_1_CLK,
      BRAM_PORT1_din(31 downto 0) => BRAM_PORT_1_DIN(31 downto 0),
      BRAM_PORT1_dout(31 downto 0) => BRAM_PORT_1_DOUT(31 downto 0),
      BRAM_PORT1_en => BRAM_PORT_1_EN,
      BRAM_PORT1_rst => BRAM_PORT_1_RST,
      BRAM_PORT1_we(3 downto 0) => BRAM_PORT_1_WE(3 downto 0),
      invert_banks => invert_banks_0_2
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bram_filter_3_imp_1CN42BO is
  port (
    BRAM_PORT0_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT0_clk : in STD_LOGIC;
    BRAM_PORT0_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT0_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT0_en : in STD_LOGIC;
    BRAM_PORT0_rst : in STD_LOGIC;
    BRAM_PORT0_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    BRAM_PORT_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT_clk : in STD_LOGIC;
    BRAM_PORT_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT_en : in STD_LOGIC;
    BRAM_PORT_rst : in STD_LOGIC;
    BRAM_PORT_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    invert_banks : in STD_LOGIC
  );
end bram_filter_3_imp_1CN42BO;

architecture STRUCTURE of bram_filter_3_imp_1CN42BO is
  component conv_accelerator_bd_blk_mem_gen_0_3 is
  port (
    clka : in STD_LOGIC;
    rsta : in STD_LOGIC;
    ena : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 3 downto 0 );
    addra : in STD_LOGIC_VECTOR ( 31 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 31 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component conv_accelerator_bd_blk_mem_gen_0_3;
  component conv_accelerator_bd_blk_mem_gen_1_3 is
  port (
    clka : in STD_LOGIC;
    rsta : in STD_LOGIC;
    ena : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 3 downto 0 );
    addra : in STD_LOGIC_VECTOR ( 31 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 31 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component conv_accelerator_bd_blk_mem_gen_1_3;
  component conv_accelerator_bd_bram_switch_1_3 is
  port (
    BRAM_PORT0_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT0_clk : in STD_LOGIC;
    BRAM_PORT0_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT0_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT0_en : in STD_LOGIC;
    BRAM_PORT0_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    BRAM_PORT0_rst : in STD_LOGIC;
    BRAM_PORT1_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT1_clk : in STD_LOGIC;
    BRAM_PORT1_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT1_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT1_en : in STD_LOGIC;
    BRAM_PORT1_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    BRAM_PORT1_rst : in STD_LOGIC;
    BLK_MEM_PORT0_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BLK_MEM_PORT0_clk : out STD_LOGIC;
    BLK_MEM_PORT0_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BLK_MEM_PORT0_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BLK_MEM_PORT0_en : out STD_LOGIC;
    BLK_MEM_PORT0_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    BLK_MEM_PORT0_rst : out STD_LOGIC;
    BLK_MEM_PORT1_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BLK_MEM_PORT1_clk : out STD_LOGIC;
    BLK_MEM_PORT1_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BLK_MEM_PORT1_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BLK_MEM_PORT1_en : out STD_LOGIC;
    BLK_MEM_PORT1_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    BLK_MEM_PORT1_rst : out STD_LOGIC;
    invert_banks : in STD_LOGIC
  );
  end component conv_accelerator_bd_bram_switch_1_3;
  signal BRAM_PORT_1_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_PORT_1_CLK : STD_LOGIC;
  signal BRAM_PORT_1_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_PORT_1_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_PORT_1_EN : STD_LOGIC;
  signal BRAM_PORT_1_RST : STD_LOGIC;
  signal BRAM_PORT_1_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal Conn1_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal Conn1_CLK : STD_LOGIC;
  signal Conn1_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal Conn1_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal Conn1_EN : STD_LOGIC;
  signal Conn1_RST : STD_LOGIC;
  signal Conn1_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal bram_switch_0_BLK_MEM_PORTA0_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_switch_0_BLK_MEM_PORTA0_CLK : STD_LOGIC;
  signal bram_switch_0_BLK_MEM_PORTA0_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_switch_0_BLK_MEM_PORTA0_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_switch_0_BLK_MEM_PORTA0_EN : STD_LOGIC;
  signal bram_switch_0_BLK_MEM_PORTA0_RST : STD_LOGIC;
  signal bram_switch_0_BLK_MEM_PORTA0_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal bram_switch_0_BLK_MEM_PORTA1_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_switch_0_BLK_MEM_PORTA1_CLK : STD_LOGIC;
  signal bram_switch_0_BLK_MEM_PORTA1_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_switch_0_BLK_MEM_PORTA1_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_switch_0_BLK_MEM_PORTA1_EN : STD_LOGIC;
  signal bram_switch_0_BLK_MEM_PORTA1_RST : STD_LOGIC;
  signal bram_switch_0_BLK_MEM_PORTA1_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal invert_banks_0_2 : STD_LOGIC;
begin
  BRAM_PORT0_dout(31 downto 0) <= Conn1_DOUT(31 downto 0);
  BRAM_PORT_1_ADDR(31 downto 0) <= BRAM_PORT_addr(31 downto 0);
  BRAM_PORT_1_CLK <= BRAM_PORT_clk;
  BRAM_PORT_1_DIN(31 downto 0) <= BRAM_PORT_din(31 downto 0);
  BRAM_PORT_1_EN <= BRAM_PORT_en;
  BRAM_PORT_1_RST <= BRAM_PORT_rst;
  BRAM_PORT_1_WE(3 downto 0) <= BRAM_PORT_we(3 downto 0);
  BRAM_PORT_dout(31 downto 0) <= BRAM_PORT_1_DOUT(31 downto 0);
  Conn1_ADDR(31 downto 0) <= BRAM_PORT0_addr(31 downto 0);
  Conn1_CLK <= BRAM_PORT0_clk;
  Conn1_DIN(31 downto 0) <= BRAM_PORT0_din(31 downto 0);
  Conn1_EN <= BRAM_PORT0_en;
  Conn1_RST <= BRAM_PORT0_rst;
  Conn1_WE(3 downto 0) <= BRAM_PORT0_we(3 downto 0);
  invert_banks_0_2 <= invert_banks;
blk_mem_gen_0: component conv_accelerator_bd_blk_mem_gen_0_3
     port map (
      addra(31 downto 0) => bram_switch_0_BLK_MEM_PORTA0_ADDR(31 downto 0),
      clka => bram_switch_0_BLK_MEM_PORTA0_CLK,
      dina(31 downto 0) => bram_switch_0_BLK_MEM_PORTA0_DIN(31 downto 0),
      douta(31 downto 0) => bram_switch_0_BLK_MEM_PORTA0_DOUT(31 downto 0),
      ena => bram_switch_0_BLK_MEM_PORTA0_EN,
      rsta => bram_switch_0_BLK_MEM_PORTA0_RST,
      wea(3 downto 0) => bram_switch_0_BLK_MEM_PORTA0_WE(3 downto 0)
    );
blk_mem_gen_1: component conv_accelerator_bd_blk_mem_gen_1_3
     port map (
      addra(31 downto 0) => bram_switch_0_BLK_MEM_PORTA1_ADDR(31 downto 0),
      clka => bram_switch_0_BLK_MEM_PORTA1_CLK,
      dina(31 downto 0) => bram_switch_0_BLK_MEM_PORTA1_DIN(31 downto 0),
      douta(31 downto 0) => bram_switch_0_BLK_MEM_PORTA1_DOUT(31 downto 0),
      ena => bram_switch_0_BLK_MEM_PORTA1_EN,
      rsta => bram_switch_0_BLK_MEM_PORTA1_RST,
      wea(3 downto 0) => bram_switch_0_BLK_MEM_PORTA1_WE(3 downto 0)
    );
bram_switch_1: component conv_accelerator_bd_bram_switch_1_3
     port map (
      BLK_MEM_PORT0_addr(31 downto 0) => bram_switch_0_BLK_MEM_PORTA0_ADDR(31 downto 0),
      BLK_MEM_PORT0_clk => bram_switch_0_BLK_MEM_PORTA0_CLK,
      BLK_MEM_PORT0_din(31 downto 0) => bram_switch_0_BLK_MEM_PORTA0_DIN(31 downto 0),
      BLK_MEM_PORT0_dout(31 downto 0) => bram_switch_0_BLK_MEM_PORTA0_DOUT(31 downto 0),
      BLK_MEM_PORT0_en => bram_switch_0_BLK_MEM_PORTA0_EN,
      BLK_MEM_PORT0_rst => bram_switch_0_BLK_MEM_PORTA0_RST,
      BLK_MEM_PORT0_we(3 downto 0) => bram_switch_0_BLK_MEM_PORTA0_WE(3 downto 0),
      BLK_MEM_PORT1_addr(31 downto 0) => bram_switch_0_BLK_MEM_PORTA1_ADDR(31 downto 0),
      BLK_MEM_PORT1_clk => bram_switch_0_BLK_MEM_PORTA1_CLK,
      BLK_MEM_PORT1_din(31 downto 0) => bram_switch_0_BLK_MEM_PORTA1_DIN(31 downto 0),
      BLK_MEM_PORT1_dout(31 downto 0) => bram_switch_0_BLK_MEM_PORTA1_DOUT(31 downto 0),
      BLK_MEM_PORT1_en => bram_switch_0_BLK_MEM_PORTA1_EN,
      BLK_MEM_PORT1_rst => bram_switch_0_BLK_MEM_PORTA1_RST,
      BLK_MEM_PORT1_we(3 downto 0) => bram_switch_0_BLK_MEM_PORTA1_WE(3 downto 0),
      BRAM_PORT0_addr(31 downto 0) => Conn1_ADDR(31 downto 0),
      BRAM_PORT0_clk => Conn1_CLK,
      BRAM_PORT0_din(31 downto 0) => Conn1_DIN(31 downto 0),
      BRAM_PORT0_dout(31 downto 0) => Conn1_DOUT(31 downto 0),
      BRAM_PORT0_en => Conn1_EN,
      BRAM_PORT0_rst => Conn1_RST,
      BRAM_PORT0_we(3 downto 0) => Conn1_WE(3 downto 0),
      BRAM_PORT1_addr(31 downto 0) => BRAM_PORT_1_ADDR(31 downto 0),
      BRAM_PORT1_clk => BRAM_PORT_1_CLK,
      BRAM_PORT1_din(31 downto 0) => BRAM_PORT_1_DIN(31 downto 0),
      BRAM_PORT1_dout(31 downto 0) => BRAM_PORT_1_DOUT(31 downto 0),
      BRAM_PORT1_en => BRAM_PORT_1_EN,
      BRAM_PORT1_rst => BRAM_PORT_1_RST,
      BRAM_PORT1_we(3 downto 0) => BRAM_PORT_1_WE(3 downto 0),
      invert_banks => invert_banks_0_2
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bram_input_0_imp_1S46NXD is
  port (
    BRAM_INPUTS_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_INPUTS_clk : in STD_LOGIC;
    BRAM_INPUTS_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_INPUTS_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_INPUTS_en : in STD_LOGIC;
    BRAM_INPUTS_rst : in STD_LOGIC;
    BRAM_INPUTS_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    BRAM_OUTPUTS_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_OUTPUTS_clk : in STD_LOGIC;
    BRAM_OUTPUTS_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_OUTPUTS_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_OUTPUTS_en : in STD_LOGIC;
    BRAM_OUTPUTS_rst : in STD_LOGIC;
    BRAM_OUTPUTS_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    BRAM_PORT0_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT0_clk : in STD_LOGIC;
    BRAM_PORT0_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT0_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT0_en : in STD_LOGIC;
    BRAM_PORT0_rst : in STD_LOGIC;
    BRAM_PORT0_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    BRAM_PORT1_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT1_clk : in STD_LOGIC;
    BRAM_PORT1_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT1_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT1_en : in STD_LOGIC;
    BRAM_PORT1_rst : in STD_LOGIC;
    BRAM_PORT1_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    invert_banks : in STD_LOGIC;
    sel : in STD_LOGIC
  );
end bram_input_0_imp_1S46NXD;

architecture STRUCTURE of bram_input_0_imp_1S46NXD is
  component conv_accelerator_bd_blk_mem_gen_0_4 is
  port (
    clka : in STD_LOGIC;
    rsta : in STD_LOGIC;
    ena : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 3 downto 0 );
    addra : in STD_LOGIC_VECTOR ( 31 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 31 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component conv_accelerator_bd_blk_mem_gen_0_4;
  component conv_accelerator_bd_blk_mem_gen_1_4 is
  port (
    clka : in STD_LOGIC;
    rsta : in STD_LOGIC;
    ena : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 3 downto 0 );
    addra : in STD_LOGIC_VECTOR ( 31 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 31 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component conv_accelerator_bd_blk_mem_gen_1_4;
  component conv_accelerator_bd_bram_mux_0_0 is
  port (
    BRAM_PORT0_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT0_clk : in STD_LOGIC;
    BRAM_PORT0_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT0_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT0_en : in STD_LOGIC;
    BRAM_PORT0_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    BRAM_PORT0_rst : in STD_LOGIC;
    BRAM_PORT1_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT1_clk : in STD_LOGIC;
    BRAM_PORT1_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT1_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT1_en : in STD_LOGIC;
    BRAM_PORT1_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    BRAM_PORT1_rst : in STD_LOGIC;
    sel : in STD_LOGIC;
    BRAM_PORT_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT_clk : out STD_LOGIC;
    BRAM_PORT_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT_en : out STD_LOGIC;
    BRAM_PORT_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    BRAM_PORT_rst : out STD_LOGIC
  );
  end component conv_accelerator_bd_bram_mux_0_0;
  component conv_accelerator_bd_bram_mux_1_0 is
  port (
    BRAM_PORT0_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT0_clk : in STD_LOGIC;
    BRAM_PORT0_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT0_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT0_en : in STD_LOGIC;
    BRAM_PORT0_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    BRAM_PORT0_rst : in STD_LOGIC;
    BRAM_PORT1_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT1_clk : in STD_LOGIC;
    BRAM_PORT1_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT1_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT1_en : in STD_LOGIC;
    BRAM_PORT1_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    BRAM_PORT1_rst : in STD_LOGIC;
    sel : in STD_LOGIC;
    BRAM_PORT_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT_clk : out STD_LOGIC;
    BRAM_PORT_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT_en : out STD_LOGIC;
    BRAM_PORT_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    BRAM_PORT_rst : out STD_LOGIC
  );
  end component conv_accelerator_bd_bram_mux_1_0;
  component conv_accelerator_bd_bram_switch_1_4 is
  port (
    BRAM_PORT0_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT0_clk : in STD_LOGIC;
    BRAM_PORT0_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT0_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT0_en : in STD_LOGIC;
    BRAM_PORT0_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    BRAM_PORT0_rst : in STD_LOGIC;
    BRAM_PORT1_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT1_clk : in STD_LOGIC;
    BRAM_PORT1_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT1_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT1_en : in STD_LOGIC;
    BRAM_PORT1_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    BRAM_PORT1_rst : in STD_LOGIC;
    BLK_MEM_PORT0_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BLK_MEM_PORT0_clk : out STD_LOGIC;
    BLK_MEM_PORT0_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BLK_MEM_PORT0_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BLK_MEM_PORT0_en : out STD_LOGIC;
    BLK_MEM_PORT0_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    BLK_MEM_PORT0_rst : out STD_LOGIC;
    BLK_MEM_PORT1_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BLK_MEM_PORT1_clk : out STD_LOGIC;
    BLK_MEM_PORT1_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BLK_MEM_PORT1_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BLK_MEM_PORT1_en : out STD_LOGIC;
    BLK_MEM_PORT1_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    BLK_MEM_PORT1_rst : out STD_LOGIC;
    invert_banks : in STD_LOGIC
  );
  end component conv_accelerator_bd_bram_switch_1_4;
  signal BRAM_INPUTS_1_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_INPUTS_1_CLK : STD_LOGIC;
  signal BRAM_INPUTS_1_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_INPUTS_1_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_INPUTS_1_EN : STD_LOGIC;
  signal BRAM_INPUTS_1_RST : STD_LOGIC;
  signal BRAM_INPUTS_1_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal BRAM_OUTPUTS_1_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_OUTPUTS_1_CLK : STD_LOGIC;
  signal BRAM_OUTPUTS_1_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_OUTPUTS_1_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_OUTPUTS_1_EN : STD_LOGIC;
  signal BRAM_OUTPUTS_1_RST : STD_LOGIC;
  signal BRAM_OUTPUTS_1_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal Conn2_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal Conn2_CLK : STD_LOGIC;
  signal Conn2_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal Conn2_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal Conn2_EN : STD_LOGIC;
  signal Conn2_RST : STD_LOGIC;
  signal Conn2_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal Conn3_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal Conn3_CLK : STD_LOGIC;
  signal Conn3_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal Conn3_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal Conn3_EN : STD_LOGIC;
  signal Conn3_RST : STD_LOGIC;
  signal Conn3_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal Net : STD_LOGIC;
  signal bram_mux_0_BRAM_PORT_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_mux_0_BRAM_PORT_CLK : STD_LOGIC;
  signal bram_mux_0_BRAM_PORT_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_mux_0_BRAM_PORT_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_mux_0_BRAM_PORT_EN : STD_LOGIC;
  signal bram_mux_0_BRAM_PORT_RST : STD_LOGIC;
  signal bram_mux_0_BRAM_PORT_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal bram_mux_1_BRAM_PORT_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_mux_1_BRAM_PORT_CLK : STD_LOGIC;
  signal bram_mux_1_BRAM_PORT_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_mux_1_BRAM_PORT_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_mux_1_BRAM_PORT_EN : STD_LOGIC;
  signal bram_mux_1_BRAM_PORT_RST : STD_LOGIC;
  signal bram_mux_1_BRAM_PORT_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal bram_switch_1_BLK_MEM_PORT0_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_switch_1_BLK_MEM_PORT0_CLK : STD_LOGIC;
  signal bram_switch_1_BLK_MEM_PORT0_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_switch_1_BLK_MEM_PORT0_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_switch_1_BLK_MEM_PORT0_EN : STD_LOGIC;
  signal bram_switch_1_BLK_MEM_PORT0_RST : STD_LOGIC;
  signal bram_switch_1_BLK_MEM_PORT0_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal bram_switch_1_BLK_MEM_PORT1_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_switch_1_BLK_MEM_PORT1_CLK : STD_LOGIC;
  signal bram_switch_1_BLK_MEM_PORT1_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_switch_1_BLK_MEM_PORT1_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_switch_1_BLK_MEM_PORT1_EN : STD_LOGIC;
  signal bram_switch_1_BLK_MEM_PORT1_RST : STD_LOGIC;
  signal bram_switch_1_BLK_MEM_PORT1_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal invert_banks_0_2 : STD_LOGIC;
begin
  BRAM_INPUTS_1_ADDR(31 downto 0) <= BRAM_INPUTS_addr(31 downto 0);
  BRAM_INPUTS_1_CLK <= BRAM_INPUTS_clk;
  BRAM_INPUTS_1_DIN(31 downto 0) <= BRAM_INPUTS_din(31 downto 0);
  BRAM_INPUTS_1_EN <= BRAM_INPUTS_en;
  BRAM_INPUTS_1_RST <= BRAM_INPUTS_rst;
  BRAM_INPUTS_1_WE(3 downto 0) <= BRAM_INPUTS_we(3 downto 0);
  BRAM_INPUTS_dout(31 downto 0) <= BRAM_INPUTS_1_DOUT(31 downto 0);
  BRAM_OUTPUTS_1_ADDR(31 downto 0) <= BRAM_OUTPUTS_addr(31 downto 0);
  BRAM_OUTPUTS_1_CLK <= BRAM_OUTPUTS_clk;
  BRAM_OUTPUTS_1_DIN(31 downto 0) <= BRAM_OUTPUTS_din(31 downto 0);
  BRAM_OUTPUTS_1_EN <= BRAM_OUTPUTS_en;
  BRAM_OUTPUTS_1_RST <= BRAM_OUTPUTS_rst;
  BRAM_OUTPUTS_1_WE(3 downto 0) <= BRAM_OUTPUTS_we(3 downto 0);
  BRAM_OUTPUTS_dout(31 downto 0) <= BRAM_OUTPUTS_1_DOUT(31 downto 0);
  BRAM_PORT0_dout(31 downto 0) <= Conn2_DOUT(31 downto 0);
  BRAM_PORT1_dout(31 downto 0) <= Conn3_DOUT(31 downto 0);
  Conn2_ADDR(31 downto 0) <= BRAM_PORT0_addr(31 downto 0);
  Conn2_CLK <= BRAM_PORT0_clk;
  Conn2_DIN(31 downto 0) <= BRAM_PORT0_din(31 downto 0);
  Conn2_EN <= BRAM_PORT0_en;
  Conn2_RST <= BRAM_PORT0_rst;
  Conn2_WE(3 downto 0) <= BRAM_PORT0_we(3 downto 0);
  Conn3_ADDR(31 downto 0) <= BRAM_PORT1_addr(31 downto 0);
  Conn3_CLK <= BRAM_PORT1_clk;
  Conn3_DIN(31 downto 0) <= BRAM_PORT1_din(31 downto 0);
  Conn3_EN <= BRAM_PORT1_en;
  Conn3_RST <= BRAM_PORT1_rst;
  Conn3_WE(3 downto 0) <= BRAM_PORT1_we(3 downto 0);
  Net <= sel;
  invert_banks_0_2 <= invert_banks;
blk_mem_gen_0: component conv_accelerator_bd_blk_mem_gen_0_4
     port map (
      addra(31 downto 0) => bram_switch_1_BLK_MEM_PORT0_ADDR(31 downto 0),
      clka => bram_switch_1_BLK_MEM_PORT0_CLK,
      dina(31 downto 0) => bram_switch_1_BLK_MEM_PORT0_DIN(31 downto 0),
      douta(31 downto 0) => bram_switch_1_BLK_MEM_PORT0_DOUT(31 downto 0),
      ena => bram_switch_1_BLK_MEM_PORT0_EN,
      rsta => bram_switch_1_BLK_MEM_PORT0_RST,
      wea(3 downto 0) => bram_switch_1_BLK_MEM_PORT0_WE(3 downto 0)
    );
blk_mem_gen_1: component conv_accelerator_bd_blk_mem_gen_1_4
     port map (
      addra(31 downto 0) => bram_switch_1_BLK_MEM_PORT1_ADDR(31 downto 0),
      clka => bram_switch_1_BLK_MEM_PORT1_CLK,
      dina(31 downto 0) => bram_switch_1_BLK_MEM_PORT1_DIN(31 downto 0),
      douta(31 downto 0) => bram_switch_1_BLK_MEM_PORT1_DOUT(31 downto 0),
      ena => bram_switch_1_BLK_MEM_PORT1_EN,
      rsta => bram_switch_1_BLK_MEM_PORT1_RST,
      wea(3 downto 0) => bram_switch_1_BLK_MEM_PORT1_WE(3 downto 0)
    );
bram_mux_0: component conv_accelerator_bd_bram_mux_0_0
     port map (
      BRAM_PORT0_addr(31 downto 0) => Conn2_ADDR(31 downto 0),
      BRAM_PORT0_clk => Conn2_CLK,
      BRAM_PORT0_din(31 downto 0) => Conn2_DIN(31 downto 0),
      BRAM_PORT0_dout(31 downto 0) => Conn2_DOUT(31 downto 0),
      BRAM_PORT0_en => Conn2_EN,
      BRAM_PORT0_rst => Conn2_RST,
      BRAM_PORT0_we(3 downto 0) => Conn2_WE(3 downto 0),
      BRAM_PORT1_addr(31 downto 0) => BRAM_INPUTS_1_ADDR(31 downto 0),
      BRAM_PORT1_clk => BRAM_INPUTS_1_CLK,
      BRAM_PORT1_din(31 downto 0) => BRAM_INPUTS_1_DIN(31 downto 0),
      BRAM_PORT1_dout(31 downto 0) => BRAM_INPUTS_1_DOUT(31 downto 0),
      BRAM_PORT1_en => BRAM_INPUTS_1_EN,
      BRAM_PORT1_rst => BRAM_INPUTS_1_RST,
      BRAM_PORT1_we(3 downto 0) => BRAM_INPUTS_1_WE(3 downto 0),
      BRAM_PORT_addr(31 downto 0) => bram_mux_0_BRAM_PORT_ADDR(31 downto 0),
      BRAM_PORT_clk => bram_mux_0_BRAM_PORT_CLK,
      BRAM_PORT_din(31 downto 0) => bram_mux_0_BRAM_PORT_DIN(31 downto 0),
      BRAM_PORT_dout(31 downto 0) => bram_mux_0_BRAM_PORT_DOUT(31 downto 0),
      BRAM_PORT_en => bram_mux_0_BRAM_PORT_EN,
      BRAM_PORT_rst => bram_mux_0_BRAM_PORT_RST,
      BRAM_PORT_we(3 downto 0) => bram_mux_0_BRAM_PORT_WE(3 downto 0),
      sel => Net
    );
bram_mux_1: component conv_accelerator_bd_bram_mux_1_0
     port map (
      BRAM_PORT0_addr(31 downto 0) => Conn3_ADDR(31 downto 0),
      BRAM_PORT0_clk => Conn3_CLK,
      BRAM_PORT0_din(31 downto 0) => Conn3_DIN(31 downto 0),
      BRAM_PORT0_dout(31 downto 0) => Conn3_DOUT(31 downto 0),
      BRAM_PORT0_en => Conn3_EN,
      BRAM_PORT0_rst => Conn3_RST,
      BRAM_PORT0_we(3 downto 0) => Conn3_WE(3 downto 0),
      BRAM_PORT1_addr(31 downto 0) => BRAM_OUTPUTS_1_ADDR(31 downto 0),
      BRAM_PORT1_clk => BRAM_OUTPUTS_1_CLK,
      BRAM_PORT1_din(31 downto 0) => BRAM_OUTPUTS_1_DIN(31 downto 0),
      BRAM_PORT1_dout(31 downto 0) => BRAM_OUTPUTS_1_DOUT(31 downto 0),
      BRAM_PORT1_en => BRAM_OUTPUTS_1_EN,
      BRAM_PORT1_rst => BRAM_OUTPUTS_1_RST,
      BRAM_PORT1_we(3 downto 0) => BRAM_OUTPUTS_1_WE(3 downto 0),
      BRAM_PORT_addr(31 downto 0) => bram_mux_1_BRAM_PORT_ADDR(31 downto 0),
      BRAM_PORT_clk => bram_mux_1_BRAM_PORT_CLK,
      BRAM_PORT_din(31 downto 0) => bram_mux_1_BRAM_PORT_DIN(31 downto 0),
      BRAM_PORT_dout(31 downto 0) => bram_mux_1_BRAM_PORT_DOUT(31 downto 0),
      BRAM_PORT_en => bram_mux_1_BRAM_PORT_EN,
      BRAM_PORT_rst => bram_mux_1_BRAM_PORT_RST,
      BRAM_PORT_we(3 downto 0) => bram_mux_1_BRAM_PORT_WE(3 downto 0),
      sel => Net
    );
bram_switch_1: component conv_accelerator_bd_bram_switch_1_4
     port map (
      BLK_MEM_PORT0_addr(31 downto 0) => bram_switch_1_BLK_MEM_PORT0_ADDR(31 downto 0),
      BLK_MEM_PORT0_clk => bram_switch_1_BLK_MEM_PORT0_CLK,
      BLK_MEM_PORT0_din(31 downto 0) => bram_switch_1_BLK_MEM_PORT0_DIN(31 downto 0),
      BLK_MEM_PORT0_dout(31 downto 0) => bram_switch_1_BLK_MEM_PORT0_DOUT(31 downto 0),
      BLK_MEM_PORT0_en => bram_switch_1_BLK_MEM_PORT0_EN,
      BLK_MEM_PORT0_rst => bram_switch_1_BLK_MEM_PORT0_RST,
      BLK_MEM_PORT0_we(3 downto 0) => bram_switch_1_BLK_MEM_PORT0_WE(3 downto 0),
      BLK_MEM_PORT1_addr(31 downto 0) => bram_switch_1_BLK_MEM_PORT1_ADDR(31 downto 0),
      BLK_MEM_PORT1_clk => bram_switch_1_BLK_MEM_PORT1_CLK,
      BLK_MEM_PORT1_din(31 downto 0) => bram_switch_1_BLK_MEM_PORT1_DIN(31 downto 0),
      BLK_MEM_PORT1_dout(31 downto 0) => bram_switch_1_BLK_MEM_PORT1_DOUT(31 downto 0),
      BLK_MEM_PORT1_en => bram_switch_1_BLK_MEM_PORT1_EN,
      BLK_MEM_PORT1_rst => bram_switch_1_BLK_MEM_PORT1_RST,
      BLK_MEM_PORT1_we(3 downto 0) => bram_switch_1_BLK_MEM_PORT1_WE(3 downto 0),
      BRAM_PORT0_addr(31 downto 0) => bram_mux_0_BRAM_PORT_ADDR(31 downto 0),
      BRAM_PORT0_clk => bram_mux_0_BRAM_PORT_CLK,
      BRAM_PORT0_din(31 downto 0) => bram_mux_0_BRAM_PORT_DIN(31 downto 0),
      BRAM_PORT0_dout(31 downto 0) => bram_mux_0_BRAM_PORT_DOUT(31 downto 0),
      BRAM_PORT0_en => bram_mux_0_BRAM_PORT_EN,
      BRAM_PORT0_rst => bram_mux_0_BRAM_PORT_RST,
      BRAM_PORT0_we(3 downto 0) => bram_mux_0_BRAM_PORT_WE(3 downto 0),
      BRAM_PORT1_addr(31 downto 0) => bram_mux_1_BRAM_PORT_ADDR(31 downto 0),
      BRAM_PORT1_clk => bram_mux_1_BRAM_PORT_CLK,
      BRAM_PORT1_din(31 downto 0) => bram_mux_1_BRAM_PORT_DIN(31 downto 0),
      BRAM_PORT1_dout(31 downto 0) => bram_mux_1_BRAM_PORT_DOUT(31 downto 0),
      BRAM_PORT1_en => bram_mux_1_BRAM_PORT_EN,
      BRAM_PORT1_rst => bram_mux_1_BRAM_PORT_RST,
      BRAM_PORT1_we(3 downto 0) => bram_mux_1_BRAM_PORT_WE(3 downto 0),
      invert_banks => invert_banks_0_2
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bram_imp_1FWG8IU is
  port (
    BRAM_PORT_FILTER_0_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT_FILTER_0_clk : in STD_LOGIC;
    BRAM_PORT_FILTER_0_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT_FILTER_0_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT_FILTER_0_en : in STD_LOGIC;
    BRAM_PORT_FILTER_0_rst : in STD_LOGIC;
    BRAM_PORT_FILTER_0_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    BRAM_PORT_FILTER_1_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT_FILTER_1_clk : in STD_LOGIC;
    BRAM_PORT_FILTER_1_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT_FILTER_1_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT_FILTER_1_en : in STD_LOGIC;
    BRAM_PORT_FILTER_1_rst : in STD_LOGIC;
    BRAM_PORT_FILTER_1_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    BRAM_PORT_FILTER_2_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT_FILTER_2_clk : in STD_LOGIC;
    BRAM_PORT_FILTER_2_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT_FILTER_2_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT_FILTER_2_en : in STD_LOGIC;
    BRAM_PORT_FILTER_2_rst : in STD_LOGIC;
    BRAM_PORT_FILTER_2_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    BRAM_PORT_FILTER_3_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT_FILTER_3_clk : in STD_LOGIC;
    BRAM_PORT_FILTER_3_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT_FILTER_3_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT_FILTER_3_en : in STD_LOGIC;
    BRAM_PORT_FILTER_3_rst : in STD_LOGIC;
    BRAM_PORT_FILTER_3_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    BRAM_PORT_INPUT_0_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT_INPUT_0_clk : in STD_LOGIC;
    BRAM_PORT_INPUT_0_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT_INPUT_0_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT_INPUT_0_en : in STD_LOGIC;
    BRAM_PORT_INPUT_0_rst : in STD_LOGIC;
    BRAM_PORT_INPUT_0_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    BRAM_PORT_OUTPUT_0_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT_OUTPUT_0_clk : in STD_LOGIC;
    BRAM_PORT_OUTPUT_0_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT_OUTPUT_0_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORT_OUTPUT_0_en : in STD_LOGIC;
    BRAM_PORT_OUTPUT_0_rst : in STD_LOGIC;
    BRAM_PORT_OUTPUT_0_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_BRAM_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_BRAM_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_BRAM_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_BRAM_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXI_BRAM_arlock : in STD_LOGIC;
    S_AXI_BRAM_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_BRAM_arready : out STD_LOGIC;
    S_AXI_BRAM_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_BRAM_arvalid : in STD_LOGIC;
    S_AXI_BRAM_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_BRAM_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_BRAM_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_BRAM_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXI_BRAM_awlock : in STD_LOGIC;
    S_AXI_BRAM_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_BRAM_awready : out STD_LOGIC;
    S_AXI_BRAM_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_BRAM_awvalid : in STD_LOGIC;
    S_AXI_BRAM_bready : in STD_LOGIC;
    S_AXI_BRAM_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_BRAM_bvalid : out STD_LOGIC;
    S_AXI_BRAM_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_BRAM_rlast : out STD_LOGIC;
    S_AXI_BRAM_rready : in STD_LOGIC;
    S_AXI_BRAM_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_BRAM_rvalid : out STD_LOGIC;
    S_AXI_BRAM_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_BRAM_wlast : in STD_LOGIC;
    S_AXI_BRAM_wready : out STD_LOGIC;
    S_AXI_BRAM_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_BRAM_wvalid : in STD_LOGIC;
    aclk_0 : in STD_LOGIC;
    aresetn_0 : in STD_LOGIC;
    invert_activations : in STD_LOGIC;
    invert_filters : in STD_LOGIC;
    sel : in STD_LOGIC
  );
end bram_imp_1FWG8IU;

architecture STRUCTURE of bram_imp_1FWG8IU is
  component conv_accelerator_bd_axi_bram_ctrl_0 is
  port (
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 18 downto 0 );
    s_axi_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awlock : in STD_LOGIC;
    s_axi_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wlast : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 18 downto 0 );
    s_axi_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arlock : in STD_LOGIC;
    s_axi_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rlast : out STD_LOGIC;
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    bram_rst_a : out STD_LOGIC;
    bram_clk_a : out STD_LOGIC;
    bram_en_a : out STD_LOGIC;
    bram_we_a : out STD_LOGIC_VECTOR ( 3 downto 0 );
    bram_addr_a : out STD_LOGIC_VECTOR ( 18 downto 0 );
    bram_wrdata_a : out STD_LOGIC_VECTOR ( 31 downto 0 );
    bram_rddata_a : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component conv_accelerator_bd_axi_bram_ctrl_0;
  component conv_accelerator_bd_bram_connect_0_0 is
  port (
    M_BRAM0_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM0_clk : out STD_LOGIC;
    M_BRAM0_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM0_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM0_en : out STD_LOGIC;
    M_BRAM0_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_BRAM0_rst : out STD_LOGIC;
    M_BRAM1_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM1_clk : out STD_LOGIC;
    M_BRAM1_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM1_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM1_en : out STD_LOGIC;
    M_BRAM1_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_BRAM1_rst : out STD_LOGIC;
    S_BRAM_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_BRAM_clk : in STD_LOGIC;
    S_BRAM_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_BRAM_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_BRAM_en : in STD_LOGIC;
    S_BRAM_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_BRAM_rst : in STD_LOGIC
  );
  end component conv_accelerator_bd_bram_connect_0_0;
  component conv_accelerator_bd_bram_connect_1_0 is
  port (
    M_BRAM0_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM0_clk : out STD_LOGIC;
    M_BRAM0_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM0_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM0_en : out STD_LOGIC;
    M_BRAM0_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_BRAM0_rst : out STD_LOGIC;
    M_BRAM1_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM1_clk : out STD_LOGIC;
    M_BRAM1_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM1_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM1_en : out STD_LOGIC;
    M_BRAM1_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_BRAM1_rst : out STD_LOGIC;
    S_BRAM_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_BRAM_clk : in STD_LOGIC;
    S_BRAM_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_BRAM_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_BRAM_en : in STD_LOGIC;
    S_BRAM_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_BRAM_rst : in STD_LOGIC
  );
  end component conv_accelerator_bd_bram_connect_1_0;
  component conv_accelerator_bd_bram_connect_2_0 is
  port (
    M_BRAM0_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM0_clk : out STD_LOGIC;
    M_BRAM0_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM0_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM0_en : out STD_LOGIC;
    M_BRAM0_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_BRAM0_rst : out STD_LOGIC;
    M_BRAM1_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM1_clk : out STD_LOGIC;
    M_BRAM1_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM1_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM1_en : out STD_LOGIC;
    M_BRAM1_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_BRAM1_rst : out STD_LOGIC;
    S_BRAM_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_BRAM_clk : in STD_LOGIC;
    S_BRAM_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_BRAM_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_BRAM_en : in STD_LOGIC;
    S_BRAM_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_BRAM_rst : in STD_LOGIC
  );
  end component conv_accelerator_bd_bram_connect_2_0;
  component conv_accelerator_bd_bram_connect_3_0 is
  port (
    M_BRAM0_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM0_clk : out STD_LOGIC;
    M_BRAM0_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM0_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM0_en : out STD_LOGIC;
    M_BRAM0_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_BRAM0_rst : out STD_LOGIC;
    M_BRAM1_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM1_clk : out STD_LOGIC;
    M_BRAM1_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM1_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM1_en : out STD_LOGIC;
    M_BRAM1_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_BRAM1_rst : out STD_LOGIC;
    S_BRAM_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_BRAM_clk : in STD_LOGIC;
    S_BRAM_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_BRAM_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_BRAM_en : in STD_LOGIC;
    S_BRAM_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_BRAM_rst : in STD_LOGIC
  );
  end component conv_accelerator_bd_bram_connect_3_0;
  component conv_accelerator_bd_bram_connect_4_0 is
  port (
    M_BRAM0_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM0_clk : out STD_LOGIC;
    M_BRAM0_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM0_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM0_en : out STD_LOGIC;
    M_BRAM0_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_BRAM0_rst : out STD_LOGIC;
    M_BRAM1_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM1_clk : out STD_LOGIC;
    M_BRAM1_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM1_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM1_en : out STD_LOGIC;
    M_BRAM1_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_BRAM1_rst : out STD_LOGIC;
    S_BRAM_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_BRAM_clk : in STD_LOGIC;
    S_BRAM_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_BRAM_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_BRAM_en : in STD_LOGIC;
    S_BRAM_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_BRAM_rst : in STD_LOGIC
  );
  end component conv_accelerator_bd_bram_connect_4_0;
  component conv_accelerator_bd_bram_read_delay_0_0 is
  port (
    M_BRAM_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM_clk : in STD_LOGIC;
    M_BRAM_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM_en : in STD_LOGIC;
    M_BRAM_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    M_BRAM_rst : in STD_LOGIC;
    S_BRAM_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_BRAM_clk : out STD_LOGIC;
    S_BRAM_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_BRAM_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_BRAM_en : out STD_LOGIC;
    S_BRAM_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    S_BRAM_rst : out STD_LOGIC
  );
  end component conv_accelerator_bd_bram_read_delay_0_0;
  component conv_accelerator_bd_bram_read_delay_1_0 is
  port (
    M_BRAM_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM_clk : in STD_LOGIC;
    M_BRAM_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM_en : in STD_LOGIC;
    M_BRAM_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    M_BRAM_rst : in STD_LOGIC;
    S_BRAM_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_BRAM_clk : out STD_LOGIC;
    S_BRAM_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_BRAM_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_BRAM_en : out STD_LOGIC;
    S_BRAM_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    S_BRAM_rst : out STD_LOGIC
  );
  end component conv_accelerator_bd_bram_read_delay_1_0;
  component conv_accelerator_bd_bram_read_delay_2_0 is
  port (
    M_BRAM_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM_clk : in STD_LOGIC;
    M_BRAM_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM_en : in STD_LOGIC;
    M_BRAM_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    M_BRAM_rst : in STD_LOGIC;
    S_BRAM_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_BRAM_clk : out STD_LOGIC;
    S_BRAM_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_BRAM_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_BRAM_en : out STD_LOGIC;
    S_BRAM_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    S_BRAM_rst : out STD_LOGIC
  );
  end component conv_accelerator_bd_bram_read_delay_2_0;
  component conv_accelerator_bd_bram_read_delay_3_0 is
  port (
    M_BRAM_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM_clk : in STD_LOGIC;
    M_BRAM_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM_en : in STD_LOGIC;
    M_BRAM_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    M_BRAM_rst : in STD_LOGIC;
    S_BRAM_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_BRAM_clk : out STD_LOGIC;
    S_BRAM_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_BRAM_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_BRAM_en : out STD_LOGIC;
    S_BRAM_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    S_BRAM_rst : out STD_LOGIC
  );
  end component conv_accelerator_bd_bram_read_delay_3_0;
  component conv_accelerator_bd_bram_read_delay_4_0 is
  port (
    M_BRAM_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM_clk : in STD_LOGIC;
    M_BRAM_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM_en : in STD_LOGIC;
    M_BRAM_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    M_BRAM_rst : in STD_LOGIC;
    S_BRAM_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_BRAM_clk : out STD_LOGIC;
    S_BRAM_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_BRAM_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_BRAM_en : out STD_LOGIC;
    S_BRAM_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    S_BRAM_rst : out STD_LOGIC
  );
  end component conv_accelerator_bd_bram_read_delay_4_0;
  component conv_accelerator_bd_bram_read_delay_5_0 is
  port (
    M_BRAM_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM_clk : in STD_LOGIC;
    M_BRAM_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_BRAM_en : in STD_LOGIC;
    M_BRAM_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    M_BRAM_rst : in STD_LOGIC;
    S_BRAM_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_BRAM_clk : out STD_LOGIC;
    S_BRAM_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_BRAM_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_BRAM_en : out STD_LOGIC;
    S_BRAM_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    S_BRAM_rst : out STD_LOGIC
  );
  end component conv_accelerator_bd_bram_read_delay_5_0;
  signal BRAM_PORT_FILTER_0_1_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_PORT_FILTER_0_1_CLK : STD_LOGIC;
  signal BRAM_PORT_FILTER_0_1_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_PORT_FILTER_0_1_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_PORT_FILTER_0_1_EN : STD_LOGIC;
  signal BRAM_PORT_FILTER_0_1_RST : STD_LOGIC;
  signal BRAM_PORT_FILTER_0_1_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal BRAM_PORT_FILTER_1_1_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_PORT_FILTER_1_1_CLK : STD_LOGIC;
  signal BRAM_PORT_FILTER_1_1_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_PORT_FILTER_1_1_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_PORT_FILTER_1_1_EN : STD_LOGIC;
  signal BRAM_PORT_FILTER_1_1_RST : STD_LOGIC;
  signal BRAM_PORT_FILTER_1_1_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal BRAM_PORT_FILTER_2_1_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_PORT_FILTER_2_1_CLK : STD_LOGIC;
  signal BRAM_PORT_FILTER_2_1_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_PORT_FILTER_2_1_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_PORT_FILTER_2_1_EN : STD_LOGIC;
  signal BRAM_PORT_FILTER_2_1_RST : STD_LOGIC;
  signal BRAM_PORT_FILTER_2_1_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal BRAM_PORT_FILTER_3_1_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_PORT_FILTER_3_1_CLK : STD_LOGIC;
  signal BRAM_PORT_FILTER_3_1_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_PORT_FILTER_3_1_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_PORT_FILTER_3_1_EN : STD_LOGIC;
  signal BRAM_PORT_FILTER_3_1_RST : STD_LOGIC;
  signal BRAM_PORT_FILTER_3_1_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal BRAM_PORT_INPUT_0_1_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_PORT_INPUT_0_1_CLK : STD_LOGIC;
  signal BRAM_PORT_INPUT_0_1_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_PORT_INPUT_0_1_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_PORT_INPUT_0_1_EN : STD_LOGIC;
  signal BRAM_PORT_INPUT_0_1_RST : STD_LOGIC;
  signal BRAM_PORT_INPUT_0_1_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal BRAM_PORT_OUTPUT_0_1_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_PORT_OUTPUT_0_1_CLK : STD_LOGIC;
  signal BRAM_PORT_OUTPUT_0_1_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_PORT_OUTPUT_0_1_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_PORT_OUTPUT_0_1_EN : STD_LOGIC;
  signal BRAM_PORT_OUTPUT_0_1_RST : STD_LOGIC;
  signal BRAM_PORT_OUTPUT_0_1_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal aclk_0_1 : STD_LOGIC;
  signal aresetn_0_1 : STD_LOGIC;
  signal axi_bram_ctrl_BRAM_PORTA_ADDR : STD_LOGIC_VECTOR ( 18 downto 0 );
  signal axi_bram_ctrl_BRAM_PORTA_CLK : STD_LOGIC;
  signal axi_bram_ctrl_BRAM_PORTA_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_bram_ctrl_BRAM_PORTA_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_bram_ctrl_BRAM_PORTA_EN : STD_LOGIC;
  signal axi_bram_ctrl_BRAM_PORTA_RST : STD_LOGIC;
  signal axi_bram_ctrl_BRAM_PORTA_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_register_slice_2_M_AXI_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_register_slice_2_M_AXI_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_register_slice_2_M_AXI_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_register_slice_2_M_AXI_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axi_register_slice_2_M_AXI_ARLOCK : STD_LOGIC;
  signal axi_register_slice_2_M_AXI_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_register_slice_2_M_AXI_ARREADY : STD_LOGIC;
  signal axi_register_slice_2_M_AXI_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_register_slice_2_M_AXI_ARVALID : STD_LOGIC;
  signal axi_register_slice_2_M_AXI_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_register_slice_2_M_AXI_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_register_slice_2_M_AXI_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_register_slice_2_M_AXI_AWLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axi_register_slice_2_M_AXI_AWLOCK : STD_LOGIC;
  signal axi_register_slice_2_M_AXI_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_register_slice_2_M_AXI_AWREADY : STD_LOGIC;
  signal axi_register_slice_2_M_AXI_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_register_slice_2_M_AXI_AWVALID : STD_LOGIC;
  signal axi_register_slice_2_M_AXI_BREADY : STD_LOGIC;
  signal axi_register_slice_2_M_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_register_slice_2_M_AXI_BVALID : STD_LOGIC;
  signal axi_register_slice_2_M_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_register_slice_2_M_AXI_RLAST : STD_LOGIC;
  signal axi_register_slice_2_M_AXI_RREADY : STD_LOGIC;
  signal axi_register_slice_2_M_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_register_slice_2_M_AXI_RVALID : STD_LOGIC;
  signal axi_register_slice_2_M_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_register_slice_2_M_AXI_WLAST : STD_LOGIC;
  signal axi_register_slice_2_M_AXI_WREADY : STD_LOGIC;
  signal axi_register_slice_2_M_AXI_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_register_slice_2_M_AXI_WVALID : STD_LOGIC;
  signal bram_connect_0_M_BRAM0_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_connect_0_M_BRAM0_CLK : STD_LOGIC;
  signal bram_connect_0_M_BRAM0_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_connect_0_M_BRAM0_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_connect_0_M_BRAM0_EN : STD_LOGIC;
  signal bram_connect_0_M_BRAM0_RST : STD_LOGIC;
  signal bram_connect_0_M_BRAM0_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal bram_connect_0_M_BRAM1_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_connect_0_M_BRAM1_CLK : STD_LOGIC;
  signal bram_connect_0_M_BRAM1_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_connect_0_M_BRAM1_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_connect_0_M_BRAM1_EN : STD_LOGIC;
  signal bram_connect_0_M_BRAM1_RST : STD_LOGIC;
  signal bram_connect_0_M_BRAM1_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal bram_connect_1_M_BRAM0_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_connect_1_M_BRAM0_CLK : STD_LOGIC;
  signal bram_connect_1_M_BRAM0_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_connect_1_M_BRAM0_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_connect_1_M_BRAM0_EN : STD_LOGIC;
  signal bram_connect_1_M_BRAM0_RST : STD_LOGIC;
  signal bram_connect_1_M_BRAM0_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal bram_connect_1_M_BRAM1_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_connect_1_M_BRAM1_CLK : STD_LOGIC;
  signal bram_connect_1_M_BRAM1_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_connect_1_M_BRAM1_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_connect_1_M_BRAM1_EN : STD_LOGIC;
  signal bram_connect_1_M_BRAM1_RST : STD_LOGIC;
  signal bram_connect_1_M_BRAM1_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal bram_connect_2_M_BRAM0_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_connect_2_M_BRAM0_CLK : STD_LOGIC;
  signal bram_connect_2_M_BRAM0_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_connect_2_M_BRAM0_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_connect_2_M_BRAM0_EN : STD_LOGIC;
  signal bram_connect_2_M_BRAM0_RST : STD_LOGIC;
  signal bram_connect_2_M_BRAM0_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal bram_connect_2_M_BRAM1_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_connect_2_M_BRAM1_CLK : STD_LOGIC;
  signal bram_connect_2_M_BRAM1_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_connect_2_M_BRAM1_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_connect_2_M_BRAM1_EN : STD_LOGIC;
  signal bram_connect_2_M_BRAM1_RST : STD_LOGIC;
  signal bram_connect_2_M_BRAM1_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal bram_connect_3_M_BRAM0_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_connect_3_M_BRAM0_CLK : STD_LOGIC;
  signal bram_connect_3_M_BRAM0_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_connect_3_M_BRAM0_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_connect_3_M_BRAM0_EN : STD_LOGIC;
  signal bram_connect_3_M_BRAM0_RST : STD_LOGIC;
  signal bram_connect_3_M_BRAM0_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal bram_connect_3_M_BRAM1_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_connect_3_M_BRAM1_CLK : STD_LOGIC;
  signal bram_connect_3_M_BRAM1_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_connect_3_M_BRAM1_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_connect_3_M_BRAM1_EN : STD_LOGIC;
  signal bram_connect_3_M_BRAM1_RST : STD_LOGIC;
  signal bram_connect_3_M_BRAM1_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal bram_connect_4_M_BRAM0_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_connect_4_M_BRAM0_CLK : STD_LOGIC;
  signal bram_connect_4_M_BRAM0_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_connect_4_M_BRAM0_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_connect_4_M_BRAM0_EN : STD_LOGIC;
  signal bram_connect_4_M_BRAM0_RST : STD_LOGIC;
  signal bram_connect_4_M_BRAM0_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal bram_connect_4_M_BRAM1_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_connect_4_M_BRAM1_CLK : STD_LOGIC;
  signal bram_connect_4_M_BRAM1_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_connect_4_M_BRAM1_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_connect_4_M_BRAM1_EN : STD_LOGIC;
  signal bram_connect_4_M_BRAM1_RST : STD_LOGIC;
  signal bram_connect_4_M_BRAM1_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal bram_read_delay_0_S_BRAM_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_read_delay_0_S_BRAM_CLK : STD_LOGIC;
  signal bram_read_delay_0_S_BRAM_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_read_delay_0_S_BRAM_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_read_delay_0_S_BRAM_EN : STD_LOGIC;
  signal bram_read_delay_0_S_BRAM_RST : STD_LOGIC;
  signal bram_read_delay_0_S_BRAM_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal bram_read_delay_1_S_BRAM_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_read_delay_1_S_BRAM_CLK : STD_LOGIC;
  signal bram_read_delay_1_S_BRAM_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_read_delay_1_S_BRAM_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_read_delay_1_S_BRAM_EN : STD_LOGIC;
  signal bram_read_delay_1_S_BRAM_RST : STD_LOGIC;
  signal bram_read_delay_1_S_BRAM_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal bram_read_delay_2_S_BRAM_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_read_delay_2_S_BRAM_CLK : STD_LOGIC;
  signal bram_read_delay_2_S_BRAM_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_read_delay_2_S_BRAM_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_read_delay_2_S_BRAM_EN : STD_LOGIC;
  signal bram_read_delay_2_S_BRAM_RST : STD_LOGIC;
  signal bram_read_delay_2_S_BRAM_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal bram_read_delay_3_S_BRAM_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_read_delay_3_S_BRAM_CLK : STD_LOGIC;
  signal bram_read_delay_3_S_BRAM_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_read_delay_3_S_BRAM_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_read_delay_3_S_BRAM_EN : STD_LOGIC;
  signal bram_read_delay_3_S_BRAM_RST : STD_LOGIC;
  signal bram_read_delay_3_S_BRAM_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal bram_read_delay_4_S_BRAM_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_read_delay_4_S_BRAM_CLK : STD_LOGIC;
  signal bram_read_delay_4_S_BRAM_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_read_delay_4_S_BRAM_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_read_delay_4_S_BRAM_EN : STD_LOGIC;
  signal bram_read_delay_4_S_BRAM_RST : STD_LOGIC;
  signal bram_read_delay_4_S_BRAM_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal bram_read_delay_5_S_BRAM_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_read_delay_5_S_BRAM_CLK : STD_LOGIC;
  signal bram_read_delay_5_S_BRAM_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_read_delay_5_S_BRAM_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal bram_read_delay_5_S_BRAM_EN : STD_LOGIC;
  signal bram_read_delay_5_S_BRAM_RST : STD_LOGIC;
  signal bram_read_delay_5_S_BRAM_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal invert_banks_1 : STD_LOGIC;
  signal invert_banks_2 : STD_LOGIC;
  signal sel_1 : STD_LOGIC;
begin
  BRAM_PORT_FILTER_0_1_ADDR(31 downto 0) <= BRAM_PORT_FILTER_0_addr(31 downto 0);
  BRAM_PORT_FILTER_0_1_CLK <= BRAM_PORT_FILTER_0_clk;
  BRAM_PORT_FILTER_0_1_DIN(31 downto 0) <= BRAM_PORT_FILTER_0_din(31 downto 0);
  BRAM_PORT_FILTER_0_1_EN <= BRAM_PORT_FILTER_0_en;
  BRAM_PORT_FILTER_0_1_RST <= BRAM_PORT_FILTER_0_rst;
  BRAM_PORT_FILTER_0_1_WE(3 downto 0) <= BRAM_PORT_FILTER_0_we(3 downto 0);
  BRAM_PORT_FILTER_0_dout(31 downto 0) <= BRAM_PORT_FILTER_0_1_DOUT(31 downto 0);
  BRAM_PORT_FILTER_1_1_ADDR(31 downto 0) <= BRAM_PORT_FILTER_1_addr(31 downto 0);
  BRAM_PORT_FILTER_1_1_CLK <= BRAM_PORT_FILTER_1_clk;
  BRAM_PORT_FILTER_1_1_DIN(31 downto 0) <= BRAM_PORT_FILTER_1_din(31 downto 0);
  BRAM_PORT_FILTER_1_1_EN <= BRAM_PORT_FILTER_1_en;
  BRAM_PORT_FILTER_1_1_RST <= BRAM_PORT_FILTER_1_rst;
  BRAM_PORT_FILTER_1_1_WE(3 downto 0) <= BRAM_PORT_FILTER_1_we(3 downto 0);
  BRAM_PORT_FILTER_1_dout(31 downto 0) <= BRAM_PORT_FILTER_1_1_DOUT(31 downto 0);
  BRAM_PORT_FILTER_2_1_ADDR(31 downto 0) <= BRAM_PORT_FILTER_2_addr(31 downto 0);
  BRAM_PORT_FILTER_2_1_CLK <= BRAM_PORT_FILTER_2_clk;
  BRAM_PORT_FILTER_2_1_DIN(31 downto 0) <= BRAM_PORT_FILTER_2_din(31 downto 0);
  BRAM_PORT_FILTER_2_1_EN <= BRAM_PORT_FILTER_2_en;
  BRAM_PORT_FILTER_2_1_RST <= BRAM_PORT_FILTER_2_rst;
  BRAM_PORT_FILTER_2_1_WE(3 downto 0) <= BRAM_PORT_FILTER_2_we(3 downto 0);
  BRAM_PORT_FILTER_2_dout(31 downto 0) <= BRAM_PORT_FILTER_2_1_DOUT(31 downto 0);
  BRAM_PORT_FILTER_3_1_ADDR(31 downto 0) <= BRAM_PORT_FILTER_3_addr(31 downto 0);
  BRAM_PORT_FILTER_3_1_CLK <= BRAM_PORT_FILTER_3_clk;
  BRAM_PORT_FILTER_3_1_DIN(31 downto 0) <= BRAM_PORT_FILTER_3_din(31 downto 0);
  BRAM_PORT_FILTER_3_1_EN <= BRAM_PORT_FILTER_3_en;
  BRAM_PORT_FILTER_3_1_RST <= BRAM_PORT_FILTER_3_rst;
  BRAM_PORT_FILTER_3_1_WE(3 downto 0) <= BRAM_PORT_FILTER_3_we(3 downto 0);
  BRAM_PORT_FILTER_3_dout(31 downto 0) <= BRAM_PORT_FILTER_3_1_DOUT(31 downto 0);
  BRAM_PORT_INPUT_0_1_ADDR(31 downto 0) <= BRAM_PORT_OUTPUT_0_addr(31 downto 0);
  BRAM_PORT_INPUT_0_1_CLK <= BRAM_PORT_OUTPUT_0_clk;
  BRAM_PORT_INPUT_0_1_DIN(31 downto 0) <= BRAM_PORT_OUTPUT_0_din(31 downto 0);
  BRAM_PORT_INPUT_0_1_EN <= BRAM_PORT_OUTPUT_0_en;
  BRAM_PORT_INPUT_0_1_RST <= BRAM_PORT_OUTPUT_0_rst;
  BRAM_PORT_INPUT_0_1_WE(3 downto 0) <= BRAM_PORT_OUTPUT_0_we(3 downto 0);
  BRAM_PORT_INPUT_0_dout(31 downto 0) <= BRAM_PORT_OUTPUT_0_1_DOUT(31 downto 0);
  BRAM_PORT_OUTPUT_0_1_ADDR(31 downto 0) <= BRAM_PORT_INPUT_0_addr(31 downto 0);
  BRAM_PORT_OUTPUT_0_1_CLK <= BRAM_PORT_INPUT_0_clk;
  BRAM_PORT_OUTPUT_0_1_DIN(31 downto 0) <= BRAM_PORT_INPUT_0_din(31 downto 0);
  BRAM_PORT_OUTPUT_0_1_EN <= BRAM_PORT_INPUT_0_en;
  BRAM_PORT_OUTPUT_0_1_RST <= BRAM_PORT_INPUT_0_rst;
  BRAM_PORT_OUTPUT_0_1_WE(3 downto 0) <= BRAM_PORT_INPUT_0_we(3 downto 0);
  BRAM_PORT_OUTPUT_0_dout(31 downto 0) <= BRAM_PORT_INPUT_0_1_DOUT(31 downto 0);
  S_AXI_BRAM_arready <= axi_register_slice_2_M_AXI_ARREADY;
  S_AXI_BRAM_awready <= axi_register_slice_2_M_AXI_AWREADY;
  S_AXI_BRAM_bresp(1 downto 0) <= axi_register_slice_2_M_AXI_BRESP(1 downto 0);
  S_AXI_BRAM_bvalid <= axi_register_slice_2_M_AXI_BVALID;
  S_AXI_BRAM_rdata(31 downto 0) <= axi_register_slice_2_M_AXI_RDATA(31 downto 0);
  S_AXI_BRAM_rlast <= axi_register_slice_2_M_AXI_RLAST;
  S_AXI_BRAM_rresp(1 downto 0) <= axi_register_slice_2_M_AXI_RRESP(1 downto 0);
  S_AXI_BRAM_rvalid <= axi_register_slice_2_M_AXI_RVALID;
  S_AXI_BRAM_wready <= axi_register_slice_2_M_AXI_WREADY;
  aclk_0_1 <= aclk_0;
  aresetn_0_1 <= aresetn_0;
  axi_register_slice_2_M_AXI_ARADDR(31 downto 0) <= S_AXI_BRAM_araddr(31 downto 0);
  axi_register_slice_2_M_AXI_ARBURST(1 downto 0) <= S_AXI_BRAM_arburst(1 downto 0);
  axi_register_slice_2_M_AXI_ARCACHE(3 downto 0) <= S_AXI_BRAM_arcache(3 downto 0);
  axi_register_slice_2_M_AXI_ARLEN(7 downto 0) <= S_AXI_BRAM_arlen(7 downto 0);
  axi_register_slice_2_M_AXI_ARLOCK <= S_AXI_BRAM_arlock;
  axi_register_slice_2_M_AXI_ARPROT(2 downto 0) <= S_AXI_BRAM_arprot(2 downto 0);
  axi_register_slice_2_M_AXI_ARSIZE(2 downto 0) <= S_AXI_BRAM_arsize(2 downto 0);
  axi_register_slice_2_M_AXI_ARVALID <= S_AXI_BRAM_arvalid;
  axi_register_slice_2_M_AXI_AWADDR(31 downto 0) <= S_AXI_BRAM_awaddr(31 downto 0);
  axi_register_slice_2_M_AXI_AWBURST(1 downto 0) <= S_AXI_BRAM_awburst(1 downto 0);
  axi_register_slice_2_M_AXI_AWCACHE(3 downto 0) <= S_AXI_BRAM_awcache(3 downto 0);
  axi_register_slice_2_M_AXI_AWLEN(7 downto 0) <= S_AXI_BRAM_awlen(7 downto 0);
  axi_register_slice_2_M_AXI_AWLOCK <= S_AXI_BRAM_awlock;
  axi_register_slice_2_M_AXI_AWPROT(2 downto 0) <= S_AXI_BRAM_awprot(2 downto 0);
  axi_register_slice_2_M_AXI_AWSIZE(2 downto 0) <= S_AXI_BRAM_awsize(2 downto 0);
  axi_register_slice_2_M_AXI_AWVALID <= S_AXI_BRAM_awvalid;
  axi_register_slice_2_M_AXI_BREADY <= S_AXI_BRAM_bready;
  axi_register_slice_2_M_AXI_RREADY <= S_AXI_BRAM_rready;
  axi_register_slice_2_M_AXI_WDATA(31 downto 0) <= S_AXI_BRAM_wdata(31 downto 0);
  axi_register_slice_2_M_AXI_WLAST <= S_AXI_BRAM_wlast;
  axi_register_slice_2_M_AXI_WSTRB(3 downto 0) <= S_AXI_BRAM_wstrb(3 downto 0);
  axi_register_slice_2_M_AXI_WVALID <= S_AXI_BRAM_wvalid;
  invert_banks_1 <= invert_filters;
  invert_banks_2 <= invert_activations;
  sel_1 <= sel;
axi_bram_ctrl: component conv_accelerator_bd_axi_bram_ctrl_0
     port map (
      bram_addr_a(18 downto 0) => axi_bram_ctrl_BRAM_PORTA_ADDR(18 downto 0),
      bram_clk_a => axi_bram_ctrl_BRAM_PORTA_CLK,
      bram_en_a => axi_bram_ctrl_BRAM_PORTA_EN,
      bram_rddata_a(31 downto 0) => axi_bram_ctrl_BRAM_PORTA_DOUT(31 downto 0),
      bram_rst_a => axi_bram_ctrl_BRAM_PORTA_RST,
      bram_we_a(3 downto 0) => axi_bram_ctrl_BRAM_PORTA_WE(3 downto 0),
      bram_wrdata_a(31 downto 0) => axi_bram_ctrl_BRAM_PORTA_DIN(31 downto 0),
      s_axi_aclk => aclk_0_1,
      s_axi_araddr(18 downto 0) => axi_register_slice_2_M_AXI_ARADDR(18 downto 0),
      s_axi_arburst(1 downto 0) => axi_register_slice_2_M_AXI_ARBURST(1 downto 0),
      s_axi_arcache(3 downto 0) => axi_register_slice_2_M_AXI_ARCACHE(3 downto 0),
      s_axi_aresetn => aresetn_0_1,
      s_axi_arlen(7 downto 0) => axi_register_slice_2_M_AXI_ARLEN(7 downto 0),
      s_axi_arlock => axi_register_slice_2_M_AXI_ARLOCK,
      s_axi_arprot(2 downto 0) => axi_register_slice_2_M_AXI_ARPROT(2 downto 0),
      s_axi_arready => axi_register_slice_2_M_AXI_ARREADY,
      s_axi_arsize(2 downto 0) => axi_register_slice_2_M_AXI_ARSIZE(2 downto 0),
      s_axi_arvalid => axi_register_slice_2_M_AXI_ARVALID,
      s_axi_awaddr(18 downto 0) => axi_register_slice_2_M_AXI_AWADDR(18 downto 0),
      s_axi_awburst(1 downto 0) => axi_register_slice_2_M_AXI_AWBURST(1 downto 0),
      s_axi_awcache(3 downto 0) => axi_register_slice_2_M_AXI_AWCACHE(3 downto 0),
      s_axi_awlen(7 downto 0) => axi_register_slice_2_M_AXI_AWLEN(7 downto 0),
      s_axi_awlock => axi_register_slice_2_M_AXI_AWLOCK,
      s_axi_awprot(2 downto 0) => axi_register_slice_2_M_AXI_AWPROT(2 downto 0),
      s_axi_awready => axi_register_slice_2_M_AXI_AWREADY,
      s_axi_awsize(2 downto 0) => axi_register_slice_2_M_AXI_AWSIZE(2 downto 0),
      s_axi_awvalid => axi_register_slice_2_M_AXI_AWVALID,
      s_axi_bready => axi_register_slice_2_M_AXI_BREADY,
      s_axi_bresp(1 downto 0) => axi_register_slice_2_M_AXI_BRESP(1 downto 0),
      s_axi_bvalid => axi_register_slice_2_M_AXI_BVALID,
      s_axi_rdata(31 downto 0) => axi_register_slice_2_M_AXI_RDATA(31 downto 0),
      s_axi_rlast => axi_register_slice_2_M_AXI_RLAST,
      s_axi_rready => axi_register_slice_2_M_AXI_RREADY,
      s_axi_rresp(1 downto 0) => axi_register_slice_2_M_AXI_RRESP(1 downto 0),
      s_axi_rvalid => axi_register_slice_2_M_AXI_RVALID,
      s_axi_wdata(31 downto 0) => axi_register_slice_2_M_AXI_WDATA(31 downto 0),
      s_axi_wlast => axi_register_slice_2_M_AXI_WLAST,
      s_axi_wready => axi_register_slice_2_M_AXI_WREADY,
      s_axi_wstrb(3 downto 0) => axi_register_slice_2_M_AXI_WSTRB(3 downto 0),
      s_axi_wvalid => axi_register_slice_2_M_AXI_WVALID
    );
bram_connect_0: component conv_accelerator_bd_bram_connect_0_0
     port map (
      M_BRAM0_addr(31 downto 0) => bram_connect_0_M_BRAM0_ADDR(31 downto 0),
      M_BRAM0_clk => bram_connect_0_M_BRAM0_CLK,
      M_BRAM0_din(31 downto 0) => bram_connect_0_M_BRAM0_DIN(31 downto 0),
      M_BRAM0_dout(31 downto 0) => bram_connect_0_M_BRAM0_DOUT(31 downto 0),
      M_BRAM0_en => bram_connect_0_M_BRAM0_EN,
      M_BRAM0_rst => bram_connect_0_M_BRAM0_RST,
      M_BRAM0_we(3 downto 0) => bram_connect_0_M_BRAM0_WE(3 downto 0),
      M_BRAM1_addr(31 downto 0) => bram_connect_0_M_BRAM1_ADDR(31 downto 0),
      M_BRAM1_clk => bram_connect_0_M_BRAM1_CLK,
      M_BRAM1_din(31 downto 0) => bram_connect_0_M_BRAM1_DIN(31 downto 0),
      M_BRAM1_dout(31 downto 0) => bram_connect_0_M_BRAM1_DOUT(31 downto 0),
      M_BRAM1_en => bram_connect_0_M_BRAM1_EN,
      M_BRAM1_rst => bram_connect_0_M_BRAM1_RST,
      M_BRAM1_we(3 downto 0) => bram_connect_0_M_BRAM1_WE(3 downto 0),
      S_BRAM_addr(31 downto 0) => bram_connect_3_M_BRAM0_ADDR(31 downto 0),
      S_BRAM_clk => bram_connect_3_M_BRAM0_CLK,
      S_BRAM_din(31 downto 0) => bram_connect_3_M_BRAM0_DIN(31 downto 0),
      S_BRAM_dout(31 downto 0) => bram_connect_3_M_BRAM0_DOUT(31 downto 0),
      S_BRAM_en => bram_connect_3_M_BRAM0_EN,
      S_BRAM_rst => bram_connect_3_M_BRAM0_RST,
      S_BRAM_we(3 downto 0) => bram_connect_3_M_BRAM0_WE(3 downto 0)
    );
bram_connect_1: component conv_accelerator_bd_bram_connect_1_0
     port map (
      M_BRAM0_addr(31 downto 0) => bram_connect_1_M_BRAM0_ADDR(31 downto 0),
      M_BRAM0_clk => bram_connect_1_M_BRAM0_CLK,
      M_BRAM0_din(31 downto 0) => bram_connect_1_M_BRAM0_DIN(31 downto 0),
      M_BRAM0_dout(31 downto 0) => bram_connect_1_M_BRAM0_DOUT(31 downto 0),
      M_BRAM0_en => bram_connect_1_M_BRAM0_EN,
      M_BRAM0_rst => bram_connect_1_M_BRAM0_RST,
      M_BRAM0_we(3 downto 0) => bram_connect_1_M_BRAM0_WE(3 downto 0),
      M_BRAM1_addr(31 downto 0) => bram_connect_1_M_BRAM1_ADDR(31 downto 0),
      M_BRAM1_clk => bram_connect_1_M_BRAM1_CLK,
      M_BRAM1_din(31 downto 0) => bram_connect_1_M_BRAM1_DIN(31 downto 0),
      M_BRAM1_dout(31 downto 0) => bram_connect_1_M_BRAM1_DOUT(31 downto 0),
      M_BRAM1_en => bram_connect_1_M_BRAM1_EN,
      M_BRAM1_rst => bram_connect_1_M_BRAM1_RST,
      M_BRAM1_we(3 downto 0) => bram_connect_1_M_BRAM1_WE(3 downto 0),
      S_BRAM_addr(31 downto 0) => bram_connect_3_M_BRAM1_ADDR(31 downto 0),
      S_BRAM_clk => bram_connect_3_M_BRAM1_CLK,
      S_BRAM_din(31 downto 0) => bram_connect_3_M_BRAM1_DIN(31 downto 0),
      S_BRAM_dout(31 downto 0) => bram_connect_3_M_BRAM1_DOUT(31 downto 0),
      S_BRAM_en => bram_connect_3_M_BRAM1_EN,
      S_BRAM_rst => bram_connect_3_M_BRAM1_RST,
      S_BRAM_we(3 downto 0) => bram_connect_3_M_BRAM1_WE(3 downto 0)
    );
bram_connect_2: component conv_accelerator_bd_bram_connect_2_0
     port map (
      M_BRAM0_addr(31 downto 0) => bram_connect_2_M_BRAM0_ADDR(31 downto 0),
      M_BRAM0_clk => bram_connect_2_M_BRAM0_CLK,
      M_BRAM0_din(31 downto 0) => bram_connect_2_M_BRAM0_DIN(31 downto 0),
      M_BRAM0_dout(31 downto 0) => bram_connect_2_M_BRAM0_DOUT(31 downto 0),
      M_BRAM0_en => bram_connect_2_M_BRAM0_EN,
      M_BRAM0_rst => bram_connect_2_M_BRAM0_RST,
      M_BRAM0_we(3 downto 0) => bram_connect_2_M_BRAM0_WE(3 downto 0),
      M_BRAM1_addr(31 downto 0) => bram_connect_2_M_BRAM1_ADDR(31 downto 0),
      M_BRAM1_clk => bram_connect_2_M_BRAM1_CLK,
      M_BRAM1_din(31 downto 0) => bram_connect_2_M_BRAM1_DIN(31 downto 0),
      M_BRAM1_dout(31 downto 0) => bram_connect_2_M_BRAM1_DOUT(31 downto 0),
      M_BRAM1_en => bram_connect_2_M_BRAM1_EN,
      M_BRAM1_rst => bram_connect_2_M_BRAM1_RST,
      M_BRAM1_we(3 downto 0) => bram_connect_2_M_BRAM1_WE(3 downto 0),
      S_BRAM_addr(31 downto 0) => bram_connect_4_M_BRAM0_ADDR(31 downto 0),
      S_BRAM_clk => bram_connect_4_M_BRAM0_CLK,
      S_BRAM_din(31 downto 0) => bram_connect_4_M_BRAM0_DIN(31 downto 0),
      S_BRAM_dout(31 downto 0) => bram_connect_4_M_BRAM0_DOUT(31 downto 0),
      S_BRAM_en => bram_connect_4_M_BRAM0_EN,
      S_BRAM_rst => bram_connect_4_M_BRAM0_RST,
      S_BRAM_we(3 downto 0) => bram_connect_4_M_BRAM0_WE(3 downto 0)
    );
bram_connect_3: component conv_accelerator_bd_bram_connect_3_0
     port map (
      M_BRAM0_addr(31 downto 0) => bram_connect_3_M_BRAM0_ADDR(31 downto 0),
      M_BRAM0_clk => bram_connect_3_M_BRAM0_CLK,
      M_BRAM0_din(31 downto 0) => bram_connect_3_M_BRAM0_DIN(31 downto 0),
      M_BRAM0_dout(31 downto 0) => bram_connect_3_M_BRAM0_DOUT(31 downto 0),
      M_BRAM0_en => bram_connect_3_M_BRAM0_EN,
      M_BRAM0_rst => bram_connect_3_M_BRAM0_RST,
      M_BRAM0_we(3 downto 0) => bram_connect_3_M_BRAM0_WE(3 downto 0),
      M_BRAM1_addr(31 downto 0) => bram_connect_3_M_BRAM1_ADDR(31 downto 0),
      M_BRAM1_clk => bram_connect_3_M_BRAM1_CLK,
      M_BRAM1_din(31 downto 0) => bram_connect_3_M_BRAM1_DIN(31 downto 0),
      M_BRAM1_dout(31 downto 0) => bram_connect_3_M_BRAM1_DOUT(31 downto 0),
      M_BRAM1_en => bram_connect_3_M_BRAM1_EN,
      M_BRAM1_rst => bram_connect_3_M_BRAM1_RST,
      M_BRAM1_we(3 downto 0) => bram_connect_3_M_BRAM1_WE(3 downto 0),
      S_BRAM_addr(31 downto 0) => bram_connect_4_M_BRAM1_ADDR(31 downto 0),
      S_BRAM_clk => bram_connect_4_M_BRAM1_CLK,
      S_BRAM_din(31 downto 0) => bram_connect_4_M_BRAM1_DIN(31 downto 0),
      S_BRAM_dout(31 downto 0) => bram_connect_4_M_BRAM1_DOUT(31 downto 0),
      S_BRAM_en => bram_connect_4_M_BRAM1_EN,
      S_BRAM_rst => bram_connect_4_M_BRAM1_RST,
      S_BRAM_we(3 downto 0) => bram_connect_4_M_BRAM1_WE(3 downto 0)
    );
bram_connect_4: component conv_accelerator_bd_bram_connect_4_0
     port map (
      M_BRAM0_addr(31 downto 0) => bram_connect_4_M_BRAM0_ADDR(31 downto 0),
      M_BRAM0_clk => bram_connect_4_M_BRAM0_CLK,
      M_BRAM0_din(31 downto 0) => bram_connect_4_M_BRAM0_DIN(31 downto 0),
      M_BRAM0_dout(31 downto 0) => bram_connect_4_M_BRAM0_DOUT(31 downto 0),
      M_BRAM0_en => bram_connect_4_M_BRAM0_EN,
      M_BRAM0_rst => bram_connect_4_M_BRAM0_RST,
      M_BRAM0_we(3 downto 0) => bram_connect_4_M_BRAM0_WE(3 downto 0),
      M_BRAM1_addr(31 downto 0) => bram_connect_4_M_BRAM1_ADDR(31 downto 0),
      M_BRAM1_clk => bram_connect_4_M_BRAM1_CLK,
      M_BRAM1_din(31 downto 0) => bram_connect_4_M_BRAM1_DIN(31 downto 0),
      M_BRAM1_dout(31 downto 0) => bram_connect_4_M_BRAM1_DOUT(31 downto 0),
      M_BRAM1_en => bram_connect_4_M_BRAM1_EN,
      M_BRAM1_rst => bram_connect_4_M_BRAM1_RST,
      M_BRAM1_we(3 downto 0) => bram_connect_4_M_BRAM1_WE(3 downto 0),
      S_BRAM_addr(31 downto 19) => B"0000000000000",
      S_BRAM_addr(18 downto 0) => axi_bram_ctrl_BRAM_PORTA_ADDR(18 downto 0),
      S_BRAM_clk => axi_bram_ctrl_BRAM_PORTA_CLK,
      S_BRAM_din(31 downto 0) => axi_bram_ctrl_BRAM_PORTA_DIN(31 downto 0),
      S_BRAM_dout(31 downto 0) => axi_bram_ctrl_BRAM_PORTA_DOUT(31 downto 0),
      S_BRAM_en => axi_bram_ctrl_BRAM_PORTA_EN,
      S_BRAM_rst => axi_bram_ctrl_BRAM_PORTA_RST,
      S_BRAM_we(3 downto 0) => axi_bram_ctrl_BRAM_PORTA_WE(3 downto 0)
    );
bram_filter_0: entity work.bram_filter_0_imp_8ZJM6
     port map (
      BRAM_PORT0_addr(31 downto 0) => bram_read_delay_0_S_BRAM_ADDR(31 downto 0),
      BRAM_PORT0_clk => bram_read_delay_0_S_BRAM_CLK,
      BRAM_PORT0_din(31 downto 0) => bram_read_delay_0_S_BRAM_DIN(31 downto 0),
      BRAM_PORT0_dout(31 downto 0) => bram_read_delay_0_S_BRAM_DOUT(31 downto 0),
      BRAM_PORT0_en => bram_read_delay_0_S_BRAM_EN,
      BRAM_PORT0_rst => bram_read_delay_0_S_BRAM_RST,
      BRAM_PORT0_we(3 downto 0) => bram_read_delay_0_S_BRAM_WE(3 downto 0),
      BRAM_PORT_addr(31 downto 0) => BRAM_PORT_FILTER_0_1_ADDR(31 downto 0),
      BRAM_PORT_clk => BRAM_PORT_FILTER_0_1_CLK,
      BRAM_PORT_din(31 downto 0) => BRAM_PORT_FILTER_0_1_DIN(31 downto 0),
      BRAM_PORT_dout(31 downto 0) => BRAM_PORT_FILTER_0_1_DOUT(31 downto 0),
      BRAM_PORT_en => BRAM_PORT_FILTER_0_1_EN,
      BRAM_PORT_rst => BRAM_PORT_FILTER_0_1_RST,
      BRAM_PORT_we(3 downto 0) => BRAM_PORT_FILTER_0_1_WE(3 downto 0),
      invert_banks => invert_banks_1
    );
bram_filter_1: entity work.bram_filter_1_imp_S5WSI0
     port map (
      BRAM_PORT0_addr(31 downto 0) => bram_read_delay_1_S_BRAM_ADDR(31 downto 0),
      BRAM_PORT0_clk => bram_read_delay_1_S_BRAM_CLK,
      BRAM_PORT0_din(31 downto 0) => bram_read_delay_1_S_BRAM_DIN(31 downto 0),
      BRAM_PORT0_dout(31 downto 0) => bram_read_delay_1_S_BRAM_DOUT(31 downto 0),
      BRAM_PORT0_en => bram_read_delay_1_S_BRAM_EN,
      BRAM_PORT0_rst => bram_read_delay_1_S_BRAM_RST,
      BRAM_PORT0_we(3 downto 0) => bram_read_delay_1_S_BRAM_WE(3 downto 0),
      BRAM_PORT_addr(31 downto 0) => BRAM_PORT_FILTER_1_1_ADDR(31 downto 0),
      BRAM_PORT_clk => BRAM_PORT_FILTER_1_1_CLK,
      BRAM_PORT_din(31 downto 0) => BRAM_PORT_FILTER_1_1_DIN(31 downto 0),
      BRAM_PORT_dout(31 downto 0) => BRAM_PORT_FILTER_1_1_DOUT(31 downto 0),
      BRAM_PORT_en => BRAM_PORT_FILTER_1_1_EN,
      BRAM_PORT_rst => BRAM_PORT_FILTER_1_1_RST,
      BRAM_PORT_we(3 downto 0) => BRAM_PORT_FILTER_1_1_WE(3 downto 0),
      invert_banks => invert_banks_1
    );
bram_filter_2: entity work.bram_filter_2_imp_1K3ACG2
     port map (
      BRAM_PORT0_addr(31 downto 0) => bram_read_delay_2_S_BRAM_ADDR(31 downto 0),
      BRAM_PORT0_clk => bram_read_delay_2_S_BRAM_CLK,
      BRAM_PORT0_din(31 downto 0) => bram_read_delay_2_S_BRAM_DIN(31 downto 0),
      BRAM_PORT0_dout(31 downto 0) => bram_read_delay_2_S_BRAM_DOUT(31 downto 0),
      BRAM_PORT0_en => bram_read_delay_2_S_BRAM_EN,
      BRAM_PORT0_rst => bram_read_delay_2_S_BRAM_RST,
      BRAM_PORT0_we(3 downto 0) => bram_read_delay_2_S_BRAM_WE(3 downto 0),
      BRAM_PORT_addr(31 downto 0) => BRAM_PORT_FILTER_2_1_ADDR(31 downto 0),
      BRAM_PORT_clk => BRAM_PORT_FILTER_2_1_CLK,
      BRAM_PORT_din(31 downto 0) => BRAM_PORT_FILTER_2_1_DIN(31 downto 0),
      BRAM_PORT_dout(31 downto 0) => BRAM_PORT_FILTER_2_1_DOUT(31 downto 0),
      BRAM_PORT_en => BRAM_PORT_FILTER_2_1_EN,
      BRAM_PORT_rst => BRAM_PORT_FILTER_2_1_RST,
      BRAM_PORT_we(3 downto 0) => BRAM_PORT_FILTER_2_1_WE(3 downto 0),
      invert_banks => invert_banks_1
    );
bram_filter_3: entity work.bram_filter_3_imp_1CN42BO
     port map (
      BRAM_PORT0_addr(31 downto 0) => bram_read_delay_3_S_BRAM_ADDR(31 downto 0),
      BRAM_PORT0_clk => bram_read_delay_3_S_BRAM_CLK,
      BRAM_PORT0_din(31 downto 0) => bram_read_delay_3_S_BRAM_DIN(31 downto 0),
      BRAM_PORT0_dout(31 downto 0) => bram_read_delay_3_S_BRAM_DOUT(31 downto 0),
      BRAM_PORT0_en => bram_read_delay_3_S_BRAM_EN,
      BRAM_PORT0_rst => bram_read_delay_3_S_BRAM_RST,
      BRAM_PORT0_we(3 downto 0) => bram_read_delay_3_S_BRAM_WE(3 downto 0),
      BRAM_PORT_addr(31 downto 0) => BRAM_PORT_FILTER_3_1_ADDR(31 downto 0),
      BRAM_PORT_clk => BRAM_PORT_FILTER_3_1_CLK,
      BRAM_PORT_din(31 downto 0) => BRAM_PORT_FILTER_3_1_DIN(31 downto 0),
      BRAM_PORT_dout(31 downto 0) => BRAM_PORT_FILTER_3_1_DOUT(31 downto 0),
      BRAM_PORT_en => BRAM_PORT_FILTER_3_1_EN,
      BRAM_PORT_rst => BRAM_PORT_FILTER_3_1_RST,
      BRAM_PORT_we(3 downto 0) => BRAM_PORT_FILTER_3_1_WE(3 downto 0),
      invert_banks => invert_banks_1
    );
bram_input_0: entity work.bram_input_0_imp_1S46NXD
     port map (
      BRAM_INPUTS_addr(31 downto 0) => BRAM_PORT_OUTPUT_0_1_ADDR(31 downto 0),
      BRAM_INPUTS_clk => BRAM_PORT_OUTPUT_0_1_CLK,
      BRAM_INPUTS_din(31 downto 0) => BRAM_PORT_OUTPUT_0_1_DIN(31 downto 0),
      BRAM_INPUTS_dout(31 downto 0) => BRAM_PORT_OUTPUT_0_1_DOUT(31 downto 0),
      BRAM_INPUTS_en => BRAM_PORT_OUTPUT_0_1_EN,
      BRAM_INPUTS_rst => BRAM_PORT_OUTPUT_0_1_RST,
      BRAM_INPUTS_we(3 downto 0) => BRAM_PORT_OUTPUT_0_1_WE(3 downto 0),
      BRAM_OUTPUTS_addr(31 downto 0) => BRAM_PORT_INPUT_0_1_ADDR(31 downto 0),
      BRAM_OUTPUTS_clk => BRAM_PORT_INPUT_0_1_CLK,
      BRAM_OUTPUTS_din(31 downto 0) => BRAM_PORT_INPUT_0_1_DIN(31 downto 0),
      BRAM_OUTPUTS_dout(31 downto 0) => BRAM_PORT_INPUT_0_1_DOUT(31 downto 0),
      BRAM_OUTPUTS_en => BRAM_PORT_INPUT_0_1_EN,
      BRAM_OUTPUTS_rst => BRAM_PORT_INPUT_0_1_RST,
      BRAM_OUTPUTS_we(3 downto 0) => BRAM_PORT_INPUT_0_1_WE(3 downto 0),
      BRAM_PORT0_addr(31 downto 0) => bram_read_delay_5_S_BRAM_ADDR(31 downto 0),
      BRAM_PORT0_clk => bram_read_delay_5_S_BRAM_CLK,
      BRAM_PORT0_din(31 downto 0) => bram_read_delay_5_S_BRAM_DIN(31 downto 0),
      BRAM_PORT0_dout(31 downto 0) => bram_read_delay_5_S_BRAM_DOUT(31 downto 0),
      BRAM_PORT0_en => bram_read_delay_5_S_BRAM_EN,
      BRAM_PORT0_rst => bram_read_delay_5_S_BRAM_RST,
      BRAM_PORT0_we(3 downto 0) => bram_read_delay_5_S_BRAM_WE(3 downto 0),
      BRAM_PORT1_addr(31 downto 0) => bram_read_delay_4_S_BRAM_ADDR(31 downto 0),
      BRAM_PORT1_clk => bram_read_delay_4_S_BRAM_CLK,
      BRAM_PORT1_din(31 downto 0) => bram_read_delay_4_S_BRAM_DIN(31 downto 0),
      BRAM_PORT1_dout(31 downto 0) => bram_read_delay_4_S_BRAM_DOUT(31 downto 0),
      BRAM_PORT1_en => bram_read_delay_4_S_BRAM_EN,
      BRAM_PORT1_rst => bram_read_delay_4_S_BRAM_RST,
      BRAM_PORT1_we(3 downto 0) => bram_read_delay_4_S_BRAM_WE(3 downto 0),
      invert_banks => invert_banks_2,
      sel => sel_1
    );
bram_read_delay_0: component conv_accelerator_bd_bram_read_delay_0_0
     port map (
      M_BRAM_addr(31 downto 0) => bram_connect_0_M_BRAM0_ADDR(31 downto 0),
      M_BRAM_clk => bram_connect_0_M_BRAM0_CLK,
      M_BRAM_din(31 downto 0) => bram_connect_0_M_BRAM0_DIN(31 downto 0),
      M_BRAM_dout(31 downto 0) => bram_connect_0_M_BRAM0_DOUT(31 downto 0),
      M_BRAM_en => bram_connect_0_M_BRAM0_EN,
      M_BRAM_rst => bram_connect_0_M_BRAM0_RST,
      M_BRAM_we(3 downto 0) => bram_connect_0_M_BRAM0_WE(3 downto 0),
      S_BRAM_addr(31 downto 0) => bram_read_delay_0_S_BRAM_ADDR(31 downto 0),
      S_BRAM_clk => bram_read_delay_0_S_BRAM_CLK,
      S_BRAM_din(31 downto 0) => bram_read_delay_0_S_BRAM_DIN(31 downto 0),
      S_BRAM_dout(31 downto 0) => bram_read_delay_0_S_BRAM_DOUT(31 downto 0),
      S_BRAM_en => bram_read_delay_0_S_BRAM_EN,
      S_BRAM_rst => bram_read_delay_0_S_BRAM_RST,
      S_BRAM_we(3 downto 0) => bram_read_delay_0_S_BRAM_WE(3 downto 0)
    );
bram_read_delay_1: component conv_accelerator_bd_bram_read_delay_1_0
     port map (
      M_BRAM_addr(31 downto 0) => bram_connect_0_M_BRAM1_ADDR(31 downto 0),
      M_BRAM_clk => bram_connect_0_M_BRAM1_CLK,
      M_BRAM_din(31 downto 0) => bram_connect_0_M_BRAM1_DIN(31 downto 0),
      M_BRAM_dout(31 downto 0) => bram_connect_0_M_BRAM1_DOUT(31 downto 0),
      M_BRAM_en => bram_connect_0_M_BRAM1_EN,
      M_BRAM_rst => bram_connect_0_M_BRAM1_RST,
      M_BRAM_we(3 downto 0) => bram_connect_0_M_BRAM1_WE(3 downto 0),
      S_BRAM_addr(31 downto 0) => bram_read_delay_1_S_BRAM_ADDR(31 downto 0),
      S_BRAM_clk => bram_read_delay_1_S_BRAM_CLK,
      S_BRAM_din(31 downto 0) => bram_read_delay_1_S_BRAM_DIN(31 downto 0),
      S_BRAM_dout(31 downto 0) => bram_read_delay_1_S_BRAM_DOUT(31 downto 0),
      S_BRAM_en => bram_read_delay_1_S_BRAM_EN,
      S_BRAM_rst => bram_read_delay_1_S_BRAM_RST,
      S_BRAM_we(3 downto 0) => bram_read_delay_1_S_BRAM_WE(3 downto 0)
    );
bram_read_delay_2: component conv_accelerator_bd_bram_read_delay_2_0
     port map (
      M_BRAM_addr(31 downto 0) => bram_connect_1_M_BRAM0_ADDR(31 downto 0),
      M_BRAM_clk => bram_connect_1_M_BRAM0_CLK,
      M_BRAM_din(31 downto 0) => bram_connect_1_M_BRAM0_DIN(31 downto 0),
      M_BRAM_dout(31 downto 0) => bram_connect_1_M_BRAM0_DOUT(31 downto 0),
      M_BRAM_en => bram_connect_1_M_BRAM0_EN,
      M_BRAM_rst => bram_connect_1_M_BRAM0_RST,
      M_BRAM_we(3 downto 0) => bram_connect_1_M_BRAM0_WE(3 downto 0),
      S_BRAM_addr(31 downto 0) => bram_read_delay_2_S_BRAM_ADDR(31 downto 0),
      S_BRAM_clk => bram_read_delay_2_S_BRAM_CLK,
      S_BRAM_din(31 downto 0) => bram_read_delay_2_S_BRAM_DIN(31 downto 0),
      S_BRAM_dout(31 downto 0) => bram_read_delay_2_S_BRAM_DOUT(31 downto 0),
      S_BRAM_en => bram_read_delay_2_S_BRAM_EN,
      S_BRAM_rst => bram_read_delay_2_S_BRAM_RST,
      S_BRAM_we(3 downto 0) => bram_read_delay_2_S_BRAM_WE(3 downto 0)
    );
bram_read_delay_3: component conv_accelerator_bd_bram_read_delay_3_0
     port map (
      M_BRAM_addr(31 downto 0) => bram_connect_1_M_BRAM1_ADDR(31 downto 0),
      M_BRAM_clk => bram_connect_1_M_BRAM1_CLK,
      M_BRAM_din(31 downto 0) => bram_connect_1_M_BRAM1_DIN(31 downto 0),
      M_BRAM_dout(31 downto 0) => bram_connect_1_M_BRAM1_DOUT(31 downto 0),
      M_BRAM_en => bram_connect_1_M_BRAM1_EN,
      M_BRAM_rst => bram_connect_1_M_BRAM1_RST,
      M_BRAM_we(3 downto 0) => bram_connect_1_M_BRAM1_WE(3 downto 0),
      S_BRAM_addr(31 downto 0) => bram_read_delay_3_S_BRAM_ADDR(31 downto 0),
      S_BRAM_clk => bram_read_delay_3_S_BRAM_CLK,
      S_BRAM_din(31 downto 0) => bram_read_delay_3_S_BRAM_DIN(31 downto 0),
      S_BRAM_dout(31 downto 0) => bram_read_delay_3_S_BRAM_DOUT(31 downto 0),
      S_BRAM_en => bram_read_delay_3_S_BRAM_EN,
      S_BRAM_rst => bram_read_delay_3_S_BRAM_RST,
      S_BRAM_we(3 downto 0) => bram_read_delay_3_S_BRAM_WE(3 downto 0)
    );
bram_read_delay_4: component conv_accelerator_bd_bram_read_delay_4_0
     port map (
      M_BRAM_addr(31 downto 0) => bram_connect_2_M_BRAM1_ADDR(31 downto 0),
      M_BRAM_clk => bram_connect_2_M_BRAM1_CLK,
      M_BRAM_din(31 downto 0) => bram_connect_2_M_BRAM1_DIN(31 downto 0),
      M_BRAM_dout(31 downto 0) => bram_connect_2_M_BRAM1_DOUT(31 downto 0),
      M_BRAM_en => bram_connect_2_M_BRAM1_EN,
      M_BRAM_rst => bram_connect_2_M_BRAM1_RST,
      M_BRAM_we(3 downto 0) => bram_connect_2_M_BRAM1_WE(3 downto 0),
      S_BRAM_addr(31 downto 0) => bram_read_delay_4_S_BRAM_ADDR(31 downto 0),
      S_BRAM_clk => bram_read_delay_4_S_BRAM_CLK,
      S_BRAM_din(31 downto 0) => bram_read_delay_4_S_BRAM_DIN(31 downto 0),
      S_BRAM_dout(31 downto 0) => bram_read_delay_4_S_BRAM_DOUT(31 downto 0),
      S_BRAM_en => bram_read_delay_4_S_BRAM_EN,
      S_BRAM_rst => bram_read_delay_4_S_BRAM_RST,
      S_BRAM_we(3 downto 0) => bram_read_delay_4_S_BRAM_WE(3 downto 0)
    );
bram_read_delay_5: component conv_accelerator_bd_bram_read_delay_5_0
     port map (
      M_BRAM_addr(31 downto 0) => bram_connect_2_M_BRAM0_ADDR(31 downto 0),
      M_BRAM_clk => bram_connect_2_M_BRAM0_CLK,
      M_BRAM_din(31 downto 0) => bram_connect_2_M_BRAM0_DIN(31 downto 0),
      M_BRAM_dout(31 downto 0) => bram_connect_2_M_BRAM0_DOUT(31 downto 0),
      M_BRAM_en => bram_connect_2_M_BRAM0_EN,
      M_BRAM_rst => bram_connect_2_M_BRAM0_RST,
      M_BRAM_we(3 downto 0) => bram_connect_2_M_BRAM0_WE(3 downto 0),
      S_BRAM_addr(31 downto 0) => bram_read_delay_5_S_BRAM_ADDR(31 downto 0),
      S_BRAM_clk => bram_read_delay_5_S_BRAM_CLK,
      S_BRAM_din(31 downto 0) => bram_read_delay_5_S_BRAM_DIN(31 downto 0),
      S_BRAM_dout(31 downto 0) => bram_read_delay_5_S_BRAM_DOUT(31 downto 0),
      S_BRAM_en => bram_read_delay_5_S_BRAM_EN,
      S_BRAM_rst => bram_read_delay_5_S_BRAM_RST,
      S_BRAM_we(3 downto 0) => bram_read_delay_5_S_BRAM_WE(3 downto 0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity conv_accelerator_bd is
  port (
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_cas_n : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of conv_accelerator_bd : entity is "conv_accelerator_bd,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=conv_accelerator_bd,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=43,numReposBlks=37,numNonXlnxBlks=0,numHierBlks=6,maxHierDepth=2,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=19,numPkgbdBlks=0,bdsource=USER,synth_mode=Global}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of conv_accelerator_bd : entity is "conv_accelerator_bd.hwdef";
end conv_accelerator_bd;

architecture STRUCTURE of conv_accelerator_bd is
  component conv_accelerator_bd_axi_cdma_0_0 is
  port (
    m_axi_aclk : in STD_LOGIC;
    s_axi_lite_aclk : in STD_LOGIC;
    s_axi_lite_aresetn : in STD_LOGIC;
    cdma_introut : out STD_LOGIC;
    s_axi_lite_awready : out STD_LOGIC;
    s_axi_lite_awvalid : in STD_LOGIC;
    s_axi_lite_awaddr : in STD_LOGIC_VECTOR ( 5 downto 0 );
    s_axi_lite_wready : out STD_LOGIC;
    s_axi_lite_wvalid : in STD_LOGIC;
    s_axi_lite_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_lite_bready : in STD_LOGIC;
    s_axi_lite_bvalid : out STD_LOGIC;
    s_axi_lite_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_lite_arready : out STD_LOGIC;
    s_axi_lite_arvalid : in STD_LOGIC;
    s_axi_lite_araddr : in STD_LOGIC_VECTOR ( 5 downto 0 );
    s_axi_lite_rready : in STD_LOGIC;
    s_axi_lite_rvalid : out STD_LOGIC;
    s_axi_lite_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_lite_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_arready : in STD_LOGIC;
    m_axi_arvalid : out STD_LOGIC;
    m_axi_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_rready : out STD_LOGIC;
    m_axi_rvalid : in STD_LOGIC;
    m_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rlast : in STD_LOGIC;
    m_axi_awready : in STD_LOGIC;
    m_axi_awvalid : out STD_LOGIC;
    m_axi_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_wready : in STD_LOGIC;
    m_axi_wvalid : out STD_LOGIC;
    m_axi_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_wlast : out STD_LOGIC;
    m_axi_bready : out STD_LOGIC;
    m_axi_bvalid : in STD_LOGIC;
    m_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  end component conv_accelerator_bd_axi_cdma_0_0;
  component conv_accelerator_bd_axi_crossbar_0_0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bready : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rready : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_awaddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axi_awprot : out STD_LOGIC_VECTOR ( 5 downto 0 );
    m_axi_awvalid : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_awready : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axi_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_wvalid : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_wready : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_bresp : in STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_bvalid : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_bready : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_araddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axi_arprot : out STD_LOGIC_VECTOR ( 5 downto 0 );
    m_axi_arvalid : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_arready : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_rvalid : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rready : out STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  end component conv_accelerator_bd_axi_crossbar_0_0;
  component conv_accelerator_bd_axi_crossbar_1_0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wlast : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bready : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rlast : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rready : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_awaddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axi_awlen : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axi_awsize : out STD_LOGIC_VECTOR ( 5 downto 0 );
    m_axi_awburst : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_awlock : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_awcache : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_awprot : out STD_LOGIC_VECTOR ( 5 downto 0 );
    m_axi_awregion : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_awqos : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_awvalid : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_awready : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axi_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_wlast : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_wvalid : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_wready : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_bresp : in STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_bvalid : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_bready : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_araddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axi_arlen : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axi_arsize : out STD_LOGIC_VECTOR ( 5 downto 0 );
    m_axi_arburst : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_arlock : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_arcache : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_arprot : out STD_LOGIC_VECTOR ( 5 downto 0 );
    m_axi_arregion : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_arqos : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_arvalid : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_arready : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_rlast : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rvalid : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rready : out STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  end component conv_accelerator_bd_axi_crossbar_1_0;
  component conv_accelerator_bd_axi_protocol_convert_0_0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axi_awid : in STD_LOGIC_VECTOR ( 11 downto 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awlen : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awlock : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wid : in STD_LOGIC_VECTOR ( 11 downto 0 );
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wlast : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bid : out STD_LOGIC_VECTOR ( 11 downto 0 );
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_arid : in STD_LOGIC_VECTOR ( 11 downto 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_arlen : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arlock : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rid : out STD_LOGIC_VECTOR ( 11 downto 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rlast : out STD_LOGIC;
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    m_axi_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awvalid : out STD_LOGIC;
    m_axi_awready : in STD_LOGIC;
    m_axi_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_wvalid : out STD_LOGIC;
    m_axi_wready : in STD_LOGIC;
    m_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_bvalid : in STD_LOGIC;
    m_axi_bready : out STD_LOGIC;
    m_axi_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arvalid : out STD_LOGIC;
    m_axi_arready : in STD_LOGIC;
    m_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rvalid : in STD_LOGIC;
    m_axi_rready : out STD_LOGIC
  );
  end component conv_accelerator_bd_axi_protocol_convert_0_0;
  component conv_accelerator_bd_axi_protocol_convert_3_0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awregion : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wlast : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arregion : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rlast : out STD_LOGIC;
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    m_axi_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_awlen : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_awlock : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_awvalid : out STD_LOGIC;
    m_axi_awready : in STD_LOGIC;
    m_axi_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_wlast : out STD_LOGIC;
    m_axi_wvalid : out STD_LOGIC;
    m_axi_wready : in STD_LOGIC;
    m_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_bvalid : in STD_LOGIC;
    m_axi_bready : out STD_LOGIC;
    m_axi_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_arlen : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_arlock : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_arvalid : out STD_LOGIC;
    m_axi_arready : in STD_LOGIC;
    m_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rlast : in STD_LOGIC;
    m_axi_rvalid : in STD_LOGIC;
    m_axi_rready : out STD_LOGIC
  );
  end component conv_accelerator_bd_axi_protocol_convert_3_0;
  component conv_accelerator_bd_processing_system7_0_0 is
  port (
    M_AXI_GP0_ARVALID : out STD_LOGIC;
    M_AXI_GP0_AWVALID : out STD_LOGIC;
    M_AXI_GP0_BREADY : out STD_LOGIC;
    M_AXI_GP0_RREADY : out STD_LOGIC;
    M_AXI_GP0_WLAST : out STD_LOGIC;
    M_AXI_GP0_WVALID : out STD_LOGIC;
    M_AXI_GP0_ARID : out STD_LOGIC_VECTOR ( 11 downto 0 );
    M_AXI_GP0_AWID : out STD_LOGIC_VECTOR ( 11 downto 0 );
    M_AXI_GP0_WID : out STD_LOGIC_VECTOR ( 11 downto 0 );
    M_AXI_GP0_ARBURST : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_GP0_ARLOCK : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_GP0_ARSIZE : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_GP0_AWBURST : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_GP0_AWLOCK : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_GP0_AWSIZE : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_GP0_ARPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_GP0_AWPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_GP0_ARADDR : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_GP0_AWADDR : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_GP0_WDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_GP0_ARCACHE : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_GP0_ARLEN : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_GP0_ARQOS : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_GP0_AWCACHE : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_GP0_AWLEN : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_GP0_AWQOS : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_GP0_WSTRB : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_GP0_ACLK : in STD_LOGIC;
    M_AXI_GP0_ARREADY : in STD_LOGIC;
    M_AXI_GP0_AWREADY : in STD_LOGIC;
    M_AXI_GP0_BVALID : in STD_LOGIC;
    M_AXI_GP0_RLAST : in STD_LOGIC;
    M_AXI_GP0_RVALID : in STD_LOGIC;
    M_AXI_GP0_WREADY : in STD_LOGIC;
    M_AXI_GP0_BID : in STD_LOGIC_VECTOR ( 11 downto 0 );
    M_AXI_GP0_RID : in STD_LOGIC_VECTOR ( 11 downto 0 );
    M_AXI_GP0_BRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_GP0_RRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_GP0_RDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_HP0_ARREADY : out STD_LOGIC;
    S_AXI_HP0_AWREADY : out STD_LOGIC;
    S_AXI_HP0_BVALID : out STD_LOGIC;
    S_AXI_HP0_RLAST : out STD_LOGIC;
    S_AXI_HP0_RVALID : out STD_LOGIC;
    S_AXI_HP0_WREADY : out STD_LOGIC;
    S_AXI_HP0_BRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_HP0_RRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_HP0_BID : out STD_LOGIC_VECTOR ( 5 downto 0 );
    S_AXI_HP0_RID : out STD_LOGIC_VECTOR ( 5 downto 0 );
    S_AXI_HP0_RDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_HP0_RCOUNT : out STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXI_HP0_WCOUNT : out STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXI_HP0_RACOUNT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_HP0_WACOUNT : out STD_LOGIC_VECTOR ( 5 downto 0 );
    S_AXI_HP0_ACLK : in STD_LOGIC;
    S_AXI_HP0_ARVALID : in STD_LOGIC;
    S_AXI_HP0_AWVALID : in STD_LOGIC;
    S_AXI_HP0_BREADY : in STD_LOGIC;
    S_AXI_HP0_RDISSUECAP1_EN : in STD_LOGIC;
    S_AXI_HP0_RREADY : in STD_LOGIC;
    S_AXI_HP0_WLAST : in STD_LOGIC;
    S_AXI_HP0_WRISSUECAP1_EN : in STD_LOGIC;
    S_AXI_HP0_WVALID : in STD_LOGIC;
    S_AXI_HP0_ARBURST : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_HP0_ARLOCK : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_HP0_ARSIZE : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_HP0_AWBURST : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_HP0_AWLOCK : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_HP0_AWSIZE : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_HP0_ARPROT : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_HP0_AWPROT : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_HP0_ARADDR : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_HP0_AWADDR : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_HP0_ARCACHE : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_HP0_ARLEN : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_HP0_ARQOS : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_HP0_AWCACHE : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_HP0_AWLEN : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_HP0_AWQOS : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_HP0_ARID : in STD_LOGIC_VECTOR ( 5 downto 0 );
    S_AXI_HP0_AWID : in STD_LOGIC_VECTOR ( 5 downto 0 );
    S_AXI_HP0_WID : in STD_LOGIC_VECTOR ( 5 downto 0 );
    S_AXI_HP0_WDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_HP0_WSTRB : in STD_LOGIC_VECTOR ( 3 downto 0 );
    FCLK_CLK0 : out STD_LOGIC;
    FCLK_RESET0_N : out STD_LOGIC;
    MIO : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    DDR_CAS_n : inout STD_LOGIC;
    DDR_CKE : inout STD_LOGIC;
    DDR_Clk_n : inout STD_LOGIC;
    DDR_Clk : inout STD_LOGIC;
    DDR_CS_n : inout STD_LOGIC;
    DDR_DRSTB : inout STD_LOGIC;
    DDR_ODT : inout STD_LOGIC;
    DDR_RAS_n : inout STD_LOGIC;
    DDR_WEB : inout STD_LOGIC;
    DDR_BankAddr : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_Addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_VRN : inout STD_LOGIC;
    DDR_VRP : inout STD_LOGIC;
    DDR_DM : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_DQ : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_DQS_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_DQS : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    PS_SRSTB : inout STD_LOGIC;
    PS_CLK : inout STD_LOGIC;
    PS_PORB : inout STD_LOGIC
  );
  end component conv_accelerator_bd_processing_system7_0_0;
  component conv_accelerator_bd_rst_ps7_0_200M_0 is
  port (
    slowest_sync_clk : in STD_LOGIC;
    ext_reset_in : in STD_LOGIC;
    aux_reset_in : in STD_LOGIC;
    mb_debug_sys_rst : in STD_LOGIC;
    dcm_locked : in STD_LOGIC;
    mb_reset : out STD_LOGIC;
    bus_struct_reset : out STD_LOGIC_VECTOR ( 0 to 0 );
    peripheral_reset : out STD_LOGIC_VECTOR ( 0 to 0 );
    interconnect_aresetn : out STD_LOGIC_VECTOR ( 0 to 0 );
    peripheral_aresetn : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component conv_accelerator_bd_rst_ps7_0_200M_0;
  component conv_accelerator_bd_conv_accelerator_wra_0_0 is
  port (
    S_AXI_LITE_ACLK : in STD_LOGIC;
    S_AXI_LITE_ARESETN : in STD_LOGIC;
    S_AXI_LITE_AWVALID : in STD_LOGIC;
    S_AXI_LITE_AWREADY : out STD_LOGIC;
    S_AXI_LITE_AWADDR : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXI_LITE_AWPROT : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_LITE_WVALID : in STD_LOGIC;
    S_AXI_LITE_WREADY : out STD_LOGIC;
    S_AXI_LITE_WDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_LITE_WSTRB : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_LITE_BVALID : out STD_LOGIC;
    S_AXI_LITE_BREADY : in STD_LOGIC;
    S_AXI_LITE_BRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_LITE_ARVALID : in STD_LOGIC;
    S_AXI_LITE_ARREADY : out STD_LOGIC;
    S_AXI_LITE_ARADDR : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXI_LITE_ARPROT : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_LITE_RVALID : out STD_LOGIC;
    S_AXI_LITE_RREADY : in STD_LOGIC;
    S_AXI_LITE_RDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_LITE_RRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    BRAM_INPUT_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_INPUT_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_INPUT_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_INPUT_en : out STD_LOGIC;
    BRAM_INPUT_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    BRAM_INPUT_rst : out STD_LOGIC;
    BRAM_INPUT_clk : out STD_LOGIC;
    BRAM_FILTER0_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_FILTER0_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_FILTER0_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_FILTER0_en : out STD_LOGIC;
    BRAM_FILTER0_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    BRAM_FILTER0_rst : out STD_LOGIC;
    BRAM_FILTER0_clk : out STD_LOGIC;
    BRAM_FILTER1_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_FILTER1_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_FILTER1_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_FILTER1_en : out STD_LOGIC;
    BRAM_FILTER1_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    BRAM_FILTER1_rst : out STD_LOGIC;
    BRAM_FILTER1_clk : out STD_LOGIC;
    BRAM_FILTER2_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_FILTER2_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_FILTER2_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_FILTER2_en : out STD_LOGIC;
    BRAM_FILTER2_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    BRAM_FILTER2_rst : out STD_LOGIC;
    BRAM_FILTER2_clk : out STD_LOGIC;
    BRAM_FILTER3_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_FILTER3_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_FILTER3_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_FILTER3_en : out STD_LOGIC;
    BRAM_FILTER3_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    BRAM_FILTER3_rst : out STD_LOGIC;
    BRAM_FILTER3_clk : out STD_LOGIC;
    BRAM_OUTPUT_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_OUTPUT_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_OUTPUT_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_OUTPUT_en : out STD_LOGIC;
    BRAM_OUTPUT_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    BRAM_OUTPUT_rst : out STD_LOGIC;
    BRAM_OUTPUT_clk : out STD_LOGIC;
    accelerator_controls_activation_bram : out STD_LOGIC;
    swap_activations : out STD_LOGIC;
    swap_filters : out STD_LOGIC
  );
  end component conv_accelerator_bd_conv_accelerator_wra_0_0;
  signal BRAM_PORT_OUTPUT_0_1_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_PORT_OUTPUT_0_1_CLK : STD_LOGIC;
  signal BRAM_PORT_OUTPUT_0_1_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_PORT_OUTPUT_0_1_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal BRAM_PORT_OUTPUT_0_1_EN : STD_LOGIC;
  signal BRAM_PORT_OUTPUT_0_1_RST : STD_LOGIC;
  signal BRAM_PORT_OUTPUT_0_1_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_cdma_0_M_AXI_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_cdma_0_M_AXI_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_cdma_0_M_AXI_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_cdma_0_M_AXI_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axi_cdma_0_M_AXI_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_cdma_0_M_AXI_ARREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_cdma_0_M_AXI_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_cdma_0_M_AXI_ARVALID : STD_LOGIC;
  signal axi_cdma_0_M_AXI_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_cdma_0_M_AXI_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_cdma_0_M_AXI_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_cdma_0_M_AXI_AWLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axi_cdma_0_M_AXI_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_cdma_0_M_AXI_AWREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_cdma_0_M_AXI_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_cdma_0_M_AXI_AWVALID : STD_LOGIC;
  signal axi_cdma_0_M_AXI_BREADY : STD_LOGIC;
  signal axi_cdma_0_M_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_cdma_0_M_AXI_BVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_cdma_0_M_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_cdma_0_M_AXI_RLAST : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_cdma_0_M_AXI_RREADY : STD_LOGIC;
  signal axi_cdma_0_M_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_cdma_0_M_AXI_RVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_cdma_0_M_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_cdma_0_M_AXI_WLAST : STD_LOGIC;
  signal axi_cdma_0_M_AXI_WREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_cdma_0_M_AXI_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_cdma_0_M_AXI_WVALID : STD_LOGIC;
  signal axi_crossbar_0_M00_AXI_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_crossbar_0_M00_AXI_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_crossbar_0_M00_AXI_ARREADY : STD_LOGIC;
  signal axi_crossbar_0_M00_AXI_ARVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_crossbar_0_M00_AXI_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_crossbar_0_M00_AXI_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_crossbar_0_M00_AXI_AWREADY : STD_LOGIC;
  signal axi_crossbar_0_M00_AXI_AWVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_crossbar_0_M00_AXI_BREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_crossbar_0_M00_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_crossbar_0_M00_AXI_BVALID : STD_LOGIC;
  signal axi_crossbar_0_M00_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_crossbar_0_M00_AXI_RREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_crossbar_0_M00_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_crossbar_0_M00_AXI_RVALID : STD_LOGIC;
  signal axi_crossbar_0_M00_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_crossbar_0_M00_AXI_WREADY : STD_LOGIC;
  signal axi_crossbar_0_M00_AXI_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_crossbar_0_M00_AXI_WVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_crossbar_0_M01_AXI_ARADDR : STD_LOGIC_VECTOR ( 63 downto 32 );
  signal axi_crossbar_0_M01_AXI_ARREADY : STD_LOGIC;
  signal axi_crossbar_0_M01_AXI_ARVALID : STD_LOGIC_VECTOR ( 1 to 1 );
  signal axi_crossbar_0_M01_AXI_AWADDR : STD_LOGIC_VECTOR ( 63 downto 32 );
  signal axi_crossbar_0_M01_AXI_AWREADY : STD_LOGIC;
  signal axi_crossbar_0_M01_AXI_AWVALID : STD_LOGIC_VECTOR ( 1 to 1 );
  signal axi_crossbar_0_M01_AXI_BREADY : STD_LOGIC_VECTOR ( 1 to 1 );
  signal axi_crossbar_0_M01_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_crossbar_0_M01_AXI_BVALID : STD_LOGIC;
  signal axi_crossbar_0_M01_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_crossbar_0_M01_AXI_RREADY : STD_LOGIC_VECTOR ( 1 to 1 );
  signal axi_crossbar_0_M01_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_crossbar_0_M01_AXI_RVALID : STD_LOGIC;
  signal axi_crossbar_0_M01_AXI_WDATA : STD_LOGIC_VECTOR ( 63 downto 32 );
  signal axi_crossbar_0_M01_AXI_WREADY : STD_LOGIC;
  signal axi_crossbar_0_M01_AXI_WVALID : STD_LOGIC_VECTOR ( 1 to 1 );
  signal axi_crossbar_1_M00_AXI_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_crossbar_1_M00_AXI_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_crossbar_1_M00_AXI_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_crossbar_1_M00_AXI_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axi_crossbar_1_M00_AXI_ARLOCK : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_crossbar_1_M00_AXI_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_crossbar_1_M00_AXI_ARQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_crossbar_1_M00_AXI_ARREADY : STD_LOGIC;
  signal axi_crossbar_1_M00_AXI_ARREGION : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_crossbar_1_M00_AXI_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_crossbar_1_M00_AXI_ARVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_crossbar_1_M00_AXI_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_crossbar_1_M00_AXI_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_crossbar_1_M00_AXI_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_crossbar_1_M00_AXI_AWLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axi_crossbar_1_M00_AXI_AWLOCK : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_crossbar_1_M00_AXI_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_crossbar_1_M00_AXI_AWQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_crossbar_1_M00_AXI_AWREADY : STD_LOGIC;
  signal axi_crossbar_1_M00_AXI_AWREGION : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_crossbar_1_M00_AXI_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_crossbar_1_M00_AXI_AWVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_crossbar_1_M00_AXI_BREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_crossbar_1_M00_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_crossbar_1_M00_AXI_BVALID : STD_LOGIC;
  signal axi_crossbar_1_M00_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_crossbar_1_M00_AXI_RLAST : STD_LOGIC;
  signal axi_crossbar_1_M00_AXI_RREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_crossbar_1_M00_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_crossbar_1_M00_AXI_RVALID : STD_LOGIC;
  signal axi_crossbar_1_M00_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_crossbar_1_M00_AXI_WLAST : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_crossbar_1_M00_AXI_WREADY : STD_LOGIC;
  signal axi_crossbar_1_M00_AXI_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_crossbar_1_M00_AXI_WVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_crossbar_1_M01_AXI_ARADDR : STD_LOGIC_VECTOR ( 63 downto 32 );
  signal axi_crossbar_1_M01_AXI_ARBURST : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal axi_crossbar_1_M01_AXI_ARCACHE : STD_LOGIC_VECTOR ( 7 downto 4 );
  signal axi_crossbar_1_M01_AXI_ARLEN : STD_LOGIC_VECTOR ( 15 downto 8 );
  signal axi_crossbar_1_M01_AXI_ARLOCK : STD_LOGIC_VECTOR ( 1 to 1 );
  signal axi_crossbar_1_M01_AXI_ARPROT : STD_LOGIC_VECTOR ( 5 downto 3 );
  signal axi_crossbar_1_M01_AXI_ARREADY : STD_LOGIC;
  signal axi_crossbar_1_M01_AXI_ARSIZE : STD_LOGIC_VECTOR ( 5 downto 3 );
  signal axi_crossbar_1_M01_AXI_ARVALID : STD_LOGIC_VECTOR ( 1 to 1 );
  signal axi_crossbar_1_M01_AXI_AWADDR : STD_LOGIC_VECTOR ( 63 downto 32 );
  signal axi_crossbar_1_M01_AXI_AWBURST : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal axi_crossbar_1_M01_AXI_AWCACHE : STD_LOGIC_VECTOR ( 7 downto 4 );
  signal axi_crossbar_1_M01_AXI_AWLEN : STD_LOGIC_VECTOR ( 15 downto 8 );
  signal axi_crossbar_1_M01_AXI_AWLOCK : STD_LOGIC_VECTOR ( 1 to 1 );
  signal axi_crossbar_1_M01_AXI_AWPROT : STD_LOGIC_VECTOR ( 5 downto 3 );
  signal axi_crossbar_1_M01_AXI_AWREADY : STD_LOGIC;
  signal axi_crossbar_1_M01_AXI_AWSIZE : STD_LOGIC_VECTOR ( 5 downto 3 );
  signal axi_crossbar_1_M01_AXI_AWVALID : STD_LOGIC_VECTOR ( 1 to 1 );
  signal axi_crossbar_1_M01_AXI_BREADY : STD_LOGIC_VECTOR ( 1 to 1 );
  signal axi_crossbar_1_M01_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_crossbar_1_M01_AXI_BVALID : STD_LOGIC;
  signal axi_crossbar_1_M01_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_crossbar_1_M01_AXI_RLAST : STD_LOGIC;
  signal axi_crossbar_1_M01_AXI_RREADY : STD_LOGIC_VECTOR ( 1 to 1 );
  signal axi_crossbar_1_M01_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_crossbar_1_M01_AXI_RVALID : STD_LOGIC;
  signal axi_crossbar_1_M01_AXI_WDATA : STD_LOGIC_VECTOR ( 63 downto 32 );
  signal axi_crossbar_1_M01_AXI_WLAST : STD_LOGIC_VECTOR ( 1 to 1 );
  signal axi_crossbar_1_M01_AXI_WREADY : STD_LOGIC;
  signal axi_crossbar_1_M01_AXI_WSTRB : STD_LOGIC_VECTOR ( 7 downto 4 );
  signal axi_crossbar_1_M01_AXI_WVALID : STD_LOGIC_VECTOR ( 1 to 1 );
  signal axi_protocol_convert_0_M_AXI_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_protocol_convert_0_M_AXI_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_protocol_convert_0_M_AXI_ARREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_protocol_convert_0_M_AXI_ARVALID : STD_LOGIC;
  signal axi_protocol_convert_0_M_AXI_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_protocol_convert_0_M_AXI_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_protocol_convert_0_M_AXI_AWREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_protocol_convert_0_M_AXI_AWVALID : STD_LOGIC;
  signal axi_protocol_convert_0_M_AXI_BREADY : STD_LOGIC;
  signal axi_protocol_convert_0_M_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_protocol_convert_0_M_AXI_BVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_protocol_convert_0_M_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_protocol_convert_0_M_AXI_RREADY : STD_LOGIC;
  signal axi_protocol_convert_0_M_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_protocol_convert_0_M_AXI_RVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_protocol_convert_0_M_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_protocol_convert_0_M_AXI_WREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_protocol_convert_0_M_AXI_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_protocol_convert_0_M_AXI_WVALID : STD_LOGIC;
  signal axi_protocol_convert_3_M_AXI_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_protocol_convert_3_M_AXI_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_protocol_convert_3_M_AXI_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_protocol_convert_3_M_AXI_ARLEN : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_protocol_convert_3_M_AXI_ARLOCK : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_protocol_convert_3_M_AXI_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_protocol_convert_3_M_AXI_ARQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_protocol_convert_3_M_AXI_ARREADY : STD_LOGIC;
  signal axi_protocol_convert_3_M_AXI_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_protocol_convert_3_M_AXI_ARVALID : STD_LOGIC;
  signal axi_protocol_convert_3_M_AXI_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_protocol_convert_3_M_AXI_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_protocol_convert_3_M_AXI_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_protocol_convert_3_M_AXI_AWLEN : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_protocol_convert_3_M_AXI_AWLOCK : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_protocol_convert_3_M_AXI_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_protocol_convert_3_M_AXI_AWQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_protocol_convert_3_M_AXI_AWREADY : STD_LOGIC;
  signal axi_protocol_convert_3_M_AXI_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_protocol_convert_3_M_AXI_AWVALID : STD_LOGIC;
  signal axi_protocol_convert_3_M_AXI_BREADY : STD_LOGIC;
  signal axi_protocol_convert_3_M_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_protocol_convert_3_M_AXI_BVALID : STD_LOGIC;
  signal axi_protocol_convert_3_M_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_protocol_convert_3_M_AXI_RLAST : STD_LOGIC;
  signal axi_protocol_convert_3_M_AXI_RREADY : STD_LOGIC;
  signal axi_protocol_convert_3_M_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_protocol_convert_3_M_AXI_RVALID : STD_LOGIC;
  signal axi_protocol_convert_3_M_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_protocol_convert_3_M_AXI_WLAST : STD_LOGIC;
  signal axi_protocol_convert_3_M_AXI_WREADY : STD_LOGIC;
  signal axi_protocol_convert_3_M_AXI_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_protocol_convert_3_M_AXI_WVALID : STD_LOGIC;
  signal conv_accelerator_0_swap_banks : STD_LOGIC;
  signal conv_accelerator_wra_0_BRAM_FILTER0_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal conv_accelerator_wra_0_BRAM_FILTER0_CLK : STD_LOGIC;
  signal conv_accelerator_wra_0_BRAM_FILTER0_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal conv_accelerator_wra_0_BRAM_FILTER0_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal conv_accelerator_wra_0_BRAM_FILTER0_EN : STD_LOGIC;
  signal conv_accelerator_wra_0_BRAM_FILTER0_RST : STD_LOGIC;
  signal conv_accelerator_wra_0_BRAM_FILTER0_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal conv_accelerator_wra_0_BRAM_FILTER1_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal conv_accelerator_wra_0_BRAM_FILTER1_CLK : STD_LOGIC;
  signal conv_accelerator_wra_0_BRAM_FILTER1_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal conv_accelerator_wra_0_BRAM_FILTER1_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal conv_accelerator_wra_0_BRAM_FILTER1_EN : STD_LOGIC;
  signal conv_accelerator_wra_0_BRAM_FILTER1_RST : STD_LOGIC;
  signal conv_accelerator_wra_0_BRAM_FILTER1_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal conv_accelerator_wra_0_BRAM_FILTER2_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal conv_accelerator_wra_0_BRAM_FILTER2_CLK : STD_LOGIC;
  signal conv_accelerator_wra_0_BRAM_FILTER2_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal conv_accelerator_wra_0_BRAM_FILTER2_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal conv_accelerator_wra_0_BRAM_FILTER2_EN : STD_LOGIC;
  signal conv_accelerator_wra_0_BRAM_FILTER2_RST : STD_LOGIC;
  signal conv_accelerator_wra_0_BRAM_FILTER2_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal conv_accelerator_wra_0_BRAM_FILTER3_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal conv_accelerator_wra_0_BRAM_FILTER3_CLK : STD_LOGIC;
  signal conv_accelerator_wra_0_BRAM_FILTER3_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal conv_accelerator_wra_0_BRAM_FILTER3_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal conv_accelerator_wra_0_BRAM_FILTER3_EN : STD_LOGIC;
  signal conv_accelerator_wra_0_BRAM_FILTER3_RST : STD_LOGIC;
  signal conv_accelerator_wra_0_BRAM_FILTER3_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal conv_accelerator_wra_0_BRAM_INPUT_ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal conv_accelerator_wra_0_BRAM_INPUT_CLK : STD_LOGIC;
  signal conv_accelerator_wra_0_BRAM_INPUT_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal conv_accelerator_wra_0_BRAM_INPUT_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal conv_accelerator_wra_0_BRAM_INPUT_EN : STD_LOGIC;
  signal conv_accelerator_wra_0_BRAM_INPUT_RST : STD_LOGIC;
  signal conv_accelerator_wra_0_BRAM_INPUT_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal conv_accelerator_wra_0_ps_controls_activation_bram : STD_LOGIC;
  signal conv_accelerator_wra_0_swap_activations : STD_LOGIC;
  signal processing_system7_0_DDR_ADDR : STD_LOGIC_VECTOR ( 14 downto 0 );
  signal processing_system7_0_DDR_BA : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal processing_system7_0_DDR_CAS_N : STD_LOGIC;
  signal processing_system7_0_DDR_CKE : STD_LOGIC;
  signal processing_system7_0_DDR_CK_N : STD_LOGIC;
  signal processing_system7_0_DDR_CK_P : STD_LOGIC;
  signal processing_system7_0_DDR_CS_N : STD_LOGIC;
  signal processing_system7_0_DDR_DM : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_DDR_DQ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_DDR_DQS_N : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_DDR_DQS_P : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_DDR_ODT : STD_LOGIC;
  signal processing_system7_0_DDR_RAS_N : STD_LOGIC;
  signal processing_system7_0_DDR_RESET_N : STD_LOGIC;
  signal processing_system7_0_DDR_WE_N : STD_LOGIC;
  signal processing_system7_0_FCLK_CLK0 : STD_LOGIC;
  signal processing_system7_0_FCLK_RESET0_N : STD_LOGIC;
  signal processing_system7_0_FIXED_IO_DDR_VRN : STD_LOGIC;
  signal processing_system7_0_FIXED_IO_DDR_VRP : STD_LOGIC;
  signal processing_system7_0_FIXED_IO_MIO : STD_LOGIC_VECTOR ( 53 downto 0 );
  signal processing_system7_0_FIXED_IO_PS_CLK : STD_LOGIC;
  signal processing_system7_0_FIXED_IO_PS_PORB : STD_LOGIC;
  signal processing_system7_0_FIXED_IO_PS_SRSTB : STD_LOGIC;
  signal processing_system7_0_M_AXI_GP0_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_M_AXI_GP0_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_M_AXI_GP0_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_M_AXI_GP0_ARID : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal processing_system7_0_M_AXI_GP0_ARLEN : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_M_AXI_GP0_ARLOCK : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_M_AXI_GP0_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal processing_system7_0_M_AXI_GP0_ARQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_M_AXI_GP0_ARREADY : STD_LOGIC;
  signal processing_system7_0_M_AXI_GP0_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal processing_system7_0_M_AXI_GP0_ARVALID : STD_LOGIC;
  signal processing_system7_0_M_AXI_GP0_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_M_AXI_GP0_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_M_AXI_GP0_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_M_AXI_GP0_AWID : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal processing_system7_0_M_AXI_GP0_AWLEN : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_M_AXI_GP0_AWLOCK : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_M_AXI_GP0_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal processing_system7_0_M_AXI_GP0_AWQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_M_AXI_GP0_AWREADY : STD_LOGIC;
  signal processing_system7_0_M_AXI_GP0_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal processing_system7_0_M_AXI_GP0_AWVALID : STD_LOGIC;
  signal processing_system7_0_M_AXI_GP0_BID : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal processing_system7_0_M_AXI_GP0_BREADY : STD_LOGIC;
  signal processing_system7_0_M_AXI_GP0_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_M_AXI_GP0_BVALID : STD_LOGIC;
  signal processing_system7_0_M_AXI_GP0_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_M_AXI_GP0_RID : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal processing_system7_0_M_AXI_GP0_RLAST : STD_LOGIC;
  signal processing_system7_0_M_AXI_GP0_RREADY : STD_LOGIC;
  signal processing_system7_0_M_AXI_GP0_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal processing_system7_0_M_AXI_GP0_RVALID : STD_LOGIC;
  signal processing_system7_0_M_AXI_GP0_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_M_AXI_GP0_WID : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal processing_system7_0_M_AXI_GP0_WLAST : STD_LOGIC;
  signal processing_system7_0_M_AXI_GP0_WREADY : STD_LOGIC;
  signal processing_system7_0_M_AXI_GP0_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_M_AXI_GP0_WVALID : STD_LOGIC;
  signal rst_ps7_0_100M_peripheral_aresetn : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_axi_cdma_0_cdma_introut_UNCONNECTED : STD_LOGIC;
  signal NLW_axi_crossbar_0_m_axi_arprot_UNCONNECTED : STD_LOGIC_VECTOR ( 5 downto 3 );
  signal NLW_axi_crossbar_0_m_axi_awprot_UNCONNECTED : STD_LOGIC_VECTOR ( 5 downto 3 );
  signal NLW_axi_crossbar_0_m_axi_wstrb_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 4 );
  signal NLW_axi_crossbar_1_m_axi_arqos_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 4 );
  signal NLW_axi_crossbar_1_m_axi_arregion_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 4 );
  signal NLW_axi_crossbar_1_m_axi_awqos_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 4 );
  signal NLW_axi_crossbar_1_m_axi_awregion_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 4 );
  signal NLW_processing_system7_0_S_AXI_HP0_BID_UNCONNECTED : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal NLW_processing_system7_0_S_AXI_HP0_RACOUNT_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_processing_system7_0_S_AXI_HP0_RCOUNT_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal NLW_processing_system7_0_S_AXI_HP0_RID_UNCONNECTED : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal NLW_processing_system7_0_S_AXI_HP0_WACOUNT_UNCONNECTED : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal NLW_processing_system7_0_S_AXI_HP0_WCOUNT_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal NLW_rst_ps7_0_200M_mb_reset_UNCONNECTED : STD_LOGIC;
  signal NLW_rst_ps7_0_200M_bus_struct_reset_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_rst_ps7_0_200M_interconnect_aresetn_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_rst_ps7_0_200M_peripheral_reset_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of DDR_cas_n : signal is "xilinx.com:interface:ddrx:1.0 DDR CAS_N";
  attribute X_INTERFACE_INFO of DDR_ck_n : signal is "xilinx.com:interface:ddrx:1.0 DDR CK_N";
  attribute X_INTERFACE_INFO of DDR_ck_p : signal is "xilinx.com:interface:ddrx:1.0 DDR CK_P";
  attribute X_INTERFACE_INFO of DDR_cke : signal is "xilinx.com:interface:ddrx:1.0 DDR CKE";
  attribute X_INTERFACE_INFO of DDR_cs_n : signal is "xilinx.com:interface:ddrx:1.0 DDR CS_N";
  attribute X_INTERFACE_INFO of DDR_odt : signal is "xilinx.com:interface:ddrx:1.0 DDR ODT";
  attribute X_INTERFACE_INFO of DDR_ras_n : signal is "xilinx.com:interface:ddrx:1.0 DDR RAS_N";
  attribute X_INTERFACE_INFO of DDR_reset_n : signal is "xilinx.com:interface:ddrx:1.0 DDR RESET_N";
  attribute X_INTERFACE_INFO of DDR_we_n : signal is "xilinx.com:interface:ddrx:1.0 DDR WE_N";
  attribute X_INTERFACE_INFO of FIXED_IO_ddr_vrn : signal is "xilinx.com:display_processing_system7:fixedio:1.0 FIXED_IO DDR_VRN";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of FIXED_IO_ddr_vrn : signal is "XIL_INTERFACENAME FIXED_IO, CAN_DEBUG false";
  attribute X_INTERFACE_INFO of FIXED_IO_ddr_vrp : signal is "xilinx.com:display_processing_system7:fixedio:1.0 FIXED_IO DDR_VRP";
  attribute X_INTERFACE_INFO of FIXED_IO_ps_clk : signal is "xilinx.com:display_processing_system7:fixedio:1.0 FIXED_IO PS_CLK";
  attribute X_INTERFACE_INFO of FIXED_IO_ps_porb : signal is "xilinx.com:display_processing_system7:fixedio:1.0 FIXED_IO PS_PORB";
  attribute X_INTERFACE_INFO of FIXED_IO_ps_srstb : signal is "xilinx.com:display_processing_system7:fixedio:1.0 FIXED_IO PS_SRSTB";
  attribute X_INTERFACE_INFO of DDR_addr : signal is "xilinx.com:interface:ddrx:1.0 DDR ADDR";
  attribute X_INTERFACE_PARAMETER of DDR_addr : signal is "XIL_INTERFACENAME DDR, AXI_ARBITRATION_SCHEME TDM, BURST_LENGTH 8, CAN_DEBUG false, CAS_LATENCY 11, CAS_WRITE_LATENCY 11, CS_ENABLED true, DATA_MASK_ENABLED true, DATA_WIDTH 8, MEMORY_TYPE COMPONENTS, MEM_ADDR_MAP ROW_COLUMN_BANK, SLOT Single, TIMEPERIOD_PS 1250";
  attribute X_INTERFACE_INFO of DDR_ba : signal is "xilinx.com:interface:ddrx:1.0 DDR BA";
  attribute X_INTERFACE_INFO of DDR_dm : signal is "xilinx.com:interface:ddrx:1.0 DDR DM";
  attribute X_INTERFACE_INFO of DDR_dq : signal is "xilinx.com:interface:ddrx:1.0 DDR DQ";
  attribute X_INTERFACE_INFO of DDR_dqs_n : signal is "xilinx.com:interface:ddrx:1.0 DDR DQS_N";
  attribute X_INTERFACE_INFO of DDR_dqs_p : signal is "xilinx.com:interface:ddrx:1.0 DDR DQS_P";
  attribute X_INTERFACE_INFO of FIXED_IO_mio : signal is "xilinx.com:display_processing_system7:fixedio:1.0 FIXED_IO MIO";
begin
axi_cdma_0: component conv_accelerator_bd_axi_cdma_0_0
     port map (
      cdma_introut => NLW_axi_cdma_0_cdma_introut_UNCONNECTED,
      m_axi_aclk => processing_system7_0_FCLK_CLK0,
      m_axi_araddr(31 downto 0) => axi_cdma_0_M_AXI_ARADDR(31 downto 0),
      m_axi_arburst(1 downto 0) => axi_cdma_0_M_AXI_ARBURST(1 downto 0),
      m_axi_arcache(3 downto 0) => axi_cdma_0_M_AXI_ARCACHE(3 downto 0),
      m_axi_arlen(7 downto 0) => axi_cdma_0_M_AXI_ARLEN(7 downto 0),
      m_axi_arprot(2 downto 0) => axi_cdma_0_M_AXI_ARPROT(2 downto 0),
      m_axi_arready => axi_cdma_0_M_AXI_ARREADY(0),
      m_axi_arsize(2 downto 0) => axi_cdma_0_M_AXI_ARSIZE(2 downto 0),
      m_axi_arvalid => axi_cdma_0_M_AXI_ARVALID,
      m_axi_awaddr(31 downto 0) => axi_cdma_0_M_AXI_AWADDR(31 downto 0),
      m_axi_awburst(1 downto 0) => axi_cdma_0_M_AXI_AWBURST(1 downto 0),
      m_axi_awcache(3 downto 0) => axi_cdma_0_M_AXI_AWCACHE(3 downto 0),
      m_axi_awlen(7 downto 0) => axi_cdma_0_M_AXI_AWLEN(7 downto 0),
      m_axi_awprot(2 downto 0) => axi_cdma_0_M_AXI_AWPROT(2 downto 0),
      m_axi_awready => axi_cdma_0_M_AXI_AWREADY(0),
      m_axi_awsize(2 downto 0) => axi_cdma_0_M_AXI_AWSIZE(2 downto 0),
      m_axi_awvalid => axi_cdma_0_M_AXI_AWVALID,
      m_axi_bready => axi_cdma_0_M_AXI_BREADY,
      m_axi_bresp(1 downto 0) => axi_cdma_0_M_AXI_BRESP(1 downto 0),
      m_axi_bvalid => axi_cdma_0_M_AXI_BVALID(0),
      m_axi_rdata(31 downto 0) => axi_cdma_0_M_AXI_RDATA(31 downto 0),
      m_axi_rlast => axi_cdma_0_M_AXI_RLAST(0),
      m_axi_rready => axi_cdma_0_M_AXI_RREADY,
      m_axi_rresp(1 downto 0) => axi_cdma_0_M_AXI_RRESP(1 downto 0),
      m_axi_rvalid => axi_cdma_0_M_AXI_RVALID(0),
      m_axi_wdata(31 downto 0) => axi_cdma_0_M_AXI_WDATA(31 downto 0),
      m_axi_wlast => axi_cdma_0_M_AXI_WLAST,
      m_axi_wready => axi_cdma_0_M_AXI_WREADY(0),
      m_axi_wstrb(3 downto 0) => axi_cdma_0_M_AXI_WSTRB(3 downto 0),
      m_axi_wvalid => axi_cdma_0_M_AXI_WVALID,
      s_axi_lite_aclk => processing_system7_0_FCLK_CLK0,
      s_axi_lite_araddr(5 downto 0) => axi_crossbar_0_M01_AXI_ARADDR(37 downto 32),
      s_axi_lite_aresetn => rst_ps7_0_100M_peripheral_aresetn(0),
      s_axi_lite_arready => axi_crossbar_0_M01_AXI_ARREADY,
      s_axi_lite_arvalid => axi_crossbar_0_M01_AXI_ARVALID(1),
      s_axi_lite_awaddr(5 downto 0) => axi_crossbar_0_M01_AXI_AWADDR(37 downto 32),
      s_axi_lite_awready => axi_crossbar_0_M01_AXI_AWREADY,
      s_axi_lite_awvalid => axi_crossbar_0_M01_AXI_AWVALID(1),
      s_axi_lite_bready => axi_crossbar_0_M01_AXI_BREADY(1),
      s_axi_lite_bresp(1 downto 0) => axi_crossbar_0_M01_AXI_BRESP(1 downto 0),
      s_axi_lite_bvalid => axi_crossbar_0_M01_AXI_BVALID,
      s_axi_lite_rdata(31 downto 0) => axi_crossbar_0_M01_AXI_RDATA(31 downto 0),
      s_axi_lite_rready => axi_crossbar_0_M01_AXI_RREADY(1),
      s_axi_lite_rresp(1 downto 0) => axi_crossbar_0_M01_AXI_RRESP(1 downto 0),
      s_axi_lite_rvalid => axi_crossbar_0_M01_AXI_RVALID,
      s_axi_lite_wdata(31 downto 0) => axi_crossbar_0_M01_AXI_WDATA(63 downto 32),
      s_axi_lite_wready => axi_crossbar_0_M01_AXI_WREADY,
      s_axi_lite_wvalid => axi_crossbar_0_M01_AXI_WVALID(1)
    );
axi_crossbar_0: component conv_accelerator_bd_axi_crossbar_0_0
     port map (
      aclk => processing_system7_0_FCLK_CLK0,
      aresetn => rst_ps7_0_100M_peripheral_aresetn(0),
      m_axi_araddr(63 downto 32) => axi_crossbar_0_M01_AXI_ARADDR(63 downto 32),
      m_axi_araddr(31 downto 0) => axi_crossbar_0_M00_AXI_ARADDR(31 downto 0),
      m_axi_arprot(5 downto 3) => NLW_axi_crossbar_0_m_axi_arprot_UNCONNECTED(5 downto 3),
      m_axi_arprot(2 downto 0) => axi_crossbar_0_M00_AXI_ARPROT(2 downto 0),
      m_axi_arready(1) => axi_crossbar_0_M01_AXI_ARREADY,
      m_axi_arready(0) => axi_crossbar_0_M00_AXI_ARREADY,
      m_axi_arvalid(1) => axi_crossbar_0_M01_AXI_ARVALID(1),
      m_axi_arvalid(0) => axi_crossbar_0_M00_AXI_ARVALID(0),
      m_axi_awaddr(63 downto 32) => axi_crossbar_0_M01_AXI_AWADDR(63 downto 32),
      m_axi_awaddr(31 downto 0) => axi_crossbar_0_M00_AXI_AWADDR(31 downto 0),
      m_axi_awprot(5 downto 3) => NLW_axi_crossbar_0_m_axi_awprot_UNCONNECTED(5 downto 3),
      m_axi_awprot(2 downto 0) => axi_crossbar_0_M00_AXI_AWPROT(2 downto 0),
      m_axi_awready(1) => axi_crossbar_0_M01_AXI_AWREADY,
      m_axi_awready(0) => axi_crossbar_0_M00_AXI_AWREADY,
      m_axi_awvalid(1) => axi_crossbar_0_M01_AXI_AWVALID(1),
      m_axi_awvalid(0) => axi_crossbar_0_M00_AXI_AWVALID(0),
      m_axi_bready(1) => axi_crossbar_0_M01_AXI_BREADY(1),
      m_axi_bready(0) => axi_crossbar_0_M00_AXI_BREADY(0),
      m_axi_bresp(3 downto 2) => axi_crossbar_0_M01_AXI_BRESP(1 downto 0),
      m_axi_bresp(1 downto 0) => axi_crossbar_0_M00_AXI_BRESP(1 downto 0),
      m_axi_bvalid(1) => axi_crossbar_0_M01_AXI_BVALID,
      m_axi_bvalid(0) => axi_crossbar_0_M00_AXI_BVALID,
      m_axi_rdata(63 downto 32) => axi_crossbar_0_M01_AXI_RDATA(31 downto 0),
      m_axi_rdata(31 downto 0) => axi_crossbar_0_M00_AXI_RDATA(31 downto 0),
      m_axi_rready(1) => axi_crossbar_0_M01_AXI_RREADY(1),
      m_axi_rready(0) => axi_crossbar_0_M00_AXI_RREADY(0),
      m_axi_rresp(3 downto 2) => axi_crossbar_0_M01_AXI_RRESP(1 downto 0),
      m_axi_rresp(1 downto 0) => axi_crossbar_0_M00_AXI_RRESP(1 downto 0),
      m_axi_rvalid(1) => axi_crossbar_0_M01_AXI_RVALID,
      m_axi_rvalid(0) => axi_crossbar_0_M00_AXI_RVALID,
      m_axi_wdata(63 downto 32) => axi_crossbar_0_M01_AXI_WDATA(63 downto 32),
      m_axi_wdata(31 downto 0) => axi_crossbar_0_M00_AXI_WDATA(31 downto 0),
      m_axi_wready(1) => axi_crossbar_0_M01_AXI_WREADY,
      m_axi_wready(0) => axi_crossbar_0_M00_AXI_WREADY,
      m_axi_wstrb(7 downto 4) => NLW_axi_crossbar_0_m_axi_wstrb_UNCONNECTED(7 downto 4),
      m_axi_wstrb(3 downto 0) => axi_crossbar_0_M00_AXI_WSTRB(3 downto 0),
      m_axi_wvalid(1) => axi_crossbar_0_M01_AXI_WVALID(1),
      m_axi_wvalid(0) => axi_crossbar_0_M00_AXI_WVALID(0),
      s_axi_araddr(31 downto 0) => axi_protocol_convert_0_M_AXI_ARADDR(31 downto 0),
      s_axi_arprot(2 downto 0) => axi_protocol_convert_0_M_AXI_ARPROT(2 downto 0),
      s_axi_arready(0) => axi_protocol_convert_0_M_AXI_ARREADY(0),
      s_axi_arvalid(0) => axi_protocol_convert_0_M_AXI_ARVALID,
      s_axi_awaddr(31 downto 0) => axi_protocol_convert_0_M_AXI_AWADDR(31 downto 0),
      s_axi_awprot(2 downto 0) => axi_protocol_convert_0_M_AXI_AWPROT(2 downto 0),
      s_axi_awready(0) => axi_protocol_convert_0_M_AXI_AWREADY(0),
      s_axi_awvalid(0) => axi_protocol_convert_0_M_AXI_AWVALID,
      s_axi_bready(0) => axi_protocol_convert_0_M_AXI_BREADY,
      s_axi_bresp(1 downto 0) => axi_protocol_convert_0_M_AXI_BRESP(1 downto 0),
      s_axi_bvalid(0) => axi_protocol_convert_0_M_AXI_BVALID(0),
      s_axi_rdata(31 downto 0) => axi_protocol_convert_0_M_AXI_RDATA(31 downto 0),
      s_axi_rready(0) => axi_protocol_convert_0_M_AXI_RREADY,
      s_axi_rresp(1 downto 0) => axi_protocol_convert_0_M_AXI_RRESP(1 downto 0),
      s_axi_rvalid(0) => axi_protocol_convert_0_M_AXI_RVALID(0),
      s_axi_wdata(31 downto 0) => axi_protocol_convert_0_M_AXI_WDATA(31 downto 0),
      s_axi_wready(0) => axi_protocol_convert_0_M_AXI_WREADY(0),
      s_axi_wstrb(3 downto 0) => axi_protocol_convert_0_M_AXI_WSTRB(3 downto 0),
      s_axi_wvalid(0) => axi_protocol_convert_0_M_AXI_WVALID
    );
axi_crossbar_1: component conv_accelerator_bd_axi_crossbar_1_0
     port map (
      aclk => processing_system7_0_FCLK_CLK0,
      aresetn => rst_ps7_0_100M_peripheral_aresetn(0),
      m_axi_araddr(63 downto 32) => axi_crossbar_1_M01_AXI_ARADDR(63 downto 32),
      m_axi_araddr(31 downto 0) => axi_crossbar_1_M00_AXI_ARADDR(31 downto 0),
      m_axi_arburst(3 downto 2) => axi_crossbar_1_M01_AXI_ARBURST(3 downto 2),
      m_axi_arburst(1 downto 0) => axi_crossbar_1_M00_AXI_ARBURST(1 downto 0),
      m_axi_arcache(7 downto 4) => axi_crossbar_1_M01_AXI_ARCACHE(7 downto 4),
      m_axi_arcache(3 downto 0) => axi_crossbar_1_M00_AXI_ARCACHE(3 downto 0),
      m_axi_arlen(15 downto 8) => axi_crossbar_1_M01_AXI_ARLEN(15 downto 8),
      m_axi_arlen(7 downto 0) => axi_crossbar_1_M00_AXI_ARLEN(7 downto 0),
      m_axi_arlock(1) => axi_crossbar_1_M01_AXI_ARLOCK(1),
      m_axi_arlock(0) => axi_crossbar_1_M00_AXI_ARLOCK(0),
      m_axi_arprot(5 downto 3) => axi_crossbar_1_M01_AXI_ARPROT(5 downto 3),
      m_axi_arprot(2 downto 0) => axi_crossbar_1_M00_AXI_ARPROT(2 downto 0),
      m_axi_arqos(7 downto 4) => NLW_axi_crossbar_1_m_axi_arqos_UNCONNECTED(7 downto 4),
      m_axi_arqos(3 downto 0) => axi_crossbar_1_M00_AXI_ARQOS(3 downto 0),
      m_axi_arready(1) => axi_crossbar_1_M01_AXI_ARREADY,
      m_axi_arready(0) => axi_crossbar_1_M00_AXI_ARREADY,
      m_axi_arregion(7 downto 4) => NLW_axi_crossbar_1_m_axi_arregion_UNCONNECTED(7 downto 4),
      m_axi_arregion(3 downto 0) => axi_crossbar_1_M00_AXI_ARREGION(3 downto 0),
      m_axi_arsize(5 downto 3) => axi_crossbar_1_M01_AXI_ARSIZE(5 downto 3),
      m_axi_arsize(2 downto 0) => axi_crossbar_1_M00_AXI_ARSIZE(2 downto 0),
      m_axi_arvalid(1) => axi_crossbar_1_M01_AXI_ARVALID(1),
      m_axi_arvalid(0) => axi_crossbar_1_M00_AXI_ARVALID(0),
      m_axi_awaddr(63 downto 32) => axi_crossbar_1_M01_AXI_AWADDR(63 downto 32),
      m_axi_awaddr(31 downto 0) => axi_crossbar_1_M00_AXI_AWADDR(31 downto 0),
      m_axi_awburst(3 downto 2) => axi_crossbar_1_M01_AXI_AWBURST(3 downto 2),
      m_axi_awburst(1 downto 0) => axi_crossbar_1_M00_AXI_AWBURST(1 downto 0),
      m_axi_awcache(7 downto 4) => axi_crossbar_1_M01_AXI_AWCACHE(7 downto 4),
      m_axi_awcache(3 downto 0) => axi_crossbar_1_M00_AXI_AWCACHE(3 downto 0),
      m_axi_awlen(15 downto 8) => axi_crossbar_1_M01_AXI_AWLEN(15 downto 8),
      m_axi_awlen(7 downto 0) => axi_crossbar_1_M00_AXI_AWLEN(7 downto 0),
      m_axi_awlock(1) => axi_crossbar_1_M01_AXI_AWLOCK(1),
      m_axi_awlock(0) => axi_crossbar_1_M00_AXI_AWLOCK(0),
      m_axi_awprot(5 downto 3) => axi_crossbar_1_M01_AXI_AWPROT(5 downto 3),
      m_axi_awprot(2 downto 0) => axi_crossbar_1_M00_AXI_AWPROT(2 downto 0),
      m_axi_awqos(7 downto 4) => NLW_axi_crossbar_1_m_axi_awqos_UNCONNECTED(7 downto 4),
      m_axi_awqos(3 downto 0) => axi_crossbar_1_M00_AXI_AWQOS(3 downto 0),
      m_axi_awready(1) => axi_crossbar_1_M01_AXI_AWREADY,
      m_axi_awready(0) => axi_crossbar_1_M00_AXI_AWREADY,
      m_axi_awregion(7 downto 4) => NLW_axi_crossbar_1_m_axi_awregion_UNCONNECTED(7 downto 4),
      m_axi_awregion(3 downto 0) => axi_crossbar_1_M00_AXI_AWREGION(3 downto 0),
      m_axi_awsize(5 downto 3) => axi_crossbar_1_M01_AXI_AWSIZE(5 downto 3),
      m_axi_awsize(2 downto 0) => axi_crossbar_1_M00_AXI_AWSIZE(2 downto 0),
      m_axi_awvalid(1) => axi_crossbar_1_M01_AXI_AWVALID(1),
      m_axi_awvalid(0) => axi_crossbar_1_M00_AXI_AWVALID(0),
      m_axi_bready(1) => axi_crossbar_1_M01_AXI_BREADY(1),
      m_axi_bready(0) => axi_crossbar_1_M00_AXI_BREADY(0),
      m_axi_bresp(3 downto 2) => axi_crossbar_1_M01_AXI_BRESP(1 downto 0),
      m_axi_bresp(1 downto 0) => axi_crossbar_1_M00_AXI_BRESP(1 downto 0),
      m_axi_bvalid(1) => axi_crossbar_1_M01_AXI_BVALID,
      m_axi_bvalid(0) => axi_crossbar_1_M00_AXI_BVALID,
      m_axi_rdata(63 downto 32) => axi_crossbar_1_M01_AXI_RDATA(31 downto 0),
      m_axi_rdata(31 downto 0) => axi_crossbar_1_M00_AXI_RDATA(31 downto 0),
      m_axi_rlast(1) => axi_crossbar_1_M01_AXI_RLAST,
      m_axi_rlast(0) => axi_crossbar_1_M00_AXI_RLAST,
      m_axi_rready(1) => axi_crossbar_1_M01_AXI_RREADY(1),
      m_axi_rready(0) => axi_crossbar_1_M00_AXI_RREADY(0),
      m_axi_rresp(3 downto 2) => axi_crossbar_1_M01_AXI_RRESP(1 downto 0),
      m_axi_rresp(1 downto 0) => axi_crossbar_1_M00_AXI_RRESP(1 downto 0),
      m_axi_rvalid(1) => axi_crossbar_1_M01_AXI_RVALID,
      m_axi_rvalid(0) => axi_crossbar_1_M00_AXI_RVALID,
      m_axi_wdata(63 downto 32) => axi_crossbar_1_M01_AXI_WDATA(63 downto 32),
      m_axi_wdata(31 downto 0) => axi_crossbar_1_M00_AXI_WDATA(31 downto 0),
      m_axi_wlast(1) => axi_crossbar_1_M01_AXI_WLAST(1),
      m_axi_wlast(0) => axi_crossbar_1_M00_AXI_WLAST(0),
      m_axi_wready(1) => axi_crossbar_1_M01_AXI_WREADY,
      m_axi_wready(0) => axi_crossbar_1_M00_AXI_WREADY,
      m_axi_wstrb(7 downto 4) => axi_crossbar_1_M01_AXI_WSTRB(7 downto 4),
      m_axi_wstrb(3 downto 0) => axi_crossbar_1_M00_AXI_WSTRB(3 downto 0),
      m_axi_wvalid(1) => axi_crossbar_1_M01_AXI_WVALID(1),
      m_axi_wvalid(0) => axi_crossbar_1_M00_AXI_WVALID(0),
      s_axi_araddr(31 downto 0) => axi_cdma_0_M_AXI_ARADDR(31 downto 0),
      s_axi_arburst(1 downto 0) => axi_cdma_0_M_AXI_ARBURST(1 downto 0),
      s_axi_arcache(3 downto 0) => axi_cdma_0_M_AXI_ARCACHE(3 downto 0),
      s_axi_arlen(7 downto 0) => axi_cdma_0_M_AXI_ARLEN(7 downto 0),
      s_axi_arlock(0) => '0',
      s_axi_arprot(2 downto 0) => axi_cdma_0_M_AXI_ARPROT(2 downto 0),
      s_axi_arqos(3 downto 0) => B"0000",
      s_axi_arready(0) => axi_cdma_0_M_AXI_ARREADY(0),
      s_axi_arsize(2 downto 0) => axi_cdma_0_M_AXI_ARSIZE(2 downto 0),
      s_axi_arvalid(0) => axi_cdma_0_M_AXI_ARVALID,
      s_axi_awaddr(31 downto 0) => axi_cdma_0_M_AXI_AWADDR(31 downto 0),
      s_axi_awburst(1 downto 0) => axi_cdma_0_M_AXI_AWBURST(1 downto 0),
      s_axi_awcache(3 downto 0) => axi_cdma_0_M_AXI_AWCACHE(3 downto 0),
      s_axi_awlen(7 downto 0) => axi_cdma_0_M_AXI_AWLEN(7 downto 0),
      s_axi_awlock(0) => '0',
      s_axi_awprot(2 downto 0) => axi_cdma_0_M_AXI_AWPROT(2 downto 0),
      s_axi_awqos(3 downto 0) => B"0000",
      s_axi_awready(0) => axi_cdma_0_M_AXI_AWREADY(0),
      s_axi_awsize(2 downto 0) => axi_cdma_0_M_AXI_AWSIZE(2 downto 0),
      s_axi_awvalid(0) => axi_cdma_0_M_AXI_AWVALID,
      s_axi_bready(0) => axi_cdma_0_M_AXI_BREADY,
      s_axi_bresp(1 downto 0) => axi_cdma_0_M_AXI_BRESP(1 downto 0),
      s_axi_bvalid(0) => axi_cdma_0_M_AXI_BVALID(0),
      s_axi_rdata(31 downto 0) => axi_cdma_0_M_AXI_RDATA(31 downto 0),
      s_axi_rlast(0) => axi_cdma_0_M_AXI_RLAST(0),
      s_axi_rready(0) => axi_cdma_0_M_AXI_RREADY,
      s_axi_rresp(1 downto 0) => axi_cdma_0_M_AXI_RRESP(1 downto 0),
      s_axi_rvalid(0) => axi_cdma_0_M_AXI_RVALID(0),
      s_axi_wdata(31 downto 0) => axi_cdma_0_M_AXI_WDATA(31 downto 0),
      s_axi_wlast(0) => axi_cdma_0_M_AXI_WLAST,
      s_axi_wready(0) => axi_cdma_0_M_AXI_WREADY(0),
      s_axi_wstrb(3 downto 0) => axi_cdma_0_M_AXI_WSTRB(3 downto 0),
      s_axi_wvalid(0) => axi_cdma_0_M_AXI_WVALID
    );
axi_protocol_convert_0: component conv_accelerator_bd_axi_protocol_convert_0_0
     port map (
      aclk => processing_system7_0_FCLK_CLK0,
      aresetn => rst_ps7_0_100M_peripheral_aresetn(0),
      m_axi_araddr(31 downto 0) => axi_protocol_convert_0_M_AXI_ARADDR(31 downto 0),
      m_axi_arprot(2 downto 0) => axi_protocol_convert_0_M_AXI_ARPROT(2 downto 0),
      m_axi_arready => axi_protocol_convert_0_M_AXI_ARREADY(0),
      m_axi_arvalid => axi_protocol_convert_0_M_AXI_ARVALID,
      m_axi_awaddr(31 downto 0) => axi_protocol_convert_0_M_AXI_AWADDR(31 downto 0),
      m_axi_awprot(2 downto 0) => axi_protocol_convert_0_M_AXI_AWPROT(2 downto 0),
      m_axi_awready => axi_protocol_convert_0_M_AXI_AWREADY(0),
      m_axi_awvalid => axi_protocol_convert_0_M_AXI_AWVALID,
      m_axi_bready => axi_protocol_convert_0_M_AXI_BREADY,
      m_axi_bresp(1 downto 0) => axi_protocol_convert_0_M_AXI_BRESP(1 downto 0),
      m_axi_bvalid => axi_protocol_convert_0_M_AXI_BVALID(0),
      m_axi_rdata(31 downto 0) => axi_protocol_convert_0_M_AXI_RDATA(31 downto 0),
      m_axi_rready => axi_protocol_convert_0_M_AXI_RREADY,
      m_axi_rresp(1 downto 0) => axi_protocol_convert_0_M_AXI_RRESP(1 downto 0),
      m_axi_rvalid => axi_protocol_convert_0_M_AXI_RVALID(0),
      m_axi_wdata(31 downto 0) => axi_protocol_convert_0_M_AXI_WDATA(31 downto 0),
      m_axi_wready => axi_protocol_convert_0_M_AXI_WREADY(0),
      m_axi_wstrb(3 downto 0) => axi_protocol_convert_0_M_AXI_WSTRB(3 downto 0),
      m_axi_wvalid => axi_protocol_convert_0_M_AXI_WVALID,
      s_axi_araddr(31 downto 0) => processing_system7_0_M_AXI_GP0_ARADDR(31 downto 0),
      s_axi_arburst(1 downto 0) => processing_system7_0_M_AXI_GP0_ARBURST(1 downto 0),
      s_axi_arcache(3 downto 0) => processing_system7_0_M_AXI_GP0_ARCACHE(3 downto 0),
      s_axi_arid(11 downto 0) => processing_system7_0_M_AXI_GP0_ARID(11 downto 0),
      s_axi_arlen(3 downto 0) => processing_system7_0_M_AXI_GP0_ARLEN(3 downto 0),
      s_axi_arlock(1 downto 0) => processing_system7_0_M_AXI_GP0_ARLOCK(1 downto 0),
      s_axi_arprot(2 downto 0) => processing_system7_0_M_AXI_GP0_ARPROT(2 downto 0),
      s_axi_arqos(3 downto 0) => processing_system7_0_M_AXI_GP0_ARQOS(3 downto 0),
      s_axi_arready => processing_system7_0_M_AXI_GP0_ARREADY,
      s_axi_arsize(2 downto 0) => processing_system7_0_M_AXI_GP0_ARSIZE(2 downto 0),
      s_axi_arvalid => processing_system7_0_M_AXI_GP0_ARVALID,
      s_axi_awaddr(31 downto 0) => processing_system7_0_M_AXI_GP0_AWADDR(31 downto 0),
      s_axi_awburst(1 downto 0) => processing_system7_0_M_AXI_GP0_AWBURST(1 downto 0),
      s_axi_awcache(3 downto 0) => processing_system7_0_M_AXI_GP0_AWCACHE(3 downto 0),
      s_axi_awid(11 downto 0) => processing_system7_0_M_AXI_GP0_AWID(11 downto 0),
      s_axi_awlen(3 downto 0) => processing_system7_0_M_AXI_GP0_AWLEN(3 downto 0),
      s_axi_awlock(1 downto 0) => processing_system7_0_M_AXI_GP0_AWLOCK(1 downto 0),
      s_axi_awprot(2 downto 0) => processing_system7_0_M_AXI_GP0_AWPROT(2 downto 0),
      s_axi_awqos(3 downto 0) => processing_system7_0_M_AXI_GP0_AWQOS(3 downto 0),
      s_axi_awready => processing_system7_0_M_AXI_GP0_AWREADY,
      s_axi_awsize(2 downto 0) => processing_system7_0_M_AXI_GP0_AWSIZE(2 downto 0),
      s_axi_awvalid => processing_system7_0_M_AXI_GP0_AWVALID,
      s_axi_bid(11 downto 0) => processing_system7_0_M_AXI_GP0_BID(11 downto 0),
      s_axi_bready => processing_system7_0_M_AXI_GP0_BREADY,
      s_axi_bresp(1 downto 0) => processing_system7_0_M_AXI_GP0_BRESP(1 downto 0),
      s_axi_bvalid => processing_system7_0_M_AXI_GP0_BVALID,
      s_axi_rdata(31 downto 0) => processing_system7_0_M_AXI_GP0_RDATA(31 downto 0),
      s_axi_rid(11 downto 0) => processing_system7_0_M_AXI_GP0_RID(11 downto 0),
      s_axi_rlast => processing_system7_0_M_AXI_GP0_RLAST,
      s_axi_rready => processing_system7_0_M_AXI_GP0_RREADY,
      s_axi_rresp(1 downto 0) => processing_system7_0_M_AXI_GP0_RRESP(1 downto 0),
      s_axi_rvalid => processing_system7_0_M_AXI_GP0_RVALID,
      s_axi_wdata(31 downto 0) => processing_system7_0_M_AXI_GP0_WDATA(31 downto 0),
      s_axi_wid(11 downto 0) => processing_system7_0_M_AXI_GP0_WID(11 downto 0),
      s_axi_wlast => processing_system7_0_M_AXI_GP0_WLAST,
      s_axi_wready => processing_system7_0_M_AXI_GP0_WREADY,
      s_axi_wstrb(3 downto 0) => processing_system7_0_M_AXI_GP0_WSTRB(3 downto 0),
      s_axi_wvalid => processing_system7_0_M_AXI_GP0_WVALID
    );
axi_protocol_convert_3: component conv_accelerator_bd_axi_protocol_convert_3_0
     port map (
      aclk => processing_system7_0_FCLK_CLK0,
      aresetn => rst_ps7_0_100M_peripheral_aresetn(0),
      m_axi_araddr(31 downto 0) => axi_protocol_convert_3_M_AXI_ARADDR(31 downto 0),
      m_axi_arburst(1 downto 0) => axi_protocol_convert_3_M_AXI_ARBURST(1 downto 0),
      m_axi_arcache(3 downto 0) => axi_protocol_convert_3_M_AXI_ARCACHE(3 downto 0),
      m_axi_arlen(3 downto 0) => axi_protocol_convert_3_M_AXI_ARLEN(3 downto 0),
      m_axi_arlock(1 downto 0) => axi_protocol_convert_3_M_AXI_ARLOCK(1 downto 0),
      m_axi_arprot(2 downto 0) => axi_protocol_convert_3_M_AXI_ARPROT(2 downto 0),
      m_axi_arqos(3 downto 0) => axi_protocol_convert_3_M_AXI_ARQOS(3 downto 0),
      m_axi_arready => axi_protocol_convert_3_M_AXI_ARREADY,
      m_axi_arsize(2 downto 0) => axi_protocol_convert_3_M_AXI_ARSIZE(2 downto 0),
      m_axi_arvalid => axi_protocol_convert_3_M_AXI_ARVALID,
      m_axi_awaddr(31 downto 0) => axi_protocol_convert_3_M_AXI_AWADDR(31 downto 0),
      m_axi_awburst(1 downto 0) => axi_protocol_convert_3_M_AXI_AWBURST(1 downto 0),
      m_axi_awcache(3 downto 0) => axi_protocol_convert_3_M_AXI_AWCACHE(3 downto 0),
      m_axi_awlen(3 downto 0) => axi_protocol_convert_3_M_AXI_AWLEN(3 downto 0),
      m_axi_awlock(1 downto 0) => axi_protocol_convert_3_M_AXI_AWLOCK(1 downto 0),
      m_axi_awprot(2 downto 0) => axi_protocol_convert_3_M_AXI_AWPROT(2 downto 0),
      m_axi_awqos(3 downto 0) => axi_protocol_convert_3_M_AXI_AWQOS(3 downto 0),
      m_axi_awready => axi_protocol_convert_3_M_AXI_AWREADY,
      m_axi_awsize(2 downto 0) => axi_protocol_convert_3_M_AXI_AWSIZE(2 downto 0),
      m_axi_awvalid => axi_protocol_convert_3_M_AXI_AWVALID,
      m_axi_bready => axi_protocol_convert_3_M_AXI_BREADY,
      m_axi_bresp(1 downto 0) => axi_protocol_convert_3_M_AXI_BRESP(1 downto 0),
      m_axi_bvalid => axi_protocol_convert_3_M_AXI_BVALID,
      m_axi_rdata(31 downto 0) => axi_protocol_convert_3_M_AXI_RDATA(31 downto 0),
      m_axi_rlast => axi_protocol_convert_3_M_AXI_RLAST,
      m_axi_rready => axi_protocol_convert_3_M_AXI_RREADY,
      m_axi_rresp(1 downto 0) => axi_protocol_convert_3_M_AXI_RRESP(1 downto 0),
      m_axi_rvalid => axi_protocol_convert_3_M_AXI_RVALID,
      m_axi_wdata(31 downto 0) => axi_protocol_convert_3_M_AXI_WDATA(31 downto 0),
      m_axi_wlast => axi_protocol_convert_3_M_AXI_WLAST,
      m_axi_wready => axi_protocol_convert_3_M_AXI_WREADY,
      m_axi_wstrb(3 downto 0) => axi_protocol_convert_3_M_AXI_WSTRB(3 downto 0),
      m_axi_wvalid => axi_protocol_convert_3_M_AXI_WVALID,
      s_axi_araddr(31 downto 0) => axi_crossbar_1_M00_AXI_ARADDR(31 downto 0),
      s_axi_arburst(1 downto 0) => axi_crossbar_1_M00_AXI_ARBURST(1 downto 0),
      s_axi_arcache(3 downto 0) => axi_crossbar_1_M00_AXI_ARCACHE(3 downto 0),
      s_axi_arlen(7 downto 0) => axi_crossbar_1_M00_AXI_ARLEN(7 downto 0),
      s_axi_arlock(0) => axi_crossbar_1_M00_AXI_ARLOCK(0),
      s_axi_arprot(2 downto 0) => axi_crossbar_1_M00_AXI_ARPROT(2 downto 0),
      s_axi_arqos(3 downto 0) => axi_crossbar_1_M00_AXI_ARQOS(3 downto 0),
      s_axi_arready => axi_crossbar_1_M00_AXI_ARREADY,
      s_axi_arregion(3 downto 0) => axi_crossbar_1_M00_AXI_ARREGION(3 downto 0),
      s_axi_arsize(2 downto 0) => axi_crossbar_1_M00_AXI_ARSIZE(2 downto 0),
      s_axi_arvalid => axi_crossbar_1_M00_AXI_ARVALID(0),
      s_axi_awaddr(31 downto 0) => axi_crossbar_1_M00_AXI_AWADDR(31 downto 0),
      s_axi_awburst(1 downto 0) => axi_crossbar_1_M00_AXI_AWBURST(1 downto 0),
      s_axi_awcache(3 downto 0) => axi_crossbar_1_M00_AXI_AWCACHE(3 downto 0),
      s_axi_awlen(7 downto 0) => axi_crossbar_1_M00_AXI_AWLEN(7 downto 0),
      s_axi_awlock(0) => axi_crossbar_1_M00_AXI_AWLOCK(0),
      s_axi_awprot(2 downto 0) => axi_crossbar_1_M00_AXI_AWPROT(2 downto 0),
      s_axi_awqos(3 downto 0) => axi_crossbar_1_M00_AXI_AWQOS(3 downto 0),
      s_axi_awready => axi_crossbar_1_M00_AXI_AWREADY,
      s_axi_awregion(3 downto 0) => axi_crossbar_1_M00_AXI_AWREGION(3 downto 0),
      s_axi_awsize(2 downto 0) => axi_crossbar_1_M00_AXI_AWSIZE(2 downto 0),
      s_axi_awvalid => axi_crossbar_1_M00_AXI_AWVALID(0),
      s_axi_bready => axi_crossbar_1_M00_AXI_BREADY(0),
      s_axi_bresp(1 downto 0) => axi_crossbar_1_M00_AXI_BRESP(1 downto 0),
      s_axi_bvalid => axi_crossbar_1_M00_AXI_BVALID,
      s_axi_rdata(31 downto 0) => axi_crossbar_1_M00_AXI_RDATA(31 downto 0),
      s_axi_rlast => axi_crossbar_1_M00_AXI_RLAST,
      s_axi_rready => axi_crossbar_1_M00_AXI_RREADY(0),
      s_axi_rresp(1 downto 0) => axi_crossbar_1_M00_AXI_RRESP(1 downto 0),
      s_axi_rvalid => axi_crossbar_1_M00_AXI_RVALID,
      s_axi_wdata(31 downto 0) => axi_crossbar_1_M00_AXI_WDATA(31 downto 0),
      s_axi_wlast => axi_crossbar_1_M00_AXI_WLAST(0),
      s_axi_wready => axi_crossbar_1_M00_AXI_WREADY,
      s_axi_wstrb(3 downto 0) => axi_crossbar_1_M00_AXI_WSTRB(3 downto 0),
      s_axi_wvalid => axi_crossbar_1_M00_AXI_WVALID(0)
    );
bram: entity work.bram_imp_1FWG8IU
     port map (
      BRAM_PORT_FILTER_0_addr(31 downto 0) => conv_accelerator_wra_0_BRAM_FILTER0_ADDR(31 downto 0),
      BRAM_PORT_FILTER_0_clk => conv_accelerator_wra_0_BRAM_FILTER0_CLK,
      BRAM_PORT_FILTER_0_din(31 downto 0) => conv_accelerator_wra_0_BRAM_FILTER0_DIN(31 downto 0),
      BRAM_PORT_FILTER_0_dout(31 downto 0) => conv_accelerator_wra_0_BRAM_FILTER0_DOUT(31 downto 0),
      BRAM_PORT_FILTER_0_en => conv_accelerator_wra_0_BRAM_FILTER0_EN,
      BRAM_PORT_FILTER_0_rst => conv_accelerator_wra_0_BRAM_FILTER0_RST,
      BRAM_PORT_FILTER_0_we(3 downto 0) => conv_accelerator_wra_0_BRAM_FILTER0_WE(3 downto 0),
      BRAM_PORT_FILTER_1_addr(31 downto 0) => conv_accelerator_wra_0_BRAM_FILTER1_ADDR(31 downto 0),
      BRAM_PORT_FILTER_1_clk => conv_accelerator_wra_0_BRAM_FILTER1_CLK,
      BRAM_PORT_FILTER_1_din(31 downto 0) => conv_accelerator_wra_0_BRAM_FILTER1_DIN(31 downto 0),
      BRAM_PORT_FILTER_1_dout(31 downto 0) => conv_accelerator_wra_0_BRAM_FILTER1_DOUT(31 downto 0),
      BRAM_PORT_FILTER_1_en => conv_accelerator_wra_0_BRAM_FILTER1_EN,
      BRAM_PORT_FILTER_1_rst => conv_accelerator_wra_0_BRAM_FILTER1_RST,
      BRAM_PORT_FILTER_1_we(3 downto 0) => conv_accelerator_wra_0_BRAM_FILTER1_WE(3 downto 0),
      BRAM_PORT_FILTER_2_addr(31 downto 0) => conv_accelerator_wra_0_BRAM_FILTER2_ADDR(31 downto 0),
      BRAM_PORT_FILTER_2_clk => conv_accelerator_wra_0_BRAM_FILTER2_CLK,
      BRAM_PORT_FILTER_2_din(31 downto 0) => conv_accelerator_wra_0_BRAM_FILTER2_DIN(31 downto 0),
      BRAM_PORT_FILTER_2_dout(31 downto 0) => conv_accelerator_wra_0_BRAM_FILTER2_DOUT(31 downto 0),
      BRAM_PORT_FILTER_2_en => conv_accelerator_wra_0_BRAM_FILTER2_EN,
      BRAM_PORT_FILTER_2_rst => conv_accelerator_wra_0_BRAM_FILTER2_RST,
      BRAM_PORT_FILTER_2_we(3 downto 0) => conv_accelerator_wra_0_BRAM_FILTER2_WE(3 downto 0),
      BRAM_PORT_FILTER_3_addr(31 downto 0) => conv_accelerator_wra_0_BRAM_FILTER3_ADDR(31 downto 0),
      BRAM_PORT_FILTER_3_clk => conv_accelerator_wra_0_BRAM_FILTER3_CLK,
      BRAM_PORT_FILTER_3_din(31 downto 0) => conv_accelerator_wra_0_BRAM_FILTER3_DIN(31 downto 0),
      BRAM_PORT_FILTER_3_dout(31 downto 0) => conv_accelerator_wra_0_BRAM_FILTER3_DOUT(31 downto 0),
      BRAM_PORT_FILTER_3_en => conv_accelerator_wra_0_BRAM_FILTER3_EN,
      BRAM_PORT_FILTER_3_rst => conv_accelerator_wra_0_BRAM_FILTER3_RST,
      BRAM_PORT_FILTER_3_we(3 downto 0) => conv_accelerator_wra_0_BRAM_FILTER3_WE(3 downto 0),
      BRAM_PORT_INPUT_0_addr(31 downto 0) => conv_accelerator_wra_0_BRAM_INPUT_ADDR(31 downto 0),
      BRAM_PORT_INPUT_0_clk => conv_accelerator_wra_0_BRAM_INPUT_CLK,
      BRAM_PORT_INPUT_0_din(31 downto 0) => conv_accelerator_wra_0_BRAM_INPUT_DIN(31 downto 0),
      BRAM_PORT_INPUT_0_dout(31 downto 0) => conv_accelerator_wra_0_BRAM_INPUT_DOUT(31 downto 0),
      BRAM_PORT_INPUT_0_en => conv_accelerator_wra_0_BRAM_INPUT_EN,
      BRAM_PORT_INPUT_0_rst => conv_accelerator_wra_0_BRAM_INPUT_RST,
      BRAM_PORT_INPUT_0_we(3 downto 0) => conv_accelerator_wra_0_BRAM_INPUT_WE(3 downto 0),
      BRAM_PORT_OUTPUT_0_addr(31 downto 0) => BRAM_PORT_OUTPUT_0_1_ADDR(31 downto 0),
      BRAM_PORT_OUTPUT_0_clk => BRAM_PORT_OUTPUT_0_1_CLK,
      BRAM_PORT_OUTPUT_0_din(31 downto 0) => BRAM_PORT_OUTPUT_0_1_DIN(31 downto 0),
      BRAM_PORT_OUTPUT_0_dout(31 downto 0) => BRAM_PORT_OUTPUT_0_1_DOUT(31 downto 0),
      BRAM_PORT_OUTPUT_0_en => BRAM_PORT_OUTPUT_0_1_EN,
      BRAM_PORT_OUTPUT_0_rst => BRAM_PORT_OUTPUT_0_1_RST,
      BRAM_PORT_OUTPUT_0_we(3 downto 0) => BRAM_PORT_OUTPUT_0_1_WE(3 downto 0),
      S_AXI_BRAM_araddr(31 downto 0) => axi_crossbar_1_M01_AXI_ARADDR(63 downto 32),
      S_AXI_BRAM_arburst(1 downto 0) => axi_crossbar_1_M01_AXI_ARBURST(3 downto 2),
      S_AXI_BRAM_arcache(3 downto 0) => axi_crossbar_1_M01_AXI_ARCACHE(7 downto 4),
      S_AXI_BRAM_arlen(7 downto 0) => axi_crossbar_1_M01_AXI_ARLEN(15 downto 8),
      S_AXI_BRAM_arlock => axi_crossbar_1_M01_AXI_ARLOCK(1),
      S_AXI_BRAM_arprot(2 downto 0) => axi_crossbar_1_M01_AXI_ARPROT(5 downto 3),
      S_AXI_BRAM_arready => axi_crossbar_1_M01_AXI_ARREADY,
      S_AXI_BRAM_arsize(2 downto 0) => axi_crossbar_1_M01_AXI_ARSIZE(5 downto 3),
      S_AXI_BRAM_arvalid => axi_crossbar_1_M01_AXI_ARVALID(1),
      S_AXI_BRAM_awaddr(31 downto 0) => axi_crossbar_1_M01_AXI_AWADDR(63 downto 32),
      S_AXI_BRAM_awburst(1 downto 0) => axi_crossbar_1_M01_AXI_AWBURST(3 downto 2),
      S_AXI_BRAM_awcache(3 downto 0) => axi_crossbar_1_M01_AXI_AWCACHE(7 downto 4),
      S_AXI_BRAM_awlen(7 downto 0) => axi_crossbar_1_M01_AXI_AWLEN(15 downto 8),
      S_AXI_BRAM_awlock => axi_crossbar_1_M01_AXI_AWLOCK(1),
      S_AXI_BRAM_awprot(2 downto 0) => axi_crossbar_1_M01_AXI_AWPROT(5 downto 3),
      S_AXI_BRAM_awready => axi_crossbar_1_M01_AXI_AWREADY,
      S_AXI_BRAM_awsize(2 downto 0) => axi_crossbar_1_M01_AXI_AWSIZE(5 downto 3),
      S_AXI_BRAM_awvalid => axi_crossbar_1_M01_AXI_AWVALID(1),
      S_AXI_BRAM_bready => axi_crossbar_1_M01_AXI_BREADY(1),
      S_AXI_BRAM_bresp(1 downto 0) => axi_crossbar_1_M01_AXI_BRESP(1 downto 0),
      S_AXI_BRAM_bvalid => axi_crossbar_1_M01_AXI_BVALID,
      S_AXI_BRAM_rdata(31 downto 0) => axi_crossbar_1_M01_AXI_RDATA(31 downto 0),
      S_AXI_BRAM_rlast => axi_crossbar_1_M01_AXI_RLAST,
      S_AXI_BRAM_rready => axi_crossbar_1_M01_AXI_RREADY(1),
      S_AXI_BRAM_rresp(1 downto 0) => axi_crossbar_1_M01_AXI_RRESP(1 downto 0),
      S_AXI_BRAM_rvalid => axi_crossbar_1_M01_AXI_RVALID,
      S_AXI_BRAM_wdata(31 downto 0) => axi_crossbar_1_M01_AXI_WDATA(63 downto 32),
      S_AXI_BRAM_wlast => axi_crossbar_1_M01_AXI_WLAST(1),
      S_AXI_BRAM_wready => axi_crossbar_1_M01_AXI_WREADY,
      S_AXI_BRAM_wstrb(3 downto 0) => axi_crossbar_1_M01_AXI_WSTRB(7 downto 4),
      S_AXI_BRAM_wvalid => axi_crossbar_1_M01_AXI_WVALID(1),
      aclk_0 => processing_system7_0_FCLK_CLK0,
      aresetn_0 => rst_ps7_0_100M_peripheral_aresetn(0),
      invert_activations => conv_accelerator_wra_0_swap_activations,
      invert_filters => conv_accelerator_0_swap_banks,
      sel => conv_accelerator_wra_0_ps_controls_activation_bram
    );
conv_accelerator_wra_0: component conv_accelerator_bd_conv_accelerator_wra_0_0
     port map (
      BRAM_FILTER0_addr(31 downto 0) => conv_accelerator_wra_0_BRAM_FILTER0_ADDR(31 downto 0),
      BRAM_FILTER0_clk => conv_accelerator_wra_0_BRAM_FILTER0_CLK,
      BRAM_FILTER0_din(31 downto 0) => conv_accelerator_wra_0_BRAM_FILTER0_DIN(31 downto 0),
      BRAM_FILTER0_dout(31 downto 0) => conv_accelerator_wra_0_BRAM_FILTER0_DOUT(31 downto 0),
      BRAM_FILTER0_en => conv_accelerator_wra_0_BRAM_FILTER0_EN,
      BRAM_FILTER0_rst => conv_accelerator_wra_0_BRAM_FILTER0_RST,
      BRAM_FILTER0_we(3 downto 0) => conv_accelerator_wra_0_BRAM_FILTER0_WE(3 downto 0),
      BRAM_FILTER1_addr(31 downto 0) => conv_accelerator_wra_0_BRAM_FILTER1_ADDR(31 downto 0),
      BRAM_FILTER1_clk => conv_accelerator_wra_0_BRAM_FILTER1_CLK,
      BRAM_FILTER1_din(31 downto 0) => conv_accelerator_wra_0_BRAM_FILTER1_DIN(31 downto 0),
      BRAM_FILTER1_dout(31 downto 0) => conv_accelerator_wra_0_BRAM_FILTER1_DOUT(31 downto 0),
      BRAM_FILTER1_en => conv_accelerator_wra_0_BRAM_FILTER1_EN,
      BRAM_FILTER1_rst => conv_accelerator_wra_0_BRAM_FILTER1_RST,
      BRAM_FILTER1_we(3 downto 0) => conv_accelerator_wra_0_BRAM_FILTER1_WE(3 downto 0),
      BRAM_FILTER2_addr(31 downto 0) => conv_accelerator_wra_0_BRAM_FILTER2_ADDR(31 downto 0),
      BRAM_FILTER2_clk => conv_accelerator_wra_0_BRAM_FILTER2_CLK,
      BRAM_FILTER2_din(31 downto 0) => conv_accelerator_wra_0_BRAM_FILTER2_DIN(31 downto 0),
      BRAM_FILTER2_dout(31 downto 0) => conv_accelerator_wra_0_BRAM_FILTER2_DOUT(31 downto 0),
      BRAM_FILTER2_en => conv_accelerator_wra_0_BRAM_FILTER2_EN,
      BRAM_FILTER2_rst => conv_accelerator_wra_0_BRAM_FILTER2_RST,
      BRAM_FILTER2_we(3 downto 0) => conv_accelerator_wra_0_BRAM_FILTER2_WE(3 downto 0),
      BRAM_FILTER3_addr(31 downto 0) => conv_accelerator_wra_0_BRAM_FILTER3_ADDR(31 downto 0),
      BRAM_FILTER3_clk => conv_accelerator_wra_0_BRAM_FILTER3_CLK,
      BRAM_FILTER3_din(31 downto 0) => conv_accelerator_wra_0_BRAM_FILTER3_DIN(31 downto 0),
      BRAM_FILTER3_dout(31 downto 0) => conv_accelerator_wra_0_BRAM_FILTER3_DOUT(31 downto 0),
      BRAM_FILTER3_en => conv_accelerator_wra_0_BRAM_FILTER3_EN,
      BRAM_FILTER3_rst => conv_accelerator_wra_0_BRAM_FILTER3_RST,
      BRAM_FILTER3_we(3 downto 0) => conv_accelerator_wra_0_BRAM_FILTER3_WE(3 downto 0),
      BRAM_INPUT_addr(31 downto 0) => conv_accelerator_wra_0_BRAM_INPUT_ADDR(31 downto 0),
      BRAM_INPUT_clk => conv_accelerator_wra_0_BRAM_INPUT_CLK,
      BRAM_INPUT_din(31 downto 0) => conv_accelerator_wra_0_BRAM_INPUT_DIN(31 downto 0),
      BRAM_INPUT_dout(31 downto 0) => conv_accelerator_wra_0_BRAM_INPUT_DOUT(31 downto 0),
      BRAM_INPUT_en => conv_accelerator_wra_0_BRAM_INPUT_EN,
      BRAM_INPUT_rst => conv_accelerator_wra_0_BRAM_INPUT_RST,
      BRAM_INPUT_we(3 downto 0) => conv_accelerator_wra_0_BRAM_INPUT_WE(3 downto 0),
      BRAM_OUTPUT_addr(31 downto 0) => BRAM_PORT_OUTPUT_0_1_ADDR(31 downto 0),
      BRAM_OUTPUT_clk => BRAM_PORT_OUTPUT_0_1_CLK,
      BRAM_OUTPUT_din(31 downto 0) => BRAM_PORT_OUTPUT_0_1_DIN(31 downto 0),
      BRAM_OUTPUT_dout(31 downto 0) => BRAM_PORT_OUTPUT_0_1_DOUT(31 downto 0),
      BRAM_OUTPUT_en => BRAM_PORT_OUTPUT_0_1_EN,
      BRAM_OUTPUT_rst => BRAM_PORT_OUTPUT_0_1_RST,
      BRAM_OUTPUT_we(3 downto 0) => BRAM_PORT_OUTPUT_0_1_WE(3 downto 0),
      S_AXI_LITE_ACLK => processing_system7_0_FCLK_CLK0,
      S_AXI_LITE_ARADDR(7 downto 0) => axi_crossbar_0_M00_AXI_ARADDR(7 downto 0),
      S_AXI_LITE_ARESETN => rst_ps7_0_100M_peripheral_aresetn(0),
      S_AXI_LITE_ARPROT(2 downto 0) => axi_crossbar_0_M00_AXI_ARPROT(2 downto 0),
      S_AXI_LITE_ARREADY => axi_crossbar_0_M00_AXI_ARREADY,
      S_AXI_LITE_ARVALID => axi_crossbar_0_M00_AXI_ARVALID(0),
      S_AXI_LITE_AWADDR(7 downto 0) => axi_crossbar_0_M00_AXI_AWADDR(7 downto 0),
      S_AXI_LITE_AWPROT(2 downto 0) => axi_crossbar_0_M00_AXI_AWPROT(2 downto 0),
      S_AXI_LITE_AWREADY => axi_crossbar_0_M00_AXI_AWREADY,
      S_AXI_LITE_AWVALID => axi_crossbar_0_M00_AXI_AWVALID(0),
      S_AXI_LITE_BREADY => axi_crossbar_0_M00_AXI_BREADY(0),
      S_AXI_LITE_BRESP(1 downto 0) => axi_crossbar_0_M00_AXI_BRESP(1 downto 0),
      S_AXI_LITE_BVALID => axi_crossbar_0_M00_AXI_BVALID,
      S_AXI_LITE_RDATA(31 downto 0) => axi_crossbar_0_M00_AXI_RDATA(31 downto 0),
      S_AXI_LITE_RREADY => axi_crossbar_0_M00_AXI_RREADY(0),
      S_AXI_LITE_RRESP(1 downto 0) => axi_crossbar_0_M00_AXI_RRESP(1 downto 0),
      S_AXI_LITE_RVALID => axi_crossbar_0_M00_AXI_RVALID,
      S_AXI_LITE_WDATA(31 downto 0) => axi_crossbar_0_M00_AXI_WDATA(31 downto 0),
      S_AXI_LITE_WREADY => axi_crossbar_0_M00_AXI_WREADY,
      S_AXI_LITE_WSTRB(3 downto 0) => axi_crossbar_0_M00_AXI_WSTRB(3 downto 0),
      S_AXI_LITE_WVALID => axi_crossbar_0_M00_AXI_WVALID(0),
      accelerator_controls_activation_bram => conv_accelerator_wra_0_ps_controls_activation_bram,
      swap_activations => conv_accelerator_wra_0_swap_activations,
      swap_filters => conv_accelerator_0_swap_banks
    );
processing_system7_0: component conv_accelerator_bd_processing_system7_0_0
     port map (
      DDR_Addr(14 downto 0) => DDR_addr(14 downto 0),
      DDR_BankAddr(2 downto 0) => DDR_ba(2 downto 0),
      DDR_CAS_n => DDR_cas_n,
      DDR_CKE => DDR_cke,
      DDR_CS_n => DDR_cs_n,
      DDR_Clk => DDR_ck_p,
      DDR_Clk_n => DDR_ck_n,
      DDR_DM(3 downto 0) => DDR_dm(3 downto 0),
      DDR_DQ(31 downto 0) => DDR_dq(31 downto 0),
      DDR_DQS(3 downto 0) => DDR_dqs_p(3 downto 0),
      DDR_DQS_n(3 downto 0) => DDR_dqs_n(3 downto 0),
      DDR_DRSTB => DDR_reset_n,
      DDR_ODT => DDR_odt,
      DDR_RAS_n => DDR_ras_n,
      DDR_VRN => FIXED_IO_ddr_vrn,
      DDR_VRP => FIXED_IO_ddr_vrp,
      DDR_WEB => DDR_we_n,
      FCLK_CLK0 => processing_system7_0_FCLK_CLK0,
      FCLK_RESET0_N => processing_system7_0_FCLK_RESET0_N,
      MIO(53 downto 0) => FIXED_IO_mio(53 downto 0),
      M_AXI_GP0_ACLK => processing_system7_0_FCLK_CLK0,
      M_AXI_GP0_ARADDR(31 downto 0) => processing_system7_0_M_AXI_GP0_ARADDR(31 downto 0),
      M_AXI_GP0_ARBURST(1 downto 0) => processing_system7_0_M_AXI_GP0_ARBURST(1 downto 0),
      M_AXI_GP0_ARCACHE(3 downto 0) => processing_system7_0_M_AXI_GP0_ARCACHE(3 downto 0),
      M_AXI_GP0_ARID(11 downto 0) => processing_system7_0_M_AXI_GP0_ARID(11 downto 0),
      M_AXI_GP0_ARLEN(3 downto 0) => processing_system7_0_M_AXI_GP0_ARLEN(3 downto 0),
      M_AXI_GP0_ARLOCK(1 downto 0) => processing_system7_0_M_AXI_GP0_ARLOCK(1 downto 0),
      M_AXI_GP0_ARPROT(2 downto 0) => processing_system7_0_M_AXI_GP0_ARPROT(2 downto 0),
      M_AXI_GP0_ARQOS(3 downto 0) => processing_system7_0_M_AXI_GP0_ARQOS(3 downto 0),
      M_AXI_GP0_ARREADY => processing_system7_0_M_AXI_GP0_ARREADY,
      M_AXI_GP0_ARSIZE(2 downto 0) => processing_system7_0_M_AXI_GP0_ARSIZE(2 downto 0),
      M_AXI_GP0_ARVALID => processing_system7_0_M_AXI_GP0_ARVALID,
      M_AXI_GP0_AWADDR(31 downto 0) => processing_system7_0_M_AXI_GP0_AWADDR(31 downto 0),
      M_AXI_GP0_AWBURST(1 downto 0) => processing_system7_0_M_AXI_GP0_AWBURST(1 downto 0),
      M_AXI_GP0_AWCACHE(3 downto 0) => processing_system7_0_M_AXI_GP0_AWCACHE(3 downto 0),
      M_AXI_GP0_AWID(11 downto 0) => processing_system7_0_M_AXI_GP0_AWID(11 downto 0),
      M_AXI_GP0_AWLEN(3 downto 0) => processing_system7_0_M_AXI_GP0_AWLEN(3 downto 0),
      M_AXI_GP0_AWLOCK(1 downto 0) => processing_system7_0_M_AXI_GP0_AWLOCK(1 downto 0),
      M_AXI_GP0_AWPROT(2 downto 0) => processing_system7_0_M_AXI_GP0_AWPROT(2 downto 0),
      M_AXI_GP0_AWQOS(3 downto 0) => processing_system7_0_M_AXI_GP0_AWQOS(3 downto 0),
      M_AXI_GP0_AWREADY => processing_system7_0_M_AXI_GP0_AWREADY,
      M_AXI_GP0_AWSIZE(2 downto 0) => processing_system7_0_M_AXI_GP0_AWSIZE(2 downto 0),
      M_AXI_GP0_AWVALID => processing_system7_0_M_AXI_GP0_AWVALID,
      M_AXI_GP0_BID(11 downto 0) => processing_system7_0_M_AXI_GP0_BID(11 downto 0),
      M_AXI_GP0_BREADY => processing_system7_0_M_AXI_GP0_BREADY,
      M_AXI_GP0_BRESP(1 downto 0) => processing_system7_0_M_AXI_GP0_BRESP(1 downto 0),
      M_AXI_GP0_BVALID => processing_system7_0_M_AXI_GP0_BVALID,
      M_AXI_GP0_RDATA(31 downto 0) => processing_system7_0_M_AXI_GP0_RDATA(31 downto 0),
      M_AXI_GP0_RID(11 downto 0) => processing_system7_0_M_AXI_GP0_RID(11 downto 0),
      M_AXI_GP0_RLAST => processing_system7_0_M_AXI_GP0_RLAST,
      M_AXI_GP0_RREADY => processing_system7_0_M_AXI_GP0_RREADY,
      M_AXI_GP0_RRESP(1 downto 0) => processing_system7_0_M_AXI_GP0_RRESP(1 downto 0),
      M_AXI_GP0_RVALID => processing_system7_0_M_AXI_GP0_RVALID,
      M_AXI_GP0_WDATA(31 downto 0) => processing_system7_0_M_AXI_GP0_WDATA(31 downto 0),
      M_AXI_GP0_WID(11 downto 0) => processing_system7_0_M_AXI_GP0_WID(11 downto 0),
      M_AXI_GP0_WLAST => processing_system7_0_M_AXI_GP0_WLAST,
      M_AXI_GP0_WREADY => processing_system7_0_M_AXI_GP0_WREADY,
      M_AXI_GP0_WSTRB(3 downto 0) => processing_system7_0_M_AXI_GP0_WSTRB(3 downto 0),
      M_AXI_GP0_WVALID => processing_system7_0_M_AXI_GP0_WVALID,
      PS_CLK => FIXED_IO_ps_clk,
      PS_PORB => FIXED_IO_ps_porb,
      PS_SRSTB => FIXED_IO_ps_srstb,
      S_AXI_HP0_ACLK => processing_system7_0_FCLK_CLK0,
      S_AXI_HP0_ARADDR(31 downto 0) => axi_protocol_convert_3_M_AXI_ARADDR(31 downto 0),
      S_AXI_HP0_ARBURST(1 downto 0) => axi_protocol_convert_3_M_AXI_ARBURST(1 downto 0),
      S_AXI_HP0_ARCACHE(3 downto 0) => axi_protocol_convert_3_M_AXI_ARCACHE(3 downto 0),
      S_AXI_HP0_ARID(5 downto 0) => B"000000",
      S_AXI_HP0_ARLEN(3 downto 0) => axi_protocol_convert_3_M_AXI_ARLEN(3 downto 0),
      S_AXI_HP0_ARLOCK(1 downto 0) => axi_protocol_convert_3_M_AXI_ARLOCK(1 downto 0),
      S_AXI_HP0_ARPROT(2 downto 0) => axi_protocol_convert_3_M_AXI_ARPROT(2 downto 0),
      S_AXI_HP0_ARQOS(3 downto 0) => axi_protocol_convert_3_M_AXI_ARQOS(3 downto 0),
      S_AXI_HP0_ARREADY => axi_protocol_convert_3_M_AXI_ARREADY,
      S_AXI_HP0_ARSIZE(2 downto 0) => axi_protocol_convert_3_M_AXI_ARSIZE(2 downto 0),
      S_AXI_HP0_ARVALID => axi_protocol_convert_3_M_AXI_ARVALID,
      S_AXI_HP0_AWADDR(31 downto 0) => axi_protocol_convert_3_M_AXI_AWADDR(31 downto 0),
      S_AXI_HP0_AWBURST(1 downto 0) => axi_protocol_convert_3_M_AXI_AWBURST(1 downto 0),
      S_AXI_HP0_AWCACHE(3 downto 0) => axi_protocol_convert_3_M_AXI_AWCACHE(3 downto 0),
      S_AXI_HP0_AWID(5 downto 0) => B"000000",
      S_AXI_HP0_AWLEN(3 downto 0) => axi_protocol_convert_3_M_AXI_AWLEN(3 downto 0),
      S_AXI_HP0_AWLOCK(1 downto 0) => axi_protocol_convert_3_M_AXI_AWLOCK(1 downto 0),
      S_AXI_HP0_AWPROT(2 downto 0) => axi_protocol_convert_3_M_AXI_AWPROT(2 downto 0),
      S_AXI_HP0_AWQOS(3 downto 0) => axi_protocol_convert_3_M_AXI_AWQOS(3 downto 0),
      S_AXI_HP0_AWREADY => axi_protocol_convert_3_M_AXI_AWREADY,
      S_AXI_HP0_AWSIZE(2 downto 0) => axi_protocol_convert_3_M_AXI_AWSIZE(2 downto 0),
      S_AXI_HP0_AWVALID => axi_protocol_convert_3_M_AXI_AWVALID,
      S_AXI_HP0_BID(5 downto 0) => NLW_processing_system7_0_S_AXI_HP0_BID_UNCONNECTED(5 downto 0),
      S_AXI_HP0_BREADY => axi_protocol_convert_3_M_AXI_BREADY,
      S_AXI_HP0_BRESP(1 downto 0) => axi_protocol_convert_3_M_AXI_BRESP(1 downto 0),
      S_AXI_HP0_BVALID => axi_protocol_convert_3_M_AXI_BVALID,
      S_AXI_HP0_RACOUNT(2 downto 0) => NLW_processing_system7_0_S_AXI_HP0_RACOUNT_UNCONNECTED(2 downto 0),
      S_AXI_HP0_RCOUNT(7 downto 0) => NLW_processing_system7_0_S_AXI_HP0_RCOUNT_UNCONNECTED(7 downto 0),
      S_AXI_HP0_RDATA(31 downto 0) => axi_protocol_convert_3_M_AXI_RDATA(31 downto 0),
      S_AXI_HP0_RDISSUECAP1_EN => '0',
      S_AXI_HP0_RID(5 downto 0) => NLW_processing_system7_0_S_AXI_HP0_RID_UNCONNECTED(5 downto 0),
      S_AXI_HP0_RLAST => axi_protocol_convert_3_M_AXI_RLAST,
      S_AXI_HP0_RREADY => axi_protocol_convert_3_M_AXI_RREADY,
      S_AXI_HP0_RRESP(1 downto 0) => axi_protocol_convert_3_M_AXI_RRESP(1 downto 0),
      S_AXI_HP0_RVALID => axi_protocol_convert_3_M_AXI_RVALID,
      S_AXI_HP0_WACOUNT(5 downto 0) => NLW_processing_system7_0_S_AXI_HP0_WACOUNT_UNCONNECTED(5 downto 0),
      S_AXI_HP0_WCOUNT(7 downto 0) => NLW_processing_system7_0_S_AXI_HP0_WCOUNT_UNCONNECTED(7 downto 0),
      S_AXI_HP0_WDATA(31 downto 0) => axi_protocol_convert_3_M_AXI_WDATA(31 downto 0),
      S_AXI_HP0_WID(5 downto 0) => B"000000",
      S_AXI_HP0_WLAST => axi_protocol_convert_3_M_AXI_WLAST,
      S_AXI_HP0_WREADY => axi_protocol_convert_3_M_AXI_WREADY,
      S_AXI_HP0_WRISSUECAP1_EN => '0',
      S_AXI_HP0_WSTRB(3 downto 0) => axi_protocol_convert_3_M_AXI_WSTRB(3 downto 0),
      S_AXI_HP0_WVALID => axi_protocol_convert_3_M_AXI_WVALID
    );
rst_ps7_0_200M: component conv_accelerator_bd_rst_ps7_0_200M_0
     port map (
      aux_reset_in => '1',
      bus_struct_reset(0) => NLW_rst_ps7_0_200M_bus_struct_reset_UNCONNECTED(0),
      dcm_locked => '1',
      ext_reset_in => processing_system7_0_FCLK_RESET0_N,
      interconnect_aresetn(0) => NLW_rst_ps7_0_200M_interconnect_aresetn_UNCONNECTED(0),
      mb_debug_sys_rst => '0',
      mb_reset => NLW_rst_ps7_0_200M_mb_reset_UNCONNECTED,
      peripheral_aresetn(0) => rst_ps7_0_100M_peripheral_aresetn(0),
      peripheral_reset(0) => NLW_rst_ps7_0_200M_peripheral_reset_UNCONNECTED(0),
      slowest_sync_clk => processing_system7_0_FCLK_CLK0
    );
end STRUCTURE;
