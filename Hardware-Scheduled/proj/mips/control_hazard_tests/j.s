.data
.text
.globl main
main:
    # One instruction
    addi $2, $0, 7
    j next
    addi $3, $0, 7 # Flushed
    
next:
    add $3, $0, $2 # Hazard
    
    # Two instructions
    addi $2, $0, 8
    addi $1, $0, 8
    j two
    addi $3, $3, 7 # Flushed
    
two:
    add $3, $0, $2
    # Three instructions
    addi $2, $0, 9
    addi $1, $0, 10
    nop
    j three
    addi $3, $3, 7 # Flushed

three:
    add $3, $0, $2
    # End Test
    
exit:
    # Exit program
    halt
