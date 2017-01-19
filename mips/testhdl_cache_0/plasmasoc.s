	.file	1 "plasmasoc.c"
	.section .mdebug.abi32
	.previous
	.text
	.align	2
	.ent	l1_cache_find_range
	.type	l1_cache_find_range, @function
l1_cache_find_range:
	.frame	$fp,32,$31		# vars= 24, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-32
	sw	$fp,24($sp)
	move	$fp,$sp
	sw	$4,32($fp)
	sw	$5,36($fp)
	sw	$6,40($fp)
	sw	$7,44($fp)
	li	$2,32			# 0x20
	sw	$2,8($fp)
	lw	$3,32($fp)
	lw	$2,36($fp)
	nop
	addu	$2,$3,$2
	sw	$2,4($fp)
	lw	$3,4($fp)
	li	$2,-32			# 0xffffffffffffffe0
	and	$2,$3,$2
	sw	$2,0($fp)
	lw	$3,32($fp)
	li	$2,-32			# 0xffffffffffffffe0
	and	$3,$3,$2
	lw	$2,40($fp)
	nop
	sw	$3,0($2)
	lw	$3,0($fp)
	lw	$2,8($fp)
	nop
	addu	$3,$3,$2
	lw	$2,44($fp)
	nop
	sw	$3,0($2)
	lw	$2,44($fp)
	nop
	lw	$2,0($2)
	nop
	sw	$2,20($fp)
	lw	$3,4($fp)
	lw	$2,0($fp)
	nop
	sltu	$2,$2,$3
	beq	$2,$0,$L2
	nop

	lw	$2,8($fp)
	nop
	sw	$2,16($fp)
	j	$L4
	nop

$L2:
	sw	$0,16($fp)
$L4:
	lw	$4,20($fp)
	lw	$2,16($fp)
	nop
	addu	$3,$4,$2
	lw	$2,44($fp)
	nop
	sw	$3,0($2)
	move	$sp,$fp
	lw	$fp,24($sp)
	addiu	$sp,$sp,32
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	l1_cache_find_range
	.align	2
	.globl	l1_cache_operate_on_line_range
	.ent	l1_cache_operate_on_line_range
	.type	l1_cache_operate_on_line_range, @function
l1_cache_operate_on_line_range:
	.frame	$fp,40,$31		# vars= 16, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-40
	sw	$31,36($sp)
	sw	$fp,32($sp)
	move	$fp,$sp
	sw	$4,40($fp)
	sw	$5,44($fp)
	sw	$6,48($fp)
	li	$2,32			# 0x20
	sw	$2,16($fp)
	lw	$2,48($fp)
	nop
	beq	$2,$0,$L11
	nop

	addiu	$2,$fp,20
	addiu	$3,$fp,24
	lw	$4,44($fp)
	lw	$5,48($fp)
	move	$6,$2
	move	$7,$3
	jal	l1_cache_find_range
	nop

	j	$L9
	nop

$L10:
	lw	$2,20($fp)
	lw	$3,40($fp)
	move	$4,$2
	jal	$3
	nop

	lw	$3,20($fp)
	lw	$2,16($fp)
	nop
	addu	$2,$3,$2
	sw	$2,20($fp)
$L9:
	lw	$3,20($fp)
	lw	$2,24($fp)
	nop
	bne	$3,$2,$L10
	nop

$L11:
	move	$sp,$fp
	lw	$31,36($sp)
	lw	$fp,32($sp)
	addiu	$sp,$sp,40
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	l1_cache_operate_on_line_range
	.ident	"GCC: (GNU) 4.1.2"
