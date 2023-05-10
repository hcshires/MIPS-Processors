onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/MyMips/iCLK
add wave -noupdate /tb/MyMips/s_Inst
add wave -noupdate /tb/MyMips/PC/i_Data
add wave -noupdate /tb/MyMips/PC/o_Data
add wave -noupdate /tb/MyMips/reg_file/s_data_bus_array
add wave -noupdate -divider {New Divider}
add wave -noupdate -expand /tb/MyMips/j_jr_b_mux/i_reg_bus
add wave -noupdate -radix binary /tb/MyMips/central_control/i_opcode
add wave -noupdate -radix binary /tb/MyMips/central_control/i_funct
add wave -noupdate /tb/MyMips/central_control/o_jump
add wave -noupdate /tb/MyMips/j_jr_b_mux/i_sel
add wave -noupdate /tb/MyMips/j_jr_b_mux/o_reg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {165 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 278
configure wave -valuecolwidth 106
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {235 ns}
