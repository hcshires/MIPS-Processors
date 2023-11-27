.data
.text
.globl main
main:
    # One instruction
    addi $2, $0, 7
    jal next
    addi $3, $0, 7 # Flushed
    
    # Two instructions
    addi $2, $0, 8
    addi $1, $0, 8
    add $3, $0, $2
    jal two
    
    # Three instructions
    addi $2, $0, 9
    addi $1, $0, 10
    nop
    jal three
    
next:
    add $3, $0, $2 # Hazard
    jr $ra
    addi $3, $3, 7 # Flushed
    
two:
    jr $ra
    addi $3, $3, 7 # Flushed

three:
    add $3, $0, $2
    # End Test
    
exit:
    # Exit program
    halt
