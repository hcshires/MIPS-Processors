# Simulation
vsim work.tb_alu -voptargs=+acc

# Add data inputs that are specific to this design. 
add wave -noupdate -divider {ALU Ctrl}
add wave -position insertpoint  \
sim:/tb_alu/s_iALUCtrl

add wave -noupdate -divider {ALU In}
add wave -position insertpoint  \
sim:/tb_alu/s_iData0 \
sim:/tb_alu/s_iData1 \
sim:/tb_alu/s_iShamt

add wave -noupdate -divider {ALU Out}
add wave -position insertpoint  \
sim:/tb_alu/s_oALUOut \
sim:/tb_alu/s_oCout \
sim:/tb_alu/s_oOverflow

# Run
run 300
