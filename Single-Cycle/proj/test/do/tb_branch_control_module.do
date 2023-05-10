# Simulation
vsim work.tb_branch_control_module -voptargs=+acc

# Add data inputs that are specific to this design. 
add wave -noupdate -divider {Data Inputs}
add wave -position insertpoint  \
sim:/tb_branch_control_module/s_iDsrc1 \
sim:/tb_branch_control_module/s_iDsrc2 \
sim:/tb_branch_control_module/s_iBrType

# Add data outputs that are specific to this design.
add wave -noupdate -divider {Data Outputs}
add wave -position insertpoint  \
sim:/tb_branch_control_module/s_oBranch

# Run
run 70
