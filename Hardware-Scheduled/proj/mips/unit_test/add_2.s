.data
.text
.globl main
main:
    # Start Test
    addi $1, $0, 1     # load 1 into $1 to initialize a value for the test
    nop
    nop
    nop
    nop

# the tests below are used to see if the registers will properly multiply by 2 and if they can ultimately store the max value
# this is storing the powers of 2 in the registers
    add $1, $1, $1     # $1 = 1 + 1 --> should be 2
    nop
    nop
    nop
    nop
    add $2, $1, $1     # $2 = 2 + 2 --> should be 4  
    nop
    nop
    nop
    nop
    add $3, $2, $2     # $3 = 4 + 4 --> should be 8
    nop
    nop
    nop
    nop   
    add $4, $3, $3     # $4 = 8 + 8 --> should be 16
    nop
    nop
    nop
    nop   
    add $5, $4, $4     # $5 = 16 + 16 --> should be 32
    nop
    nop
    nop
    nop
    add $6, $5, $5     # $6 = 32 + 32 --> should be 64
    nop
    nop
    nop
    nop  
    add $7, $6, $6     # $7 = 64 + 64 --> should be 128   
    nop
    nop
    nop
    nop
    add $8, $7, $7     # $8 = 128 + 128 --> should be 256   
    nop
    nop
    nop
    nop
    add $9, $8, $8     # $9 = 256 + 256 --> should be 512   
    nop
    nop
    nop
    nop
    add $10, $9, $9     # $10 = 512 + 512 --> should be 1024   
    nop
    nop
    nop
    nop
    add $11, $10, $10     # $11 = 1024 + 1024 --> should be 2048   
    nop
    nop
    nop
    nop
    add $12, $11, $11     # $12 = 2048 + 2048 --> should be 4096  
    nop
    nop
    nop
    nop
    add $13, $12, $12     # $13 = 4096 + 4096 --> should be 8192 
    nop
    nop
    nop
    nop
    add $14, $13, $13     # $14 = 8192 + 8192 --> should be 16384
    nop
    nop
    nop
    nop
    add $15, $14, $14     # $15 = 16384 + 16384 --> should be 32768   
    # Exit program
    halt
