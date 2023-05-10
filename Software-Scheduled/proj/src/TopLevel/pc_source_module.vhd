-------------------------------------------------------------------------
-- Tony Manschula
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- pc_source_module.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a design for simple module that
--              generates a control signal for the PC source mux based on
--              whether the instruction in write-back would cause a
--              branch or jump to occur
--              
-- 04/08/23: Created
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity pc_source_module is
  port (
        i_do_branch : in std_logic;
        i_jump      : in std_logic_vector(1 downto 0);
        o_PCSrcSel  : out std_logic
  );
end pc_source_module;

architecture dataflow of pc_source_module is
  signal s_input_concat : std_logic_vector(2 downto 0);
begin
  s_input_concat <= i_do_branch & i_jump;
  with s_input_concat select
    o_PCSrcSel <= '0' when b"000",
                  '1' when others;

end dataflow;