	.file	1 "main.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=32
	.module	nooddspreg
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.set	nomips16
	.set	nomicromips
	.ent	main
	.type	main, @function
main:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	li	$2,1073807360			# 0x40010000
	sw	$2,%gp_rel(xgpio_output_obj)($28)
	li	$2,983040			# 0xf0000
	li	$3,1073741824			# 0x40000000
	ori	$2,$2,0xffff
	sw	$3,%gp_rel(xgpio_input_obj)($28)
	sw	$2,4($3)
	lw	$2,%gp_rel(xgpio_output_obj)($28)
	nop
	sw	$0,4($2)
$L2:
	lw	$2,%gp_rel(xgpio_input_obj)($28)
	nop
	lw	$3,0($2)
	lw	$2,%gp_rel(xgpio_output_obj)($28)
	nop
	sw	$3,0($2)
	b	$L2
	nop

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main

	.comm	xgpio_output_obj,4,4

	.comm	xgpio_input_obj,4,4
	.ident	"GCC: (GNU) 6.3.0"
