	.file	1 "port_layer.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=32
	.module	nooddspreg

	.comm	int_obj,68,4

	.comm	uart_obj,4,4

	.comm	uart_fifo,512,4
	.globl	uart_in_ptr
	.section	.sbss,"aw",@nobits
	.align	2
	.type	uart_in_ptr, @object
	.size	uart_in_ptr, 4
uart_in_ptr:
	.space	4
	.globl	uart_out_ptr
	.align	2
	.type	uart_out_ptr, @object
	.size	uart_out_ptr, 4
uart_out_ptr:
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
	b	$L3
	nop

$L5:
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
$L3:
	lw	$2,28($fp)
	nop
	sltu	$2,$2,8
	bne	$2,$0,$L5
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
	.globl	uart_isr
	.set	nomips16
	.set	nomicromips
	.ent	uart_isr
	.type	uart_isr, @function
uart_isr:
	.frame	$fp,24,$31		# vars= 16, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$fp,20($sp)
	move	$fp,$sp
	sw	$4,24($fp)
	addiu	$2,$28,%gp_rel(uart_obj)
	sw	$2,8($fp)
	lw	$2,8($fp)
	nop
	lw	$2,0($2)
	nop
	addiu	$2,$2,4
	lw	$2,0($2)
	nop
	sw	$2,0($fp)
	lw	$2,%gp_rel(uart_in_ptr)($28)
	nop
	addiu	$2,$2,1
	andi	$2,$2,0x1ff
	sw	$2,4($fp)
	lw	$2,%gp_rel(uart_out_ptr)($28)
	lw	$3,4($fp)
	nop
	beq	$3,$2,$L9
	nop

	lw	$4,%gp_rel(uart_in_ptr)($28)
	lw	$2,0($fp)
	nop
	andi	$3,$2,0x00ff
	lui	$2,%hi(uart_fifo)
	addiu	$2,$2,%lo(uart_fifo)
	addu	$2,$4,$2
	sb	$3,0($2)
	lw	$2,4($fp)
	nop
	sw	$2,%gp_rel(uart_in_ptr)($28)
$L9:
	nop
	move	$sp,$fp
	lw	$fp,20($sp)
	addiu	$sp,$sp,24
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	uart_isr
	.size	uart_isr, .-uart_isr
	.align	2
	.globl	initialize
	.set	nomips16
	.set	nomicromips
	.ent	initialize
	.type	initialize, @function
initialize:
	.frame	$fp,80,$31		# vars= 56, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	addiu	$sp,$sp,-80
	sw	$31,76($sp)
	sw	$fp,72($sp)
	move	$fp,$sp
	sw	$4,80($fp)
	lui	$2,%hi(int_obj)
	addiu	$2,$2,%lo(int_obj)
	sw	$2,52($fp)
	li	$2,1151336448			# 0x44a00000
	sw	$2,56($fp)
	lw	$2,52($fp)
	lw	$3,56($fp)
	#nop
	sw	$3,0($2)
	lw	$2,52($fp)
	#nop
	addiu	$2,$2,4
	sw	$2,60($fp)
	lw	$2,60($fp)
	#nop
	addiu	$2,$2,64
	sw	$2,64($fp)
	b	$L11
$L12:
	lw	$2,60($fp)
	#nop
	addiu	$3,$2,8
	sw	$3,60($fp)
	sw	$0,0($2)
$L11:
	lw	$3,64($fp)
	lw	$2,60($fp)
	#nop
	bne	$3,$2,$L12
	addiu	$2,$28,%gp_rel(uart_obj)
	sw	$2,44($fp)
	li	$2,1151598592			# 0x44a40000
	sw	$2,48($fp)
	lw	$2,44($fp)
	lw	$3,48($fp)
	#nop
	sw	$3,0($2)
	lui	$2,%hi(int_obj)
	addiu	$2,$2,%lo(int_obj)
	sw	$2,24($fp)
	li	$2,3			# 0x3
	sw	$2,28($fp)
	lui	$2,%hi(uart_isr)
	addiu	$2,$2,%lo(uart_isr)
	sw	$2,32($fp)
	sw	$0,36($fp)
	lw	$2,24($fp)
	#nop
	addiu	$3,$2,4
	lw	$2,28($fp)
	#nop
	sll	$2,$2,3
	addu	$2,$3,$2
	sw	$2,40($fp)
	lw	$2,40($fp)
	lw	$3,32($fp)
	#nop
	sw	$3,0($2)
	lw	$2,40($fp)
	lw	$3,36($fp)
	#nop
	sw	$3,4($2)
	lui	$2,%hi(int_obj)
	addiu	$2,$2,%lo(int_obj)
	sw	$2,16($fp)
	li	$2,3			# 0x3
	sw	$2,20($fp)
	lw	$2,16($fp)
	#nop
	lw	$2,0($2)
	#nop
	move	$5,$2
	lw	$2,16($fp)
	#nop
	lw	$2,0($2)
	#nop
	lw	$2,0($2)
	li	$4,1			# 0x1
	lw	$3,20($fp)
	#nop
	sll	$3,$4,$3
	or	$2,$2,$3
	sw	$2,0($5)
	li	$4,1			# 0x1
	jal	OS_AsmInterruptEnable
	lw	$2,80($fp)
	#nop
	beq	$2,$0,$L14
	lw	$2,80($fp)
	#nop
	jalr	$2
