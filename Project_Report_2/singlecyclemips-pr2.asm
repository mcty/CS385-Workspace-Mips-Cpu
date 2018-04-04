# Test program for SingleCycleMIPS-PR2.v

  .text	

  .globl __start 
__start:

	lw $t1, 0($0)		#$t1=7
	lw $t2, 4($0)		#$t2=5
	slt $t3, $t1, $t2	#$t3=0
	//beq $t3, $0, 2	#
	bne $t3, $0, 2		#$t3=0
	sw $t1, 4($0)		#$t1=4
	sw $t2, 0($0)		#$t2=0	
	lw $t1, 0($0)		#$t1=5
	lw $t2, 4($0)		#$t2=7
	sub $t1, $t1, $t2	#$t1=-2

	.data 
	.word 7
	.word 5


