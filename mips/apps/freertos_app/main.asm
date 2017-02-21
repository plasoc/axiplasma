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
	#nop
	lw	$2,4($2)
	#nop
	sw	$2,%gp_rel(input_value)($28)
	lw	$2,%gp_rel(gpio_obj)($28)
	li	$3,3			# 0x3
	sw	$3,0($2)
	jr	$31
	.end	gpio_isr
	.size	gpio_isr, .-gpio_isr
	.align	2
	.globl	taskmain
	.set	nomips16
	.set	nomicromips
	.ent	taskmain
	.type	taskmain, @function
taskmain:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
$L3:
	lw	$3,%gp_rel(input_value)($28)
	lw	$2,%gp_rel(gpio_obj)($28)
	nop
	sw	$3,8($2)
	b	$L3
	nop

	.set	macro
	.set	reorder
	.end	taskmain
	.size	taskmain, .-taskmain
	.align	2
	.globl	FreeRTOS_TickISR
	.set	nomips16
	.set	nomicromips
	.ent	FreeRTOS_TickISR
	.type	FreeRTOS_TickISR, @function
FreeRTOS_TickISR:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, gp= 0
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	jal	xTaskIncrementTick
	jal	vTaskSwitchContext
	lw	$31,20($sp)
	lw	$2,%gp_rel(timer_obj)($28)
	li	$3,7			# 0x7
	sw	$3,0($2)
	.set	noreorder
	.set	nomacro
	jr	$31
	addiu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	FreeRTOS_TickISR
	.size	FreeRTOS_TickISR, .-FreeRTOS_TickISR
	.align	2
	.globl	FreeRTOS_UserISR
	.set	nomips16
	.set	nomicromips
	.ent	FreeRTOS_UserISR
	.type	FreeRTOS_UserISR, @function
FreeRTOS_UserISR:
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
$L7:
	sll	$2,$2,3
	addu	$2,$17,$2
	lw	$3,0($2)
	lw	$4,4($2)
	jalr	$3
	nop

	lw	$2,%lo(int_obj)($16)
	nop
	lw	$2,4($2)
	nop
	sltu	$3,$2,8
	bne	$3,$0,$L7
	nop

	lw	$31,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	jr	$31
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	FreeRTOS_UserISR
	.size	FreeRTOS_UserISR, .-FreeRTOS_UserISR
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
$LC0:
	.ascii	"taskmain\000"
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.set	nomips16
	.set	nomicromips
	.ent	main
	.type	main, @function
main:
	.frame	$sp,32,$31		# vars= 0, regs= 1/0, args= 24, gp= 0
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	li	$2,1151336448			# 0x44a00000
	lui	$3,%hi(int_obj)
	addiu	$sp,$sp,-32
	sw	$2,%lo(int_obj)($3)
	lui	$4,%hi(int_obj+68)
	lui	$2,%hi(int_obj+4)
	addiu	$2,$2,%lo(int_obj+4)
	sw	$31,28($sp)
	addiu	$4,$4,%lo(int_obj+68)
$L11:
	addiu	$2,$2,8
	.set	noreorder
	.set	nomacro
	bne	$2,$4,$L11
	sw	$0,-8($2)
	.set	macro
	.set	reorder

	li	$2,1151467520			# 0x44a20000
	lui	$4,%hi(gpio_isr)
	sw	$2,%gp_rel(gpio_obj)($28)
	addiu	$4,$4,%lo(gpio_isr)
	addiu	$2,$3,%lo(int_obj)
	sw	$4,12($2)
	li	$5,50000			# 0xc350
	li	$4,1151401984			# 0x44a10000
	sw	$4,%gp_rel(timer_obj)($28)
	sw	$0,16($2)
	sw	$5,4($4)
	lui	$4,%hi(FreeRTOS_TickISR)
	addiu	$4,$4,%lo(FreeRTOS_TickISR)
	sw	$4,4($2)
	sw	$0,8($2)
	lw	$2,%lo(int_obj)($3)
	li	$3,255			# 0xff
	sw	$3,0($2)
	lw	$2,%gp_rel(timer_obj)($28)
	li	$3,3			# 0x3
	sw	$3,0($2)
	lw	$2,%gp_rel(gpio_obj)($28)
	li	$3,1			# 0x1
	lui	$5,%hi($LC0)
	lui	$4,%hi(taskmain)
	sw	$3,0($2)
	move	$7,$0
	sw	$0,20($sp)
	sw	$0,16($sp)
	li	$6,128			# 0x80
	addiu	$5,$5,%lo($LC0)
	.set	noreorder
	.set	nomacro
	jal	xTaskCreate
	addiu	$4,$4,%lo(taskmain)
	.set	macro
	.set	reorder

	jal	vTaskStartScheduler
	lw	$31,28($sp)
	move	$2,$0
	.set	noreorder
	.set	nomacro
	jr	$31
	addiu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	main
	.size	main, .-main
	.text
	.align	2
	.globl	vAssertCalled
	.set	nomips16
	.set	nomicromips
	.ent	vAssertCalled
	.type	vAssertCalled, @function
vAssertCalled:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	bne	$5,$0,$L17
	nop

	lw	$2,%gp_rel(gpio_obj)($28)
	li	$3,65535			# 0xffff
	sw	$3,8($2)
$L16:
	b	$L16
	nop

$L17:
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	vAssertCalled
	.size	vAssertCalled, .-vAssertCalled
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
