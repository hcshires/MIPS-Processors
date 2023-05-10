onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/MyMips/iCLK
add wave -noupdate /tb/MyMips/iRST
add wave -noupdate /tb/MyMips/s_NextInstAddr
add wave -noupdate /tb/MyMips/s_IF_final_pc
add wave -noupdate -divider {New Divider}
add wave -noupdate /tb/MyMips/IF_ID_pipe_reg/o_PCP4
add wave -noupdate /tb/MyMips/s_ID_Inst
add wave -noupdate /tb/MyMips/hazard_detection/i_ID_rs
add wave -noupdate /tb/MyMips/hazard_detection/i_ID_rt
add wave -noupdate /tb/MyMips/hazard_detection/i_ID_write_reg
add wave -noupdate /tb/MyMips/hazard_detection/i_IDEX_rd
add wave -noupdate /tb/MyMips/hazard_detection/i_EXMEM_rd
add wave -noupdate /tb/MyMips/hazard_detection/i_IDEX_RegWr
add wave -noupdate /tb/MyMips/hazard_detection/i_EXMEM_RegWr
add wave -noupdate /tb/MyMips/s_ID_CntrlRegWrite
add wave -noupdate /tb/MyMips/hazard_detection/o_IDEX_data_stall
add wave -noupdate /tb/MyMips/hazard_detection/o_IFID_squash
add wave -noupdate /tb/MyMips/hazard_detection/o_IDEX_squash
add wave -noupdate /tb/MyMips/hazard_detection/o_EXMEM_squash
add wave -noupdate /tb/MyMips/hazard_detection/o_PC_pause
add wave -noupdate /tb/MyMips/s_IF_PC_pause
add wave -noupdate /tb/MyMips/hazard_detection/i_MEMWB_branch_taken
add wave -noupdate -divider {Branch/Jump Control}
add wave -noupdate /tb/MyMips/branch_control/i_dsrc1
add wave -noupdate /tb/MyMips/branch_control/i_dsrc2
add wave -noupdate /tb/MyMips/branch_control/i_BrType
add wave -noupdate /tb/MyMips/branch_control/o_Branch
add wave -noupdate -divider {IDEX Reg}
add wave -noupdate /tb/MyMips/ID_EX_pipe_reg/o_dsrc1
add wave -noupdate /tb/MyMips/ID_EX_pipe_reg/o_dsrc2
add wave -noupdate /tb/MyMips/ID_EX_pipe_reg/o_sign_ext_imm
add wave -noupdate /tb/MyMips/s_EX_alu_out
add wave -noupdate -divider {Reg Write}
add wave -noupdate /tb/MyMips/reg_file/i_dest
add wave -noupdate /tb/MyMips/reg_file/i_RegWrite
add wave -noupdate /tb/MyMips/reg_file/i_wdata
add wave -noupdate -divider Halt
add wave -noupdate /tb/MyMips/s_ID_Halt
add wave -noupdate /tb/MyMips/s_EX_Halt
add wave -noupdate /tb/MyMips/s_MEM_Halt
add wave -noupdate /tb/MyMips/s_Halt
add wave -noupdate /tb/MyMips/EX_MEM_pipe_reg/i_RST
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {251 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 358
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
WaveRestoreZoom {87 ns} {467 ns}
