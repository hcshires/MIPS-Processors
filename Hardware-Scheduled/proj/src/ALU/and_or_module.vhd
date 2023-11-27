-------------------------------------------------------------------------
-- Tony Manschula and Henry Shires
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- and_or_module.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a design for a module that computes
--              AND, OR, NOR, and XOR for two n-bit inputs
--              
-- 03/06/23: Created
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity and_or_module is
  generic (N : integer := 32);
  port (
        i_D0      : in std_logic_vector(N-1 downto 0);
        i_D1      : in std_logic_vector(N-1 downto 0);
        i_op      : in std_logic_vector(1 downto 0);
        o_result  : out std_logic_vector(N-1 downto 0)
  );
end and_or_module;

architecture dataflow of and_or_module is
  signal s_others : std_logic_vector(0 downto 0);
begin
  s_others <= b"0";
  with i_op select
    o_result <= i_D0 AND i_D1 when b"00",
                i_D0 OR i_D1 when b"01",
                i_D0 NOR i_D1 when b"10",
                i_D0 XOR i_D1 when b"11",
                std_logic_vector(resize(unsigned(s_others), o_result'length)) when others;
end dataflow;