-------------------------------------------------------------------------
-- Henry Shires
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_branch_control_module.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a test bench for a single-cycle processor 
--              branch control unit based on the implementation of branching
--              and fetch logic for group TermProj_3_02.
--              
-- 03/29/23: Created
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all; -- For logic types I/O
library std;
use std.env.all; -- For hierarchical/external signals

entity tb_branch_control_module is
  generic (
    bus_width : integer := 32;
    sel_width : integer := 5
  );
end tb_branch_control_module;

architecture structural of tb_branch_control_module is
  component branch_control_module is
    generic (N : integer := 32);
    port (
      i_dsrc1 : in std_logic_vector(N - 1 downto 0);
      i_dsrc2 : in std_logic_vector(N - 1 downto 0);
      i_BrType : in std_logic_vector(2 downto 0);
      o_Branch : out std_logic
    );
  end component;

  -- Input
  signal s_iDsrc1 : std_logic_vector(bus_width - 1 downto 0);
  signal s_iDsrc2 : std_logic_vector(bus_width - 1 downto 0);
  signal s_iBrType : std_logic_vector(2 downto 0);

  -- Output
  signal s_oBranch : std_logic;

begin
  DUT0 : branch_control_module generic map(bus_width) port map(s_iDsrc1, s_iDsrc2, s_iBrType, s_oBranch);

  P_TEST : process
  begin
    -- beq: Condition false
    s_iDsrc1 <= x"12345678";
    s_iDsrc2 <= x"87654321";
    s_iBrType <= "000";
    wait for 5 ns;

    -- beq: Condition true
    s_iDsrc1 <= x"12345678";
    s_iDsrc2 <= x"12345678";
    s_iBrType <= "000";
    wait for 5 ns;

    -- bne: Condition false
    s_iDsrc1 <= x"12345678";
    s_iDsrc2 <= x"12345678";
    s_iBrType <= "001";
    wait for 5 ns;

    -- bne: Condition true
    s_iDsrc1 <= x"12345678";
    s_iDsrc2 <= x"87654321";
    s_iBrType <= "001";
    wait for 5 ns;

    -- bgez, bgezal: Condition false, < 0
    s_iDsrc1 <= x"FFFFFFFF";
    s_iBrType <= "010";
    wait for 5 ns;

    -- bgez, bgezal: Condition true, == 0
    s_iDsrc1 <= x"00000000";
    s_iBrType <= "010";
    wait for 5 ns;

    -- bgez, bgezal: Condition true, > 0
    s_iDsrc1 <= x"00000001";
    s_iBrType <= "010";
    wait for 5 ns;

    -- bgtz: Condition false
    s_iDsrc1 <= x"00000000";
    s_iBrType <= "011";
    wait for 5 ns;

    -- bgtz: Condition true
    s_iDsrc1 <= x"00000001";
    s_iBrType <= "011";
    wait for 5 ns;

    -- blez: Condition false
    s_iDsrc1 <= x"00000001";
    s_iBrType <= "100";
    wait for 5 ns;

    -- blez: Condition true, == 0
    s_iDsrc1 <= x"00000000";
    s_iBrType <= "100";
    wait for 5 ns;

    -- blez: Condition true, < 0
    s_iDsrc1 <= x"FFFFFFFF";
    s_iBrType <= "100";
    wait for 5 ns;

    -- bltz, bltzal: Condition false
    s_iDsrc1 <= x"00000000";
    s_iBrType <= "101";
    wait for 5 ns;

    -- bltz, bltzal: Condition true
    s_iDsrc1 <= x"FFFFFFFF";
    s_iBrType <= "101";
    wait for 5 ns;
    wait;
  end process;
end architecture;