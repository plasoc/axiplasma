	.file	1 "main.c"
	.section .mdebug.abi32
	.previous
	.globl	str_0
	.data
	.align	2
	.type	str_0, @object
	.size	str_0, 64
str_0:
	.ascii	"This is a string\000"
	.space	47
	.globl	str_1
	.align	2
	.type	str_1, @object
	.size	str_1, 64
str_1:
	.ascii	" that needs to be extended.\000"
	.space	36
	.globl	start_value
	.align	2
	.type	start_value, @object
	.size	start_value, 4
start_value:
	.word	32
	.globl	end_value
	.section	.bss
	.align	2
	.type	end_value, @object
	.size	end_value, 4
end_value:
	.space	4
	.text
	.align	2
	.globl	main
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
	lui	$2,%hi(str_0)
	addiu	$4,$2,%lo(str_0)
	lui	$2,%hi(str_1)
	addiu	$5,$2,%lo(str_1)
	jal	strcat
	nop

	lui	$2,%hi(end_value)
	addiu	$4,$2,%lo(end_value)
	lui	$2,%hi(start_value)
	addiu	$5,$2,%lo(start_value)
	li	$6,4			# 0x4
	jal	memcpy
	nop

	move	$2,$0
	move	$sp,$fp
	lw	$31,20($sp)
	lw	$fp,16($sp)
	addiu	$sp,$sp,24
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	main
	.ident	"GCC: (GNU) 4.1.2"
