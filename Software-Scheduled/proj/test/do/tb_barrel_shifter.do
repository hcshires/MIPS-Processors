# Simulation
vsim work.tb_barrel_shifter -voptargs=+acc

# Add data inputs that are specific to this design. 
add wave -noupdate -divider {Data Inputs}
add wave -position insertpoint  \
sim:/tb_barrel_shifter/s_iShamt \
sim:/tb_barrel_shifter/s_iShsrc \
sim:/tb_barrel_shifter/s_iShdir \
sim:/tb_barrel_shifter/s_iSharr

# Add intermediate signals
add wave -noupdate -divider {Signals}
add wave -position insertpoint  \
sim:/tb_barrel_shifter/DUT0/s_reverseIn

# Add data outputs that are specific to this design.
add wave -noupdate -divider {Data Outputs}
add wave -position insertpoint  \
sim:/tb_barrel_shifter/s_oVal

# Run
run 150
