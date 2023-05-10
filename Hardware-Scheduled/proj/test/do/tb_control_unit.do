# Simulation
vsim work.tb_control_unit -voptargs=+acc

# Add data inputs that are specific to this design. 
add wave -noupdate -divider {Data Inputs}
add wave -position insertpoint  \
sim:/tb_control_unit/s_iOpcode \
sim:/tb_control_unit/s_iFunct \
sim:/tb_control_unit/s_iRt

# Add data outputs that are specific to this design.
add wave -noupdate -divider {Data Outputs}
add wave -position insertpoint  \
sim:/tb_control_unit/s_oRegWr \
sim:/tb_control_unit/s_oRegDst \
sim:/tb_control_unit/s_oSignExtEn \
sim:/tb_control_unit/s_oJump \
sim:/tb_control_unit/s_oMemSel \
sim:/tb_control_unit/s_oBranchCtl \
sim:/tb_control_unit/s_oBranchType \
sim:/tb_control_unit/s_oALUSrc \
sim:/tb_control_unit/s_oALUOp \
sim:/tb_control_unit/s_oMemWr \
sim:/tb_control_unit/s_oHalt

# Run
run 200