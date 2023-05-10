onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_shift_left_2/DUT_SHIFT_RESIZE/i_data
add wave -noupdate /tb_shift_left_2/DUT_SHIFT_RESIZE/o_shft_data_resize
add wave -noupdate /tb_shift_left_2/DUT_SHIFT_RESIZE/s_shifted
add wave -noupdate -divider norsze
add wave -noupdate /tb_shift_left_2/DUT_SHIFT_NORSZE/i_data
add wave -noupdate /tb_shift_left_2/DUT_SHIFT_NORSZE/o_shft_data_norsze
add wave -noupdate /tb_shift_left_2/DUT_SHIFT_NORSZE/s_shifted_no_resize
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 369
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
WaveRestoreZoom {0 ns} {56 ns}
