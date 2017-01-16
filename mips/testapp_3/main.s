	.file	1 "main.c"
	.section .mdebug.abi32
	.previous
	.globl	array_0
	.data
	.align	2
	.type	array_0, @object
	.size	array_0, 32
array_0:
	.word	3
	.word	2
	.word	7
	.word	6
	.word	1
	.word	5
	.word	4
	.word	8
	.text
	.align	2
	.globl	main
	.ent	main
	.type	main, @function
main:
	.frame	$fp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	sw	$fp,16($sp)
	move	$fp,$sp
	lui	$2,%hi(array_0)
	addiu	$4,$2,%lo(array_0)
	li	$5,8			# 0x8
	jal	bubblesort
	nop

	move	$2,$0
	move	$sp,$fp
	lw	$31,20($sp)
	lw	$fp,16($sp)
	addiu	$sp,$sp,24
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	main
	.align	2
	.globl	bubblesort
	.ent	bubblesort
	.type	bubblesort, @function
bubblesort:
	.frame	$fp,24,$31		# vars= 16, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-24
	sw	$fp,16($sp)
	move	$fp,$sp
	sw	$4,24($fp)
	sw	$5,28($fp)
	sw	$0,8($fp)
	j	$L4
	nop

$L5:
	sw	$0,4($fp)
	j	$L6
	nop

$L7:
	lw	$2,4($fp)
	nop
	sll	$2,$2,2
	move	$3,$2
	lw	$2,24($fp)
	nop
	addu	$2,$3,$2
	lw	$4,0($2)
	lw	$2,4($fp)
	nop
	sll	$2,$2,2
	move	$3,$2
	lw	$2,24($fp)
	nop
	addu	$2,$3,$2
	addiu	$2,$2,4
	lw	$2,0($2)
	nop
	slt	$2,$2,$4
	beq	$2,$0,$L8
	nop

	lw	$2,4($fp)
	nop
	sll	$2,$2,2
	move	$3,$2
	lw	$2,24($fp)
	nop
	addu	$2,$3,$2
	addiu	$2,$2,4
	lw	$2,0($2)
	nop
	sw	$2,0($fp)
	lw	$2,4($fp)
	nop
	sll	$2,$2,2
	move	$3,$2
	lw	$2,24($fp)
	nop
	addu	$2,$3,$2
	addiu	$4,$2,4
	lw	$2,4($fp)
	nop
	sll	$2,$2,2
	move	$3,$2
	lw	$2,24($fp)
	nop
	addu	$2,$3,$2
	lw	$2,0($2)
	nop
	sw	$2,0($4)
	lw	$2,4($fp)
	nop
	sll	$2,$2,2
	move	$3,$2
	lw	$2,24($fp)
	nop
	addu	$3,$3,$2
	lw	$2,0($fp)
	nop
	sw	$2,0($3)
$L8:
	lw	$2,4($fp)
	nop
	addiu	$2,$2,1
	sw	$2,4($fp)
$L6:
	lw	$2,28($fp)
	nop
	addiu	$3,$2,-1
	lw	$2,4($fp)
	nop
	slt	$2,$2,$3
	bne	$2,$0,$L7
	nop

	lw	$2,8($fp)
	nop
	addiu	$2,$2,1
	sw	$2,8($fp)
$L4:
	lw	$2,8($fp)
	lw	$3,28($fp)
	nop
	slt	$2,$2,$3
	bne	$2,$0,$L5
	nop

	move	$sp,$fp
	lw	$fp,16($sp)
	addiu	$sp,$sp,24
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	bubblesort
	.ident	"GCC: (GNU) 4.1.2"
