-------------------------------------------------------------------------
-- Anthony Manschula
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_shift_left_2.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a skeleton of a MIPS_Processor  
-- implementation.

-- 03/03/23: Created.
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

library work;
use work.MIPS_types.all;

entity tb_shift_left_2 is
end tb_shift_left_2;

architecture structural of tb_shift_left_2 is
  signal s_data : std_logic_vector(31 downto 0);
  signal s_data_out_big : std_logic_vector(33 downto 0);
  signal s_data_out_noresize : std_logic_vector(31 downto 0);
  component shift_left_2 is
    generic (in_width : integer := 26;
             resize : std_logic := '0');
    port (
          i_data              : in std_logic_vector(in_width-1 downto 0);
          o_shft_data_resize  : out std_logic_vector((in_width+1) downto 0);
          o_shft_data_norsze  : out std_logic_vector(in_width-1 downto 0)
    );
  end component;

begin
  DUT_SHIFT_RESIZE : shift_left_2 generic map (32, '1') port map (s_data, s_data_out_big, open);
  DUT_SHIFT_NORSZE : shift_left_2 generic map (32, '0') port map (s_data, open, s_data_out_noresize);

  P_TEST_CASES: process begin
    s_data <= x"00000000";
    
    wait for 5 ns;
    s_data <= x"10001234";

    wait for 5 ns;
    s_data <= x"11111111";

    wait for 5 ns;
    s_data <= x"22222222";

    wait for 5 ns;
    s_data <= x"44444444";

    wait for 5 ns;
    s_data <= x"88888888";

    wait for 5 ns;
    s_data <= x"FFFFFFFF";

    wait;
  end process;
end structural;