	.file	1 "main.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=32
	.module	nooddspreg

	.comm	int_obj,68,4

	.comm	timer_obj,4,4

	.comm	gpio_obj,4,4

	.comm	input_value,4,4
	.globl	update_flag
	.section	.sdata,"aw",@progbits
	.align	2
	.type	update_flag, @object
	.size	update_flag, 4
update_flag:
	.word	1
	.globl	led_state
	.section	.sbss,"aw",@nobits
	.align	2
	.type	led_state, @object
	.size	led_state, 4
led_state:
	.space	4
	.text
	.align	2
	.globl	OS_InterruptServiceRoutine
	.set	nomips16
	.set	nomicromips
	.ent	OS_InterruptServiceRoutine
	.type	OS_InterruptServiceRoutine, @function
OS_InterruptServiceRoutine:
	.frame	$fp,48,$31		# vars= 24, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-48
	sw	$31,44($sp)
	sw	$fp,40($sp)
	move	$fp,$sp
	lui	$2,%hi(int_obj)
	addiu	$2,$2,%lo(int_obj)
	sw	$2,16($fp)
	lw	$2,16($fp)
	nop
	addiu	$2,$2,4
	sw	$2,20($fp)
	lw	$2,16($fp)
	nop
	sw	$2,24($fp)
	lw	$2,24($fp)
	nop
	lw	$2,0($2)
	nop
	addiu	$2,$2,4
	lw	$2,0($2)
	nop
	sw	$2,28($fp)
$L4:
	lw	$2,28($fp)
	nop
	sll	$2,$2,3
	lw	$3,20($fp)
	nop
	addu	$2,$3,$2
	sw	$2,32($fp)
	lw	$2,32($fp)
	nop
	lw	$2,0($2)
	lw	$3,32($fp)
	nop
	lw	$3,4($3)
	nop
	move	$4,$3
	jalr	$2
	nop

	lw	$2,16($fp)
	nop
	sw	$2,36($fp)
	lw	$2,36($fp)
	nop
	lw	$2,0($2)
	nop
	addiu	$2,$2,4
	lw	$2,0($2)
	nop
	sw	$2,28($fp)
	lw	$2,28($fp)
	nop
	sltu	$2,$2,8
	bne	$2,$0,$L4
	nop

	nop
	move	$sp,$fp
	lw	$31,44($sp)
	lw	$fp,40($sp)
	addiu	$sp,$sp,48
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	OS_InterruptServiceRoutine
	.size	OS_InterruptServiceRoutine, .-OS_InterruptServiceRoutine
	.align	2
	.globl	timer_isr
	.set	nomips16
	.set	nomicromips
	.ent	timer_isr
	.type	timer_isr, @function
timer_isr:
	.frame	$fp,16,$31		# vars= 8, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	addiu	$sp,$sp,-16
	sw	$fp,12($sp)
	move	$fp,$sp
	sw	$4,16($fp)
	lw	$2,%gp_rel(led_state)($28)
	#nop
	sltu	$2,$2,1
	andi	$2,$2,0x00ff
	sw	$2,%gp_rel(led_state)($28)
	li	$2,1			# 0x1
	sw	$2,%gp_rel(update_flag)($28)
	addiu	$2,$28,%gp_rel(timer_obj)
	sw	$2,0($fp)
	li	$2,1			# 0x1
	sw	$2,4($fp)
	lw	$2,0($fp)
	#nop
	lw	$2,0($2)
	#nop
	move	$3,$2
	lw	$2,4($fp)
	#nop
	beq	$2,$0,$L6
	li	$2,7			# 0x7
	b	$L7
$L6:
	li	$2,3			# 0x3
