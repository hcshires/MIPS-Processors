onerror {resume}
quietly set dataset_list [list vsim1 vsim]
if {[catch {datasetcheck $dataset_list}]} {abort}
quietly WaveActivateNextPane {} 0
add wave -noupdate vsim:/tb/MyMips/iCLK
add wave -noupdate -radix binary vsim:/tb/MyMips/proc_alu/i_ALUCtrl
add wave -noupdate vsim:/tb/MyMips/proc_alu/i_Data_0
add wave -noupdate vsim:/tb/MyMips/proc_alu/i_Data_1
add wave -noupdate vsim:/tb/MyMips/proc_alu/o_Overflow
add wave -noupdate vsim:/tb/MyMips/proc_alu/s_sum
add wave -noupdate vsim:/tb/MyMips/proc_alu/i_ALUCtrl
add wave -noupdate -divider {New Divider}
add wave -noupdate vsim:/tb/MyMips/s_ID_dsrc1
add wave -noupdate vsim:/tb/MyMips/s_ID_dsrc2
add wave -noupdate vsim:/tb/MyMips/reg_file/i_src1
add wave -noupdate vsim:/tb/MyMips/reg_file/i_src2
add wave -noupdate vsim:/tb/MyMips/reg_file/i_wdata
add wave -noupdate vsim:/tb/MyMips/reg_file/i_RegWrite
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1811 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 273
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
WaveRestoreZoom {1645 ns} {2111 ns}
