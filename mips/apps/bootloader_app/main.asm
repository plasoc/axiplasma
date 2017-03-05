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
	.frame	$fp,64,$31		# vars= 40, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	addiu	$sp,$sp,-64
	sw	$31,60($sp)
	sw	$fp,56($sp)
	move	$fp,$sp
	li	$2,1151467520			# 0x44a20000
	ori	$2,$2,0x8
	li	$3,1			# 0x1
	sw	$3,0($2)
$L8:
	jal	getword
	sw	$2,28($fp)
	lw	$3,28($fp)
	li	$2,-252706816			# 0xfffffffff0f00000
	ori	$2,$2,0xf0f0
	bne	$3,$2,$L8
	li	$2,1151467520			# 0x44a20000
	ori	$2,$2,0x8
	li	$3,2			# 0x2
	sw	$3,0($2)
	li	$2,2048			# 0x800
	sw	$2,16($fp)
	sw	$0,20($fp)
	li	$2,2048			# 0x800
	sw	$2,24($fp)
	li	$4,1			# 0x1
	jal	setbyte
$L7:
	jal	getword
	sw	$2,32($fp)
	jal	getbyte
	sb	$2,36($fp)
	jal	getbyte
	sb	$2,37($fp)
	li	$2,1151467520			# 0x44a20000
	ori	$2,$2,0x8
	lw	$3,32($fp)
	#nop
	srl	$3,$3,16
	sw	$3,0($2)
	li	$2,1151467520			# 0x44a20000
	ori	$2,$2,0x8
	lw	$3,32($fp)
	#nop
	andi	$3,$3,0xff
	sw	$3,0($2)
	lw	$3,32($fp)
	li	$2,230			# 0xe6
	divu	$0,$3,$2
	bne	$2,$0,1f
	nop
	break	7
1:
	mfhi	$2
	move	$3,$2
	lbu	$2,36($fp)
	#nop
	bne	$3,$2,$L3
	lw	$2,24($fp)
	lw	$3,32($fp)
	#nop
	sw	$3,0($2)
	lw	$2,24($fp)
	#nop
	addiu	$2,$2,4
	sw	$2,24($fp)
	lw	$3,20($fp)
	li	$2,3			# 0x3
	bne	$3,$2,$L4
	lw	$2,16($fp)
	#nop
	sw	$2,40($fp)
	li	$2,16			# 0x10
	sw	$2,44($fp)
	lw	$6,44($fp)
	lw	$5,40($fp)
	li	$4,4			# 0x4
	jal	l1_cache_operate_on_line_range
	lw	$2,24($fp)
	#nop
	sw	$2,16($fp)
	sw	$0,20($fp)
	b	$L5
$L4:
	lw	$2,20($fp)
	#nop
	addiu	$2,$2,1
	sw	$2,20($fp)
$L5:
	li	$4,1			# 0x1
	jal	setbyte
	b	$L6
$L3:
	li	$4,2			# 0x2
	jal	setbyte
$L6:
	lbu	$3,37($fp)
	li	$2,2			# 0x2
	bne	$3,$2,$L7
	lw	$2,16($fp)
	#nop
	sw	$2,48($fp)
	li	$2,16			# 0x10
	sw	$2,52($fp)
	lw	$6,52($fp)
	lw	$5,48($fp)
	li	$4,4			# 0x4
	jal	l1_cache_operate_on_line_range
	li	$2,2048			# 0x800
 #APP
 # 73 "main.c" 1
	jr $2
 # 0 "" 2
 #NO_APP
	b	$L8
	.end	run
	.size	run, .-run
	.align	2
	.globl	main
	.set	nomips16
	.set	nomicromips
	.ent	main
	.type	main, @function
main:
	.frame	$fp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	sw	$fp,16($sp)
	move	$fp,$sp
	lui	$2,%hi(run)
	addiu	$4,$2,%lo(run)
	jal	initialize
	nop

	move	$2,$0
	move	$sp,$fp
	lw	$31,20($sp)
	lw	$fp,16($sp)
	addiu	$sp,$sp,24
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main
	.ident	"GCC: (GNU) 6.3.0"