$L7:
	sw	$2,0($3)
	.set	noreorder
	nop
	.set	reorder
	move	$sp,$fp
	lw	$fp,12($sp)
	addiu	$sp,$sp,16
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
	.frame	$fp,24,$31		# vars= 16, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	addiu	$sp,$sp,-24
	sw	$fp,20($sp)
	move	$fp,$sp
	sw	$4,24($fp)
	addiu	$2,$28,%gp_rel(gpio_obj)
	sw	$2,8($fp)
	lw	$2,8($fp)
	#nop
	lw	$2,0($2)
	#nop
	addiu	$2,$2,4
	lw	$2,0($2)
	#nop
	sw	$2,%gp_rel(input_value)($28)
	li	$2,1			# 0x1
	sw	$2,%gp_rel(led_state)($28)
	li	$2,1			# 0x1
	sw	$2,%gp_rel(update_flag)($28)
	addiu	$2,$28,%gp_rel(gpio_obj)
	sw	$2,0($fp)
	li	$2,1			# 0x1
	sw	$2,4($fp)
	lw	$2,0($fp)
	#nop
	lw	$2,0($2)
	#nop
	move	$3,$2
	lw	$2,4($fp)
	#nop
	beq	$2,$0,$L10
	li	$2,3			# 0x3
	b	$L11
$L10:
	li	$2,1			# 0x1
$L11:
	sw	$2,0($3)
	.set	noreorder
	nop
	.set	reorder
	move	$sp,$fp
	lw	$fp,20($sp)
	addiu	$sp,$sp,24
	jr	$31
	.end	gpio_isr
	.size	gpio_isr, .-gpio_isr
	.align	2
	.globl	main
	.set	nomips16
	.set	nomicromips
	.ent	main
	.type	main, @function
main:
	.frame	$fp,144,$31		# vars= 120, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	addiu	$sp,$sp,-144
	sw	$31,140($sp)
	sw	$fp,136($sp)
	move	$fp,$sp
	lui	$2,%hi(int_obj)
	addiu	$2,$2,%lo(int_obj)
	sw	$2,100($fp)
	li	$2,1151336448			# 0x44a00000
	sw	$2,104($fp)
	lw	$2,100($fp)
	lw	$3,104($fp)
	#nop
	sw	$3,0($2)
	lw	$2,100($fp)
	#nop
	addiu	$2,$2,4
	sw	$2,108($fp)
	lw	$2,108($fp)
	#nop
	addiu	$2,$2,64
	sw	$2,112($fp)
	b	$L13
$L14:
	lw	$2,108($fp)
	#nop
	addiu	$3,$2,8
	sw	$3,108($fp)
	sw	$0,0($2)
