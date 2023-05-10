-------------------------------------------------------------------------
-- Tony Manschula
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- nbit_reg.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a design for an n-bit positive-edge
--              triggered, active high reset register.
--              
-- 03/24/23: Created
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mips_reg_preset is
  generic (N: integer := 32);
  port (i_CLK     : in std_logic;
        i_RST     : in std_logic;
        i_RST_Val : in std_logic_vector (N-1 downto 0);
        i_WEn     : in std_logic;
        i_Data    : in std_logic_vector(N-1 downto 0);
        o_Data    : out std_logic_vector(N-1 downto 0)
  );
end mips_reg_preset;

architecture behavioral of mips_reg_preset is
  signal s_in_Data: std_logic_vector(N-1 downto 0);
  signal s_Out    : std_logic_vector(N-1 downto 0);
  signal s_rst_val: std_logic_vector(N-1 downto 0);

begin
  o_Data <= s_Out;

  with i_WEn select
    s_in_Data <= i_Data when '1',
              s_Out when others;

  process (i_CLK, i_RST) begin
    if (i_RST = '1') then
      s_Out <= i_RST_Val;
    elsif (rising_edge(i_CLK)) then
      s_Out <= s_in_Data;
    end if;
  end process;
end behavioral;