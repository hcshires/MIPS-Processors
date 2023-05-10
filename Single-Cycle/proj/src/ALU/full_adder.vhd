-------------------------------------------------------------------------
-- Tony Manschula
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- full_adder.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file implements a 1-bit full adder.
--              
-- 01/25/2023: Created
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity full_adder is
  port (
        i_0     : in std_logic;
        i_1     : in std_logic;
        i_Cin   : in std_logic;
        o_Sum   : out std_logic;
        o_Cout  : out std_logic
  );
end full_adder;

architecture structural of full_adder is
  component andg2 is
    port (
          i_A          : in std_logic;
          i_B          : in std_logic;
          o_F          : out std_logic
    );
  end component;

  component org2 is
    port (
          i_A          : in std_logic;
          i_B          : in std_logic;
          o_F          : out std_logic
    );
  end component;

  component xorg2 is
    port (
          i_A          : in std_logic;
          i_B          : in std_logic;
          o_F          : out std_logic
    );
  end component;

  --Internal signals
  signal s_X1 : std_logic;
  signal s_A1 : std_logic;
  signal s_A2 : std_logic;
begin
  --Sum component
  xor_1 : xorg2 port map (i_0, i_1, s_X1);
  xor_2 : xorg2 port map (i_Cin, s_X1, o_Sum);
  
  --Carry output
  and_1 : andg2 port map (i_0, i_1, s_A1);
  and_2 : andg2 port map (s_X1, i_Cin, s_A2);
  or_1 : org2 port map (s_A1, s_A2, o_Cout);
end structural;