$L13:
	lw	$3,112($fp)
	lw	$2,108($fp)
	#nop
	bne	$3,$2,$L14
	addiu	$2,$28,%gp_rel(gpio_obj)
	sw	$2,92($fp)
	li	$2,1151467520			# 0x44a20000
	sw	$2,96($fp)
	lw	$2,92($fp)
	lw	$3,96($fp)
	#nop
	sw	$3,0($2)
	lui	$2,%hi(int_obj)
	addiu	$2,$2,%lo(int_obj)
	sw	$2,72($fp)
	li	$2,1			# 0x1
	sw	$2,76($fp)
	lui	$2,%hi(gpio_isr)
	addiu	$2,$2,%lo(gpio_isr)
	sw	$2,80($fp)
	sw	$0,84($fp)
	lw	$2,72($fp)
	#nop
	addiu	$3,$2,4
	lw	$2,76($fp)
	#nop
	sll	$2,$2,3
	addu	$2,$3,$2
	sw	$2,88($fp)
	lw	$2,88($fp)
	lw	$3,80($fp)
	#nop
	sw	$3,0($2)
	lw	$2,88($fp)
	lw	$3,84($fp)
	#nop
	sw	$3,4($2)
	addiu	$2,$28,%gp_rel(timer_obj)
	sw	$2,64($fp)
	li	$2,1151401984			# 0x44a10000
	sw	$2,68($fp)
	lw	$2,64($fp)
	lw	$3,68($fp)
	#nop
	sw	$3,0($2)
	addiu	$2,$28,%gp_rel(timer_obj)
	sw	$2,56($fp)
	li	$2,24969216			# 0x17d0000
	ori	$2,$2,0x7840
	sw	$2,60($fp)
	lw	$2,56($fp)
	#nop
	lw	$2,0($2)
	#nop
	addiu	$2,$2,4
	move	$3,$2
	lw	$2,60($fp)
	#nop
	sw	$2,0($3)
	lui	$2,%hi(int_obj)
	addiu	$2,$2,%lo(int_obj)
	sw	$2,36($fp)
	sw	$0,40($fp)
	lui	$2,%hi(timer_isr)
	addiu	$2,$2,%lo(timer_isr)
	sw	$2,44($fp)
	sw	$0,48($fp)
	lw	$2,36($fp)
	#nop
	addiu	$3,$2,4
	lw	$2,40($fp)
	#nop
	sll	$2,$2,3
	addu	$2,$3,$2
	sw	$2,52($fp)
	lw	$2,52($fp)
	lw	$3,44($fp)
	#nop
	sw	$3,0($2)
	lw	$2,52($fp)
	lw	$3,48($fp)
	#nop
	sw	$3,4($2)
	li	$4,1			# 0x1
	jal	OS_AsmInterruptEnable
	lui	$2,%hi(int_obj)
	addiu	$2,$2,%lo(int_obj)
	sw	$2,32($fp)
	lw	$2,32($fp)
	#nop
	lw	$2,0($2)
	#nop
	move	$3,$2
	li	$2,255			# 0xff
	sw	$2,0($3)
	addiu	$2,$28,%gp_rel(timer_obj)
	sw	$2,24($fp)
	sw	$0,28($fp)
	lw	$2,24($fp)
	#nop
	lw	$2,0($2)
	#nop
	move	$3,$2
	lw	$2,28($fp)
	#nop
	beq	$2,$0,$L15
	li	$2,7			# 0x7
	b	$L16
$L15:
	li	$2,3			# 0x3
$L16:
	sw	$2,0($3)
	addiu	$2,$28,%gp_rel(gpio_obj)
	sw	$2,16($fp)
	sw	$0,20($fp)
	lw	$2,16($fp)
	#nop
	lw	$2,0($2)
	#nop
	move	$3,$2
	lw	$2,20($fp)
	#nop
	beq	$2,$0,$L17
	li	$2,3			# 0x3
	b	$L18
$L17:
	li	$2,1			# 0x1
$L18:
	sw	$2,0($3)
$L20:
	lw	$2,%gp_rel(update_flag)($28)
	#nop
	beq	$2,$0,$L20
	lui	$2,%hi(int_obj)
	addiu	$2,$2,%lo(int_obj)
	sw	$2,128($fp)
	lw	$2,128($fp)
	#nop
	lw	$2,0($2)
	#nop
	sw	$0,0($2)
	sw	$0,%gp_rel(update_flag)($28)
	lw	$3,%gp_rel(input_value)($28)
	lw	$2,%gp_rel(led_state)($28)
	#nop
	mult	$3,$2
	addiu	$2,$28,%gp_rel(gpio_obj)
	sw	$2,120($fp)
	mflo	$2
	sw	$2,124($fp)
	lw	$2,120($fp)
	#nop
	lw	$2,0($2)
	#nop
	addiu	$2,$2,8
	move	$3,$2
	lw	$2,124($fp)
	#nop
	sw	$2,0($3)
	lui	$2,%hi(int_obj)
	addiu	$2,$2,%lo(int_obj)
	sw	$2,116($fp)
	lw	$2,116($fp)
	#nop
	lw	$2,0($2)
	#nop
	move	$3,$2
	li	$2,255			# 0xff
	sw	$2,0($3)
	b	$L20
	.end	main
	.size	main, .-main
	.ident	"GCC: (GNU) 6.3.0"
