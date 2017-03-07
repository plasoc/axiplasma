	.file	1 "main.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=32
	.module	nooddspreg
	.text
	.align	2
	.globl	timer_isr
	.set	nomips16
	.set	nomicromips
	.ent	timer_isr
	.type	timer_isr, @function
timer_isr:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,%gp_rel(led_state)($28)
	#nop
	sltu	$2,$2,1
	sw	$2,%gp_rel(led_state)($28)
	li	$2,1			# 0x1
	sw	$2,%gp_rel(update_flag)($28)
	lw	$2,%gp_rel(timer_obj)($28)
	li	$3,7			# 0x7
	sw	$3,0($2)
	jr	$31
	.end	timer_isr
	.size	timer_isr, .-timer_isr
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
	#nop
	lw	$2,4($2)
	#nop
	sw	$2,%gp_rel(input_value)($28)
	li	$2,1			# 0x1
	sw	$2,%gp_rel(led_state)($28)
	sw	$2,%gp_rel(update_flag)($28)
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
$L7:
	bne	$3,$0,$L5
	nop

	lw	$31,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	jr	$31
	addiu	$sp,$sp,32

$L5:
	sll	$2,$2,3
	addu	$2,$17,$2
	lw	$3,0($2)
	lw	$4,4($2)
	jalr	$3
	nop

	lw	$2,%lo(int_obj)($16)
	nop
	lw	$2,4($2)
	b	$L7
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
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, gp= 0
	.mask	0x80030000,-4
	.fmask	0x00000000,0
	addiu	$sp,$sp,-32
	li	$2,1151336448			# 0x44a00000
	sw	$16,20($sp)
	lui	$16,%hi(int_obj)
	sw	$2,%lo(int_obj)($16)
	lui	$3,%hi(int_obj+68)
	lui	$2,%hi(int_obj+4)
	sw	$31,28($sp)
	sw	$17,24($sp)
	addiu	$2,$2,%lo(int_obj+4)
	addiu	$3,$3,%lo(int_obj+68)
$L9:
	addiu	$2,$2,8
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L9
	sw	$0,-8($2)
	.set	macro
	.set	reorder

	lui	$3,%hi(gpio_isr)
	addiu	$2,$16,%lo(int_obj)
	addiu	$3,$3,%lo(gpio_isr)
	sw	$3,12($2)
	li	$3,24969216			# 0x17d0000
	li	$4,1151401984			# 0x44a10000
	li	$17,1151467520			# 0x44a20000
	addiu	$3,$3,30784
	sw	$4,%gp_rel(timer_obj)($28)
	sw	$17,%gp_rel(gpio_obj)($28)
	sw	$0,16($2)
	sw	$3,4($4)
	lui	$3,%hi(timer_isr)
	addiu	$3,$3,%lo(timer_isr)
	sw	$3,4($2)
	.set	noreorder
	.set	nomacro
	jal	OS_AsmInterruptInit
	sw	$0,8($2)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	OS_AsmInterruptEnable
	li	$4,1			# 0x1
	.set	macro
	.set	reorder

	lw	$2,%lo(int_obj)($16)
	li	$3,255			# 0xff
	sw	$3,0($2)
	lw	$2,%gp_rel(timer_obj)($28)
	li	$3,3			# 0x3
	sw	$3,0($2)
	lw	$3,%gp_rel(gpio_obj)($28)
	li	$2,1			# 0x1
	sw	$2,0($3)
	sw	$2,8($17)
	li	$3,255			# 0xff
$L10:
	lw	$2,%gp_rel(update_flag)($28)
	#nop
	beq	$2,$0,$L10
	lw	$2,%lo(int_obj)($16)
	#nop
	sw	$0,0($2)
	sw	$0,%gp_rel(update_flag)($28)
	lw	$2,%gp_rel(input_value)($28)
	lw	$4,%gp_rel(led_state)($28)
	#nop
	mult	$2,$4
	lw	$4,%gp_rel(gpio_obj)($28)
	mflo	$2
	sw	$2,8($4)
	lw	$2,%lo(int_obj)($16)
	#nop
	sw	$3,0($2)
	b	$L10
	.end	main
	.size	main, .-main
	.globl	led_state
	.section	.sbss,"aw",@nobits
	.align	2
	.type	led_state, @object
	.size	led_state, 4
led_state:
	.space	4
	.globl	update_flag
	.section	.sdata,"aw",@progbits
	.align	2
	.type	update_flag, @object
	.size	update_flag, 4
update_flag:
	.word	1

	.comm	input_value,4,4

	.comm	gpio_obj,4,4

	.comm	timer_obj,4,4

	.comm	int_obj,68,4
	.ident	"GCC: (GNU) 6.3.0"
