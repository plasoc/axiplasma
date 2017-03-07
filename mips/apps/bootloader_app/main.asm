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
	sw	$19,36($sp)
	li	$19,-252706816			# 0xfffffffff0f00000
	sw	$23,52($sp)
	sw	$22,48($sp)
	sw	$21,44($sp)
	sw	$31,60($sp)
	sw	$fp,56($sp)
	sw	$20,40($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	ori	$19,$19,0xf0f0
	li	$22,16777216			# 0x1000000
	li	$21,230			# 0xe6
	li	$23,3			# 0x3
$L2:
	jal	getword
	bne	$2,$19,$L2
	.set	noreorder
	.set	nomacro
	jal	setbyte
	li	$4,1			# 0x1
	.set	macro
	.set	reorder

	li	$17,16777216			# 0x1000000
	move	$16,$0
	li	$18,16777216			# 0x1000000
$L7:
	jal	getword
	.set	noreorder
	.set	nomacro
	jal	getbyte
	move	$20,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	getbyte
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	bne	$21,$0,1f
	divu	$0,$20,$21
	break	7
	.set	reorder
1:
	lw	$3,16($sp)
	andi	$fp,$2,0x00ff
	andi	$3,$3,0xff
	mfhi	$2
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L12
	li	$4,2			# 0x2
	.set	macro
	.set	reorder

	sw	$20,0($17)
	.set	noreorder
	.set	nomacro
	bne	$16,$23,$L4
	addiu	$17,$17,4
	.set	macro
	.set	reorder

	move	$5,$18
	li	$6,16			# 0x10
	.set	noreorder
	.set	nomacro
	jal	l1_cache_operate_on_line_range
	li	$4,4			# 0x4
	.set	macro
	.set	reorder

	move	$18,$17
	move	$16,$0
$L5:
	li	$4,1			# 0x1
$L12:
	jal	setbyte
	li	$2,2			# 0x2
	.set	noreorder
	.set	nomacro
	bne	$fp,$2,$L7
	li	$6,16			# 0x10
	.set	macro
	.set	reorder

	move	$5,$18
	.set	noreorder
	.set	nomacro
	jal	l1_cache_operate_on_line_range
	li	$4,4			# 0x4
	.set	macro
	.set	reorder

 #APP
 # 66 "main.c" 1
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
