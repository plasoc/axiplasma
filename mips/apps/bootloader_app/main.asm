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
	.frame	$fp,40,$31		# vars= 16, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	addiu	$sp,$sp,-40
	sw	$31,36($sp)
	sw	$fp,32($sp)
	move	$fp,$sp
$L6:
	jal	getword
	sw	$2,20($fp)
	lw	$3,20($fp)
	li	$2,-252706816			# 0xfffffffff0f00000
	ori	$2,$2,0xf0f0
	bne	$3,$2,$L6
	li	$2,268435456			# 0x10000000
	sw	$2,16($fp)
	li	$4,1			# 0x1
	jal	setbyte
$L5:
	jal	getword
	sw	$2,24($fp)
	jal	getbyte
	sb	$2,28($fp)
	jal	getbyte
	sb	$2,29($fp)
	lw	$3,24($fp)
	li	$2,230			# 0xe6
	divu	$0,$3,$2
	bne	$2,$0,1f
	nop
	break	7
1:
	mfhi	$2
	move	$3,$2
	lbu	$2,28($fp)
	#nop
	bne	$3,$2,$L3
	lw	$2,16($fp)
	#nop
	addiu	$3,$2,4
	sw	$3,16($fp)
	lw	$3,24($fp)
	#nop
	sw	$3,0($2)
	li	$4,1			# 0x1
	jal	setbyte
	b	$L4
$L3:
	li	$4,2			# 0x2
	jal	setbyte
$L4:
	lbu	$3,29($fp)
	li	$2,2			# 0x2
	bne	$3,$2,$L5
	li	$2,268435456			# 0x10000000
 #APP
 # 42 "main.c" 1
	jr $2
 # 0 "" 2
 #NO_APP
	b	$L6
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
