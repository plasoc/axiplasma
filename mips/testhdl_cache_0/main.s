	.file	1 "main.c"
	.section .mdebug.abi32
	.previous
	.text
	.align	2
	.globl	main
	.ent	main
	.type	main, @function
main:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,65536			# 0x10000
	ori	$2,$2,0x1120
	li	$3,268435456			# 0x10000000
#APP
	sw $0, 0($3)
sw $0, 0($2)

#NO_APP
	li	$4,268435456			# 0x10000000
	li	$2,1072			# 0x430
#APP
	sw $0, 0($4)
sw $0, 0($2)

#NO_APP
	li	$2,560			# 0x230
	ori	$3,$3,0x4
#APP
	sw $0, 0($3)
sw $0, 0($2)

#NO_APP
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	main
	.ident	"GCC: (GNU) 4.1.2"
