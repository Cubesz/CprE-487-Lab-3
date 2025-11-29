----------------------------------------------------------------------------------
-- Convolutional MAC Unit
--
-- Gregory Ling, 2024
----------------------------------------------------------------------------------

library work;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity conv_mac is
  generic(
      C_DATA_WIDTH : integer := 32;
      C_OUTPUT_DATA_WIDTH : integer := 32
    );
    port (  
        S_AXIS_TREADY : out std_logic;
        S_AXIS_TDATA  : in  std_logic_vector(C_DATA_WIDTH*2-1 downto 0);
        S_AXIS_TLAST  : in  std_logic;
        S_AXIS_TVALID : in  std_logic;

        bias : in std_logic_vector(C_OUTPUT_DATA_WIDTH-1 downto 0);

        M_AXIS_TREADY : in  std_logic;
        M_AXIS_TDATA  : out std_logic_vector(C_OUTPUT_DATA_WIDTH-1 downto 0);
        M_AXIS_TLAST  : out std_logic;
        M_AXIS_TVALID : out std_logic;

        rst : in std_logic;
        clk : in std_logic
    );

end conv_mac;



architecture behavioral of conv_mac is


component sv_conv_mac is
    generic (
        C_DATA_WIDTH : integer := 8;
        C_OUTPUT_DATA_WIDTH : integer := 32
    );
    port (
        ACLK : in std_logic;
        ARESETN : in std_logic;
        
        SD_AXIS_TREADY : out std_logic;
        SD_AXIS_TDATA : in std_logic_vector(C_DATA_WIDTH*2-1 downto 0);
        SD_AXIS_TLAST : in std_logic;
        SD_AXIS_TVALID : in std_logic;
        
        bias : in std_logic_vector(C_OUTPUT_DATA_WIDTH-1 downto 0);
        
        MO_AXIS_TVALID : out std_logic;
        MO_AXIS_TDATA : out std_logic_vector(C_OUTPUT_DATA_WIDTH-1 downto 0);
        MO_AXIS_TLAST : out std_logic;
        MO_AXIS_TREADY : in std_logic
    );
end component sv_conv_mac;

signal nrst : std_logic;

begin

    nrst <= not rst;

    mac: sv_conv_mac
        generic map(
            C_DATA_WIDTH => C_DATA_WIDTH,
            C_OUTPUT_DATA_WIDTH => C_OUTPUT_DATA_WIDTH
        )
        port map (
            ACLK => clk,
            ARESETN => nrst,
            
            SD_AXIS_TREADY => S_AXIS_TREADY,
            SD_AXIS_TDATA => S_AXIS_TDATA,
            SD_AXIS_TLAST => S_AXIS_TLAST,
            SD_AXIS_TVALID => S_AXIS_TVALID,
            
            bias => bias,
            
            MO_AXIS_TVALID => M_AXIS_TVALID,
            MO_AXIS_TDATA => M_AXIS_TDATA,
            MO_AXIS_TLAST => M_AXIS_TLAST,
            MO_AXIS_TREADY => M_AXIS_TREADY
        );

end architecture behavioral;
