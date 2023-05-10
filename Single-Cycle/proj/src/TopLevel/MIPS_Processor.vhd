-------------------------------------------------------------------------
-- Anthony Manschula and Henry Shires
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- The Manschula-Shires Single-Cycle MIPS Processor

-- MIPS_Processor.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a skeleton of a MIPS_Processor  
-- implementation.

-- 01/29/2019 by H3::Design created.
-- Adapted from Dr. Henry Duwe
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

library work;
use work.MIPS_types.all;
use IEEE.numeric_std.all;

entity MIPS_Processor is
  generic(N : integer := DATA_WIDTH);
  port(iCLK            : in std_logic;
       iRST            : in std_logic;
       iInstLd         : in std_logic;
       iInstAddr       : in std_logic_vector(N-1 downto 0);
       iInstExt        : in std_logic_vector(N-1 downto 0);
       oALUOut         : out std_logic_vector(N-1 downto 0)); -- TODO: Hook this up to the output of the ALU. It is important for synthesis that you have this output that can effectively be impacted by all other components so they are not optimized away.

end  MIPS_Processor;

-- The Manschula-Shires Single-Cycle MIPS Processor
architecture structure of MIPS_Processor is

  --############################################
  --!!!!DUWE REQUIRED TEST FRAMEWORK SIGNALS!!!!
  --############################################
  -- Required data memory signals
  signal s_DMemWr       : std_logic; -- TODO: use this signal as the final active high data memory write enable signal
  signal s_DMemAddr     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory address input
  signal s_DMemData     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input
  signal s_DMemOut      : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the data memory output
 
  -- Required register file signals 
  signal s_RegWrAddr    : std_logic_vector(4 downto 0); -- TODO: use this signal as the final destination register address input
  signal s_RegWrData    : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input

  -- Required instruction memory signals
  signal s_IMemAddr     : std_logic_vector(N-1 downto 0); -- Do not assign this signal, assign to s_NextInstAddr instead
  signal s_NextInstAddr : std_logic_vector(N-1 downto 0); -- TODO: use this signal as your intended final instruction memory address input.
  signal s_Inst         : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the instruction signal 

  -- Required halt signal -- for simulation
  signal s_Halt         : std_logic;  -- TODO: this signal indicates to the simulation that intended program execution has completed. (Opcode: 01 0100)

  -- Required overflow signal -- for overflow exception detection
  signal s_Ovfl         : std_logic;  -- TODO: this signal indicates an overflow exception would have been initiated
  --####END DUWE REQUIRED TEST FRAMEWORK SIGNALS#### 

  -- Signal for final new PC address
  signal s_new_pc       : std_logic_vector(N-1 downto 0);

  --"PC plus 4 adder" signals
  signal s_pc_plus_4    : std_logic_vector(N-1 downto 0);
  signal s_pcp4_cout    : std_logic;

  --Input bus for relevant destination registers, 3 buses of 5 bits each (either rt, rd, or hardcoded 31 for jal)
  signal s_dest_input_bus : bus_array(3 downto 0)(4 downto 0);

  --Generate a value for LUI instruction
  signal s_lui_val      : std_logic_vector(N-1 downto 0);

  --Signals for outputs of register file
  signal s_dsrc1,
         s_dsrc2        : std_logic_vector(N-1 downto 0);

  --Sign-extended immediate output from the sign extender, used for branch address calc
  signal s_sign_ext_imm : std_logic_vector(N-1 downto 0);

  --Signal for 2-bit left shifted jump address from inst(25:0)
  signal s_j_addr       : std_logic_vector(N-1 downto 0);

  --Signal for 2-bit left shifted branch label address
  signal s_branch_label : std_logic_vector(N-1 downto 0);

  --Signal that carries the complete branch addr (PC+4 + label addr) and carryout from that adder
  signal s_branch_addr  : std_logic_vector(N-1 downto 0);
  signal s_branch_cout  : std_logic;

  --This signal carries either PC+4 or the branch address to the 3-1 mux for j, jr, and branch
  signal s_pcp4_branch_out : std_logic_vector(N-1 downto 0);

  --Signal bus that carries the inputs reg dsrc1 (jr), j_addr, and pcp4_branch_out to final PC address mux
  signal s_final_pc_mux_bus : bus_array(3 downto 0)(N-1 downto 0);

  --Signal that carries the zero output of ALU to the branch AND gate
  --TODO rename me to be more descriptive since this is the branch control!
  signal s_branch_mod_out   : std_logic;

  --Signal from branch AND gate that compares s_zero and s_branchCtl
  signal s_do_branch    : std_logic;

  --Signal to carry the output of the immediate/reg dsrc2 mux to the second alu input
  signal s_alud1        :std_logic_vector(N-1 downto 0);

  --Signal for output of the ALU
  signal s_alu_out      : std_logic_vector(N-1 downto 0);

  signal s_reg_write_data_bus : bus_array(3 downto 0)(N-1 downto 0);

  --Signal that should never be written to
  signal s_dummy        : std_logic_vector(N-1 downto 0);

  --###############
  --CONTROL SIGNALS
  --###############
  signal s_RegWr        : std_logic; -- TODO: use this signal as the final active high write enable input to the register file (DO NOT RENAME)
  signal s_CntrlRegWrite: std_logic;
  signal s_RegDst       : std_logic_vector(1 downto 0);
  signal s_sign_ext_en  : std_logic;
  signal s_jump         : std_logic_vector(1 downto 0);
  signal s_MemSel       : std_logic_vector(1 downto 0);
  signal s_BranchCtl    : std_logic;
  --Controls the mux for immediate/reg dsrc2 to ALU
  signal s_ALUSrc       : std_logic;
  signal s_ALUOp        : std_logic_vector(2 downto 0);
  signal s_MemWr        : std_logic;
  --ALUSel: output of ALU control module (not central control)
  signal s_ALUSel       : std_logic_vector(4 downto 0);
  --Tell the ALU what type of branching to use
  signal s_BranchType   : std_logic_vector(2 downto 0);

  --#####################
  --COMPONENT DEFINITIONS
  --#####################
  component mem is
    generic(ADDR_WIDTH : integer;
            DATA_WIDTH : integer);
    port(
          clk          : in std_logic;
          addr         : in std_logic_vector((ADDR_WIDTH-1) downto 0);
          data         : in std_logic_vector((DATA_WIDTH-1) downto 0);
          we           : in std_logic := '1';
          q            : out std_logic_vector((DATA_WIDTH -1) downto 0)
    );
    end component;

  -- TODO: You may add any additional signals or components your implementation 
  --       requires below this comment

  component mux2t1_N is 
    generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
    port(i_S          : in std_logic;
        i_D0         : in std_logic_vector(N-1 downto 0);
        i_D1         : in std_logic_vector(N-1 downto 0);
        o_O          : out std_logic_vector(N-1 downto 0)
    );
  end component;
  
  component mux2t1 is
  port( i_S       : in std_logic;
        i_D0      : in std_logic;
        i_D1      : in std_logic;
        o_O       : out std_logic);
  end component;

  component mux_Nt1 is
    generic (
              bus_width : integer := 32;
              sel_width : integer := 5
            );
    port (
          --2D array of [2^sel_width][bus_width] size
          --Array width must be an int that represents the size, not treated as a binary
          i_reg_bus : in bus_array(2**sel_width - 1 downto 0)(bus_width-1 downto 0);
          i_sel     : in std_logic_vector(sel_width-1 downto 0);
          o_reg     : out std_logic_vector(bus_width-1 downto 0)
    );
  end component;

  component regfile is
    generic (
              reg_size : integer := 32;
              sel_width : integer := 5
            );
    port (
          i_src1      : in std_logic_vector(sel_width-1 downto 0);
          i_src2      : in std_logic_vector(sel_width-1 downto 0);
          i_dest      : in std_logic_vector(sel_width-1 downto 0);
          i_wdata     : in std_logic_vector(reg_size-1 downto 0);
          i_RegWrite  : in std_logic; 
          i_CLK       : in std_logic;
          i_RST       : in std_logic;
          o_data_src1 : out std_logic_vector(reg_size-1 downto 0);
          o_data_src2 : out std_logic_vector(reg_size-1 downto 0)
    );
  end component;

  component sign_extender_32 is
    port (
          i_data      : in std_logic_vector(15 downto 0);
          i_signed    : in std_logic;
          o_data_ext  : out std_logic_vector(31 downto 0)
    );
  end component;

  component andg2 is
    port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
  end component;

  component control_unit is
    port (
      -- Instruction inputs
      i_opcode    : in std_logic_vector(5 downto 0);  -- Opcode from MIPS instruction memory (s_Instr[31-26])
      i_funct     : in std_logic_vector(5 downto 0);  -- Function code for certain instructions with same opcode
      i_rt        : in std_logic_vector(4 downto 0);  -- RT field helps determine branch type
      -- Control signal outputs
      o_RegWr     : out std_logic;                    -- Register write enable
      o_RegDst    : out std_logic_vector(1 downto 0); -- Register destination
      o_sign_ext_en  : out std_logic;                 -- Sign extension enable
      o_jump      : out std_logic_vector(1 downto 0); -- Controls address for jump
      o_MemSel    : out std_logic_vector(1 downto 0); -- Select write back source, either data memory, ALU, or PC+4
      o_branchCtl : out std_logic;                    -- ANDed with branch signal from ALU to determine if branch is taken
      o_BranchType: out std_logic_vector(2 downto 0); -- Tells Branch control what branch type we want to do
      o_ALUSrc    : out std_logic;                    -- ALU source
      o_ALUOp     : out std_logic_vector(2 downto 0); -- Used by ALU control to determine ALU operation
      o_MemWr     : out std_logic;                    -- Data Memory write enable
      o_Halt      : out std_logic                     -- Instruction to stop the program
    );
  end component;

  component alu_control_logic is
    port (
          i_funct   : in std_logic_vector(5 downto 0);
          i_ALUOp   : in std_logic_vector(2 downto 0);
          o_ALUSel  : out std_logic_vector(4 downto 0)
    );
  end component;

  component branch_control_module is 
    generic (N : integer := 32);
    port (
          i_dsrc1       : in std_logic_vector(N-1 downto 0);
          i_dsrc2       : in std_logic_vector(N-1 downto 0);
          i_BrType      : in std_logic_vector(2 downto 0);
          o_Branch      : out std_logic
    );
  end component;

  component ALU is
    --Data bus width
    generic (N : integer := 32);
    port (
          i_ALUCtrl   : in std_logic_vector(4 downto 0);
          --Data 0 goes to i_A of adder
          i_Data_0    : in std_logic_vector(N-1 downto 0);
          --Data 1 goes to 1's comp unit (inverter), and to input 0 of mux
          --Mux controls whether the inverted or untouched data is added to data_0
          i_Data_1    : in std_logic_vector(N-1 downto 0);
          i_shamt     : in std_logic_vector(4 downto 0);
          o_ALUOut    : out std_logic_vector(N-1 downto 0);
          o_Cout      : out std_logic;
          o_Overflow  : out std_logic
    );
  end component;

  --Adder for PC and branch address calculation
  component ripple_adder is
    generic (N : integer := 32);
    port (
          i_A     : in std_logic_vector(N-1 downto 0);
          i_B     : in std_logic_vector(N-1 downto 0);
          i_Cin   : in std_logic;
          o_Sum   : out std_logic_vector(N-1 downto 0);
          o_Cout  : out std_logic
    );
  end component;

  --Register is for PC
  component mips_pc is
    generic (N: integer := 32);
    port (i_CLK   : in std_logic;
          i_RST   : in std_logic;
          i_WEn   : in std_logic;
          i_Data  : in std_logic_vector(N-1 downto 0);
          o_Data  : out std_logic_vector(N-1 downto 0)
    );
  end component;

  component shift_left_2 is
    generic (in_width : integer := 26;
            resize : std_logic := '0');
    port (
          i_data              : in std_logic_vector(in_width-1 downto 0);
          o_shft_data_resize  : out std_logic_vector((in_width+1) downto 0);
          o_shft_data_norsze  : out std_logic_vector(in_width-1 downto 0)
    );
  end component;


