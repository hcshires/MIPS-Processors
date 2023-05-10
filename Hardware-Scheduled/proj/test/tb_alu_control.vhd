-------------------------------------------------------------------------
-- Henry Shires
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_alu_control.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a test bench for a single-cycle processor 
--              ALU control unit based on the implementation of ALU control signals
--              for group TermProj_3_02. This spreadsheet is included in
--              our project submission files.
--              
-- 03/29/23: Created
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all; -- For logic types I/O
library std;
use std.env.all; -- For hierarchical/external signals

entity tb_alu_control is
    
end tb_alu_control;

architecture structural of tb_alu_control is
  component alu_control_logic is
    port (
      i_funct : in std_logic_vector(5 downto 0);
      i_ALUOp : in std_logic_vector(2 downto 0);
      o_ALUSel : out std_logic_vector(4 downto 0)
    );
  end component;

  -- Instruction inputs
  signal s_iFunct : std_logic_vector(5 downto 0); -- 6-bit MIPS function code from instr memory
  signal s_iALUOp : std_logic_vector(2 downto 0); -- 3-bit ALU operation code

  -- Module outputs
  signal s_oALUSel: std_logic_vector(4 downto 0); -- ALU Select output

begin
    DUT0 : alu_control_logic port map(s_iFunct, s_iALUOp, S_OALUSel);

    -- Testbench process - Opcodes from Processor Spreadsheet
  P_TEST : process
  begin
    -- add
    s_iALUOp <= "000";
    s_iFunct <= "100000";
    wait for 5 ns;

    -- addi	
    s_iALUOp <= "001";
    wait for 5 ns;
    
    -- addiu
    s_iALUOp <= "010";
    wait for 5 ns;

    -- addu
    s_iALUOp <= "000";
    s_iFunct <= "100001";
    wait for 5 ns;
    
    -- and
    s_iALUOp <= "000";
    s_iFunct  <= "100100";
    wait for 5 ns;

    -- andi
    s_iALUOp <= "011";
    wait for 5 ns;

    -- lui
    s_iALUOp <= "010";
    wait for 5 ns;

    -- lw
    s_iALUOp <= "010";
    wait for 5 ns;

    -- nor
    s_iALUOp <= "000";
    s_iFunct  <= "100111";
    wait for 5 ns;

    -- xor
    s_iALUOp <= "000";
    s_iFunct  <= "100110";
    wait for 5 ns;

    -- xori
    s_iALUOp <= "100";
    wait for 5 ns;

    -- or
    s_iALUOp <= "000";
    s_iFunct  <= "100101";
    wait for 5 ns;

    -- ori
    s_iALUOp <= "101";
    wait for 5 ns;

    -- slt
    s_iALUOp <= "000";
    s_iFunct  <= "101010";
    wait for 5 ns;

    -- slti
    s_iALUOp <= "110";
    wait for 5 ns;

    -- sll
    s_iALUOp <= "000";
    s_iFunct  <= "000000";
    wait for 5 ns;

    -- srl
    s_iALUOp <= "000";
    s_iFunct  <= "000010";
    wait for 5 ns;

    -- sra
    s_iALUOp <= "000";
    s_iFunct  <= "000011";
    wait for 5 ns;

    -- sw
    s_iALUOp <= "010";
    wait for 5 ns;

    -- sub
    s_iALUOp <= "000";
    s_iFunct  <= "100010";
    wait for 5 ns;

    -- subu
    s_iALUOp <= "000";
    s_iFunct  <= "100011";
    wait for 5 ns;

    -- beq
    s_iALUOp <= "000";
    wait for 5 ns;

    -- bne
    s_iALUOp <= "000";
    wait for 5 ns;

    -- j
    s_iALUOp <= "000";
    wait for 5 ns;

    -- jal
    s_iALUOp <= "000";
    wait for 5 ns;

    -- jr
    s_iALUOp <= "000";
    s_iFunct  <= "001000";
    wait for 5 ns;

    -- bgez
    s_iALUOp <= "000";
    wait for 5 ns;

    -- bgezal
    s_iALUOp <= "000";
    wait for 5 ns;

    -- bgtz
    s_iALUOp <= "000";
    wait for 5 ns;

    -- blez
    s_iALUOp <= "000";
    wait for 5 ns;

    -- bltzal
    s_iALUOp <= "000";
    wait for 5 ns;

    -- bltz
    s_iALUOp <= "000";
    wait for 5 ns;

    -- halt
    s_iALUOp <= "000";
    wait for 5 ns;
    wait;
  end process;

end architecture;