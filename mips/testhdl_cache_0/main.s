	.file	1 "main.c"
	.section .mdebug.abi32
	.previous
	.text
	.align	2
	.globl	main
	.ent	main
	.type	main, @function
main:
	.frame	$fp,56,$31		# vars= 32, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-56
	sw	$31,52($sp)
	sw	$fp,48($sp)
	move	$fp,$sp
	sw	$0,40($fp)
	j	$L2
	nop

$L3:
	lw	$3,40($fp)
	lw	$2,40($fp)
	nop
	sll	$2,$2,1
	move	$4,$2
	lui	$2,%hi(data)
	sll	$3,$3,2
	addiu	$2,$2,%lo(data)
	addu	$2,$3,$2
	sw	$4,0($2)
	lw	$2,40($fp)
	nop
	addiu	$2,$2,1
	sw	$2,40($fp)
$L2:
	lw	$2,40($fp)
	nop
	slt	$2,$2,16
	bne	$2,$0,$L3
	nop

	lui	$2,%hi(data)
	addiu	$2,$2,%lo(data)
	sw	$2,32($fp)
	li	$2,64			# 0x40
	sw	$2,36($fp)
	lui	$2,%hi(l1_cache_flush)
	addiu	$4,$2,%lo(l1_cache_flush)
	lw	$5,32($fp)
	lw	$6,36($fp)
	jal	l1_cache_operate_on_line_range
	nop

	lui	$2,%hi(data)
	addiu	$2,$2,%lo(data)
	sw	$2,24($fp)
	li	$2,64			# 0x40
	sw	$2,28($fp)
	lui	$2,%hi(l1_cache_invalidate)
	addiu	$4,$2,%lo(l1_cache_invalidate)
	lw	$5,24($fp)
	lw	$6,28($fp)
	jal	l1_cache_operate_on_line_range
	nop

	lui	$2,%hi(data)
	addiu	$4,$2,%lo(data)
	move	$5,$0
	li	$6,64			# 0x40
	jal	memset
	nop

	lui	$2,%hi(data)
	addiu	$2,$2,%lo(data)
	sw	$2,16($fp)
	li	$2,64			# 0x40
	sw	$2,20($fp)
	lui	$2,%hi(l1_cache_flush)
	addiu	$4,$2,%lo(l1_cache_flush)
	lw	$5,16($fp)
	lw	$6,20($fp)
	jal	l1_cache_operate_on_line_range
	nop

	move	$2,$0
	move	$sp,$fp
	lw	$31,52($sp)
	lw	$fp,48($sp)
	addiu	$sp,$sp,56
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	main
	.align	2
	.ent	l1_cache_invalidate
	.type	l1_cache_invalidate, @function
l1_cache_invalidate:
	.frame	$fp,16,$31		# vars= 8, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	addiu	$sp,$sp,-16
	sw	$fp,8($sp)
	move	$fp,$sp
	sw	$4,16($fp)
	sw	$0,0($fp)
	lw	$2,16($fp)
	#nop
	sw	$2,4($fp)
	lw	$3,0($fp)
	li	$2,268435456			# 0x10000000
	addu	$4,$3,$2
	lw	$3,4($fp)
	li	$2,-32			# 0xffffffffffffffe0
	and	$2,$3,$2
#APP
	sw $2, 0($4)
sw $0, 0($2)

#NO_APP
	move	$sp,$fp
	lw	$fp,8($sp)
	addiu	$sp,$sp,16
	j	$31
	.end	l1_cache_invalidate
	.align	2
	.ent	l1_cache_flush
	.type	l1_cache_flush, @function
l1_cache_flush:
	.frame	$fp,16,$31		# vars= 8, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	addiu	$sp,$sp,-16
	sw	$fp,8($sp)
	move	$fp,$sp
	sw	$4,16($fp)
	li	$2,4			# 0x4
	sw	$2,0($fp)
	lw	$2,16($fp)
	#nop
	sw	$2,4($fp)
	lw	$3,0($fp)
	li	$2,268435456			# 0x10000000
	addu	$4,$3,$2
	lw	$3,4($fp)
	li	$2,-32			# 0xffffffffffffffe0
	and	$2,$3,$2
#APP
	sw $2, 0($4)
sw $0, 0($2)

#NO_APP
	move	$sp,$fp
	lw	$fp,8($sp)
	addiu	$sp,$sp,16
	j	$31
	.end	l1_cache_flush

	.comm	data,64,4
	.ident	"GCC: (GNU) 4.1.2"
