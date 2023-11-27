## Combination of hazards

# Test setup
lui $4, 0x1001

addiu $1, $0, 50
sw $1, 0($4)
nop
nop
nop

## Sequential instruction data hazards
## EX/MEM.RegisterRd = ID/EX.RegisterRs or ID/EX.RegisterRt

add $1, $0, $4
lw $2, 0($4)
add $2, $1, $0
add $3, $2, $0
lw $3, 0($4)
addi $5, $3, 1
lw $5, 0($4)
addiu $6, $5, 1
addi $3, $0, 3
addi $3, $3, 1
lw $20, 0($4)
subu $21, $20, $0
addiu $5, $0, 5
addiu $6, $5, 1
addu $7, $0, $4
addu $8, $7, $0
and $9, $0, $4
lw $2, 0($4)
lw $6, 0($4)
lw $7, 0($4)
addu $7, $0, $6
add $3, $0, $2
sw $3, 0($4)
and $8, $0, $7
lw $9, 0($4)
nor $10, $0, $9
lw $10, 0($4)
xor $11, $0, $10
lw $12, 0($4)
or $13, $0, $12
lw $14, 0($4)
slt $15, $0, $14
lw $16, 0($4)
sll $17, $16, 4
lw $17, 0($4)
srl $18, $17, 4
lw $18, 0($4)
sra $19, $18, 4
lw $19, 0($4)
sub $20, $0, $19
nop
sw $20, 0($4)
lw $20, 0($4)
subu $21, $0, $20
and $10, $9, $0
andi $11, $0, 11
andi $12, $11, 1
nor $15, $0, $4
nor $16, $15, $0
xor $17, $0, $4
xor $18, $17, $0
lw $10, 0($4)
xor $11, $10, $0
xori $19, $0, 19
xori $20, $19, 1
or $21, $0, $4
or $22, $21, $0
lw $15, 0($4)
slti $16, $15, 1
ori $23, $0, 23
ori $24, $23, 1
slt $25, $0, $4
slt $26, $25, $0
slti $27, $0, 27
slti $28, $27, 1
sub $8, $0, $4
lw $9, 0($4)
nor $10, $9, $0
sub $9, $8, $0
subu $10, $0, $4
subu $11, $10, $0
add $1, $0, $4
lw $12, 0($4)
or $13, $12, $0
add $2, $0, $1
addu $7, $0, $4
addu $8, $0, $7
lw $14, 0($4)
slt $15, $14, $0
and $9, $0, $4
and $10, $0, $9
lw $8, 0($4)
andi $9, $8, 1
nor $15, $0, $4
nor $16, $0, $15
lw $7, 0($4)
and $8, $7, $0
xor $17, $0, $4
xor $18, $0, $17
or $21, $0, $4
or $22, $0, $21
slt $25, $0, $4
slt $26, $0, $25
sll $29, $0, 4
sll $30, $0, 4
srl $31, $0, 4
lw $11, 0($4)
xori $12, $11, 1
srl $1, $0, 4
lw $19, 0($4)
sub $20, $19, $0
sra $2, $0, 4
sra $3, $0, 4
lw $13, 0($4)
ori $14, $13, 1
sub $8, $0, $4
sub $9, $0, $8
lw $6, 0($4)
addu $7, $6, $0
subu $10, $0, $4
subu $11, $0, $10

halt
