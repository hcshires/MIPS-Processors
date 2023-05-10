.data
array:
   	.word   10, 5, 27, 2, 1, 12
  	 
.text
main:
    #Set the number of elements we want to sort into $a0
    addiu   $4, $0, 6
    jal bubblesort
    halt


bubblesort:
   	addiu   $sp,$sp,-32
   	sw  	$fp,28($sp)
   	#move	$fp,$sp
   	and 	$fp, $fp, $0
   	add 	$fp, $sp, $0
   	sw  	$4,32($fp)
   	sw  	$0,8($fp)
   	b   	$L2

$L6:
   	sw  	$0,12($fp)
   	b   	$L3

$L5:
   	la  	$2, array
   	lw  	$3,12($fp)
   	sll 	$3,$3,2
   	addu	$2,$3,$2
   	lw  	$3,0($2)
   	lw  	$2,12($fp)
   	addiu   $4,$2,1
   	la  	$2, array
   	sll 	$4,$4,2
   	addu	$2,$4,$2
   	lw  	$2,0($2)
   	slt 	$2,$2,$3
   	beq 	$2,$0,$L4

   	la  	$2, array
   	lw  	$3,12($fp)
   	sll 	$3,$3,2
   	addu	$2,$3,$2
   	lw  	$2,0($2)
   	sw  	$2,16($fp)
   	lw  	$2,12($fp)
   	addiu   $3,$2,1
   	la  	$2, array
   	sll 	$3,$3,2
   	addu	$2,$3,$2
   	lw  	$3,0($2)
   	la  	$2, array
   	lw  	$4,12($fp)
   	sll 	$4,$4,2
   	addu	$2,$4,$2
   	sw  	$3,0($2)
   	lw  	$2,12($fp)
   	addiu   $3,$2,1
   	la  	$2, array
   	sll 	$3,$3,2
   	addu	$2,$3,$2
   	lw  	$3,16($fp)
   	sw  	$3,0($2)
$L4:
   	lw  	$2,12($fp)
   	addiu   $2,$2,1
   	sw  	$2,12($fp)
$L3:
   	lw  	$3,32($fp)
   	lw  	$2,8($fp)
   	subu	$2,$3,$2
   	lw  	$3,12($fp)
   	slt 	$2,$3,$2
   	bne 	$2,$0,$L5

   	lw  	$2,8($fp)
   	addiu   $2,$2,1
   	sw  	$2,8($fp)
$L2:
   	lw  	$3,8($fp)
   	lw  	$2,32($fp)
   	slt 	$2,$3,$2
   	bne 	$2,$0,$L6

   	#move	$sp,$fp
   	and 	$fp, $fp, $0
   	add 	$fp, $sp, $0
   	lw  	$fp,28($sp)
   	addiu   $sp,$sp,32
   	jr $31











