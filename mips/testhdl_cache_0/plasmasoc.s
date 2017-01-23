	.file	1 "plasmasoc.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=32
	.module	nooddspreg
	.text
	.align	2
	.globl	l1_cache_operate_on_line_range
	.set	nomips16
	.set	nomicromips
	.ent	l1_cache_operate_on_line_range
	.type	l1_cache_operate_on_line_range, @function
l1_cache_operate_on_line_range:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L8
	addu	$6,$6,$5
	.set	macro
	.set	reorder

	li	$2,-32			# 0xffffffffffffffe0
	and	$3,$6,$2
	sltu	$6,$3,$6
	and	$5,$5,$2
	sll	$6,$6,5
	addiu	$2,$3,32
	addu	$6,$2,$6
	li	$2,268435456			# 0x10000000
	addu	$4,$4,$2
	li	$2,-32			# 0xffffffffffffffe0
$L4:
	.set	noreorder
	.set	nomacro
	bne	$6,$5,$L5
	and	$3,$5,$2
	.set	macro
	.set	reorder

$L8:
	jr	$31
$L5:
 #APP
 # 31 "../plasma/plasmasoc.h" 1
	sw $3, 0($4)
sw $0, 0($3)

 # 0 "" 2
 #NO_APP
	.set	noreorder
	.set	nomacro
	b	$L4
	addiu	$5,$5,32
	.set	macro
	.set	reorder

	.end	l1_cache_operate_on_line_range
	.size	l1_cache_operate_on_line_range, .-l1_cache_operate_on_line_range
	.ident	"GCC: (GNU) 6.3.0"
