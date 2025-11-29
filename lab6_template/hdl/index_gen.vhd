----------------------------------------------------------------------------------
-- Input & Filter Index Generator
--
-- Gregory Ling, 2024
----------------------------------------------------------------------------------

library work;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity index_gen is
    generic(
        DIM_WIDTH : integer := 32;
        INPUT_ADDR_WIDTH : integer := 32;
        FILTER_ADDR_WIDTH : integer := 32;
        OUTPUT_ADDR_WIDTH : integer := 32
    );
    port(
        filter_w : in std_logic_vector(DIM_WIDTH-1 downto 0); -- Filter dimension width (Filter width)
        filter_h : in std_logic_vector(DIM_WIDTH-1 downto 0); -- Filter dimension height (Filter height)
        filter_c : in std_logic_vector(DIM_WIDTH-1 downto 0); -- Filter dimension channels (Filter channels == Input channels)
        output_w : in std_logic_vector(DIM_WIDTH-1 downto 0); -- Output dimension width (Output width)
        output_h : in std_logic_vector(DIM_WIDTH-1 downto 0); -- Output dimension height (Output height)
        input_end_diff_fw : in std_logic_vector(INPUT_ADDR_WIDTH-1 downto 0); -- Amount to add to addr when completing a filter row
        input_end_diff_fh : in std_logic_vector(INPUT_ADDR_WIDTH-1 downto 0); -- Amount to add to addr when completing a filter column
        input_end_diff_fc : in std_logic_vector(INPUT_ADDR_WIDTH-1 downto 0); -- Amount to add to addr when completing a filter channel
        input_end_diff_ow : in std_logic_vector(INPUT_ADDR_WIDTH-1 downto 0); -- Amount to add to addr when completing an output row
        
        M_AXIS_TREADY : in std_logic;
        M_AXIS_TDATA_input_addr : out std_logic_vector(INPUT_ADDR_WIDTH-1 downto 0);
        M_AXIS_TDATA_filter_addr : out std_logic_vector(FILTER_ADDR_WIDTH-1 downto 0);
        M_AXIS_TLAST : out std_logic;
        M_AXIS_TVALID : out std_logic;

        conv_idle : in std_logic; -- When the convolution is idle, reset the index generator. Starts counting on falling edge
        rst : in std_logic;
        clk : in std_logic
    );
end index_gen;

architecture Behavioral of index_gen is

signal input_idx: std_logic_vector(INPUT_ADDR_WIDTH-1 downto 0) := (others => '0');
signal filter_idx: std_logic_vector(INPUT_ADDR_WIDTH-1 downto 0) := (others => '0');

signal filter_column_progress: std_logic_vector(DIM_WIDTH-1 downto 0) := (0 => '1', others => '0');
signal filter_row_progress: std_logic_vector(DIM_WIDTH-1 downto 0) := (0 => '1', others => '0');
signal filter_channel_progress: std_logic_vector(DIM_WIDTH-1 downto 0) := (0 => '1', others => '0');

signal output_column_progress: std_logic_vector(DIM_WIDTH-1 downto 0) := (0 => '1', others => '0');
signal output_row_progress: std_logic_vector(DIM_WIDTH-1 downto 0) := (0 => '1', others => '0');

signal on_last_column: std_logic := '0';
signal on_last_row: std_logic := '0';
signal on_last_channel: std_logic := '0';

signal on_last_output_column: std_logic := '0';
signal on_last_output_row: std_logic := '0';


begin

M_AXIS_TDATA_input_addr <= input_idx;
M_AXIS_TDATA_filter_addr <= filter_idx;
M_AXIS_TVALID <= (not conv_idle) and (not rst);

