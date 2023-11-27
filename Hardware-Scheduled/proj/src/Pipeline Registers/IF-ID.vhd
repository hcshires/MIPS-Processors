-------------------------------------------------------------------------
-- Tony Manschula and Henry Shires
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- IF-ID.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a design for an n-bit, positive-edge
--              triggered, active high reset PC register specific to the 
--              MIPS ISA.
--              
-- 04/08/23: Created
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity if_id_reg is 
  port (
        i_CLK   : in std_logic;
        i_RST   : in std_logic;
        i_WEn   : in std_logic;
        i_PCP4  : in std_logic_vector(31 downto 0);
        i_Inst  : in std_logic_vector(31 downto 0);
        o_PCP4  : out std_logic_vector(31 downto 0);
        o_Inst  : out std_logic_vector(31 downto 0)
  );
end if_id_reg;

architecture structural of if_id_reg is
  component reg_sync_reset is 
    generic (N : integer := 32);  --Default 32 bit register
    port (i_CLK   : in std_logic;
          i_RST   : in std_logic;
          i_WEn   : in std_logic;
          i_Data  : in std_logic_vector(N-1 downto 0);
          o_Data  : out std_logic_vector(N-1 downto 0)
          );
  end component;

begin

  PCP4_reg : reg_sync_reset port map (i_CLK, i_RST, i_WEn, i_PCP4, o_PCP4);
  Inst_reg : reg_sync_reset port map (i_CLK, i_RST, i_WEn, i_Inst, o_Inst);

end structural;