-------------------------------------------------------------------------
-- Tony Manschula
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- sign_extender.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a design for a MIPS sign extender.
--              
-- 02/10/23: Created
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sign_extender_32 is
    port (
          i_data      : in std_logic_vector(15 downto 0);
          i_signed    : in std_logic;
          o_data_ext  : out std_logic_vector(31 downto 0)
    );

end sign_extender_32;

architecture dataflow of sign_extender_32 is
begin
  with i_signed select
    o_data_ext <=  (15 => i_data(15), 14 => i_data(14), 13 => i_data(13), 12 => i_data(12), 11 => i_data(11), 10 => i_data(10), 9 => i_data(9),
                    8 => i_data(8), 7 => i_data(7), 6 => i_data(6), 5 => i_data(5), 4 => i_data(4), 3 => i_data(3), 2 => i_data(2), 1 => i_data(1), 0 => i_data(0), others => i_data(15)) when '1',
                  (15 => i_data(15), 14 => i_data(14), 13 => i_data(13), 12 => i_data(12), 11 => i_data(11), 10 => i_data(10), 9 => i_data(9),
                    8 => i_data(8), 7 => i_data(7), 6 => i_data(6), 5 => i_data(5), 4 => i_data(4), 3 => i_data(3), 2 => i_data(2), 1 => i_data(1), 0 => i_data(0), others => '0') when others;
end dataflow;