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
	li	$2,-16			# 0xfffffffffffffff0
	li	$3,268435456			# 0x10000000
	and	$4,$4,$2
	ori	$3,$3,0x4
#APP
	sw $0, 0($3)
sw $0, 0($4)

#NO_APP
	j	$31
	.end	l1_cache_flush
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
	sw	$17,20($sp)
	lui	$17,%hi(data)
	sw	$16,16($sp)
	li	$2,30			# 0x1e
	addiu	$16,$17,%lo(data)
	li	$3,35			# 0x23
	sw	$2,%lo(data)($17)
	sw	$3,4($16)
	li	$2,40			# 0x28
	li	$3,45			# 0x2d
	sw	$2,8($16)
	sw	$3,12($16)
	li	$2,50			# 0x32
	li	$3,55			# 0x37
	sw	$2,16($16)
	sw	$3,20($16)
	li	$2,60			# 0x3c
	li	$3,65			# 0x41
	sw	$2,24($16)
	sw	$3,28($16)
	li	$2,70			# 0x46
	li	$3,75			# 0x4b
	sw	$2,32($16)
	sw	$3,36($16)
	li	$2,80			# 0x50
	li	$3,85			# 0x55
	sw	$2,40($16)
	lui	$4,%hi(l1_cache_flush)
	sw	$3,44($16)
	li	$2,90			# 0x5a
	li	$3,95			# 0x5f
	sw	$2,48($16)
	move	$5,$16
	sw	$3,52($16)
	li	$2,100			# 0x64
	li	$3,105			# 0x69
	addiu	$4,$4,%lo(l1_cache_flush)
	li	$6,16			# 0x10
	sw	$2,56($16)
	sw	$31,24($sp)
	sw	$3,60($16)
	jal	l1_cache_operate_on_line_range
	nop

	lui	$4,%hi(l1_cache_invalidate)
	move	$5,$16
	addiu	$4,$4,%lo(l1_cache_invalidate)
	li	$6,16			# 0x10
	sw	$0,%lo(data)($17)
	sw	$0,4($16)
	sw	$0,8($16)
	sw	$0,12($16)
	jal	l1_cache_operate_on_line_range
	nop

	lw	$7,%lo(data)($17)
	lui	$3,%hi(data2)
	lw	$4,4($16)
	lw	$5,8($16)
	lw	$6,12($16)
	addiu	$2,$3,%lo(data2)
	sw	$7,%lo(data2)($3)
	sw	$4,4($2)
	sw	$5,8($2)
	sw	$6,12($2)
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	move	$2,$0
	j	$31
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	main
	.align	2
	.ent	l1_cache_invalidate
	.type	l1_cache_invalidate, @function
l1_cache_invalidate:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,-16			# 0xfffffffffffffff0
	and	$4,$4,$2
	li	$3,268435456			# 0x10000000
#APP
	sw $0, 0($3)
sw $0, 0($4)

#NO_APP
	j	$31
	.end	l1_cache_invalidate

	.comm	data,64,4

	.comm	data2,64,4
	.ident	"GCC: (GNU) 4.1.2"
