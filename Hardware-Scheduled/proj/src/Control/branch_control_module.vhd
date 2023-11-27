-------------------------------------------------------------------------
-- Tony Manschula and Henry Shires
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- branch_control_module.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: Implementation of a sub-control module in charge of determining
--              whether or not to branch, and if so, which type of branch
--              to take based on the instruction opcode decoded by the main
--              control unit. Outputs a 0 for no branch and 1 for branch
--              
-- 03/10/23: Created
-- 03/23/23: Refactored and updated to branch_control_module by TM
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity branch_control_module is
  generic (N : integer := 32);
  port (
    i_dsrc1  : in std_logic_vector(N - 1 downto 0);
    i_dsrc2  : in std_logic_vector(N - 1 downto 0);
    i_BrType : in std_logic_vector(2 downto 0);
    o_Branch : out std_logic
  );
end branch_control_module;

architecture behavioral of branch_control_module is
begin
  p_brctrl : process (i_dsrc1, i_dsrc2, i_BrType) begin
    case i_BrType is
        --beq
      when b"000" =>
        if (i_dsrc1 = i_dsrc2) then
          o_Branch <= '1';
        else
          o_Branch <= '0';
        end if;

        --bne
      when b"001" =>
        if (i_dsrc1 /= i_dsrc2) then
          o_Branch <= '1';
        else
          o_Branch <= '0';
        end if;

        --bgez, bgezal
      when b"010" =>
        if (signed(i_dsrc1) >= 0) then
          o_Branch <= '1';
        else
          o_Branch <= '0';
        end if;

        -- bgtz
      when b"011" =>
        if (signed(i_dsrc1) > 0) then
          o_Branch <= '1';
        else
          o_Branch <= '0';
        end if;

        -- blez
      when b"100" =>
        if (signed(i_dsrc1) <= 0) then
          o_Branch <= '1';
        else
          o_Branch <= '0';
        end if;

        -- bltzal, bltz
      when b"101" =>
        if (signed(i_dsrc1) < 0) then
          o_Branch <= '1';
        else
          o_Branch <= '0';
        end if;

      when others => o_Branch <= '0';
    end case;
  end process;
end behavioral;