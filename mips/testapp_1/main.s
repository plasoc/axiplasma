	.file	1 "main.c"
	.section .mdebug.abi32
	.previous
	.globl	x
	.data
	.align	2
	.type	x, @object
	.size	x, 4
x:
	.word	12
	.globl	y
	.align	2
	.type	y, @object
	.size	y, 4
y:
	.word	32
	.globl	z
	.section	.bss
	.align	2
	.type	z, @object
	.size	z, 4
z:
	.space	4
	.text
	.align	2
	.globl	main
	.ent	main
	.type	main, @function
main:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-8
	sw	$fp,0($sp)
	move	$fp,$sp
	lui	$2,%hi(x)
	lw	$3,%lo(x)($2)
	lui	$2,%hi(y)
	lw	$2,%lo(y)($2)
	nop
	mult	$3,$2
	mflo	$3
	lui	$2,%hi(z)
	sw	$3,%lo(z)($2)
	move	$2,$0
	move	$sp,$fp
	lw	$fp,0($sp)
	addiu	$sp,$sp,8
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	main
	.ident	"GCC: (GNU) 4.1.2"
