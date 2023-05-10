-------------------------------------------------------------------------
-- Henry Shires
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_barrel_shifter.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a test bench for the barrel shifter unit.
--              
-- 03/03/23: Created
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all; -- For logic types I/O
library std;
use std.env.all; -- For hierarchical/external signals

entity tb_barrel_shifter is
  generic (
    bus_width : integer := 32;
    sel_width : integer := 5
  );
end tb_barrel_shifter;

architecture structural of tb_barrel_shifter is

  component barrel_shifter is
    generic (
      bus_width : integer := 32;
      sel_width : integer := 5
    );
    port (
      i_shamt : in std_logic_vector(sel_width - 1 downto 0); -- Shift amount
      i_shsrc : in std_logic_vector(bus_width - 1 downto 0); -- Input to shift
      i_shDir : in std_logic;                                -- Shift direction (0 = left, 1 = right)
      i_shArr : in std_logic;                                -- Shift arithmetic (0 = logical, 1 = yes)
      o_val : out std_logic_vector(bus_width - 1 downto 0)   -- Shifted output
    );

  end component;

  signal s_iShamt : std_logic_vector(sel_width - 1 downto 0);
  signal s_iShsrc : std_logic_vector(bus_width - 1 downto 0);
  signal s_iShDir : std_logic;
  signal s_iShArr : std_logic;
  signal s_oVal : std_logic_vector(bus_width - 1 downto 0);

begin
  DUT0 : barrel_shifter
  port map(s_iShamt, s_iShsrc, s_iShDir, s_iShArr, s_oVal);

  P_TEST : process
  begin
    -- Test input #1 -> sll
    s_iShsrc <= x"00000001";
    s_iShDir <= '0';
    s_iShArr <= '0';

    -- Don't shift
    s_iShamt <= "00000";
    wait for 5 ns;

    -- Shift 1
    s_iShamt <= "00001";
    wait for 5 ns;

    -- Shift 2
    s_iShamt <= "00010";
    wait for 5 ns;

    -- Shift 4
    s_iShamt <= "00100";
    wait for 5 ns;

    -- Shift 8
    s_iShamt <= "01000";
    wait for 5 ns;

    -- Shift 16
    s_iShamt <= "10000";
    wait for 5 ns;

    -- Shift 31
    s_iShamt <= "11111";
    wait for 5 ns;

    -- Test input #2 -> srl
    s_iShsrc <= x"80000000";
    s_iShDir <= '1';
    s_iShArr <= '0';

    -- Don't shift
    s_iShamt <= "00000";
    wait for 5 ns;

    -- Shift 1
    s_iShamt <= "00001";
    wait for 5 ns;

    -- Shift 2
    s_iShamt <= "00010";
    wait for 5 ns;

    -- Shift 4
    s_iShamt <= "00100";
    wait for 5 ns;

    -- Shift 8
    s_iShamt <= "01000";
    wait for 5 ns;

    -- Shift 16
    s_iShamt <= "10000";
    wait for 5 ns;

    -- Shift 31
    s_iShamt <= "11111";
    wait for 5 ns;

    -- Test input #3 -> sra
    s_iShsrc <= x"80000000";
    s_iShDir <= '1';
    s_iShArr <= '1';

    -- Don't shift
    s_iShamt <= "00000";
    wait for 5 ns;

    -- Shift 1
    s_iShamt <= "00001";
    wait for 5 ns;

    -- Shift 2
    s_iShamt <= "00010";
    wait for 5 ns;

    -- Shift 4
    s_iShamt <= "00100";
    wait for 5 ns;

    -- Shift 8
    s_iShamt <= "01000";
    wait for 5 ns;

    -- Shift 16
    s_iShamt <= "10000";
    wait for 5 ns;

    -- Shift 31
    s_iShamt <= "11111";
    wait for 5 ns;

    -- Test input #4 -> sra with 0 MSB
    s_iShsrc <= x"08000000";
    s_iShDir <= '1';
    s_iShArr <= '1';

    -- Don't shift
    s_iShamt <= "00000";
    wait for 5 ns;

    -- Shift 1
    s_iShamt <= "00001";
    wait for 5 ns;

    -- Shift 2
    s_iShamt <= "00010";
    wait for 5 ns;

    -- Shift 4
    s_iShamt <= "00100";
    wait for 5 ns;

    -- Shift 8
    s_iShamt <= "01000";
    wait for 5 ns;

    -- Shift 16
    s_iShamt <= "10000";
    wait for 5 ns;

    -- Shift 31
    s_iShamt <= "11111";
    wait for 5 ns;
    wait;
  end process;
end architecture;