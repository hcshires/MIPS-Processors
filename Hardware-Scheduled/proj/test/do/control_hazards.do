onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/MyMips/iCLK
add wave -noupdate /tb/MyMips/iRST
add wave -noupdate /tb/MyMips/s_IF_PCP4
add wave -noupdate /tb/MyMips/s_Inst
add wave -noupdate /tb/MyMips/hazard_detection/o_IFID_squash
add wave -noupdate /tb/MyMips/hazard_detection/o_IDEX_squash
add wave -noupdate /tb/MyMips/hazard_detection/o_EXMEM_squash
add wave -noupdate /tb/MyMips/s_EX_alu_out
add wave -noupdate /tb/MyMips/s_MEM_ALUOut
add wave -noupdate /tb/MyMips/s_RegWrData
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {120 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 210
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
WaveRestoreZoom {0 ns} {351 ns}
