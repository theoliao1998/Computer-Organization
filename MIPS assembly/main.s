#simple.s
 .text
 .globl __start
__start:
main:
addiu	$s0, $0, 20	# set size to be 20 and save it in $s0
addi	$sp, $sp,-80	# initialize the array with 20 elements, make room in stack
add	$s1, $0, $sp	# the base address of the array
addiu	$t0, $0, 55	# initialize the 20 elements and respectively save them in the room in stack
sw	$t0, 0($s1)
addiu	$t1, $0, 83
sw	$t1, 4($s1)
addiu	$t2, $0, 55
sw	$t2, 8($s1)
addiu 	$t3, $0, 76
sw	$t3, 12($s1)
addiu 	$t4, $0, 45
sw	$t4, 16($s1)
addiu 	$t5, $0, 98
sw	$t5, 20($s1)
addiu 	$t6, $0, 77
sw	$t6, 24($s1)
addiu 	$t7, $0, 21
sw	$t7, 28($s1)
addiu 	$t0, $0, 90
sw	$t0, 32($s1)
addiu 	$t1, $0, 61
sw	$t1, 36($s1)
addiu 	$t2, $0, 82
sw	$t2, 40($s1)
addiu 	$t3, $0, 49
sw	$t3, 44($s1)
addiu 	$t4, $0, 73
sw	$t4, 48($s1)
addiu 	$t5, $0, 22
sw	$t5, 52($s1)
addiu 	$t6, $0, 86
sw	$t6, 56($s1)
addiu 	$t7, $0, 60
sw	$t7, 60($s1)
addiu 	$t0, $0, 59
sw	$t0, 64($s1)
addiu 	$t1, $0, 0
sw	$t1, 68($s1)
addiu 	$t2, $0, 100
sw	$t2, 72($s1)
addiu 	$t3, $0, 11
sw	$t3, 76($s1)
add	$a0, $0, $s1	# load the arguments
add	$a1, $0, $s0
jal	countArray
addi	$a2, $0, 1		# delay slot, load a2 for the 'countArray' before 
add	$a1, $0, $s0	# load the arguments
add	$s2, $0, $v0	# save the result of countArray in $s2, this is 'PassCnt'
add	$a0, $0, $s1
jal	countArray
addi	$a2, $0, -1	# delay slot, load a2 for the 'countArray' before 
add	$s3, $0, $v0	# save the result of countArray in $s3, this is 'FailCnt'
j	Exit
addi	$sp, $sp, 80	# release the room for the array stored on stack
countArray:
add	$t0, $0, $0	# initialize cnt=0
add	$t1, $a1, -1	# initialize i=numElements-1
L1:
slt	$t2, $t1, $0	# $t2=1 if i<0
beq	$t2, $0, Loop	# go to Loop if i>=0
add	$v0, $0, $t0	# set cnt as the result to be returned
jr	$ra		# return to calling routine
Loop:
sll	$t3, $t1, 2	# $t3 = i * 4
add	$t3, $t3, $a0	# $t3 = A + i * 4, the address of A[i]
lw	$t3, 0($t3)	# $t3 = A[i]
addi	$sp, $sp, -4	# make room on stack for 1 register
sw	$a0, 0($sp)	# save $a0 on stack
addi	$t2, $0, 1		# $t2 = 1
beq	$a2, $t2, L2	# if cntType==1, go to L2(Pass)
add	$a0, $t3, $0	# delay slot, load $a0 for 'Pass'
Fail:
slti	$t4, $a0, 60	# if x<60, $t4=1, else $t4=0
beq	$t4, $0, L3	# if x>=60, go to L3 to return
addi	$v0, $0, 0		# delay slot, if x>=60, the result to be returned is 0 
addi	$v0, $0, 1		# if x<60, the result to be returned is 1 
j	L3		# jump to L3 to return
L2:
Pass:
slti	$t4, $a0, 60	# if x<60, $t4=1, else $t4=0
beq	$t4, $0, L3	# if x>=60, go to L3 to return
addi	$v0, $0, 1		# delay slot, if x>=60, the result to be returned is 1 
addi	$v0, $0, 0		# if x<60, the result to be returned is 0 
L3:
lw	$a0, 0($sp)	# restore $a0 from stack
add	$t1, $t1, -1	# i--
add	$t0, $t0, $v0	# cnt += $v0, where $v0 is the result of Pass(A[i]) or Fail(A[i])
j	L1		# jump back to L1 to Loop again
addi	$sp, $sp, 4	# delay slot, adjust stack to delete 1 item, completed before j L1
Exit:
addiu 	$v0, $0, 10	# Prepare to exit (system call 0)
syscall 			# Exit
