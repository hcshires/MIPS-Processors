onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /tb_pc_source_module/DUT_pcsrc/i_do_branch
add wave -noupdate -radix binary /tb_pc_source_module/DUT_pcsrc/i_jump
add wave -noupdate -radix binary /tb_pc_source_module/DUT_pcsrc/o_PCSrcSel
add wave -noupdate -radix binary /tb_pc_source_module/DUT_pcsrc/s_input_concat
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 253
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
WaveRestoreZoom {0 ns} {118 ns}
