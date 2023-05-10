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
end MIPS_Processor;

-- The Manschula-Shires 5-stage pipelined MIPS Processor
architecture structure of MIPS_Processor is
  --############################################
  --!!!!DUWE REQUIRED TEST FRAMEWORK SIGNALS!!!!
  --############################################
  -- Required data memory signals
  signal s_DMemAddr     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory address input
  signal s_DMemData     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input
  -- Required instruction memory signals
  signal s_IMemAddr     : std_logic_vector(N-1 downto 0); -- Do not assign this signal, assign to s_NextInstAddr instead
  signal s_NextInstAddr : std_logic_vector(N-1 downto 0); -- TODO: use this signal as your intended final instruction memory address input.
  --####END DUWE REQUIRED TEST FRAMEWORK SIGNALS#### 


  --########## FETCH STAGE SIGNALS ##########
    signal s_IF_PCSrcSel      : std_logic;
    signal s_IF_PC_pause      : std_logic;
    signal s_IF_final_pc      : std_logic_vector(N-1 downto 0);
    --Signal that carries either the current PC (when stalling) or the PC+4 to the pipe register and final PC mux (when not stalling)
    signal s_IF_pc_stall_val  : std_logic_vector(N-1 downto 0);
    signal s_IF_PCP4          : std_logic_vector(N-1 downto 0);
    signal s_Inst         : std_logic_vector(N-1 downto 0); -- [x]: use this signal as the instruction signal 
  --########## END FETCH STAGE SIGNALS ##########
  
    signal s_IFID_squash       : std_logic;

  --########## DECODE STAGE SIGNALS ##########
    -- Signal for final new PC address post-control-flow logic
    signal s_ID_Inst          : std_logic_vector(N-1 downto 0);
    signal s_ID_PCP4          : std_logic_vector(N-1 downto 0);
    signal s_ID_sign_ext_en   : std_logic;
    signal s_ID_CntrlRegWrite : std_logic;
    signal s_ID_CntrlRegWrite_final : std_logic;
    signal s_ID_RegDst        : std_logic_vector(1 downto 0);
    signal s_ID_RegDst_final  : std_logic_vector(1 downto 0);
    signal s_ID_jump          : std_logic_vector(1 downto 0);
    signal s_ID_jump_final    : std_logic_vector(1 downto 0);
    signal s_ID_MemSel        : std_logic_vector(1 downto 0);
    signal s_ID_BranchCtl     : std_logic;
    --Controls the mux for immediate/reg dsrc2 to ALU
    signal s_ID_ALUSrc        : std_logic;
    signal s_ID_ALUOp         : std_logic_vector(2 downto 0);
    signal s_ID_DMemWr        : std_logic; 
    signal s_ID_DMemWr_final  : std_logic;
    signal s_id_do_branch_final: std_logic;
    --Tell the ALU what type of branching to use
    signal s_ID_BranchType    : std_logic_vector(2 downto 0);
    -- Required halt signal -- for simulation
    signal s_ID_Halt          : std_logic;
    --Input bus for relevant destination registers, 3 buses of 5 bits each (either rt, rd, or hardcoded 31 for jal)
    signal s_ID_dest_input_bus : bus_array(3 downto 0)(4 downto 0);
    --Sign-extended immediate output from the sign extender, used for branch address calc
    signal s_ID_sign_ext_imm  : std_logic_vector(N-1 downto 0);
    --Signal for 2-bit left shifted branch label address
    signal s_ID_branch_label  : std_logic_vector(N-1 downto 0);
    --Signal for 2-bit left shifted jump address from inst(25:0)
    signal s_ID_j_addr        : std_logic_vector(N-1 downto 0);
    --Signals for outputs of register file
    signal s_ID_dsrc1, s_ID_dsrc2        : std_logic_vector(N-1 downto 0);
    --Signal that carries the final calculated write register address out of the decode stage
    signal s_ID_reg_rd        : std_logic_vector(4 downto 0);
    signal s_ID_new_pc        : std_logic_vector(N-1 downto 0);
    signal s_ID_do_branch     : std_logic;
    -- Required register file signals (couple others scattered throughout)
    signal s_RegWr        : std_logic; -- [x]: use this signal as the final active high write enable input to the register file (DO NOT RENAME)
    signal s_ID_branch_mod_out: std_logic;
    signal s_ID_branch_addr   : std_logic_vector(N-1 downto 0);
    signal s_ID_pcp4_branch_out: std_logic_vector(N-1 downto 0);
    signal s_ID_final_pc_mux_bus: bus_array(3 downto 0)(N-1 downto 0);
  --########## END DECODE STAGE SIGNALS ##########
    
    signal s_IDEX_stall       : std_logic;
    signal s_IDEX_squash      : std_logic;

  --########## EXECUTE STAGE SIGNALS ##########
    --ALUSel: output of ALU control module (not central control)
    signal s_EX_ALUSel       : std_logic_vector(4 downto 0);
    --Signal to carry the output of the immediate/reg dsrc2 mux to the second alu input
    signal s_EX_alud1        :std_logic_vector(N-1 downto 0);
    --Signal for output of the ALU
    signal s_EX_alu_out      : std_logic_vector(N-1 downto 0);

    --Generate a value for LUI instruction
    signal s_EX_lui_val      : std_logic_vector(N-1 downto 0);
    
    signal s_EX_PCP4        : std_logic_vector(N-1 downto 0);
    signal s_EX_new_pc      : std_logic_vector(N-1 downto 0);
    signal s_EX_do_branch   : std_logic;
    signal s_EX_branchCtl   : std_logic;
    signal s_EX_CntrlRegWr  : std_logic;
    signal s_EX_RegDst      : std_logic_vector(1 downto 0);
    signal s_EX_jump        : std_logic_vector(1 downto 0);
    signal s_EX_memSel      : std_logic_vector(1 downto 0);
    signal s_EX_ALUSrc      : std_logic;
    signal s_EX_ALUOp       : std_logic_vector(2 downto 0);
    signal s_EX_DMemWr      : std_logic;
    signal s_EX_Halt        : std_logic;
    signal s_EX_Ovfl        : std_logic;
    
    signal s_EX_dsrc1, s_EX_dsrc2 : std_logic_vector(N-1 downto 0);
    signal s_EX_sign_ext_imm: std_logic_vector(N-1 downto 0);
    signal s_EX_Inst_funct  : std_logic_vector(5 downto 0);
    signal s_EX_Inst_lui    : std_logic_vector(15 downto 0);
    signal s_EX_Inst_shamt  : std_logic_vector(4 downto 0);
    signal s_EX_Inst_rd     : std_logic_vector(4 downto 0);
    signal s_EX_Inst_rs     : std_logic_vector(4 downto 0);
    signal s_EX_Inst_rt     : std_logic_vector(4 downto 0);
  --########## END EXECUTE STAGE SIGNALS ##########

    signal s_EXMEM_squash    : std_logic;

  --########## MEMORY STAGE SIGNALS ##########
    signal s_MEM_PCP4         : std_logic_vector(N-1 downto 0);
    signal s_MEM_new_pc       : std_logic_vector(N-1 downto 0);
    signal s_MEM_do_branch    : std_logic;
    signal s_MEM_memSel       : std_logic_vector(1 downto 0);
    signal s_MEM_CntrlRegWr   : std_logic;
    signal s_MEM_RegDst       : std_logic_vector(1 downto 0);
    signal s_DMemWr           : std_logic;    --[x]: use this signal as the final active high data memory write enable signal
    signal s_MEM_jump         : std_logic_vector(1 downto 0);
    signal s_MEM_branchCtl    : std_logic;
    signal s_MEM_dsrc2        : std_logic_vector(N-1 downto 0);
    signal s_MEM_Halt         : std_logic;
    signal s_MEM_Ovfl         : std_logic;
    signal s_MEM_ALUOut       : std_logic_vector(N-1 downto 0);
    signal s_DMemOut          : std_logic_vector(N-1 downto 0); -- [x]: use this signal as the data memory output
    signal s_MEM_lui_val      : std_logic_vector(N-1 downto 0);
    signal s_MEM_Inst_rd      : std_logic_vector(4 downto 0);
    signal s_MEM_Inst_rs      : std_logic_vector(4 downto 0);
    signal s_MEM_Inst_rt      : std_logic_vector(4 downto 0);
  --########## END MEMORY STAGE SIGNALS ##########
  
    signal s_MEMWB_stall      : std_logic;

  --########## WRITEBACK STAGE SIGNALS ##########
    signal s_WB_PCP4        : std_logic_vector(N-1 downto 0);
    signal s_WB_new_pc      : std_logic_vector(N-1 downto 0);
    signal s_WB_do_branch   : std_logic;
    signal s_WB_memSel      : std_logic_vector(1 downto 0);
    signal s_WB_CntrlRegWr  : std_logic;
    signal s_WB_RegDst      : std_logic_vector(1 downto 0);
    signal s_WB_jump        : std_logic_vector(1 downto 0);
    signal s_WB_branchCtl   : std_logic;
    signal s_Halt           : std_logic;  -- [x]: this signal indicates to the simulation that intended program execution has completed. (Opcode: 01 0100)
    signal s_Ovfl           : std_logic;  -- [x]: this signal indicates an overflow exception would have been initiated
    signal s_WB_DMemOut     : std_logic_vector(N-1 downto 0);
    signal s_WB_ALUOut      : std_logic_vector(N-1 downto 0);
    signal s_WB_lui_val     : std_logic_vector(N-1 downto 0);
    signal s_WB_Inst_rs     : std_logic_vector(4 downto 0);
    signal s_WB_Inst_rt     : std_logic_vector(4 downto 0);
    signal s_RegWrAddr      : std_logic_vector(4 downto 0); --[x]: use this signal as the final destination register address input
    signal s_RegWrData      : std_logic_vector(N-1 downto 0); --[x]: use this signal as the final data memory data input
    signal s_WB_reg_write_data_bus : bus_array(3 downto 0)(N-1 downto 0);
  --########## END WRITEBACK STAGE SIGNALS ##########

  --Signal that should never be written to
  signal s_dummy        : std_logic_vector(N-1 downto 0);

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

  component pc_source_module is
    port (
      i_do_branch : in std_logic;
      i_jump      : in std_logic_vector(1 downto 0);
      o_PCSrcSel  : out std_logic
    );
  end component;

  component if_id_reg is
    port (
      i_CLK   : in std_logic;
      i_RST   : in std_logic;
      i_WEn   : in std_logic;
      i_PCP4  : in std_logic_vector(31 downto 0);
      i_Inst  : in std_logic_vector(31 downto 0);
      o_PCP4  : out std_logic_vector(31 downto 0);
      o_Inst  : out std_logic_vector(31 downto 0)
    );
  end component;

  component id_ex_reg is
    port (
      i_CLK           : in std_logic;
      i_RST           : in std_logic;
      i_PCP4          : in std_logic_vector(31 downto 0);
      i_new_pc        : in std_logic_vector(31 downto 0);
      i_do_branch     : in std_logic;
      i_branchCtl     : in std_logic;
      i_CntrlRegWrite : in std_logic;
      i_RegDst        : in std_logic_vector(1 downto 0);
      i_jump          : in std_logic_vector(1 downto 0);
      i_memSel        : in std_logic_vector(1 downto 0);
      i_ALUSrc        : in std_logic;
      i_ALUOp         : in std_logic_vector(2 downto 0);
      i_DMemWr        : in std_logic;
      i_Halt          : in std_logic;
      i_dsrc1         : in std_logic_vector(31 downto 0);
      i_dsrc2         : in std_logic_vector(31 downto 0);
      i_sign_ext_imm  : in std_logic_vector(31 downto 0);
      --TODO rename to have a more accurate name, like i_final_reg_addr
      i_Inst_rd       : in std_logic_vector(4 downto 0);
      i_Inst_rs       : in std_logic_vector(4 downto 0);
      i_Inst_rt       : in std_logic_vector(4 downto 0);
      i_Inst_funct    : in std_logic_vector(5 downto 0);
      i_Inst_lui      : in std_logic_vector(15 downto 0);
      i_Inst_shamt    : in std_logic_vector(4 downto 0);
      o_PCP4          : out std_logic_vector(31 downto 0);
      o_new_pc        : out std_logic_vector(31 downto 0);
      o_do_branch     : out std_logic;
      o_branchCtl     : out std_logic;
      o_CntrlRegWrite : out std_logic;
      o_RegDst        : out std_logic_vector(1 downto 0);
      o_jump          : out std_logic_vector(1 downto 0);
      o_memSel        : out std_logic_vector(1 downto 0);
      o_ALUSrc        : out std_logic;
      o_ALUOp         : out std_logic_vector(2 downto 0);
      o_DMemWr        : out std_logic;
      o_Halt          : out std_logic;
      o_dsrc1         : out std_logic_vector(31 downto 0);
      o_dsrc2         : out std_logic_vector(31 downto 0);
      o_sign_ext_imm  : out std_logic_vector(31 downto 0);
      o_Inst_rd       : out std_logic_vector(4 downto 0);
      o_Inst_rs       : out std_logic_vector(4 downto 0);
      o_Inst_rt       : out std_logic_vector(4 downto 0);
      o_Inst_funct    : out std_logic_vector(5 downto 0);
      o_Inst_lui      : out std_logic_vector(15 downto 0);
      o_Inst_shamt    : out std_logic_vector(4 downto 0)
    );
  end component;

  component ex_mem_reg is 
    port (
      i_CLK           : in std_logic;
      i_RST           : in std_logic;
      i_PCP4          : in std_logic_vector(31 downto 0);
      i_new_pc        : in std_logic_vector(31 downto 0);
      i_do_branch     : in std_logic;
      i_memSel        : in std_logic_vector(1 downto 0);
      i_CntrlRegWrite : in std_logic;
      i_RegDst        : in std_logic_vector(1 downto 0);
      i_DMemWr        : in std_logic;
      i_jump          : in std_logic_vector(1 downto 0);
      i_branchCtl     : in std_logic;
      i_dsrc2         : in std_logic_vector(31 downto 0);
      i_Halt          : in std_logic;
      i_Ovfl          : in std_logic;
      i_ALUOut        : in std_logic_vector(31 downto 0);
      i_lui_val       : in std_logic_vector(31 downto 0);
      i_Inst_rd       : in std_logic_vector(4 downto 0);
      i_Inst_rs       : in std_logic_vector(4 downto 0);
      i_Inst_rt       : in std_logic_vector(4 downto 0);
      o_PCP4          : out std_logic_vector(31 downto 0);
      o_new_pc        : out std_logic_vector(31 downto 0);
      o_do_branch     : out std_logic;
      o_memSel        : out std_logic_vector(1 downto 0);
      o_CntrlRegWrite : out std_logic;
      o_RegDst        : out std_logic_vector(1 downto 0);
      o_DMemWr        : out std_logic;
      o_jump          : out std_logic_vector(1 downto 0);
      o_branchCtl     : out std_logic;
      o_dsrc2         : out std_logic_vector(31 downto 0);
      o_Halt          : out std_logic;
      o_Ovfl          : out std_logic;
      o_ALUOut        : out std_logic_vector(31 downto 0);
      o_Inst_lui      : out std_logic_vector(31 downto 0);
      o_Inst_rd       : out std_logic_vector(4 downto 0);
      o_Inst_rs       : out std_logic_vector(4 downto 0);
      o_Inst_rt       : out std_logic_vector(4 downto 0)
    );
  end component;

  component mem_wb_reg is
    port (
      i_CLK           : in std_logic;
      i_RST           : in std_logic;
      i_PCP4          : in std_logic_vector(31 downto 0);
      i_new_pc        : in std_logic_vector(31 downto 0);
      i_do_branch     : in std_logic;
      i_memSel        : in std_logic_vector(1 downto 0);
      i_CntrlRegWrite : in std_logic;
      i_RegDst        : in std_logic_vector(1 downto 0);
      i_jump          : in std_logic_vector(1 downto 0);
      i_branchCtl     : in std_logic;
      i_Halt          : in std_logic;
      i_Ovfl          : in std_logic;
      i_DMemOut       : in std_logic_vector(31 downto 0);
      i_ALUOut        : in std_logic_vector(31 downto 0);
      i_lui_val       : in std_logic_vector(31 downto 0);
      i_Inst_rd       : in std_logic_vector(4 downto 0);
      i_Inst_rs       : in std_logic_vector(4 downto 0);
      i_Inst_rt       : in std_logic_vector(4 downto 0);
      o_PCP4          : out std_logic_vector(31 downto 0);
      o_new_pc        : out std_logic_vector(31 downto 0);
      o_do_branch     : out std_logic;
      o_memSel        : out std_logic_vector(1 downto 0);
      o_CntrlRegWrite : out std_logic;
      o_RegDst        : out std_logic_vector(1 downto 0);
      o_jump          : out std_logic_vector(1 downto 0);
      o_branchCtl     : out std_logic;
      o_Halt          : out std_logic;
      o_Ovfl          : out std_logic;
      o_DMemOut       : out std_logic_vector(31 downto 0);
      o_ALUOut        : out std_logic_vector(31 downto 0);
      o_lui_val       : out std_logic_vector(31 downto 0);
      o_Inst_rd       : out std_logic_vector(4 downto 0);
      o_Inst_rs       : out std_logic_vector(4 downto 0);
      o_Inst_rt       : out std_logic_vector(4 downto 0)
    );
  end component;

  component hazard_detection_unit is
    port (
      i_ID_rs             : in std_logic_vector(4 downto 0);
      i_ID_rt             : in std_logic_vector(4 downto 0);
      i_ID_write_reg      : in std_logic_vector(4 downto 0);
      i_IDEX_rd           : in std_logic_vector(4 downto 0);
      i_EXMEM_rd          : in std_logic_vector(4 downto 0);
      i_IDEX_RegWr        : in std_logic;
      i_EXMEM_RegWr       : in std_logic;
      i_MEMWB_branch_taken: in std_logic;
      o_IDEX_data_stall   : out std_logic;
      o_IFID_squash       : out std_logic;
      o_IDEX_squash       : out std_logic;
      o_EXMEM_squash      : out std_logic;
      o_PC_pause          : out std_logic
    );
  end component;

