	.file	1 "main.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=32
	.module	nooddspreg
	.text
	.align	2
	.globl	memset
	.set	nomips16
	.set	nomicromips
	.ent	memset
	.type	memset, @function
memset:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addu	$6,$4,$6
$L2:
	bne	$4,$6,$L3
	nop

	jr	$31
	nop

$L3:
	sb	$5,0($4)
	b	$L2
	addiu	$4,$4,1

	.set	macro
	.set	reorder
	.end	memset
	.size	memset, .-memset
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.set	nomips16
	.set	nomicromips
	.ent	main
	.type	main, @function
main:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	lw	$3,%gp_rel(noncacheable)($28)
	move	$2,$0
	sw	$31,20($sp)
	sw	$16,16($sp)
	li	$5,32			# 0x20
$L5:
	lw	$4,0($3)
	addiu	$3,$3,4
	addu	$4,$4,$2
	addiu	$2,$2,2
	bne	$2,$5,$L5
	sw	$4,-4($3)

	lui	$16,%hi(data)
	addiu	$16,$16,%lo(data)
	move	$3,$16
	move	$2,$0
	li	$4,32			# 0x20
$L6:
	sw	$2,0($3)
	addiu	$2,$2,2
	bne	$2,$4,$L6
	addiu	$3,$3,4

	li	$6,64			# 0x40
	move	$5,$16
	jal	l1_cache_operate_on_line_range
	li	$4,4			# 0x4

	li	$6,64			# 0x40
	move	$5,$16
	jal	l1_cache_operate_on_line_range
	move	$4,$0

	lui	$3,%hi(data+64)
	move	$2,$16
	addiu	$3,$3,%lo(data+64)
$L7:
	sb	$0,0($2)
	addiu	$2,$2,1
	bne	$2,$3,$L7
	move	$5,$16

	li	$6,64			# 0x40
	jal	l1_cache_operate_on_line_range
	li	$4,4			# 0x4

	lw	$31,20($sp)
	lw	$16,16($sp)
	move	$2,$0
	jr	$31
	addiu	$sp,$sp,24

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main
	.globl	noncacheable
	.section	.sdata,"aw",@progbits
	.align	2
	.type	noncacheable, @object
	.size	noncacheable, 4
noncacheable:
	.word	4096

	.comm	data,64,4
	.ident	"GCC: (GNU) 6.3.0"