$L14:
	.set	noreorder
	nop
	.set	reorder
	move	$sp,$fp
	lw	$31,76($sp)
	lw	$fp,72($sp)
	addiu	$sp,$sp,80
	jr	$31
	.end	initialize
	.size	initialize, .-initialize
	.align	2
	.globl	setbyte
	.set	nomips16
	.set	nomicromips
	.ent	setbyte
	.type	setbyte, @function
setbyte:
	.frame	$fp,24,$31		# vars= 16, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$fp,20($sp)
	move	$fp,$sp
	sw	$4,24($fp)
	nop
$L17:
	addiu	$2,$28,%gp_rel(uart_obj)
	sw	$2,0($fp)
	lw	$2,0($fp)
	nop
	lw	$2,0($2)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x2
	beq	$2,$0,$L17
	nop

	addiu	$2,$28,%gp_rel(uart_obj)
	sw	$2,4($fp)
	lw	$2,24($fp)
	nop
	sw	$2,8($fp)
	lw	$2,4($fp)
	nop
	lw	$2,0($2)
	nop
	addiu	$2,$2,8
	move	$3,$2
	lw	$2,8($fp)
	nop
	sw	$2,0($3)
	nop
	move	$sp,$fp
	lw	$fp,20($sp)
	addiu	$sp,$sp,24
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
	.frame	$fp,32,$31		# vars= 24, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	addiu	$sp,$sp,-32
	sw	$fp,28($sp)
	move	$fp,$sp
	lui	$2,%hi(int_obj)
	addiu	$2,$2,%lo(int_obj)
	sw	$2,4($fp)
	li	$2,3			# 0x3
	sw	$2,8($fp)
	lw	$2,4($fp)
	#nop
	lw	$2,0($2)
	#nop
	move	$5,$2
	lw	$2,4($fp)
	#nop
	lw	$2,0($2)
	#nop
	lw	$2,0($2)
	li	$4,1			# 0x1
	lw	$3,8($fp)
	#nop
	sll	$3,$4,$3
	or	$2,$2,$3
	sw	$2,0($5)
	b	$L19
$L20:
	lw	$3,%gp_rel(uart_out_ptr)($28)
	lui	$2,%hi(uart_fifo)
	addiu	$2,$2,%lo(uart_fifo)
	addu	$2,$3,$2
	lbu	$2,0($2)
	#nop
	andi	$2,$2,0x00ff
	sw	$2,0($fp)
	lw	$2,%gp_rel(uart_out_ptr)($28)
	#nop
	addiu	$2,$2,1
	andi	$2,$2,0x1ff
	sw	$2,%gp_rel(uart_out_ptr)($28)
$L19:
	lw	$3,%gp_rel(uart_in_ptr)($28)
	lw	$2,%gp_rel(uart_out_ptr)($28)
	#nop
	beq	$3,$2,$L20
	lui	$2,%hi(int_obj)
	addiu	$2,$2,%lo(int_obj)
	sw	$2,12($fp)
	li	$2,3			# 0x3
	sw	$2,16($fp)
	lw	$2,12($fp)
	#nop
	lw	$2,0($2)
	#nop
	move	$5,$2
	lw	$2,12($fp)
	#nop
	lw	$2,0($2)
	#nop
	lw	$2,0($2)
	li	$4,1			# 0x1
	lw	$3,16($fp)
	#nop
	sll	$3,$4,$3
	nor	$3,$0,$3
	and	$2,$2,$3
	sw	$2,0($5)
	lw	$2,0($fp)
	move	$sp,$fp
	lw	$fp,28($sp)
	addiu	$sp,$sp,32
	jr	$31
	.end	getbyte
	.size	getbyte, .-getbyte
	.align	2
	.globl	setword
	.set	nomips16
	.set	nomicromips
	.ent	setword
	.type	setword, @function
setword:
	.frame	$fp,32,$31		# vars= 8, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$fp,24($sp)
	move	$fp,$sp
	sw	$4,32($fp)
	sw	$0,16($fp)
	b	$L23
	nop

$L24:
	lw	$2,32($fp)
	nop
	andi	$2,$2,0xff
	move	$4,$2
	jal	setbyte
	nop

	lw	$2,32($fp)
	nop
	srl	$2,$2,8
	sw	$2,32($fp)
	lw	$2,16($fp)
	nop
	addiu	$2,$2,1
	sw	$2,16($fp)
$L23:
	lw	$2,16($fp)
	nop
	sltu	$2,$2,4
	bne	$2,$0,$L24
	nop

	nop
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	addiu	$sp,$sp,32
	jr	$31
	nop

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
	.frame	$fp,32,$31		# vars= 8, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$fp,24($sp)
	move	$fp,$sp
	sw	$0,20($fp)
	sw	$0,16($fp)
	b	$L26
	nop

$L27:
	jal	getbyte
	nop

	move	$3,$2
	lw	$2,16($fp)
	nop
	sll	$2,$2,3
	sll	$2,$3,$2
	lw	$3,20($fp)
	nop
	or	$2,$3,$2
	sw	$2,20($fp)
	lw	$2,16($fp)
	nop
	addiu	$2,$2,1
	sw	$2,16($fp)
$L26:
	lw	$2,16($fp)
	nop
	sltu	$2,$2,4
	bne	$2,$0,$L27
	nop

	lw	$2,20($fp)
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	addiu	$sp,$sp,32
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	getword
	.size	getword, .-getword
	.ident	"GCC: (GNU) 6.3.0"
