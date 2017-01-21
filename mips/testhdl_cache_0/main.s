	.file	1 "main.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=32
	.module	nooddspreg
	.text
	.align	2
	.set	nomips16
	.set	nomicromips
	.ent	l1_cache_invalidate
	.type	l1_cache_invalidate, @function
l1_cache_invalidate:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,-32			# 0xffffffffffffffe0
	and	$4,$4,$2
	li	$2,268435456			# 0x10000000
 #APP
 # 24 "../plasma/plasmasoc.h" 1
	sw $4, 0($2)
sw $0, 0($4)

 # 0 "" 2
 #NO_APP
	jr	$31
	.end	l1_cache_invalidate
	.size	l1_cache_invalidate, .-l1_cache_invalidate
	.align	2
	.set	nomips16
	.set	nomicromips
	.ent	l1_cache_flush
	.type	l1_cache_flush, @function
l1_cache_flush:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,-32			# 0xffffffffffffffe0
	and	$4,$4,$2
	li	$2,268435456			# 0x10000000
	addiu	$2,$2,4
 #APP
 # 24 "../plasma/plasmasoc.h" 1
	sw $4, 0($2)
sw $0, 0($4)

 # 0 "" 2
 #NO_APP
	jr	$31
	.end	l1_cache_flush
	.size	l1_cache_flush, .-l1_cache_flush
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.set	nomips16
	.set	nomicromips
	.ent	main
	.type	main, @function
main:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, gp= 0
	.mask	0x80030000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	lui	$2,%hi(data)
	sw	$0,%lo(data)($2)
	sw	$16,20($sp)
	addiu	$16,$2,%lo(data)
	li	$2,2			# 0x2
	sw	$2,4($16)
	li	$2,4			# 0x4
	sw	$2,8($16)
	li	$2,6			# 0x6
	sw	$2,12($16)
	li	$2,8			# 0x8
	sw	$2,16($16)
	li	$2,10			# 0xa
	sw	$2,20($16)
	li	$2,12			# 0xc
	sw	$2,24($16)
	li	$2,14			# 0xe
	sw	$2,28($16)
	li	$2,16			# 0x10
	sw	$2,32($16)
	li	$2,18			# 0x12
	sw	$2,36($16)
	li	$2,20			# 0x14
	sw	$2,40($16)
	li	$2,22			# 0x16
	sw	$2,44($16)
	li	$2,24			# 0x18
	sw	$2,48($16)
	li	$2,26			# 0x1a
	sw	$2,52($16)
	sw	$17,24($sp)
	li	$2,28			# 0x1c
	lui	$17,%hi(l1_cache_flush)
	sw	$2,56($16)
	move	$5,$16
	li	$2,30			# 0x1e
	addiu	$4,$17,%lo(l1_cache_flush)
	li	$6,64			# 0x40
	sw	$31,28($sp)
	sw	$2,60($16)
	jal	l1_cache_operate_on_line_range
	nop

	lui	$4,%hi(l1_cache_invalidate)
	move	$5,$16
	li	$6,64			# 0x40
	jal	l1_cache_operate_on_line_range
	addiu	$4,$4,%lo(l1_cache_invalidate)

	move	$4,$16
	li	$6,64			# 0x40
	jal	memset
	move	$5,$0

	move	$5,$16
	addiu	$4,$17,%lo(l1_cache_flush)
	jal	l1_cache_operate_on_line_range
	li	$6,64			# 0x40

	lw	$31,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	move	$2,$0
	jr	$31
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main

	.comm	data,64,4
	.ident	"GCC: (GNU) 6.3.0"
