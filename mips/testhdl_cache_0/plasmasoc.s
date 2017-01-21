	.file	1 "plasmasoc.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=32
	.module	nooddspreg
	.text
	.align	2
	.globl	l1_cache_operate_on_line_range
	.set	nomips16
	.set	nomicromips
	.ent	l1_cache_operate_on_line_range
	.type	l1_cache_operate_on_line_range, @function
l1_cache_operate_on_line_range:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, gp= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L12
	nop

	addiu	$sp,$sp,-32
	sw	$17,20($sp)
	sw	$16,16($sp)
	addu	$17,$6,$5
	li	$16,-32			# 0xffffffffffffffe0
	and	$2,$17,$16
	sltu	$17,$2,$17
	sll	$17,$17,5
	addiu	$2,$2,32
	and	$16,$5,$16
	addu	$17,$2,$17
	sw	$18,24($sp)
	sw	$31,28($sp)
	beq	$16,$17,$L1
	move	$18,$4

	move	$4,$16
$L14:
	jalr	$18
	addiu	$16,$16,32

	bne	$16,$17,$L14
	move	$4,$16

$L1:
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addiu	$sp,$sp,32
$L12:
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	l1_cache_operate_on_line_range
	.size	l1_cache_operate_on_line_range, .-l1_cache_operate_on_line_range
	.ident	"GCC: (GNU) 6.3.0"
