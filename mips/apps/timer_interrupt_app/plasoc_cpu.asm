	.file	1 "plasoc_cpu.c"
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
	beq	$6,$0,$L10
	addu	$3,$6,$5
	.set	macro
	.set	reorder

	li	$6,-32			# 0xffffffffffffffe0
	and	$2,$3,$6
	sltu	$3,$2,$3
	sll	$3,$3,5
	addiu	$2,$2,32
	and	$5,$5,$6
	addu	$3,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$5,$3,$L10
	li	$2,268435456			# 0x10000000
	.set	macro
	.set	reorder

	addu	$4,$4,$2
	and	$2,$5,$6
$L9:
 #APP
 # 36 "../../plasoc/plasoc_cpu.h" 1
	sw $2, 0($4)
sw $0, 0($2)

 # 0 "" 2
 #NO_APP
	addiu	$5,$5,32
	.set	noreorder
	.set	nomacro
	bne	$5,$3,$L9
	and	$2,$5,$6
	.set	macro
	.set	reorder

$L10:
	jr	$31
	.end	l1_cache_operate_on_line_range
	.size	l1_cache_operate_on_line_range, .-l1_cache_operate_on_line_range
	.ident	"GCC: (GNU) 6.3.0"
