-------------------------------------------------------------------------
-- Tony Manschula
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- n_bit_inverter.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a design for an n-bit one's complentor
--              unit.
--              
-- 01/23/23: Created
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity n_bit_inverter is
  generic (N : integer := 16);    --Input/output data width
  port (
        i_Data    : in std_logic_vector(N-1 downto 0);
        o_Data    : out std_logic_vector(N-1 downto 0)
  );
end n_bit_inverter;

architecture structural of n_bit_inverter is
  component invg is
    port( i_A          : in std_logic;
          o_F          : out std_logic);
  end component;

begin
  g_nbit_inverter : for i in 0 to N-1 generate
    INVERTER_N : invg port map (i_Data(i), o_Data(i));
  end generate g_nbit_inverter;

end structural;