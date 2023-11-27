## Load use hazards (lw)
## ID/EX.MemRead = IF/ID.RegisterRs or IF/ID.RegisterRt

# Test setup
lui $4, 0x1001
ori $4, 0x0000

addiu $1, $0, 50
sw $1, 0($4)
nop
nop
nop

# Rs hazard
lw $2, 0($4)
add $3, $2, $0

lw $3, 0($4)
addi $5, $3, 1

lw $5, 0($4)
addiu $6, $5, 1

lw $6, 0($4)
addu $7, $6, $0

lw $7, 0($4)
and $8, $7, $0

lw $8, 0($4)
andi $9, $8, 1

lw $9, 0($4)
nor $10, $9, $0

lw $10, 0($4)
xor $11, $10, $0

lw $11, 0($4)
xori $12, $11, 1

lw $12, 0($4)
or $13, $12, $0

lw $13, 0($4)
ori $14, $13, 1

lw $14, 0($4)
slt $15, $14, $0

lw $15, 0($4)
slti $16, $15, 1

lw $19, 0($4)
sub $20, $19, $0

lw $20, 0($4)
subu $21, $20, $0

# Rt hazard
lw $2, 0($4)
add $3, $0, $2

lw $6, 0($4)
addu $7, $0, $6

lw $7, 0($4)
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

lw $20, 0($4)
subu $21, $0, $20

halt