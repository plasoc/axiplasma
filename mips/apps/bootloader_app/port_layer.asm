	.file	1 "port_layer.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=32
	.module	nooddspreg
	.text
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
	lw	$4,4($2)
	lw	$2,%gp_rel(uart_in_ptr)($28)
	lw	$3,%gp_rel(uart_out_ptr)($28)
	addiu	$2,$2,1
	andi	$2,$2,0x1ff
	beq	$2,$3,$L3
	nop

	lw	$3,%gp_rel(uart_in_ptr)($28)
	lui	$5,%hi(uart_fifo)
	addiu	$5,$5,%lo(uart_fifo)
	andi	$4,$4,0x00ff
	addu	$3,$3,$5
	sb	$4,0($3)
	sw	$2,%gp_rel(uart_in_ptr)($28)
$L3:
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	uart_isr
	.size	uart_isr, .-uart_isr
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
$L8:
	bne	$3,$0,$L6
	nop

	lw	$31,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	jr	$31
	addiu	$sp,$sp,32

$L6:
	sll	$2,$2,3
	addu	$2,$17,$2
	lw	$3,0($2)
	lw	$4,4($2)
	jalr	$3
	nop

	lw	$2,%lo(int_obj)($16)
	nop
	lw	$2,4($2)
	b	$L8
	sltu	$3,$2,8

	.set	macro
	.set	reorder
	.end	OS_InterruptServiceRoutine
	.size	OS_InterruptServiceRoutine, .-OS_InterruptServiceRoutine
	.align	2
	.globl	initialize
	.set	nomips16
	.set	nomicromips
	.ent	initialize
	.type	initialize, @function
initialize:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	addiu	$sp,$sp,-24
	li	$2,1151336448			# 0x44a00000
	lui	$3,%hi(int_obj)
	sw	$2,%lo(int_obj)($3)
	sw	$16,16($sp)
	lui	$2,%hi(int_obj+4)
	move	$16,$4
	lui	$4,%hi(int_obj+68)
	sw	$31,20($sp)
	addiu	$2,$2,%lo(int_obj+4)
	addiu	$4,$4,%lo(int_obj+68)
$L10:
	addiu	$2,$2,8
	.set	noreorder
	.set	nomacro
	bne	$2,$4,$L10
	sw	$0,-8($2)
	.set	macro
	.set	reorder

	li	$2,1151598592			# 0x44a40000
	sw	$2,%gp_rel(uart_obj)($28)
	lui	$2,%hi(uart_isr)
	addiu	$4,$3,%lo(int_obj)
	addiu	$2,$2,%lo(uart_isr)
	sw	$2,28($4)
	sw	$0,32($4)
	lw	$3,%lo(int_obj)($3)
	li	$4,1			# 0x1
	lw	$2,0($3)
	#nop
	ori	$2,$2,0x8
	sw	$2,0($3)
	jal	OS_AsmInterruptEnable
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L9
	move	$25,$16
	.set	macro
	.set	reorder

	lw	$31,20($sp)
	lw	$16,16($sp)
	.set	noreorder
	.set	nomacro
	jr	$25
	addiu	$sp,$sp,24
	.set	macro
	.set	reorder

$L9:
	lw	$31,20($sp)
	lw	$16,16($sp)
	.set	noreorder
	.set	nomacro
	jr	$31
	addiu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	initialize
	.size	initialize, .-initialize
	.align	2
	.globl	cleanup
	.set	nomips16
	.set	nomicromips
	.ent	cleanup
	.type	cleanup, @function
cleanup:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, gp= 0
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	OS_AsmInterruptEnable
	move	$4,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(int_obj)
	lw	$3,%lo(int_obj)($2)
	lw	$31,20($sp)
	lw	$2,0($3)
	li	$4,-9			# 0xfffffffffffffff7
	and	$2,$2,$4
	sw	$2,0($3)
	.set	noreorder
	.set	nomacro
	jr	$31
	addiu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	cleanup
	.size	cleanup, .-cleanup
	.align	2
	.globl	setbyte
	.set	nomips16
	.set	nomicromips
	.ent	setbyte
	.type	setbyte, @function
setbyte:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lw	$3,%gp_rel(uart_obj)($28)
	nop
$L17:
	lw	$2,0($3)
	nop
	andi	$2,$2,0x2
	beq	$2,$0,$L17
	nop

	sw	$4,8($3)
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	setbyte
	.size	setbyte, .-setbyte
	.align	2
	.globl	getbyte
	.set	nomips16
	.set	nomicromips
	.ent	getbyte
	.type	getbyte, @function
getbyte:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	sw	$16,16($sp)
$L22:
	jal	OS_AsmInterruptEnable
	move	$4,$0

	lw	$3,%gp_rel(uart_in_ptr)($28)
	lw	$2,%gp_rel(uart_out_ptr)($28)
	nop
	bne	$3,$2,$L24
	nop

	jal	OS_AsmInterruptEnable
	li	$4,1			# 0x1

	b	$L22
	nop

$L24:
	lw	$2,%gp_rel(uart_out_ptr)($28)
	lui	$3,%hi(uart_fifo)
	addiu	$3,$3,%lo(uart_fifo)
	addu	$2,$2,$3
	lbu	$16,0($2)
	lw	$2,%gp_rel(uart_out_ptr)($28)
	li	$4,1			# 0x1
	addiu	$2,$2,1
	andi	$2,$2,0x1ff
	sw	$2,%gp_rel(uart_out_ptr)($28)
	jal	OS_AsmInterruptEnable
	andi	$16,$16,0x00ff

	lw	$31,20($sp)
	move	$2,$16
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,24

	.set	macro
	.set	reorder
	.end	getbyte
	.size	getbyte, .-getbyte
	.align	2
	.globl	setword
	.set	nomips16
	.set	nomicromips
	.ent	setword
	.type	setword, @function
setword:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, gp= 0
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	move	$6,$4
	li	$5,4			# 0x4
	sw	$31,20($sp)
$L27:
	jal	setbyte
	andi	$4,$6,0x00ff

	addiu	$5,$5,-1
	bne	$5,$0,$L27
	srl	$6,$6,8

	lw	$31,20($sp)
	nop
	jr	$31
	addiu	$sp,$sp,24

	.set	macro
	.set	reorder
	.end	setword
	.size	setword, .-setword
	.align	2
	.globl	getword
	.set	nomips16
	.set	nomicromips
	.ent	getword
	.type	getword, @function
getword:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, gp= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	sw	$31,28($sp)
	move	$16,$0
	move	$17,$0
	li	$18,32			# 0x20
$L31:
	jal	getbyte
	nop

	sll	$2,$2,$16
	addiu	$16,$16,8
	bne	$16,$18,$L31
	or	$17,$17,$2

	lw	$31,28($sp)
	move	$2,$17
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	getword
	.size	getword, .-getword
	.globl	uart_out_ptr
	.section	.sbss,"aw",@nobits
	.align	2
	.type	uart_out_ptr, @object
	.size	uart_out_ptr, 4
uart_out_ptr:
	.space	4
	.globl	uart_in_ptr
	.align	2
	.type	uart_in_ptr, @object
	.size	uart_in_ptr, 4
uart_in_ptr:
	.space	4

	.comm	uart_fifo,512,4

	.comm	uart_obj,4,4

	.comm	int_obj,68,4
	.ident	"GCC: (GNU) 6.3.0"
