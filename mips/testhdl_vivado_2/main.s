	.file	1 "main.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=32
	.module	nooddspreg
	.text
	.align	2
	.globl	input_gpio_isr
	.set	nomips16
	.set	nomicromips
	.ent	input_gpio_isr
	.type	input_gpio_isr, @function
input_gpio_isr:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	sll	$4,$4,2
	addiu	$2,$28,%gp_rel(xgpio_input_obj)
	addu	$2,$2,$4
	lw	$5,0($2)
	li	$3,1			# 0x1
	sw	$3,288($5)
	lw	$2,0($2)
	nop
	lw	$5,0($2)
	addiu	$2,$28,%gp_rel(input_values)
	addu	$4,$2,$4
	sw	$5,0($4)
	sw	$3,%gp_rel(update_flag)($28)
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	input_gpio_isr
	.size	input_gpio_isr, .-input_gpio_isr
	.align	2
	.globl	OS_InterruptServiceRoutine
	.set	nomips16
	.set	nomicromips
	.ent	OS_InterruptServiceRoutine
	.type	OS_InterruptServiceRoutine, @function
OS_InterruptServiceRoutine:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, gp= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$18,24($sp)
	lui	$18,%hi(int_obj)
	lw	$2,%lo(int_obj)($18)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lui	$17,%hi(int_obj+36)
	lui	$16,%hi(int_obj+4)
	lw	$2,4($2)
	sw	$31,28($sp)
	addiu	$17,$17,%lo(int_obj+36)
	addiu	$16,$16,%lo(int_obj+4)
$L3:
	sll	$2,$2,2
	addu	$3,$17,$2
	addu	$2,$16,$2
	lw	$2,0($2)
	lw	$4,0($3)
	jalr	$2
	nop

	lw	$2,%lo(int_obj)($18)
	nop
	lw	$2,4($2)
	nop
	sltu	$3,$2,8
	bne	$3,$0,$L3
	nop

	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,32

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
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	li	$4,1073741824			# 0x40000000
	sw	$4,%gp_rel(xgpio_input_obj)($28)
	lui	$3,%hi(int_obj)
	li	$4,1151336448			# 0x44a00000
	sw	$4,%lo(int_obj)($3)
	li	$2,1073807360			# 0x40010000
	lui	$4,%hi(int_obj+4)
	sw	$2,%gp_rel(xgpio_output_obj)($28)
	sw	$0,4($2)
	addiu	$2,$4,%lo(int_obj+4)
	sw	$0,%lo(int_obj+4)($4)
	li	$5,983040			# 0xf0000
	sw	$0,4($2)
	sw	$0,8($2)
	sw	$0,12($2)
	sw	$0,16($2)
	sw	$0,20($2)
	sw	$0,24($2)
	sw	$0,28($2)
	lw	$2,%gp_rel(xgpio_input_obj)($28)
	ori	$5,$5,0xffff
	li	$6,1073872896			# 0x40020000
	sw	$6,%gp_rel(xgpio_input_obj+4)($28)
	sw	$5,4($2)
	lw	$2,%gp_rel(xgpio_input_obj)($28)
	li	$6,-2147483648			# 0xffffffff80000000
	sw	$6,284($2)
	lw	$7,%gp_rel(xgpio_input_obj)($28)
	addiu	$2,$3,%lo(int_obj)
	lw	$4,296($7)
	nop
	ori	$4,$4,0x1
	sw	$4,296($7)
	lw	$4,%gp_rel(xgpio_input_obj)($28)
	nop
	lw	$7,0($4)
	lui	$4,%hi(input_gpio_isr)
	sw	$7,%gp_rel(input_values)($28)
	lw	$7,%gp_rel(xgpio_input_obj+4)($28)
	addiu	$4,$4,%lo(input_gpio_isr)
	sw	$4,4($2)
	sw	$0,36($2)
	sw	$5,4($7)
	lw	$5,%gp_rel(xgpio_input_obj+4)($28)
	nop
	sw	$6,284($5)
	lw	$7,%gp_rel(xgpio_input_obj+4)($28)
	li	$5,255			# 0xff
	lw	$6,296($7)
	nop
	ori	$6,$6,0x1
	sw	$6,296($7)
	sw	$4,8($2)
	lw	$6,%gp_rel(xgpio_input_obj+4)($28)
	lw	$4,%lo(int_obj)($3)
	lw	$6,0($6)
	li	$7,1			# 0x1
	sw	$7,40($2)
	li	$2,255			# 0xff
	sw	$6,%gp_rel(input_values+4)($28)
	sw	$2,0($4)
$L8:
	lw	$2,%gp_rel(update_flag)($28)
	nop
	beq	$2,$0,$L8
	nop

	lw	$2,%lo(int_obj)($3)
	nop
	sw	$0,0($2)
	lw	$2,%lo(int_obj)($3)
	sw	$0,%gp_rel(update_flag)($28)
	sw	$5,0($2)
	lw	$2,%gp_rel(input_values+4)($28)
	lw	$4,%gp_rel(input_values)($28)
	sll	$2,$2,8
	or	$2,$2,$4
	lw	$4,%gp_rel(xgpio_output_obj)($28)
	nop
	sw	$2,0($4)
	b	$L8
	nop

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main
	.globl	update_flag
	.section	.sdata,"aw",@progbits
	.align	2
	.type	update_flag, @object
	.size	update_flag, 4
update_flag:
	.word	1

	.comm	input_values,8,4

	.comm	xgpio_output_obj,4,4

	.comm	xgpio_input_obj,8,4

	.comm	int_obj,68,4
	.ident	"GCC: (GNU) 6.3.0"
