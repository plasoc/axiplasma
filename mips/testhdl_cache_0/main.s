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
	.globl	memset
	.ent	memset
	.type	memset, @function
memset:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addu	$2,$4,$6
	beq	$4,$2,$L9
	andi	$5,$5,0x00ff

$L5:
	sb	$5,0($4)
	addiu	$4,$4,1
	bne	$4,$2,$L5
	nop

$L9:
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	memset
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
	.frame	$sp,56,$31		# vars= 0, regs= 10/0, args= 16, gp= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-56
	sw	$31,52($sp)
	sw	$fp,48($sp)
	sw	$23,44($sp)
	sw	$22,40($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lui	$3,%hi(noncacheable)
	lw	$2,%lo(noncacheable)($3)
	lui	$22,%hi(data)
	lw	$3,60($2)
	lw	$8,4($2)
	lw	$9,8($2)
	lw	$10,12($2)
	lw	$11,16($2)
	lw	$12,20($2)
	lw	$13,24($2)
	lw	$14,28($2)
	lw	$15,32($2)
	lw	$16,36($2)
	lw	$17,40($2)
	lw	$18,44($2)
	lw	$19,48($2)
	lw	$20,52($2)
	lw	$21,56($2)
	addiu	$3,$3,30
	addiu	$7,$22,%lo(data)
	addiu	$8,$8,2
	addiu	$9,$9,4
	addiu	$10,$10,6
	addiu	$11,$11,8
	addiu	$12,$12,10
	addiu	$13,$13,12
	addiu	$14,$14,14
	addiu	$15,$15,16
	sw	$3,60($2)
	addiu	$16,$16,18
	li	$3,2			# 0x2
	addiu	$17,$17,20
	addiu	$18,$18,22
	addiu	$19,$19,24
	addiu	$20,$20,26
	addiu	$21,$21,28
	sw	$8,4($2)
	sw	$9,8($2)
	sw	$10,12($2)
	sw	$11,16($2)
	sw	$12,20($2)
	sw	$13,24($2)
	sw	$14,28($2)
	sw	$15,32($2)
	sw	$16,36($2)
	sw	$17,40($2)
	sw	$18,44($2)
	sw	$19,48($2)
	sw	$20,52($2)
	sw	$21,56($2)
	sw	$3,4($7)
	li	$2,4			# 0x4
	li	$3,6			# 0x6
	sw	$2,8($7)
	sw	$3,12($7)
	li	$2,8			# 0x8
	li	$3,10			# 0xa
	sw	$2,16($7)
	sw	$3,20($7)
	li	$2,12			# 0xc
	li	$3,14			# 0xe
	sw	$2,24($7)
	sw	$3,28($7)
	li	$2,16			# 0x10
	li	$3,18			# 0x12
	sw	$2,32($7)
	sw	$3,36($7)
	li	$2,20			# 0x14
	li	$3,22			# 0x16
	sw	$2,40($7)
	sw	$3,44($7)
	li	$2,24			# 0x18
	li	$3,26			# 0x1a
	sw	$2,48($7)
	sw	$3,52($7)
	li	$2,28			# 0x1c
	li	$3,30			# 0x1e
	lui	$fp,%hi(l1_cache_flush)
	move	$5,$7
	sw	$2,56($7)
	sw	$3,60($7)
	addiu	$4,$fp,%lo(l1_cache_flush)
	li	$6,64			# 0x40
	move	$23,$7
	jal	l1_cache_operate_on_line_range
	sw	$0,%lo(data)($22)

	lui	$4,%hi(l1_cache_invalidate)
	addiu	$4,$4,%lo(l1_cache_invalidate)
	move	$5,$23
	jal	l1_cache_operate_on_line_range
	li	$6,64			# 0x40

	move	$2,$23
	addiu	$3,$23,64
$L13:
	sb	$0,0($2)
	addiu	$2,$2,1
	bne	$2,$3,$L13
	addiu	$4,$fp,%lo(l1_cache_flush)

	move	$5,$23
	jal	l1_cache_operate_on_line_range
	li	$6,64			# 0x40

	lw	$31,52($sp)
	lw	$fp,48($sp)
	lw	$23,44($sp)
	lw	$22,40($sp)
	lw	$21,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	move	$2,$0
	j	$31
	addiu	$sp,$sp,56

	.set	macro
	.set	reorder
	.end	main
	.globl	noncacheable
	.data
	.align	2
	.type	noncacheable, @object
	.size	noncacheable, 4
noncacheable:
	.word	2048

	.comm	data,64,4
	.ident	"GCC: (GNU) 4.1.2"
