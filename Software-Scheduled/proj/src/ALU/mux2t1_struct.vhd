-------------------------------------------------------------------------
-- Tony Manschula
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- mux2t1_struct.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file is a structurally-defined 2:1 mux.
--              
-- 01/21/23: Created
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux2t1_struct is
  port( i_S       : in std_logic;
        i_D0      : in std_logic;
        i_D1      : in std_logic;
        o_O       : out std_logic);

end mux2t1_struct;

architecture structural of mux2t1_struct is
  --Component declaration
  component andg2 is
    port( i_A          : in std_logic;
          i_B          : in std_logic;
          o_F          : out std_logic);
  end component;

  component invg is
    port( i_A          : in std_logic;
          o_F          : out std_logic);
  end component;

  component org2 is
    port( i_A          : in std_logic;
          i_B          : in std_logic;
          o_F         : out std_logic);
  end component;

  --Intermediate signal for inverted select signal as well as AND gate outputs
  signal s_S_not : std_logic;
  signal s_AND_D0 : std_logic;
  signal s_AND_D1 : std_logic;

begin
  --Instantiate two AND gates, one NOT gate, and one OR gate
  MUX_NOT : invg port map(i_S, s_S_not);

  AND_D0 : andg2 port map (i_D0, s_S_not, s_AND_D0);
  AND_D1 : andg2 port map (i_D1, i_S, s_AND_D1);

  OR_OUT : org2 port map (s_AND_D0, s_AND_D1, o_O);
end structural;