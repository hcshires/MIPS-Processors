-------------------------------------------------------------------------
-- Tony Manschula and Henry Shires
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- shift_left_2.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a design for a component that shifts
--              an input two bits left
--              
-- 3/2/23: Created
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity shift_left_2 is
  generic (in_width : integer := 26;
           resize : std_logic := '0');
  port (
        i_data              : in std_logic_vector(in_width-1 downto 0);
        o_shft_data_resize  : out std_logic_vector((in_width+1) downto 0);
        o_shft_data_norsze  : out std_logic_vector(in_width-1 downto 0)
  );
end shift_left_2;

architecture dataflow of shift_left_2 is
  signal s_shifted : std_logic_vector(in_width+1 downto 0);
  signal s_shifted_no_resize : std_logic_vector(in_width-1 downto 0);
begin
  process (all) begin
    if resize = '0' then
      --Cut off the top two bits of the input and then put 0's on the LSB
      s_shifted_no_resize <= i_data(in_width-3 downto 0) & "00";
      o_shft_data_norsze <= s_shifted_no_resize;
    else 
      --Concatenate two bits on to the output
      s_shifted <= i_data & "00";
      o_shft_data_resize <= s_shifted;
    end if;
  end process;
end dataflow;