begin
  --###################
  --PROCESSOR STRUCTURE
  --###################
  -- TODO: This is required to be your final input to your instruction memory. 
  -- This provides a feasible method to externally load the memory module 
  -- which means that the synthesis tool must assume it knows nothing about 
  -- the values stored in the instruction memory. If this is not included, 
  -- much, if not all of the design is optimized out because the synthesis tool 
  -- will believe the memory to be all zeros.
  with iInstLd select
    s_IMemAddr <= s_NextInstAddr when '0',
      iInstAddr when others;


  IMem: mem
    generic map(ADDR_WIDTH => ADDR_WIDTH,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_IMemAddr(11 downto 2),
             data => iInstExt,
             we   => iInstLd,
             q    => s_Inst);
  
  --Assigning required signals
  s_DMemAddr <= s_alu_out;
  s_DMemData <= s_dsrc2;
  DMem: mem
    generic map(ADDR_WIDTH => ADDR_WIDTH,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_DMemAddr(11 downto 2),
             data => s_DMemData,
             we   => s_DMemWr,
             q    => s_DMemOut);

  -- TODO: Implement the rest of your processor below this comment! 

  --Assign value to dummy signal so that design optimization doesn't remove it
  s_dummy <= x"FEEDFACE";

  --PC holds address of instruction to execute
  PC : mips_pc 
      port map (iCLK, iRST, '1', s_new_pc, s_NextInstAddr);

  --Adds 4 to the current value of PC
  PC_plus_4_adder : ripple_adder 
      port map (s_NextInstAddr, std_logic_vector(to_unsigned(4, N)), '0', s_pc_plus_4, s_pcp4_cout);

  --Map two instruction data lines and hardcoded 31 into a bus so the mux can mux it into the write data select port on regfile
  s_dest_input_bus <= (0 => s_Inst(20 downto 16), 1 => s_Inst(15 downto 11), 2 => std_logic_vector(to_unsigned(31, 5)), 3=> s_dummy(4 downto 0));
  --Need mux to do destination register input
  reg_dest_mux : mux_Nt1 
    generic map (bus_width => 5, sel_width => 2)
    port map (s_dest_input_bus, s_RegDst, s_RegWrAddr);

  reg_write_mux : mux2t1
    port map (s_RegDst(1), s_CntrlRegWrite, s_do_branch OR s_CntrlRegWrite, s_RegWr);

  --Register file is register file ¯\_(ツ)_/¯
  reg_file : regfile port map (s_Inst(25 downto 21), s_Inst(20 downto 16), s_RegWrAddr, s_RegWrData, s_RegWr, iCLK, iRST, s_dsrc1, s_dsrc2);

  --Sign-extend 15-bit immediate from instruction
  sign_extend_32 : sign_extender_32
    port map (s_Inst(15 downto 0), s_sign_ext_en, s_sign_ext_imm);

  --Shift left 2 on the jump address
  sl2_jaddr : shift_left_2 
    generic map (in_width => 26, resize => '1')
    port map    (s_Inst(25 downto 0), s_j_addr(27 downto 0), open);
  --Upper 4 bits of jump address come from pc+4
  s_j_addr(31 downto 28) <= s_pc_plus_4(31 downto 28);

  --Another shift left 2 module to handle branch address from branch instructions
  sl2_branch : shift_left_2
    generic map (in_width => 32, resize => '0')
    port map    (s_sign_ext_imm, open, s_branch_label);

  mux2t1_alusrc2 : mux2t1_N
    generic map (32)
    port map (s_ALUSrc, s_dsrc2, s_sign_ext_imm, s_alud1);

  central_control : control_unit
    port map (s_Inst(31 downto 26), s_Inst(5 downto 0), s_Inst(20 downto 16), s_CntrlRegWrite, s_RegDst, s_sign_ext_en, s_jump, s_MemSel, s_BranchCtl, s_BranchType, s_ALUSrc, s_ALUOp, s_DMemWr, s_Halt);

  --Control the operation performed by the ALU based off of function type and ALUOp from central control
  alu_control : alu_control_logic
    port map (s_Inst(5 downto 0), s_ALUOp, s_ALUSel);

  branch_control : branch_control_module
      port map (s_dsrc1, s_dsrc2, s_BranchType, s_branch_mod_out);

  proc_alu : ALU
    generic map (32)
    port map (s_ALUSel, s_dsrc1, s_alud1, s_Inst(10 downto 6), s_alu_out, open, s_Ovfl);
    --Done as per the Duwe MIPS processor port definition at top
    oALUOut <= s_alu_out;

  --This adder computes the branch address
  branch_adder : ripple_adder
    port map (s_pc_plus_4, s_branch_label, '0', s_branch_addr, s_branch_cout);

  branch_and : andg2
    port map (s_branchCtl, s_branch_mod_out, s_do_branch);

  --This mux switches the PC + 4 line and the branch address line according to the do_branch signal
  branch_mux : mux2t1_N 
    port map (s_do_branch, s_pc_plus_4, s_branch_addr, s_pcp4_branch_out);

  --Map three data lines (PC + 4, jump address, register data out line 1 for jr) into bus so mux can send back to PC
  s_final_pc_mux_bus <= (0 => s_pcp4_branch_out, 1 => s_j_addr, 2 => s_dsrc1, 3 => s_dummy);
  j_jr_b_mux : mux_Nt1
    generic map (bus_width => 32, sel_width => 2)
    port map    (s_final_pc_mux_bus, s_jump, s_new_pc);

  s_lui_val <= s_Inst(15 downto 0) & x"0000";
  s_reg_write_data_bus <= (0 => s_alu_out, 1 => s_DMemOut, 2 => s_pc_plus_4, 3 => s_lui_val);
  alu_dmem_mux: mux_Nt1
    generic map (bus_width => 32, sel_width => 2)
    port map    (s_reg_write_data_bus, s_MemSel, s_RegWrData);

end structure;

