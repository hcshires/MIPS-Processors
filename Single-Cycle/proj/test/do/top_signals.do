onerror {resume}
quietly set dataset_list [list vsim vsim]
if {[catch {datasetcheck $dataset_list}]} {abort}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {Top Level Control}
add wave -noupdate vsim:/tb/MyMips/iCLK
add wave -noupdate vsim:/tb/MyMips/iRST
add wave -noupdate -divider {PC/Inst Mem}
add wave -noupdate -label /tb/MyMips/PC/IncrInstAddr vsim:/tb/MyMips/PC/i_Data
add wave -noupdate -label tb/MyMips/CurrInstAddr vsim:/tb/MyMips/s_NextInstAddr
add wave -noupdate vsim:/tb/MyMips/s_Inst
add wave -noupdate -divider {Regfile Muxes/Regfile}
add wave -noupdate vsim:/tb/MyMips/reg_file/i_src1
add wave -noupdate vsim:/tb/MyMips/reg_file/i_src2
add wave -noupdate vsim:/tb/MyMips/s_RegWrAddr
add wave -noupdate vsim:/tb/MyMips/reg_file/i_RegWrite
add wave -noupdate vsim:/tb/MyMips/reg_dest_mux/i_sel
add wave -noupdate vsim:/tb/MyMips/reg_dest_mux/i_reg_bus
add wave -noupdate vsim:/tb/MyMips/s_dsrc1
add wave -noupdate vsim:/tb/MyMips/s_dsrc2
add wave -noupdate -label /tb/MyMips/mux2t1_alusrc2/imm_or_dsrc2_out vsim:/tb/MyMips/mux2t1_alusrc2/o_O
add wave -noupdate vsim:/tb/MyMips/s_RegWrData
add wave -noupdate -divider ALU
add wave -noupdate vsim:/tb/MyMips/proc_alu/i_ALUCtrl
add wave -noupdate vsim:/tb/MyMips/s_dsrc1
add wave -noupdate vsim:/tb/MyMips/s_alud1
add wave -noupdate vsim:/tb/MyMips/proc_alu/i_shamt
add wave -noupdate vsim:/tb/MyMips/proc_alu/o_Zero
add wave -noupdate vsim:/tb/MyMips/proc_alu/o_Overflow
add wave -noupdate vsim:/tb/MyMips/proc_alu/o_ALUOut
add wave -noupdate -divider DMem
add wave -noupdate vsim:/tb/MyMips/DMem/addr
add wave -noupdate vsim:/tb/MyMips/DMem/data
add wave -noupdate vsim:/tb/MyMips/DMem/we
add wave -noupdate -divider {DMem to Reg Mux}
add wave -noupdate vsim:/tb/MyMips/alu_dmem_mux/i_reg_bus
add wave -noupdate vsim:/tb/MyMips/alu_dmem_mux/i_sel
add wave -noupdate vsim:/tb/MyMips/s_RegWrData
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {110 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 298
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
WaveRestoreZoom {0 ns} {228 ns}
