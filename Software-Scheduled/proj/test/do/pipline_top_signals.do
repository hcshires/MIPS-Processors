onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/MyMips/iCLK
add wave -noupdate /tb/MyMips/PC/o_Data
add wave -noupdate /tb/MyMips/IMem/q
add wave -noupdate -divider ID
add wave -noupdate /tb/MyMips/reg_file/o_data_src1
add wave -noupdate /tb/MyMips/reg_file/o_data_src2
add wave -noupdate /tb/MyMips/ID_EX_pipe_reg/i_Inst_rd
add wave -noupdate /tb/MyMips/ID_EX_pipe_reg/i_Inst_rt
add wave -noupdate -divider EX
add wave -noupdate /tb/MyMips/mux2t1_alusrc2/i_S
add wave -noupdate /tb/MyMips/mux2t1_alusrc2/i_D0
add wave -noupdate /tb/MyMips/mux2t1_alusrc2/i_D1
add wave -noupdate /tb/MyMips/proc_alu/i_ALUCtrl
add wave -noupdate /tb/MyMips/proc_alu/i_Data_0
add wave -noupdate /tb/MyMips/mux2t1_alusrc2/o_O
add wave -noupdate /tb/MyMips/proc_alu/o_ALUOut
add wave -noupdate -divider MEM
add wave -noupdate /tb/MyMips/s_MEM_Inst_rt
add wave -noupdate /tb/MyMips/s_MEM_Inst_rd
add wave -noupdate -divider WB
add wave -noupdate -expand /tb/MyMips/alu_dmem_mux/i_reg_bus
add wave -noupdate /tb/MyMips/alu_dmem_mux/i_sel
add wave -noupdate /tb/MyMips/alu_dmem_mux/o_reg
add wave -noupdate /tb/MyMips/s_WB_Inst_rt
add wave -noupdate /tb/MyMips/s_WB_Inst_rd
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {68 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 258
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
WaveRestoreZoom {0 ns} {465 ns}
