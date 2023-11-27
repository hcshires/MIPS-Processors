.data
.text
.globl main
main:
    # One instruction
    addi $2, $0, -7
    bgtz  $2, exit
    addi $3, $0, 7
    
    # Two instructions
    addi $2, $0, -8
    addi $1, $0, 2
    bgtz  $2, exit
    addi $3, $3, 7
    
    # Three instructions
    addi $2, $0, 9
    addi $1, $0, 9
    nop
    bgtz  $2, exit
    addi $3, $3, 7
   
    # End Test
exit:
    # Exit program
    halt
