-------------------------------------------------------------------------
-- Tony Manschula and Henry Shires
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- nbit_reg.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a design for an n-bit positive-edge
--              triggered, active high reset register.
--              
-- 02/02/23: Created
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity reg is 
  generic (N : integer := 32);  --Default 32 bit register
  port (i_CLK   : in std_logic;
        i_RST   : in std_logic;
        i_WEn   : in std_logic;
        i_Data  : in std_logic_vector(N-1 downto 0);
        o_Data  : out std_logic_vector(N-1 downto 0)
        );
end reg;

architecture structural of reg is
  --No intermediate signals needed, just dff

  component dffg is
     port(i_CLK        : in std_logic;     -- Clock input
          i_RST        : in std_logic;     -- Reset input
          i_WE         : in std_logic;     -- Write enable input
          i_D          : in std_logic;     -- Data value input
          o_Q          : out std_logic);
  end component;

begin
  --Instantiate n DFF's to be the basis for the register
  g_dff : for i in 0 to N-1 generate
    DFF_N : dffg port map(i_CLK, i_RST, i_WEn, i_Data(i), o_Data(i));
  end generate g_dff;

end structural;