begin
  --Assign value to dummy signal so that design optimization doesn't remove it
  s_dummy <= x"FEEDFACE";

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
      
  --######################## FETCH STAGE ########################
  pc_src_ctrl : pc_source_module
    port map (s_WB_do_branch, s_WB_jump, s_IF_PCSrcSel);

  pc_src_mux : mux2t1_N
    port map (s_IF_PCSrcSel, s_IF_PC_stall_val, s_WB_new_pc, s_IF_final_pc);

  --PC holds address of instruction to execute
  --PC pause is inverted because we normally want to write the PC when not stalling (thus the raw value is 0)
  PC : mips_pc 
      port map (iCLK, iRST, '1', s_IF_final_pc, s_NextInstAddr);

  --Adds 4 to the current value of PC
  PC_plus_4_adder : ripple_adder 
      port map (s_NextInstAddr, std_logic_vector(to_unsigned(4, N)), '0', s_IF_PCP4, open);

  PC_pause_mux : mux2t1_N
    generic map (32)
      --NextInstAddr is actually the current instruction address
    port map (s_IF_PC_pause, s_IF_PCP4, s_NextInstAddr, s_IF_PC_stall_val);

  IMem: mem
    generic map(ADDR_WIDTH => ADDR_WIDTH,
                DATA_WIDTH => N)
    port map(
              clk  => iCLK,
              addr => s_IMemAddr(11 downto 2),
              data => iInstExt,
              we   => iInstLd,
              q    => s_Inst
            );
  --######################## END FETCH STAGE ########################

  --IF/ID Pipeline Register
  IF_ID_pipe_reg: if_id_reg 
    port map (iCLK, iRST or s_IFID_squash, not s_IF_PC_pause, s_IF_PC_stall_val, s_Inst, s_ID_PCP4, s_ID_Inst);

  --######################## DECODE STAGE ########################
  --Map two instruction data lines and hardcoded 31 into a bus so the mux can mux it into the write data select port on regfile
  s_ID_dest_input_bus <= (0 => s_ID_Inst(20 downto 16), 1 => s_ID_Inst(15 downto 11), 2 => std_logic_vector(to_unsigned(31, 5)), 3 => s_dummy(4 downto 0));
  --Need mux to do destination register input
  reg_dest_mux : mux_Nt1 
    generic map (bus_width => 5, sel_width => 2)
    port map (s_ID_dest_input_bus, s_ID_RegDst, s_ID_reg_rd);

  reg_write_mux : mux2t1
    port map (s_WB_RegDst(1), s_WB_CntrlRegWr, s_WB_do_branch OR s_WB_CntrlRegWr, s_RegWr);

  --Register file is register file ¯\_(ツ)_/¯
  reg_file : regfile port map (s_ID_Inst(25 downto 21), s_ID_Inst(20 downto 16), s_RegWrAddr, s_RegWrData, s_RegWr, iCLK, iRST, s_ID_dsrc1, s_ID_dsrc2);

  --Sign-extend 15-bit immediate from instruction
  sign_extend_32 : sign_extender_32
    port map (s_ID_Inst(15 downto 0), s_ID_sign_ext_en, s_ID_sign_ext_imm);

  --Shift left 2 on the jump address
  sl2_jaddr : shift_left_2 
    generic map (in_width => 26, resize => '1')
    port map    (s_ID_Inst(25 downto 0), s_ID_j_addr(27 downto 0), open);
  --Upper 4 bits of jump address come from pc+4
  s_ID_j_addr(31 downto 28) <= s_ID_PCP4(31 downto 28);

  --Another shift left 2 module to handle branch address from branch instructions
  sl2_branch : shift_left_2
    generic map (in_width => 32, resize => '0')
    port map    (s_ID_sign_ext_imm, open, s_ID_branch_label);

  central_control : control_unit
    port map (s_ID_Inst(31 downto 26), s_ID_Inst(5 downto 0), s_ID_Inst(20 downto 16), s_ID_CntrlRegWrite, s_ID_RegDst, s_ID_sign_ext_en, s_ID_jump, s_ID_MemSel, s_ID_BranchCtl, s_ID_BranchType, s_ID_ALUSrc, s_ID_ALUOp, s_ID_DMemWr, s_ID_Halt);

  branch_control : branch_control_module
    port map (s_ID_dsrc1, s_ID_dsrc2, s_ID_BranchType, s_ID_branch_mod_out);

  --This adder computes the branch address
  branch_adder : ripple_adder
    port map (s_ID_PCP4, s_ID_branch_label, '0', s_ID_branch_addr, open);

  branch_and : andg2
    port map (s_ID_branchCtl, s_ID_branch_mod_out, s_ID_do_branch);

  --This mux switches the PC + 4 line and the branch address line according to the do_branch signal
  branch_mux : mux2t1_N 
    port map (s_ID_do_branch, s_ID_PCP4, s_ID_branch_addr, s_ID_pcp4_branch_out);

  --Map three data lines (PC + 4, jump address, register data out line 1 for jr) into bus so mux can send back to PC
  s_ID_final_pc_mux_bus <= (0 => s_ID_pcp4_branch_out, 1 => s_ID_j_addr, 2 => s_ID_dsrc1, 3 => s_dummy);
  j_jr_b_mux : mux_Nt1
    generic map (bus_width => 32, sel_width => 2)
    port map    (s_ID_final_pc_mux_bus, s_ID_jump, s_ID_new_pc);

  hazard_detection : hazard_detection_unit
    port map (s_ID_Inst(25 downto 21), s_ID_Inst(20 downto 16), s_ID_reg_rd, s_EX_Inst_rd, s_MEM_Inst_rd, s_EX_CntrlRegWr, s_MEM_CntrlRegWr, s_IF_PCSrcSel, s_IDEX_stall, s_IFID_squash, s_IDEX_squash, s_EXMEM_squash, s_IF_PC_pause);

  RegWr_stall_mux : mux2t1
    port map (s_IDEX_stall, s_ID_CntrlRegWrite, '0', s_ID_CntrlRegWrite_final);

  RegDst_stall_mux : mux2t1_N
    generic map (2)
    port map (s_IDEX_stall, s_ID_RegDst, b"00", s_ID_RegDst_final);

  DMemWr_stall_mux : mux2t1
    port map (s_IDEX_stall, s_ID_DMemWr, '0', s_ID_DMemWr_final);

  do_Branch_stall_mux : mux2t1
      port map (s_IDEX_stall, s_ID_do_branch, '0', s_ID_do_branch_final);

  jump_stall_mux : mux2t1_N
    generic map (2)
    port map (s_IDEX_stall, s_ID_jump, b"00", s_ID_jump_final);
  --######################## END DECODE STAGE ########################
  
  ID_EX_pipe_reg: id_ex_reg
    port map (iCLK, iRST or s_IDEX_squash, s_ID_PCP4, s_ID_new_pc, s_ID_do_branch_final, s_ID_branchCtl, s_ID_CntrlRegWrite_final, s_ID_RegDst_final, s_ID_jump_final, s_ID_MemSel, s_ID_ALUSrc, s_ID_ALUOp, s_ID_DMemWr_final, s_ID_Halt, s_ID_dsrc1, s_ID_dsrc2, s_ID_sign_ext_imm, s_ID_reg_rd, s_ID_Inst(25 downto 21), s_ID_Inst(20 downto 16), s_ID_Inst(5 downto 0), s_ID_Inst(15 downto 0), s_ID_Inst(10 downto 6), 
              s_EX_PCP4, s_EX_new_pc, s_EX_do_branch, s_EX_branchCtl, s_EX_CntrlRegWr, s_EX_RegDst, s_EX_jump, s_EX_memSel, s_EX_ALUSrc, s_EX_ALUOp, s_EX_DMemWr, s_EX_Halt, s_EX_dsrc1, s_EX_dsrc2, s_EX_sign_ext_imm, s_EX_Inst_rd, s_EX_Inst_rs, s_EX_Inst_rt, s_EX_Inst_funct, s_EX_Inst_lui, s_EX_Inst_shamt);

  --######################## EXECUTE STAGE ########################
  mux2t1_alusrc2 : mux2t1_N
    generic map (32)
    port map (s_EX_ALUSrc, s_EX_dsrc2, s_EX_sign_ext_imm, s_EX_alud1);

  --Control the operation performed by the ALU based off of function type and ALUOp from central control
  alu_control : alu_control_logic
    port map (s_EX_Inst_funct, s_EX_ALUOp, s_EX_ALUSel);

  proc_alu : ALU
    generic map (32)
    port map (s_EX_ALUSel, s_EX_dsrc1, s_EX_alud1, s_EX_Inst_shamt, s_EX_alu_out, open, s_EX_Ovfl);
    --Done as per the Duwe MIPS processor port definition at top
    oALUOut <= s_EX_alu_out;

  s_EX_lui_val <= s_EX_Inst_lui & x"0000";
  --######################## END EXECUTE STAGE ########################

  EX_MEM_pipe_reg: ex_mem_reg
    port map (iCLK, iRST or s_EXMEM_squash, s_EX_PCP4, s_EX_new_pc, s_EX_do_branch, s_EX_memSel, s_EX_CntrlRegWr, s_EX_RegDst, s_EX_DMemWr, s_EX_jump, s_EX_branchCtl, s_EX_dsrc2, s_EX_Halt, s_EX_Ovfl, s_EX_alu_out, s_EX_lui_val, s_EX_Inst_rd, s_EX_Inst_rs, s_EX_Inst_rt, 
              s_MEM_PCP4, s_MEM_new_pc, s_MEM_do_branch, s_MEM_memSel, s_MEM_CntrlRegWr, s_MEM_RegDst, s_DMemWr, s_MEM_jump, s_MEM_branchCtl, s_MEM_dsrc2, s_MEM_Halt, s_MEM_Ovfl, s_MEM_ALUOut, s_MEM_lui_val, s_MEM_Inst_rd, s_MEM_Inst_rs, s_MEM_Inst_rt);

  --######################## MEMORY STAGE ########################
  --Assigning required signals
  s_DMemAddr <= s_MEM_ALUOut;
  s_DMemData <= s_MEM_dsrc2;
  DMem: mem
    generic map(ADDR_WIDTH => ADDR_WIDTH,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_DMemAddr(11 downto 2),
             data => s_DMemData,
             we   => s_DMemWr,
             q    => s_DMemOut);
  --######################## END MEMORY STAGE ########################       
  
  MEM_WB_pipe_reg: mem_wb_reg
    port map (iCLK, iRST, s_MEM_PCP4, s_MEM_new_pc, s_MEM_do_branch, s_MEM_memSel, s_MEM_CntrlRegWr, s_MEM_RegDst, s_MEM_jump, s_MEM_branchCtl, s_MEM_Halt, s_MEM_Ovfl, s_DMemOut, s_MEM_ALUOut, s_MEM_lui_val, s_MEM_Inst_rd, s_MEM_Inst_rs, s_MEM_Inst_rt,
              s_WB_PCP4, s_WB_new_pc, s_WB_do_branch, s_WB_memSel, s_WB_CntrlRegWr, s_WB_RegDst, s_WB_jump, s_WB_branchCtl, s_Halt, s_Ovfl, s_WB_DMemOut, s_WB_ALUOut, s_WB_lui_val, s_RegWrAddr, s_WB_Inst_rs, s_WB_Inst_rt);

  --######################## WRITEBACK STAGE ########################
  s_WB_reg_write_data_bus <= (0 => s_WB_ALUOut, 1 => s_WB_DMemOut, 2 => s_WB_PCP4, 3 => s_WB_lui_val);
  alu_dmem_mux: mux_Nt1
    generic map (bus_width => 32, sel_width => 2)
    port map    (s_WB_reg_write_data_bus, s_WB_MemSel, s_RegWrData);
  --######################## END WRITEBACK STAGE ########################
  

end structure;

