onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/MyMips/PC/i_Data
add wave -noupdate /tb/MyMips/PC/o_Data
add wave -noupdate /tb/MyMips/s_Inst
add wave -noupdate /tb/MyMips/s_MemSel
add wave -noupdate -expand /tb/MyMips/alu_dmem_mux/i_reg_bus
add wave -noupdate /tb/MyMips/alu_dmem_mux/i_sel
add wave -noupdate /tb/MyMips/alu_dmem_mux/o_reg
add wave -noupdate /tb/MyMips/reg_file/s_data_bus_array
add wave -noupdate -radix binary /tb/MyMips/central_control/i_funct
add wave -noupdate -radix binary /tb/MyMips/central_control/i_rt
add wave -noupdate /tb/MyMips/central_control/o_RegDst
add wave -noupdate /tb/MyMips/central_control/s_RegWrite
add wave -noupdate /tb/MyMips/reg_file/i_RegWrite
add wave -noupdate /tb/MyMips/reg_write_mux/i_S
add wave -noupdate /tb/MyMips/reg_write_mux/i_D0
add wave -noupdate /tb/MyMips/reg_write_mux/i_D1
add wave -noupdate /tb/MyMips/reg_write_mux/o_O
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {48 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 261
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ns} {233 ns}
