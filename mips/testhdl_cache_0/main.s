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
 # 26 "../plasma/plasmasoc.h" 1
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
 # 26 "../plasma/plasmasoc.h" 1
	sw $4, 0($2)
sw $0, 0($4)

 # 0 "" 2
 #NO_APP
	jr	$31
	.end	l1_cache_flush
	.size	l1_cache_flush, .-l1_cache_flush
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
	beq	$4,$6,$L7
	nop

	j	memset
	subu	$6,$6,$4

$L7:
	jr	$31
	nop

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
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, gp= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lw	$2,%gp_rel(noncacheable)($28)
	addiu	$sp,$sp,-40
	lw	$25,16($2)
	lw	$24,20($2)
	sw	$31,36($sp)
	sw	$19,28($sp)
	sw	$17,20($sp)
	lw	$19,4($2)
	lw	$17,8($2)
	lw	$31,12($2)
	lw	$15,24($2)
	lw	$14,28($2)
	lw	$13,32($2)
	lw	$12,36($2)
	lw	$11,40($2)
	lw	$10,44($2)
	lw	$9,48($2)
	lw	$8,52($2)
	lw	$7,56($2)
	lw	$3,60($2)
	sw	$20,32($sp)
	addiu	$31,$31,6
	addiu	$25,$25,8
	addiu	$24,$24,10
	addiu	$15,$15,12
	addiu	$14,$14,14
	addiu	$13,$13,16
	addiu	$12,$12,18
	addiu	$11,$11,20
	addiu	$10,$10,22
	addiu	$9,$9,24
	addiu	$8,$8,26
	addiu	$7,$7,28
	addiu	$3,$3,30
	lui	$20,%hi(data)
	addiu	$19,$19,2
	addiu	$17,$17,4
	sw	$18,24($sp)
	sw	$16,16($sp)
	addiu	$16,$20,%lo(data)
	sw	$31,12($2)
	sw	$25,16($2)
	sw	$24,20($2)
	sw	$15,24($2)
	sw	$14,28($2)
	sw	$13,32($2)
	sw	$12,36($2)
	sw	$19,4($2)
	sw	$17,8($2)
	sw	$11,40($2)
	sw	$10,44($2)
	sw	$9,48($2)
	sw	$8,52($2)
	sw	$7,56($2)
	sw	$3,60($2)
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
	lui	$18,%hi(l1_cache_flush)
	sw	$2,52($16)
	li	$2,28			# 0x1c
	move	$5,$16
	addiu	$4,$18,%lo(l1_cache_flush)
	sw	$2,56($16)
	li	$6,64			# 0x40
	li	$2,30			# 0x1e
	sw	$2,60($16)
	jal	l1_cache_operate_on_line_range
	sw	$0,%lo(data)($20)

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
	addiu	$4,$18,%lo(l1_cache_flush)
	jal	l1_cache_operate_on_line_range
	li	$6,64			# 0x40

	lw	$31,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	move	$2,$0
	jr	$31
	addiu	$sp,$sp,40

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
