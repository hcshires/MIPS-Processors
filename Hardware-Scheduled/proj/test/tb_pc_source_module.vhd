-------------------------------------------------------------------------
-- Tony Manschula
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_pc_source_module.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for simple module that
--              generates a control signal for the PC source mux based on
--              whether the instruction in write-back would cause a
--              branch or jump to occur
--              
-- 04/09/23: Created
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity tb_pc_source_module is
end tb_pc_source_module;

architecture mixed of tb_pc_source_module is
  component pc_source_module
    port (
      i_do_branch : in std_logic;
      i_jump      : in std_logic_vector(1 downto 0);
      o_PCSrcSel  : out std_logic
    );
  end component;

  signal s_br, s_src_sel : std_logic;
  signal s_jump : std_logic_vector(1 downto 0);
begin
  DUT_pcsrc : pc_source_module port map (s_br, s_jump, s_src_sel);

  P_TEST_CASES: process begin
    s_br <= '1';
    s_jump <= b"11";
    wait for 5 ns;

    s_br <= '0';
    s_jump <= b"11";
    wait for 5 ns;

    s_br <= '1';
    s_jump <= b"10";
    wait for 5 ns;

    s_br <= '0';
    s_jump <= b"10";
    wait for 5 ns;

    s_br <= '1';
    s_jump <= b"01";
    wait for 5 ns;

    s_br <= '0';
    s_jump <= b"01";
    wait for 5 ns;

    s_br <= '1';
    s_jump <= b"00";
    wait for 5 ns;

    --Expect this to be the only time that the output is low
    s_br <= '0';
    s_jump <= b"00";
    wait for 5 ns;

    wait;
  end process;
end mixed;