on_last_column <= '1' when filter_column_progress = filter_w(filter_column_progress'length - 1 downto 0) else '0';
on_last_row <= '1' when filter_row_progress = filter_h(filter_row_progress'length - 1 downto 0) else '0';
on_last_channel <= '1' when filter_channel_progress = filter_c(filter_channel_progress'length - 1 downto 0) else '0';

on_last_output_column <= '1' when output_column_progress = output_w(output_column_progress'length - 1 downto 0) else '0'; -- may cause issues with a 1x1 filter
on_last_output_row <= '1' when output_row_progress = output_h(output_row_progress'length - 1 downto 0) else '0';

-- a width * height input might make some of this redundant.

M_AXIS_TLAST <= '1' when (rst = '0' and conv_idle = '0' and M_AXIS_TREADY = '1' and on_last_channel = '1' and on_last_row = '1' and on_last_column = '1') else '0';


-- the "*_progress" start at 1 so to do inexpensive checking with given dimensions
-- assuming width (horizontal) is least significant dimension. Continually incrementing should result in incrementing rows next and then channels
-- assuming dimensions of filter as channel x row x column
-- assuming dimensions of input as channel x row x column
-- assuming same stride in both dimensions.
-- it would seem that we have different interpreations of what "completeing a channel" and "completing a column" means

p_idx_gen: process(clk)
begin
    if rising_edge(clk) then
        if (rst = '1' or conv_idle = '1') then
            input_idx <= (others => '0');
            filter_idx <= (others => '0');
            
            filter_column_progress <= (0 => '1', others => '0');
            filter_row_progress <= (0 => '1', others => '0');
            filter_channel_progress <= (0 => '1', others => '0');
            
            output_column_progress <= (0 => '1', others => '0');
            output_row_progress <= (0 => '1', others => '0');
            
        elsif (M_AXIS_TREADY = '1') then
            filter_idx <= filter_idx + 1;
            input_idx <= input_idx + 1; -- Could maybe be input_idx + input_end_diff_fh, but assuming that that input is 1.
            filter_column_progress <= filter_column_progress + 1;
            
            if (on_last_output_row = '1' and on_last_output_column = '1' and on_last_channel = '1' and on_last_row = '1' and on_last_column = '1') then
                filter_idx <= (others => '0');
                input_idx <= (others => '0');
                output_row_progress <= (0 => '1', others => '0');
                output_column_progress <= (0 => '1', others => '0');
                filter_column_progress <= (0 => '1', others => '0');
                filter_row_progress <= (0 => '1', others => '0');
                filter_channel_progress <= (0 => '1', others => '0');
                
            elsif (on_last_channel = '1' and on_last_row = '1' and on_last_column = '1') then -- new output pixel to work on / end of filter. Reset filter_idx and reset input_idx to the output iteration we are on.
                filter_column_progress <= (0 => '1', others => '0');
                filter_row_progress <= (0 => '1', others => '0');
                filter_channel_progress <= (0 => '1', others => '0');
                
                
                filter_idx <= (others => '0');
                

                input_idx <= input_idx + input_end_diff_fc; -- the amount to add when starting a new output.
                
                output_column_progress <= output_column_progress + 1;
                
                if (on_last_output_column = '1') then
                    output_column_progress <= (0 => '1', others => '0');
                    output_row_progress <= output_row_progress + 1;
                    input_idx <= input_idx + input_end_diff_ow; -- the amount to add when starting a new output on a new row.
                end if;
                    
                
            elsif (on_last_column = '1' and on_last_row = '1') then -- new channel
                filter_column_progress <= (0 => '1', others => '0');
                filter_row_progress <= (0 => '1', others => '0');
                
                filter_channel_progress <= filter_channel_progress + 1;
                
                input_idx <= input_idx + input_end_diff_fh;
                
            elsif (on_last_column = '1') then -- new row
                filter_column_progress <= (0 => '1', others => '0');
                
                filter_row_progress <= filter_row_progress + 1;
                
                input_idx <= input_idx + input_end_diff_fw;
            end if;
            
            
            
        end if;
    end if;
end process p_idx_gen;


end Behavioral;
