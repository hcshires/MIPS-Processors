onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_mux_nt1_jank/s_sel
add wave -noupdate /tb_mux_nt1_jank/s_data1
add wave -noupdate /tb_mux_nt1_jank/s_data2
add wave -noupdate /tb_mux_nt1_jank/s_data3
add wave -noupdate /tb_mux_nt1_jank/s_data4
add wave -noupdate -divider {New Divider}
add wave -noupdate /tb_mux_nt1_jank/s_db0
add wave -noupdate /tb_mux_nt1_jank/s_db1
add wave -noupdate /tb_mux_nt1_jank/s_db_array
add wave -noupdate /tb_mux_nt1_jank/s_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 264
configure wave -valuecolwidth 171
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
WaveRestoreZoom {0 ns} {64 ns}
