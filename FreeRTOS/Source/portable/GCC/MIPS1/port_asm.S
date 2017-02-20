
.extern pxCurrentTCB

.global StartFirstTask
.global pxPortInitialiseStack

portSAVE_CONTEXT:
	.set noat
	.set noreorder
	addi	$29,	$29,	-116				#adjust sp
	sw		$1,		0($29)						#at
	sw		$2,		4($29)						#v0
	sw		$3, 	8($29)						#v1
	sw		$4, 	12($29)						#a0
	sw		$5, 	16($29)						#a1
	sw		$6, 	20($29)						#a2
	sw		$7, 	24($29)						#a3
	sw		$8, 	28($29)						#t0
	sw		$9, 	32($29)						#t1
	sw		$10,	36($29)						#t2
	sw		$11,	40($29)						#t3
	sw		$12,	44($29)						#t4
	sw		$13,	48($29)						#t5
	sw		$14,	52($29)						#t6
	sw		$15,	56($29)						#t7
	sw		$16,	60($29)						#s0
	sw		$17,	64($29)						#s1
	sw		$18,	68($29)						#s2
	sw		$19,	72($29)						#s3
	sw		$20,	76($29)						#s4
	sw		$21,	80($29)						#s5
	sw		$22,	84($29)						#s6
	sw		$23,	88($29)						#s7
	sw		$24,	92($29)						#t8
	sw		$25,	96($29)						#t9
	# 26 and 27 are kernel
	# 28 is global pointer, which doesn't change
	sw		$30,	100($29)					#fp, not sure if used...
	sw		$31,	104($29)					#lr
	mfhi	$27
	sw		$27,	108($29)					#hi
	mflo	$27
	sw		$27,	112($29)					#lo
	lui		$27,	%hi(pxCurrentTCB)			#load pxCurrentTCB addr
	addiu	$27,	$27,	%lo(pxCurrentTCB)	#load pxCurrentTCB addr
	sw		$29,	0($27)						#store sp in pxCurrentTCB
	.set at
	.set reorder

portRESTORE_CONTEXT:
	.set noat
	.set noreorder
	lui		$27,	%hi(pxCurrentTCB)			#load pxCurrentTCB addr
	addiu	$27,	$27,	%lo(pxCurrentTCB)	#load pxCurrentTCB addr
	lw		$29,	0($27)						#load sp of context save
	lw		$1,		0($29)						#at
	lw		$2,		4($29)						#v0
	lw		$3, 	8($29)						#v1
	lw		$4, 	12($29)						#a0
	lw		$5, 	16($29)						#a1
	lw		$6, 	20($29)						#a2
	lw		$7, 	24($29)						#a3
	lw		$8, 	28($29)						#t0
	lw		$9, 	32($29)						#t1
	lw		$10,	36($29)						#t2
	lw		$11,	40($29)						#t3
	lw		$12,	44($29)						#t4
	lw		$13,	48($29)						#t5
	lw		$14,	52($29)						#t6
	lw		$15,	56($29)						#t7
	lw		$16,	60($29)						#s0
	lw		$17,	64($29)						#s1
	lw		$18,	68($29)						#s2
	lw		$19,	72($29)						#s3
	lw		$20,	76($29)						#s4
	lw		$21,	80($29)						#s5
	lw		$22,	84($29)						#s6
	lw		$23,	88($29)						#s7
	lw		$24,	92($29)						#t8
	lw		$25,	96($29)						#t9
	# 26 and 27 are kernel
	# 28 is global pointer, which doesn't change
	lw		$30,	100($29)					#fp
	lw		$31,	104($29)					#lr
	lw		$26,	108($29)					#hi
	mthi	$26
	lw		$26,	112($29)					#lo
	mtlo	$26
	addi	$29,	$29,	116					#adjust sp
	jr		$31
	.set at
	.set reorder

StartFirstTask:
	.set noreorder
	.set noat
	j portRESTORE_CONTEXT
	.set reorder
	.set at

pxPortInitialiseStack:
	.set noreorder
	.set noat
	addi	$2,		$4,		-116				#sp from 1st arg, fix for storing context, place in return
	sw		$6,		12($2)						#place 3rd arg on stack in a0's place
	sw		$5,		104($2)						#place 2nd arg on stack in lr's place
	# honestly the rest can be garbage
	jr $31
	.set reorder
	.set at

