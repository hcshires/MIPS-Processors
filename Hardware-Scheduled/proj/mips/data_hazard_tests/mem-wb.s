## Two-instruction space between dependencies, use nops between
## MEM/WB.RegisterRd = ID/EX.RegisterRs or ID/EX.RegisterRt

# Test setup
addiu $4, $0, 50
nop
nop
nop

# Rs hazard
add $1, $0, $4
nop
add $2, $1, $0

addi $3, $0, 3
nop
addi $4, $3, 1

addiu $5, $0, 5
nop
addiu $6, $5, 1

addu $7, $0, $4
nop
addu $8, $7, $0

and $9, $0, $4
nop
and $10, $9, $0

andi $11, $0, 11
nop
andi $12, $11, 1

nor $15, $0, $4
nop
nor $16, $15, $0

xor $17, $0, $4
nop
xor $18, $17, $0

xori $19, $0, 19
nop
xori $20, $19, 1

or $21, $0, $4
nop
or $22, $21, $0

ori $23, $0, 23
nop
ori $24, $23, 1

slt $25, $0, $4
nop
slt $26, $25, $0

slti $27, $0, 27
nop
slti $28, $27, 1

sub $8, $0, $4
nop
sub $9, $8, $0

subu $10, $0, $4
nop
subu $11, $10, $0

# Rt hazard
add $1, $0, $4
nop
add $2, $0, $1

addu $7, $0, $4
nop
addu $8, $0, $7

and $9, $0, $4
nop
and $10, $0, $9

nor $15, $0, $4
nop
nor $16, $0, $15

xor $17, $0, $4
nop
xor $18, $0, $17

or $21, $0, $4
nop
or $22, $0, $21

slt $25, $0, $4
nop
slt $26, $0, $25

sll $29, $0, 4
nop
sll $30, $0, 4

srl $31, $0, 4
nop
srl $1, $0, 4

sra $2, $0, 4
nop
sra $3, $0, 4

sub $8, $0, $4
nop
sub $9, $0, $8

subu $10, $0, $4
nop
subu $11, $0, $10

halt