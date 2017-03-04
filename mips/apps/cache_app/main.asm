	.file	1 "main.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=32
	.module	nooddspreg
	.text
	.align	2
	.globl	gpio_isr
	.set	nomips16
	.set	nomicromips
	.ent	gpio_isr
	.type	gpio_isr, @function
gpio_isr:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,%gp_rel(gpio_obj)($28)
	li	$3,3			# 0x3
	sw	$3,0($2)
	jr	$31
	.end	gpio_isr
	.size	gpio_isr, .-gpio_isr
	.align	2
	.globl	OS_InterruptServiceRoutine
	.set	nomips16
	.set	nomicromips
	.ent	OS_InterruptServiceRoutine
	.type	OS_InterruptServiceRoutine, @function
OS_InterruptServiceRoutine:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, gp= 0
	.mask	0x80030000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lui	$3,%hi(int_obj)
	lw	$2,%lo(int_obj)($3)
	addiu	$sp,$sp,-32
	lw	$2,4($2)
	sw	$17,24($sp)
	lui	$17,%hi(int_obj+4)
	sw	$16,20($sp)
	sw	$31,28($sp)
	move	$16,$3
	addiu	$17,$17,%lo(int_obj+4)
	sltu	$3,$2,8
$L6:
	bne	$3,$0,$L4
	nop

	lw	$31,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	jr	$31
	addiu	$sp,$sp,32

$L4:
	sll	$2,$2,3
	addu	$2,$17,$2
	lw	$3,0($2)
	lw	$4,4($2)
	jalr	$3
	nop

	lw	$2,%lo(int_obj)($16)
	nop
	lw	$2,4($2)
	b	$L6
	sltu	$3,$2,8

	.set	macro
	.set	reorder
	.end	OS_InterruptServiceRoutine
	.size	OS_InterruptServiceRoutine, .-OS_InterruptServiceRoutine
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
	addiu	$sp,$sp,-24
	li	$2,1151336448			# 0x44a00000
	sw	$16,16($sp)
	lui	$16,%hi(int_obj)
	sw	$2,%lo(int_obj)($16)
	lui	$3,%hi(int_obj+68)
	lui	$2,%hi(int_obj+4)
	sw	$31,20($sp)
	addiu	$2,$2,%lo(int_obj+4)
	addiu	$3,$3,%lo(int_obj+68)
$L8:
	addiu	$2,$2,8
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L8
	sw	$0,-8($2)
	.set	macro
	.set	reorder

	li	$2,1151467520			# 0x44a20000
	sw	$2,%gp_rel(gpio_obj)($28)
	lui	$2,%hi(gpio_isr)
	addiu	$3,$16,%lo(int_obj)
	addiu	$2,$2,%lo(gpio_isr)
	sw	$2,12($3)
	sw	$0,16($3)
	.set	noreorder
	.set	nomacro
	jal	OS_AsmInterruptEnable
	li	$4,1			# 0x1
	.set	macro
	.set	reorder

	lw	$2,%lo(int_obj)($16)
	li	$3,255			# 0xff
	sw	$3,0($2)
	lw	$3,%gp_rel(gpio_obj)($28)
	li	$2,1			# 0x1
	sw	$2,0($3)
	lw	$3,%gp_rel(gpio_obj)($28)
	li	$5,32			# 0x20
	sw	$2,8($3)
	lw	$3,%gp_rel(noncacheable)($28)
	move	$2,$0
$L9:
	lw	$4,0($3)
	addiu	$3,$3,4
	addu	$4,$4,$2
	addiu	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$5,$L9
	sw	$4,-4($3)
	.set	macro
	.set	reorder

	lui	$16,%hi(data)
	addiu	$16,$16,%lo(data)
	move	$3,$16
	move	$2,$0
	li	$4,32			# 0x20
$L10:
	sw	$2,0($3)
	addiu	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$4,$L10
	addiu	$3,$3,4
	.set	macro
	.set	reorder

	lw	$2,%gp_rel(gpio_obj)($28)
	li	$3,2			# 0x2
	sw	$3,8($2)
	li	$6,64			# 0x40
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	l1_cache_operate_on_line_range
	li	$4,4			# 0x4
	.set	macro
	.set	reorder

	lw	$2,%gp_rel(gpio_obj)($28)
	li	$3,3			# 0x3
	sw	$3,8($2)
	li	$6,64			# 0x40
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	l1_cache_operate_on_line_range
	move	$4,$0
	.set	macro
	.set	reorder

	lw	$2,%gp_rel(gpio_obj)($28)
	li	$3,4			# 0x4
	sw	$3,8($2)
	li	$6,64			# 0x40
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	memset
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$2,%gp_rel(gpio_obj)($28)
	li	$3,5			# 0x5
	sw	$3,8($2)
	li	$6,64			# 0x40
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	l1_cache_operate_on_line_range
	li	$4,4			# 0x4
	.set	macro
	.set	reorder

	lw	$2,%gp_rel(gpio_obj)($28)
	li	$3,6			# 0x6
	sw	$3,8($2)
$L11:
	b	$L11
	.end	main
	.size	main, .-main
	.globl	noncacheable
	.section	.sdata,"aw",@progbits
	.align	2
	.type	noncacheable, @object
	.size	noncacheable, 4
noncacheable:
	.word	32768

	.comm	data,64,4

	.comm	gpio_obj,4,4

	.comm	int_obj,68,4
	.ident	"GCC: (GNU) 6.3.0"
