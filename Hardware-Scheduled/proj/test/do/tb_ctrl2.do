onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {Data Inputs}
add wave -noupdate -radix binary /tb_control_unit/s_iOpcode
add wave -noupdate -divider {Data Outputs}
add wave -noupdate /tb_control_unit/s_oRegWr
add wave -noupdate -radix binary /tb_control_unit/s_oRegDst
add wave -noupdate /tb_control_unit/s_oSignExtEn
add wave -noupdate -radix binary /tb_control_unit/s_oJump
add wave -noupdate -radix binary /tb_control_unit/s_oMemSel
add wave -noupdate /tb_control_unit/s_oBranchCtl
add wave -noupdate /tb_control_unit/s_oALUSrc
add wave -noupdate -radix binary /tb_control_unit/s_oALUOp
add wave -noupdate /tb_control_unit/s_oMemWr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 256
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
WaveRestoreZoom {0 ns} {80 ns}
