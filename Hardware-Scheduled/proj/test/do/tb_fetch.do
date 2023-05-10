onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/MyMips/iCLK
add wave -noupdate /tb/MyMips/iRST
add wave -noupdate /tb/MyMips/s_Inst
add wave -noupdate -divider PC
add wave -noupdate /tb/MyMips/PC/i_Data
add wave -noupdate /tb/MyMips/PC/o_Data
add wave -noupdate -divider {PCP4 Adder}
add wave -noupdate /tb/MyMips/s_pc_plus_4
add wave -noupdate -divider {Jump Address}
add wave -noupdate /tb/MyMips/sl2_jaddr/i_data
add wave -noupdate /tb/MyMips/sl2_jaddr/o_shft_data_resize
add wave -noupdate /tb/MyMips/s_j_addr
add wave -noupdate -divider {Branch Address}
add wave -noupdate /tb/MyMips/sl2_branch/i_data
add wave -noupdate /tb/MyMips/sl2_branch/o_shft_data_norsze
add wave -noupdate /tb/MyMips/s_pc_plus_4
add wave -noupdate /tb/MyMips/branch_adder/o_Sum
add wave -noupdate -divider {Branch Control Module}
add wave -noupdate /tb/MyMips/branch_control/i_dsrc1
add wave -noupdate /tb/MyMips/branch_control/i_dsrc2
add wave -noupdate /tb/MyMips/branch_control/i_BrType
add wave -noupdate /tb/MyMips/branch_control/o_Branch
add wave -noupdate -divider {Branch Mux}
add wave -noupdate -label {/tb/MyMips/branch_mux/i_S (branch high)} /tb/MyMips/branch_mux/i_S
add wave -noupdate /tb/MyMips/branch_mux/i_D0
add wave -noupdate /tb/MyMips/branch_mux/i_D1
add wave -noupdate -divider {Final PC Mux}
add wave -noupdate -expand /tb/MyMips/j_jr_b_mux/i_reg_bus
add wave -noupdate /tb/MyMips/j_jr_b_mux/i_sel
add wave -noupdate /tb/MyMips/s_new_pc
add wave -noupdate -divider {Register Write Val Mux}
add wave -noupdate -expand /tb/MyMips/alu_dmem_mux/i_reg_bus
add wave -noupdate /tb/MyMips/alu_dmem_mux/i_sel
add wave -noupdate /tb/MyMips/alu_dmem_mux/o_reg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {429 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 281
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
WaveRestoreZoom {256 ns} {540 ns}
