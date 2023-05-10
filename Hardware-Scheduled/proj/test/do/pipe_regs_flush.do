onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_pipe_regs/s_iCLK
add wave -noupdate /tb_pipe_regs/s_flush_IFID
add wave -noupdate /tb_pipe_regs/s_flush_IDEX
add wave -noupdate /tb_pipe_regs/s_flush_EXMEM
add wave -noupdate /tb_pipe_regs/s_flush_MEMWB
add wave -noupdate /tb_pipe_regs/s_IF_PCP4
add wave -noupdate /tb_pipe_regs/s_ID_PCP4
add wave -noupdate /tb_pipe_regs/s_EX_PCP4
add wave -noupdate /tb_pipe_regs/s_MEM_PCP4
add wave -noupdate /tb_pipe_regs/s_WB_PCP4
add wave -noupdate /tb_pipe_regs/IFID_REG/i_RST
add wave -noupdate /tb_pipe_regs/IDEX_REG/i_RST
add wave -noupdate /tb_pipe_regs/IFID_REG/o_PCP4
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {12 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 344
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
WaveRestoreZoom {0 ns} {236 ns}
