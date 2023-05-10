-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_sign_extender.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for MIPS datapath 1.
--              
-- 02/11/23: Created
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.env.all;    

entity tb_sign_extender is
end tb_sign_extender;

architecture structural of tb_sign_extender is
  signal s_data : std_logic_vector(15 downto 0);
  signal s_data_ext : std_logic_vector(31 downto 0);
  signal s_signed : std_logic;

  component sign_extender_32 is 
    port (
          i_data      : in std_logic_vector(15 downto 0);
          i_signed    : in std_logic;
          o_data_ext  : out std_logic_vector(31 downto 0)
    );
    end component;

begin
  DUT_EXT : sign_extender_32
    port map (s_data, s_signed, s_data_ext);

  P_TEST_CASES: process begin
    s_signed <= '0';
    s_data <= x"8000";
    wait for 5 ns;

    s_signed <= '1';
    s_data <= x"8000";
    wait for 5 ns;

    s_signed <= '0';
    s_data <= x"1234";
    wait for 5 ns;

    s_signed <= '1';
    s_data <= x"1234";
    wait for 5 ns;

    s_signed <= '1';
    s_data <= x"7F4C";
    wait for 5 ns;

    wait;
  end process;
end structural;