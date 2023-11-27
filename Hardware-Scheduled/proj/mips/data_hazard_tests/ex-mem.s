## Sequential instruction data hazards
## EX/MEM.RegisterRd = ID/EX.RegisterRs or ID/EX.RegisterRt

# Test setup
lui $4, 0x1001
ori $4, 0x0000

addiu $1, $0, 50
sw $1, 0($4)
nop
nop
nop

# Rs hazard
add $1, $0, $4
add $2, $1, $0

addi $3, $0, 3
addi $4, $3, 1

addiu $5, $0, 5
addiu $6, $5, 1

addu $7, $0, $4
addu $8, $7, $0

and $9, $0, $4
and $10, $9, $0

andi $11, $0, 11
andi $12, $11, 1

nor $15, $0, $4
nor $16, $15, $0

xor $17, $0, $4
xor $18, $17, $0

xori $19, $0, 19
xori $20, $19, 1

or $21, $0, $4
or $22, $21, $0

ori $23, $0, 23
ori $24, $23, 1

slt $25, $0, $4
slt $26, $25, $0

slti $27, $0, 27
slti $28, $27, 1

lui $28, 0x1001
addi $29, $0, 29
sw $29, 0($28)

sub $8, $0, $4
sub $9, $8, $0

subu $10, $0, $4
subu $11, $10, $0

# Rt hazard
add $1, $0, $4
add $2, $0, $1

addu $7, $0, $4
addu $8, $0, $7

and $9, $0, $4
and $10, $0, $9

nor $15, $0, $4
nor $16, $0, $15

xor $17, $0, $4
xor $18, $0, $17

or $21, $0, $4
or $22, $0, $21

slt $25, $0, $4
slt $26, $0, $25

sll $29, $0, 4
sll $30, $0, 4

srl $31, $0, 4
srl $1, $0, 4

sra $2, $0, 4
sra $3, $0, 4

sub $8, $0, $4
sub $9, $0, $8

subu $10, $0, $4
subu $11, $0, $10

halt
