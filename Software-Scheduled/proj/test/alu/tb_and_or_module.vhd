-------------------------------------------------------------------------
-- Tony Manschula
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_and_or_module.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for a module that computes
--              AND, OR, NOR, and XOR for two n-bit inputs
--              
-- 03/06/23: Created
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity tb_and_or_module is
end tb_and_or_module;

architecture structural of tb_and_or_module is
  constant bus_width : integer := 4;
  signal s_D0 : std_logic_vector(bus_width-1 downto 0);
  signal s_D1 : std_logic_vector(bus_width-1 downto 0);
  signal s_op : std_logic_vector(1 downto 0);
  signal s_out: std_logic_vector(bus_width-1 downto 0);

  component and_or_module is
    generic (N : integer := 32);
    port (
          i_D0      : in std_logic_vector(N-1 downto 0);
          i_D1      : in std_logic_vector(N-1 downto 0);
          i_op      : in std_logic_vector(1 downto 0);
          o_result  : out std_logic_vector(N-1 downto 0)
    );
  end component;

begin
  DUT_AOR: and_or_module
    generic map (bus_width)
    port map (s_D0, s_D1, s_op, s_out);

  P_TEST_CASES: process begin
    --AND expect 0x1000
    s_op <= b"00";
    s_D0 <= b"1101";
    s_D1 <= b"1010";
    wait for 5 ns;

    --OR expect 0x1111
    s_op <= b"01";
    s_D0 <= b"1101";
    s_D1 <= b"1010";
    wait for 5 ns;

    --NOR expect 0x0000
    s_op <= b"10";
    s_D0 <= b"1101";
    s_D1 <= b"1010";
    wait for 5 ns;

    --XOR expect 0x0111
    s_op <= b"11";
    s_D0 <= b"1101";
    s_D1 <= b"1010";
    wait for 5 ns;

    wait;
  end process;
end structural;