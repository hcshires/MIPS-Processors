-------------------------------------------------------------------------
-- Tony Manschula and Henry Shires
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_mips_pc.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for an implementation of
--              the MIPS PC register.
--              
-- 03/24/23: Created
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_mips_pc is
  generic(gCLK_HPER   : time := 5 ns);
end tb_mips_pc;

architecture tb of tb_mips_pc is
  constant cCLK_PER  : time := gCLK_HPER * 2;
  constant width: integer := 32;
  signal CLK, reset: std_logic;
  signal s_data, s_out: std_logic_vector(width-1 downto 0);

  component mips_pc is
    generic (N: integer := 32);
    port (i_CLK   : in std_logic;
          i_RST   : in std_logic;
          i_WEn   : in std_logic;
          i_Data  : in std_logic_vector(N-1 downto 0);
          o_Data  : out std_logic_vector(N-1 downto 0)
    );
  end component;

begin
  P_CLK: process
  begin
    CLK <= '1';         -- clock starts at 1
    wait for gCLK_HPER; -- after half a cycle
    CLK <= '0';         -- clock becomes a 0 (negative edge)
    wait for gCLK_HPER; -- after half a cycle, process begins evaluation again
  end process;

  --WEn is forced to 1 since we already know that the register write enable works correctly,
  --and the MIPS PC will never be WEn == 0.
  DUT: mips_pc port map (CLK, reset, '1', s_data, s_out);

  P_TB: process begin
    --Test the POR value
    wait until rising_edge(CLK);
    reset <= '1';
    
    --Verify the preset value holds if we set the input value
    wait until rising_edge(CLK);
    s_data <= x"00400004";
    
    --At its core the PC is just a register, and we already validated the register design
    wait until rising_edge(CLK);
    reset <= '0';
    s_data <= x"00400004";

    wait until rising_edge(CLK);
    s_data <= x"00400008";

    wait;
  end process;
end tb;