	.file	1 "main.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=32
	.module	nooddspreg
	.text
	.align	2
	.set	nomips16
	.set	nomicromips
	.ent	run
	.type	run, @function
run:
	.frame	$sp,64,$31		# vars= 8, regs= 10/0, args= 16, gp= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	addiu	$sp,$sp,-64
	li	$3,1			# 0x1
	li	$2,1151467520			# 0x44a20000
	sw	$18,32($sp)
	li	$18,-252706816			# 0xfffffffff0f00000
	sw	$22,48($sp)
	sw	$20,40($sp)
	sw	$19,36($sp)
	sw	$31,60($sp)
	sw	$fp,56($sp)
	sw	$23,52($sp)
	sw	$21,44($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	ori	$18,$18,0xf0f0
	sw	$3,8($2)
	li	$19,1151467520			# 0x44a20000
	li	$20,2			# 0x2
	li	$22,2048			# 0x800
$L2:
	jal	getword
	bne	$2,$18,$L2
	sw	$20,8($19)
	.set	noreorder
	.set	nomacro
	jal	setbyte
	li	$4,1			# 0x1
	.set	macro
	.set	reorder

	li	$17,2048			# 0x800
	move	$16,$0
	li	$21,2048			# 0x800
	li	$fp,3			# 0x3
$L7:
	jal	getword
	.set	noreorder
	.set	nomacro
	jal	getbyte
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	getbyte
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	lw	$3,20($sp)
	andi	$23,$2,0x00ff
	srl	$2,$3,16
	sw	$2,8($19)
	andi	$2,$3,0xff
	sw	$2,8($19)
	li	$2,230			# 0xe6
	.set	noreorder
	bne	$2,$0,1f
	divu	$0,$3,$2
	break	7
	.set	reorder
1:
	lw	$4,16($sp)
	#nop
	andi	$4,$4,0xff
	mfhi	$2
	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L12
	li	$4,2			# 0x2
	.set	macro
	.set	reorder

	sw	$3,0($17)
	.set	noreorder
	.set	nomacro
	bne	$16,$fp,$L4
	addiu	$17,$17,4
	.set	macro
	.set	reorder

	move	$5,$21
	li	$6,16			# 0x10
	.set	noreorder
	.set	nomacro
	jal	l1_cache_operate_on_line_range
	li	$4,4			# 0x4
	.set	macro
	.set	reorder

	move	$21,$17
	move	$16,$0
$L5:
	li	$4,1			# 0x1
$L12:
	jal	setbyte
	.set	noreorder
	.set	nomacro
	bne	$23,$20,$L7
	li	$6,16			# 0x10
	.set	macro
	.set	reorder

	move	$5,$21
	.set	noreorder
	.set	nomacro
	jal	l1_cache_operate_on_line_range
	li	$4,4			# 0x4
	.set	macro
	.set	reorder

 #APP
 # 73 "main.c" 1
	jr $22
 # 0 "" 2
 #NO_APP
	b	$L2
$L4:
	.set	noreorder
	.set	nomacro
	b	$L5
	addiu	$16,$16,1
	.set	macro
	.set	reorder

	.end	run
	.size	run, .-run
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.set	nomips16
	.set	nomicromips
	.ent	main
	.type	main, @function
main:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, gp= 0
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lui	$4,%hi(run)
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	jal	initialize
	addiu	$4,$4,%lo(run)

	lw	$31,20($sp)
	move	$2,$0
	jr	$31
	addiu	$sp,$sp,24

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main
	.ident	"GCC: (GNU) 6.3.0"
