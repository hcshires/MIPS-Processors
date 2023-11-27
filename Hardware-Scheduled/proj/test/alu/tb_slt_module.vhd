-------------------------------------------------------------------------
-- Tony Manschula and Henry Shires
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_slt_module.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for a module that computes
--              AND, OR, NOR, and XOR for two n-bit inputs
--              
-- 03/06/23: Created
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity tb_slt_module is
end tb_slt_module;

architecture structural of tb_slt_module is
  constant bus_width : integer := 4;
  signal s_D0 : std_logic_vector(bus_width-1 downto 0);
  signal s_D1 : std_logic_vector(bus_width-1 downto 0);
  signal s_out: std_logic_vector(bus_width-1 downto 0);

  component slt_module is
    generic (N : integer := 32);
    port (
          i_D0      : in std_logic_vector(N-1 downto 0);
          i_D1      : in std_logic_vector(N-1 downto 0);
          o_result  : out std_logic_vector(N-1 downto 0)
    );
  end component;

begin
  DUT_SLT: slt_module
    generic map (bus_width)
    port map (s_D0, s_D1, s_out);
  
  P_TEST_CASES: process begin
    --both positive (5 < 7) --> 1
    s_D0 <= b"0101";
    s_D1 <= b"0111";
    wait for 5 ns;

    -- 7 < 5 --> 0
    s_D1 <= b"0101";
    s_D0 <= b"0111";
    wait for 5 ns;

    -- -5 < 5 --> 1  (testing signed representation)
    s_D0 <= b"1011";
    s_D1 <= b"0101";
    wait for 5 ns;

    -- -5 < -6 --> 0
    s_D0 <= b"1011";
    s_D1 <= b"1010";
    wait for 5 ns;

    wait;
  end process;
end structural;