onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/MyMips/ID_EX_pipe_reg/i_CLK
add wave -noupdate /tb/MyMips/ID_EX_pipe_reg/i_RST
add wave -noupdate -divider {New Divider}
add wave -noupdate /tb/MyMips/s_IF_final_pc
add wave -noupdate /tb/MyMips/s_NextInstAddr
add wave -noupdate /tb/MyMips/s_Inst
add wave -noupdate /tb/MyMips/IMem/addr
add wave -noupdate /tb/MyMips/IMem/q
add wave -noupdate /tb/MyMips/PC/i_WEn
add wave -noupdate -divider {New Divider}
add wave -noupdate /tb/MyMips/IF_ID_pipe_reg/o_Inst
add wave -noupdate /tb/MyMips/hazard_detection/i_ID_rs
add wave -noupdate /tb/MyMips/hazard_detection/i_ID_rt
add wave -noupdate /tb/MyMips/hazard_detection/i_ID_write_reg
add wave -noupdate /tb/MyMips/hazard_detection/i_IDEX_rd
add wave -noupdate /tb/MyMips/hazard_detection/i_EXMEM_rd
add wave -noupdate /tb/MyMips/hazard_detection/o_IDEX_stall
add wave -noupdate /tb/MyMips/hazard_detection/o_PC_pause
add wave -noupdate -divider {New Divider}
add wave -noupdate /tb/MyMips/RegWr_stall_mux/i_S
add wave -noupdate /tb/MyMips/RegWr_stall_mux/i_D1
add wave -noupdate /tb/MyMips/RegWr_stall_mux/i_D0
add wave -noupdate /tb/MyMips/RegDst_stall_mux/i_D0
add wave -noupdate /tb/MyMips/DMemWr_stall_mux/i_D0
add wave -noupdate /tb/MyMips/RegDst_stall_mux/o_O
add wave -noupdate /tb/MyMips/RegWr_stall_mux/o_O
add wave -noupdate /tb/MyMips/DMemWr_stall_mux/o_O
add wave -noupdate -divider {New Divider}
add wave -noupdate /tb/MyMips/ID_EX_pipe_reg/o_CntrlRegWrite
add wave -noupdate /tb/MyMips/ID_EX_pipe_reg/o_DMemWr
add wave -noupdate -radix binary /tb/MyMips/ID_EX_pipe_reg/o_RegDst
add wave -noupdate -divider {New Divider}
add wave -noupdate /tb/MyMips/EX_MEM_pipe_reg/o_CntrlRegWrite
add wave -noupdate /tb/MyMips/EX_MEM_pipe_reg/o_DMemWr
add wave -noupdate /tb/MyMips/EX_MEM_pipe_reg/o_RegDst
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {55 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 290
configure wave -valuecolwidth 91
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
WaveRestoreZoom {0 ns} {433 ns}
