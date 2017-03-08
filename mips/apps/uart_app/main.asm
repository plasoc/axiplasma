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
	.globl	uart_isr
	.set	nomips16
	.set	nomicromips
	.ent	uart_isr
	.type	uart_isr, @function
uart_isr:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lw	$2,%gp_rel(uart_obj)($28)
	nop
	lw	$3,4($2)
	nop
	sw	$3,8($2)
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	uart_isr
	.size	uart_isr, .-uart_isr
	.align	2
	.globl	putc_port
	.set	nomips16
	.set	nomicromips
	.ent	putc_port
	.type	putc_port, @function
putc_port:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
$L4:
	lw	$3,%gp_rel(uart_obj)($28)
	nop
	lw	$2,0($3)
	nop
	andi	$2,$2,0x2
	beq	$2,$0,$L5
	nop

	jr	$31
	nop

$L5:
	sw	$5,8($3)
	b	$L4
	nop

	.set	macro
	.set	reorder
	.end	putc_port
	.size	putc_port, .-putc_port
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
$L10:
	bne	$3,$0,$L8
	nop

	lw	$31,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	jr	$31
	addiu	$sp,$sp,32

$L8:
	sll	$2,$2,3
	addu	$2,$17,$2
	lw	$3,0($2)
	lw	$4,4($2)
	jalr	$3
	nop

	lw	$2,%lo(int_obj)($16)
	nop
	lw	$2,4($2)
	b	$L10
	sltu	$3,$2,8

	.set	macro
	.set	reorder
	.end	OS_InterruptServiceRoutine
	.size	OS_InterruptServiceRoutine, .-OS_InterruptServiceRoutine
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
$LC0:
	.ascii	"Hello World!\012\015\000"
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
$L12:
	addiu	$2,$2,8
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L12
	sw	$0,-8($2)
	.set	macro
	.set	reorder

	li	$2,1151467520			# 0x44a20000
	sw	$2,%gp_rel(gpio_obj)($28)
	lui	$2,%hi(gpio_isr)
	addiu	$17,$16,%lo(int_obj)
	addiu	$2,$2,%lo(gpio_isr)
	lui	$5,%hi(putc_port)
	addiu	$5,$5,%lo(putc_port)
	sw	$2,12($17)
	move	$4,$0
	li	$2,1151598592			# 0x44a40000
	sw	$2,%gp_rel(uart_obj)($28)
	.set	noreorder
	.set	nomacro
	jal	init_printf
	sw	$0,16($17)
	.set	macro
	.set	reorder

	lui	$2,%hi(uart_isr)
	addiu	$2,$2,%lo(uart_isr)
	sw	$2,28($17)
	.set	noreorder
	.set	nomacro
	jal	OS_AsmInterruptInit
	sw	$0,32($17)
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
	lw	$3,%gp_rel(gpio_obj)($28)
	li	$2,1			# 0x1
	sw	$2,0($3)
	lw	$3,%gp_rel(gpio_obj)($28)
	lui	$4,%hi($LC0)
	sw	$2,8($3)
	.set	noreorder
	.set	nomacro
	jal	tfp_printf
	addiu	$4,$4,%lo($LC0)
	.set	macro
	.set	reorder

	lw	$31,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	move	$2,$0
	.set	noreorder
	.set	nomacro
	jr	$31
	addiu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	main
	.size	main, .-main

	.comm	uart_obj,4,4

	.comm	gpio_obj,4,4

	.comm	int_obj,68,4
	.ident	"GCC: (GNU) 6.3.0"
