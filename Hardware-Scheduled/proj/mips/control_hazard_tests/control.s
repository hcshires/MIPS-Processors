.data
.text
.globl main
main:
    # One instruction
    addi $2, $0, 7
    beq  $2, $0, exit
    addi $3, $0, 7
    
    # Two instructions
    addi $2, $0, 8
    addi $1, $0, 2
    bne  $2, $1, next
    beq  $2, $1, exit # flush
    addi $3, $3, 7
    jal next
    
    # Three instructions
    addi $2, $0, 9
    addi $1, $0, 9
    nop
    j exit
    addi $3, $3, 7
next:
    add $3, $0, $2 # Hazard
    
    # Three instructions
    addi $2, $0, -9
    addi $1, $0, 9
    slt $4, $3, $2
    bltzal $4, two
    addi $3, $3, 7
    
    # One instruction
    addi $2, $0, 7
    jal two
    addi $3, $0, 7 # Flushed
    jr $ra
    addi $3, $3, 7 # Flushed
    
two:
# Two instructions
    addi $2, $0, 8
    addi $1, $0, 8
    add $3, $0, $2
    jal three
    jr $ra
    addi $3, $3, 7 # Flushed

three:
    add $3, $0, $2
    # One instruction
    addi $2, $0, 7
    bne  $2, $2, exit
    addi $3, $0, 7
    
    addi $2, $0, 9
    addi $1, $0, 10
    nop
    bne $1, $1, exit
    addi $3, $3, 7
    
    # One instruction
    addi $2, $0, -5
    bgez $2, exit
    addi $3, $0, 7
    
    # Two instructions
    addi $2, $0, -8
    addi $1, $0, 2
    bgez $2, exit
    addi $3, $3, 7
    
    # Two instructions
    addi $3, $3, -64
    addi $1, $0, 2
    bgezal $3, exit
    addi $3, $3, 7
    
    # One instruction
    addi $2, $0, -7
    bgtz  $2, exit
    addi $3, $0, 7
    
    # Three instructions
    addi $2, $0, -9
    addi $1, $0, 9
    nop
    bgtz  $2, exit
    addi $3, $3, 7
    
    # One instruction
    addi $2, $0, 7
    blez  $2, exit
    addi $3, $0, 7
    
    # Two instructions
    addi $2, $0, 8
    addi $1, $0, 2
    blez  $2, exit
    addi $3, $3, 7
    
    # One instruction
    addi $2, $0, 7
    bltz  $2, exit
    addi $3, $0, 7
    
    # Two instructions
    addi $2, $0, 8
    addi $1, $0, 2
    bltz  $2, exit
    addi $3, $3, 7
    
    # One instruction
    addi $2, $0, 7
    bltzal  $2, exit
    addi $3, $0, 7
    
    # Two instructions
    addi $2, $0, 8
    addi $1, $0, 2
    bltzal  $2, exit
    addi $3, $3, 7
    j exit
   
    # End Test
exit:
    # Exit program
    halt


halt
