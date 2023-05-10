onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/MyMips/iCLK
add wave -noupdate /tb/MyMips/iRST
add wave -noupdate /tb/MyMips/s_IMemAddr
add wave -noupdate /tb/MyMips/s_Inst
add wave -noupdate -divider Decode
add wave -noupdate /tb/MyMips/s_ID_Inst
add wave -noupdate /tb/MyMips/s_ID_new_pc
add wave -noupdate /tb/MyMips/reg_file/i_src1
add wave -noupdate /tb/MyMips/reg_file/i_src2
add wave -noupdate /tb/MyMips/reg_file/o_data_src1
add wave -noupdate /tb/MyMips/reg_file/o_data_src2
add wave -noupdate /tb/MyMips/s_ID_RegDst
add wave -noupdate /tb/MyMips/s_ID_Halt
add wave -noupdate /tb/MyMips/s_ID_jump
add wave -noupdate -divider Execute
add wave -noupdate /tb/MyMips/alu_control/i_ALUOp
add wave -noupdate /tb/MyMips/alu_control/i_funct
add wave -noupdate /tb/MyMips/alu_control/o_ALUSel
add wave -noupdate /tb/MyMips/proc_alu/i_Data_0
add wave -noupdate /tb/MyMips/proc_alu/i_Data_1
add wave -noupdate /tb/MyMips/proc_alu/o_ALUOut
add wave -noupdate -divider Mem
add wave -noupdate /tb/MyMips/DMem/addr
add wave -noupdate /tb/MyMips/DMem/we
add wave -noupdate /tb/MyMips/DMem/data
add wave -noupdate /tb/MyMips/DMem/q
add wave -noupdate -divider Writeback
add wave -noupdate -expand /tb/MyMips/alu_dmem_mux/i_reg_bus
add wave -noupdate /tb/MyMips/alu_dmem_mux/i_sel
add wave -noupdate /tb/MyMips/alu_dmem_mux/o_reg
add wave -noupdate /tb/MyMips/reg_file/i_RegWrite
add wave -noupdate /tb/MyMips/reg_file/i_wdata
add wave -noupdate /tb/MyMips/s_WB_Inst_rt
add wave -noupdate /tb/MyMips/s_WB_Inst_rd
add wave -noupdate /tb/MyMips/s_WB_RegDst
add wave -noupdate /tb/MyMips/reg_file/i_dest
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {296 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 242
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
WaveRestoreZoom {0 ns} {943 ns}
