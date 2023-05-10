# Simulation
vsim work.tb_pipe_regs -voptargs=+acc

add wave -noupdate -divider {Clk and Reset}
add wave -position insertpoint \
sim:/tb_pipe_regs/s_iCLK \
sim:/tb_pipe_regs/s_iRST

add wave -noupdate -divider {Flush Signals}
add wave -position insertpoint \
sim:/tb_pipe_regs/s_flush_IFID \
sim:/tb_pipe_regs/s_flush_IDEX \
sim:/tb_pipe_regs/s_flush_EXMEM \
sim:/tb_pipe_regs/s_flush_MEMWB

add wave -noupdate -divider {IF Signals}
add wave -position insertpoint \
sim:/tb_pipe_regs/s_IF_PCP4 \
sim:/tb_pipe_regs/s_IF_Inst

add wave -noupdate -divider {ID Signals}
add wave -position insertpoint  \
sim:/tb_pipe_regs/s_ID_PCP4 \
sim:/tb_pipe_regs/s_ID_Inst \
sim:/tb_pipe_regs/s_ID_doBranch \
sim:/tb_pipe_regs/s_ID_CntrlRegWrite \
sim:/tb_pipe_regs/s_ID_RegDst \
sim:/tb_pipe_regs/s_ID_jump \
sim:/tb_pipe_regs/s_ID_memSel \
sim:/tb_pipe_regs/s_ID_ALUSrc \
sim:/tb_pipe_regs/s_ID_ALUOp \
sim:/tb_pipe_regs/s_ID_DMemWr \
sim:/tb_pipe_regs/s_ID_Halt \
sim:/tb_pipe_regs/s_ID_dsrc1 \
sim:/tb_pipe_regs/s_ID_dsrc2 \
sim:/tb_pipe_regs/s_ID_sign_ext_imm \
sim:/tb_pipe_regs/s_ID_Inst_rt \
sim:/tb_pipe_regs/s_ID_Inst_rd \
sim:/tb_pipe_regs/s_ID_Inst_funct \
sim:/tb_pipe_regs/s_ID_lui_val \
sim:/tb_pipe_regs/s_ID_Inst_shamt

add wave -noupdate -divider {EX Signals}
add wave -position insertpoint \
sim:/tb_pipe_regs/s_EX_PCP4 \
sim:/tb_pipe_regs/s_EX_Inst \
sim:/tb_pipe_regs/s_EX_doBranch \
sim:/tb_pipe_regs/s_EX_CntrlRegWrite \
sim:/tb_pipe_regs/s_EX_RegDst \
sim:/tb_pipe_regs/s_EX_jump \
sim:/tb_pipe_regs/s_EX_memSel \
sim:/tb_pipe_regs/s_EX_ALUSrc \
sim:/tb_pipe_regs/s_EX_ALUOp \
sim:/tb_pipe_regs/s_EX_DMemWr \
sim:/tb_pipe_regs/s_EX_dsrc1 \
sim:/tb_pipe_regs/s_EX_dsrc2 \
sim:/tb_pipe_regs/s_EX_sign_ext_imm \
sim:/tb_pipe_regs/s_EX_Inst_rt \
sim:/tb_pipe_regs/s_EX_Inst_rd \
sim:/tb_pipe_regs/s_EX_Inst_funct \
sim:/tb_pipe_regs/s_EX_lui_out \
sim:/tb_pipe_regs/s_EX_lui_val \
sim:/tb_pipe_regs/s_EX_Inst_shamt \
sim:/tb_pipe_regs/s_EX_ALUOut

add wave -noupdate -divider {MEM Signals}
add wave -position insertpoint \
sim:/tb_pipe_regs/s_MEM_PCP4 \
sim:/tb_pipe_regs/s_MEM_Inst \
sim:/tb_pipe_regs/s_MEM_doBranch \
sim:/tb_pipe_regs/s_MEM_CntrlRegWrite \
sim:/tb_pipe_regs/s_MEM_RegDst \
sim:/tb_pipe_regs/s_MEM_jump \
sim:/tb_pipe_regs/s_MEM_memSel \
sim:/tb_pipe_regs/s_MEM_DMemWr \
sim:/tb_pipe_regs/s_MEM_Halt \
sim:/tb_pipe_regs/s_MEM_dsrc2 \
sim:/tb_pipe_regs/s_MEM_Inst_rt \
sim:/tb_pipe_regs/s_MEM_Inst_rd \
sim:/tb_pipe_regs/s_MEM_lui_val \
sim:/tb_pipe_regs/s_MEM_ALUOut \
sim:/tb_pipe_regs/s_MEM_DMemOut

add wave -noupdate -divider {WB Signals}
add wave -position insertpoint \
sim:/tb_pipe_regs/s_WB_PCP4 \
sim:/tb_pipe_regs/s_WB_Inst \
sim:/tb_pipe_regs/s_WB_doBranch \
sim:/tb_pipe_regs/s_WB_CntrlRegWrite \
sim:/tb_pipe_regs/s_WB_RegDst \
sim:/tb_pipe_regs/s_WB_jump \
sim:/tb_pipe_regs/s_WB_memSel \
sim:/tb_pipe_regs/s_WB_Halt \
sim:/tb_pipe_regs/s_WB_Inst_lui \
sim:/tb_pipe_regs/s_WB_ALUOut \
sim:/tb_pipe_regs/s_WB_DMOut \
sim:/tb_pipe_regs/s_WB_Inst_rt \
sim:/tb_pipe_regs/s_WB_Inst_rd

# Run
run 500