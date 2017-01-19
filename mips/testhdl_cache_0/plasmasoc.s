	.file	1 "plasmasoc.c"
	.section .mdebug.abi32
	.previous
	.text
	.align	2
	.globl	l1_cache_operate_on_line_range
	.ent	l1_cache_operate_on_line_range
	.type	l1_cache_operate_on_line_range, @function
l1_cache_operate_on_line_range:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, gp= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-32
	sw	$18,24($sp)
	sw	$31,28($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	beq	$6,$0,$L8
	move	$18,$4

	addu	$2,$6,$5
	andi	$3,$2,0xf
	sltu	$2,$3,$2
	sll	$2,$2,4
	addiu	$3,$3,16
	addu	$17,$2,$3
	andi	$16,$5,0xf
	beq	$16,$17,$L8
	move	$4,$16

$L13:
	jal	$18
	addiu	$16,$16,16

	bne	$17,$16,$L13
	move	$4,$16

$L8:
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	j	$31
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	l1_cache_operate_on_line_range
	.ident	"GCC: (GNU) 4.1.2"
