-------------------------------------------------------------------------
-- Tony Manschula and Henry Shires
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- alu_control_logic.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a design the ALU control logic.
--              
-- 03/12/23: Created
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity alu_control_logic is
  port (
        i_funct   : in std_logic_vector(5 downto 0);
        i_ALUOp   : in std_logic_vector(2 downto 0);
        o_ALUSel  : out std_logic_vector(4 downto 0)
  );
end alu_control_logic;

architecture behavioral of alu_control_logic is 

begin
  process (i_funct, i_ALUOp) begin
    if ((i_funct = b"100000" and i_ALUOp = b"000") or i_ALUOp = b"001")       then o_ALUSel <= b"11010";
    elsif ((i_funct = b"100001" and i_ALUOp = b"000") or i_ALUOp = b"010")    then o_ALUSel <= b"01010";
    elsif ((i_funct = b"100100" and i_ALUOp = b"000") or i_ALUOp = b"011")    then o_ALUSel <= b"00000";
    elsif (i_funct = b"100111" and i_ALUOp = b"000")                          then o_ALUSel <= b"00110";
    elsif (i_funct = b"100110" and i_ALUOp = b"000")                          then o_ALUSel <= b"00111";
    elsif ((i_funct = b"100101" and i_ALUOp = b"000") or i_ALUOp = b"101")    then o_ALUSel <= b"00001";
    elsif ((i_funct = b"101010" and i_ALUOp = b"000") or i_ALUOp = b"110")    then o_ALUSel <= b"01111";
    elsif (i_funct = b"000000" and i_ALUOp = b"000")                          then o_ALUSel <= b"01011";
    elsif (i_funct = b"000010" and i_ALUOp = b"000")                          then o_ALUSel <= b"01100";
    elsif ((i_funct = b"100110" and i_ALUOp = b"000") or i_ALUOp = b"100")    then o_ALUSel <= b"00111";
    elsif (i_funct = b"000011" and i_ALUOp = b"000")                          then o_ALUSel <= b"01101";
    elsif (i_funct = b"100010" and i_ALUOp = b"000")                          then o_ALUSel <= b"11110";
    elsif (i_funct = b"100011" and i_ALUOp = b"000")                          then o_ALUSel <= b"01110";
    else o_ALUSel <= b"00000";
    end if;
  end process;
end behavioral;