onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /tb_and_or_module/s_D0
add wave -noupdate -radix binary /tb_and_or_module/s_D1
add wave -noupdate -radix binary /tb_and_or_module/s_op
add wave -noupdate -radix binary /tb_and_or_module/s_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {17 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 176
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
WaveRestoreZoom {0 ns} {38 ns}
