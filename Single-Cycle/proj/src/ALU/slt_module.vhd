-------------------------------------------------------------------------
-- Tony Manschula and Henry Shires
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- slt_module.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a design for a module that computes
--              AND, OR, NOR, and XOR for two n-bit inputs
--              
-- 03/06/23: Created
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity slt_module is
  generic (N : integer := 32);
  port (
        i_D0      : in std_logic_vector(N-1 downto 0);
        i_D1      : in std_logic_vector(N-1 downto 0);
        o_result  : out std_logic_vector(N-1 downto 0)
  );
end slt_module;

architecture behavioral of slt_module is
  signal s_0 : std_logic_vector(0 downto 0);
  signal s_1 : std_logic_vector(0 downto 0);
begin
  s_0 <= b"0";
  s_1 <= b"1";
  process (i_D0, i_D1) begin
    if (signed(i_D0) < signed(i_D1)) then 
      --Output a 1 if d0 is less than d1, otherwise output 0
      o_result <= std_logic_vector(resize(unsigned(s_1), o_result'length));
    else 
      o_result <= std_logic_vector(resize(unsigned(s_0), o_result'length));
    end if;
  end process;
end behavioral;