# Simulation
vsim work.tb_alu_control -voptargs=+acc

# Add data inputs that are specific to this design. 
add wave -noupdate -divider {Data Inputs}
add wave -position insertpoint  \
sim:/tb_alu_control/s_iFunct \
sim:/tb_alu_control/s_iALUOp

# Add data outputs that are specific to this design.
add wave -noupdate -divider {Data Outputs}
add wave -position insertpoint  \
sim:/tb_alu_control/s_oALUSel

# Run
run 150
