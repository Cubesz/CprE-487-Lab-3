----------------------------------------------------------------------------------
-- Output Storage Unit
--
-- Gregory Ling, 2024
----------------------------------------------------------------------------------

library work;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity output_storage is
    generic(
        DATA_WIDTH : integer := 32;
        BRAM_DATA_WIDTH : integer := 32;
        ADDR_WIDTH : integer := 32;
        BRAM_ADDR_WIDTH : integer := 32;
        DIM_WIDTH : integer := 8;
        C_TID_WIDTH : integer := 1
    );
    port(
        S_AXIS_TREADY : out std_logic;
        S_AXIS_TDATA  : in  std_logic_vector(DATA_WIDTH-1 downto 0);
        S_AXIS_TLAST  : in  std_logic;
        S_AXIS_TID    : in  std_logic_vector(C_TID_WIDTH-1 downto 0);
        S_AXIS_TVALID : in  std_logic;

        BRAM_addr : out std_logic_vector(32-1 downto 0);
        BRAM_din : out std_logic_vector(BRAM_DATA_WIDTH-1 downto 0);
        BRAM_dout : in std_logic_vector(BRAM_DATA_WIDTH-1 downto 0);
        BRAM_en : out std_logic;
        BRAM_we : out std_logic_vector((BRAM_DATA_WIDTH/8)-1 downto 0);
        BRAM_rst : out std_logic;
        BRAM_clk : out std_logic;

        max_pooling : in std_logic;
        elements_per_channel : in std_logic_vector(ADDR_WIDTH-1 downto 0);
        output_w : in std_logic_vector(DIM_WIDTH-1 downto 0);
        output_h : in std_logic_vector(DIM_WIDTH-1 downto 0);
        initial_offset : in std_logic_vector(ADDR_WIDTH-1 downto 0);
        
        conv_complete : out std_logic;
        conv_idle : in std_logic;
        clk : in std_logic;
        rst : in std_logic
    );
end output_storage;

architecture Behavioral of output_storage is

component sv_output_storage is
    generic (
        DATA_WIDTH : integer := 32;
        BRAM_DATA_WIDTH : integer := 32;
        ADDR_WIDTH : integer := 32;
        BRAM_ADDR_WIDTH : integer := 32;
        DIM_WIDTH : integer := 8;
        C_TID_WIDTH : integer := 1
    );
    port (
        S_AXIS_TREADY : out std_logic;
        S_AXIS_TDATA : in std_logic_vector(DATA_WIDTH-1 downto 0);
        S_AXIS_TLAST : in std_logic;
        S_AXIS_TID : in std_logic_vector(C_TID_WIDTH-1 downto 0);
        S_AXIS_TVALID : in std_logic;
        
        BRAM_addr : out std_logic_vector(32-1 downto 0);
        BRAM_din : out std_logic_vector(BRAM_DATA_WIDTH-1 downto 0);
        BRAM_dout : in std_logic_vector(BRAM_DATA_WIDTH-1 downto 0);
        BRAM_en : out std_logic;
        BRAM_we : out std_logic_vector((BRAM_DATA_WIDTH/8)-1 downto 0);
        BRAM_rst : out std_logic;
        BRAM_clk : out std_logic;
        
        max_pooling : in std_logic;
        elements_per_channel : in std_logic_vector(ADDR_WIDTH-1 downto 0);
        output_w : in std_logic_vector(DIM_WIDTH-1 downto 0);
        output_h : in std_logic_vector(DIM_WIDTH-1 downto 0);
        initial_offset : in std_logic_vector(ADDR_WIDTH-1 downto 0);
        
        conv_complete : out std_logic;
        conv_idle : in std_logic;
        clk : in std_logic;
        rst : in std_logic
    );
end component sv_output_storage;


begin


out_store: sv_output_storage
    generic map (
        DATA_WIDTH => DATA_WIDTH,
        BRAM_DATA_WIDTH => BRAM_DATA_WIDTH,
        ADDR_WIDTH => ADDR_WIDTH,
        BRAM_ADDR_WIDTH => BRAM_ADDR_WIDTH,
        DIM_WIDTH => DIM_WIDTH,
        C_TID_WIDTH => C_TID_WIDTH
    )
    port map (
        S_AXIS_TREADY => S_AXIS_TREADY,
        S_AXIS_TDATA => S_AXIS_TDATA,
        S_AXIS_TLAST => S_AXIS_TLAST,
        S_AXIS_TID => S_AXIS_TID,
        S_AXIS_TVALID => S_AXIS_TVALID,
        
        BRAM_addr => BRAM_addr,
        BRAM_din => BRAM_din,
        BRAM_dout => BRAM_dout,
        BRAM_en => BRAM_en,
        BRAM_we => BRAM_we,
        BRAM_rst => BRAM_rst,
        BRAM_clk => BRAM_clk,
        
        max_pooling => max_pooling,
        elements_per_channel => elements_per_channel,
        output_w =>  output_w,
        output_h => output_h,
        initial_offset => initial_offset,
        
        conv_complete => conv_complete,
        conv_idle => conv_idle,
        clk => clk,
        rst => rst
    );



end Behavioral;
