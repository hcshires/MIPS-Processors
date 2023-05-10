#This test tests every instruction that the single-cycle processor is required to support
.data
  sample: .word 15

.text 
addi $8, $t1, 0x123
addiu $8, $8, 0x7FFFFFFF  #Shouldn't generate overflow
lui $9, 0x204
addu $9, $9, $8           #Also shouldn't generate overflow
and $10, $8, $9
andi $11, $9, 0x2F0       #Should still be 0x200

#load address of data
la $12, sample

lw $13, 0($12)            #Load "15" into $13
nor $13, $13, $8

lui $8, 0x0FFF
lui $9, 0x0FF0
xor $14, $8, $9
xori $15, $8, 0x0FF0      #Should have same result

or $16, $8, $9
ori $17, $8, 0x0FF0      #Expect same result

slt $18, $8, $9           #Should not be set
slti $18, $8, 0x1FFF      #Should be set
sll $8, $8, 3
srl $8, $8, 3
lui $8, 0x8FFF
sra $8, $8, 5             #Should shift in sign bit from left

sw $8, 4($12)             #Store the result of the arithmetic shift in the address after "sample"
sub $19, $8, $9
subu $20, $8, $8

lui $8, 0x0020
lui $9, 0x0020
beq	$8, $9, br_eq
addi $1, $1, 0x00002468   #!!!This should never be executed!!!

br_eq:
bne $8, $9, br_ne
addi $1, $1, 0x00001245   #!!!This should always be executed!!!

br_ne:
j next

addi $1, $1, 0x00002468   #!!!This should never be executed!!!
addi $1, $1, 0x0000ABCD   #!!!This should never be executed!!!

next:
jal jal_label             #We expect that $31 should be updated with the address of the next instruction
addi $1, $1, 0x00002468   #!!!This should never be executed!!!
addi $1, $1, 0x0000ABCD   #!!!This should never be executed!!!

jal_label:
addu $21, $0, $31         #Test that the $ra register updated correctly
bgez $0, b_gez
addi $1, $1, 0x00002468   #!!!This should never be executed!!!
addi $1, $1, 0x0000ABCD   #!!!This should never be executed!!!

b_gez:
bgtz $8, b_gtz
addi $1, $1, 0x00002468   #!!!This should never be executed!!!
addi $1, $1, 0x0000ABCD   #!!!This should never be executed!!!

b_gtz:
blez $0, b_lez
addi $1, $1, 0x00002468   #!!!This should never be executed!!!
addi $1, $1, 0x0000ABCD   #!!!This should never be executed!!!

b_lez:
lui $8, 0x8FFF
bltz, $8, b_ltz
addi $1, $1, 0x00002468   #!!!This should never be executed!!!
addi $1, $1, 0x0000ABCD   #!!!This should never be executed!!!

b_ltz:
halt

# Currently unimplemented
# b_ltz:
# bgezal $9, j_back
# bltzal $8, j_back
# halt

# j_back:
# jr $31