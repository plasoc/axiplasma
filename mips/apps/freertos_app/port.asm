	.file	1 "port.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=32
	.module	nooddspreg
	.text
	.align	2
	.globl	OS_InterruptServiceRoutine
	.set	nomips16
	.set	nomicromips
	.ent	OS_InterruptServiceRoutine
	.type	OS_InterruptServiceRoutine, @function
OS_InterruptServiceRoutine:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	OS_InterruptServiceRoutine
	.size	OS_InterruptServiceRoutine, .-OS_InterruptServiceRoutine
	.align	2
	.globl	xPortStartScheduler
	.set	nomips16
	.set	nomicromips
	.ent	xPortStartScheduler
	.type	xPortStartScheduler, @function
xPortStartScheduler:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, gp= 0
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	jal	FreeRTOS_AsmInterruptInit
	nop

	jal	vPortStartFirstTask
	nop

	jal	OS_AsmInterruptEnable
	move	$4,$0

$L3:
	b	$L3
	nop

	.set	macro
	.set	reorder
	.end	xPortStartScheduler
	.size	xPortStartScheduler, .-xPortStartScheduler
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
$LC0:
	.ascii	"../../freertos/port.c\000"
	.text
	.align	2
	.globl	vPortEndScheduler
	.set	nomips16
	.set	nomicromips
	.ent	vPortEndScheduler
	.type	vPortEndScheduler, @function
vPortEndScheduler:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lui	$4,%hi($LC0)
	li	$5,105			# 0x69
	j	vAssertCalled
	addiu	$4,$4,%lo($LC0)

	.set	macro
	.set	reorder
	.end	vPortEndScheduler
	.size	vPortEndScheduler, .-vPortEndScheduler
	.ident	"GCC: (GNU) 6.3.0"
