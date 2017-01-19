	.file	1 "main.c"
	.section .mdebug.abi32
	.previous
	.text
	.align	2
	.ent	l1_cache_flush
	.type	l1_cache_flush, @function
l1_cache_flush:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,-32			# 0xffffffffffffffe0
	li	$3,268435456			# 0x10000000
	and	$4,$4,$2
	ori	$3,$3,0x4
#APP
	sw $4, 0($3)
sw $0, 0($4)

#NO_APP
	j	$31
	.end	l1_cache_flush
	.align	2
	.ent	l1_cache_invalidate
	.type	l1_cache_invalidate, @function
l1_cache_invalidate:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,-32			# 0xffffffffffffffe0
	and	$4,$4,$2
	li	$3,268435456			# 0x10000000
#APP
	sw $4, 0($3)
sw $0, 0($4)

#NO_APP
	j	$31
	.end	l1_cache_invalidate
	.align	2
	.globl	main
	.ent	main
	.type	main, @function
main:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, gp= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-32
	lui	$3,%hi(data)
	sw	$16,16($sp)
	li	$2,2			# 0x2
	addiu	$16,$3,%lo(data)
	sw	$31,24($sp)
	sw	$17,20($sp)
	sw	$0,%lo(data)($3)
	sw	$2,4($16)
	li	$3,4			# 0x4
	li	$2,6			# 0x6
	sw	$3,8($16)
	sw	$2,12($16)
	li	$3,8			# 0x8
	li	$2,10			# 0xa
	sw	$3,16($16)
	sw	$2,20($16)
	li	$3,12			# 0xc
	li	$2,14			# 0xe
	sw	$3,24($16)
	sw	$2,28($16)
	li	$3,16			# 0x10
	li	$2,18			# 0x12
	sw	$3,32($16)
	sw	$2,36($16)
	li	$3,20			# 0x14
	li	$2,22			# 0x16
	sw	$3,40($16)
	lui	$17,%hi(l1_cache_flush)
	sw	$2,44($16)
	li	$3,24			# 0x18
	li	$2,26			# 0x1a
	sw	$3,48($16)
	addiu	$4,$17,%lo(l1_cache_flush)
	sw	$2,52($16)
	li	$3,28			# 0x1c
	li	$2,30			# 0x1e
	move	$5,$16
	li	$6,64			# 0x40
	sw	$3,56($16)
	sw	$2,60($16)
	jal	l1_cache_operate_on_line_range
	nop

	lui	$4,%hi(l1_cache_invalidate)
	move	$5,$16
	addiu	$4,$4,%lo(l1_cache_invalidate)
	jal	l1_cache_operate_on_line_range
	li	$6,64			# 0x40

	move	$4,$16
	move	$5,$0
	jal	memset
	li	$6,64			# 0x40

	addiu	$4,$17,%lo(l1_cache_flush)
	move	$5,$16
	jal	l1_cache_operate_on_line_range
	li	$6,64			# 0x40

	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	move	$2,$0
	j	$31
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	main

	.comm	data,64,4
	.ident	"GCC: (GNU) 4.1.2"
