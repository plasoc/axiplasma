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
	.frame	$fp,56,$31		# vars= 48, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	addiu	$sp,$sp,-56
	sw	$fp,52($sp)
	move	$fp,$sp
	sw	$4,56($fp)
	sw	$5,60($fp)
	sw	$6,64($fp)
	li	$2,32			# 0x20
	sw	$2,0($fp)
	lw	$2,64($fp)
	#nop
	beq	$2,$0,$L8
	lw	$2,60($fp)
	#nop
	sw	$2,4($fp)
	lw	$2,64($fp)
	#nop
	sw	$2,8($fp)
	addiu	$2,$fp,40
	sw	$2,12($fp)
	addiu	$2,$fp,44
	sw	$2,16($fp)
	li	$2,32			# 0x20
	sw	$2,20($fp)
	lw	$3,4($fp)
	lw	$2,8($fp)
	#nop
	addu	$2,$3,$2
	sw	$2,24($fp)
	lw	$3,24($fp)
	li	$2,-32			# 0xffffffffffffffe0
	and	$2,$3,$2
	sw	$2,28($fp)
	lw	$3,4($fp)
	li	$2,-32			# 0xffffffffffffffe0
	and	$3,$3,$2
	lw	$2,12($fp)
	#nop
	sw	$3,0($2)
	lw	$3,20($fp)
	lw	$2,28($fp)
	#nop
	addu	$3,$3,$2
	lw	$2,16($fp)
	#nop
	sw	$3,0($2)
	lw	$2,16($fp)
	#nop
	lw	$3,0($2)
	lw	$4,24($fp)
	lw	$2,28($fp)
	#nop
	sltu	$2,$2,$4
	beq	$2,$0,$L4
	lw	$2,20($fp)
	b	$L5
$L4:
	move	$2,$0
$L5:
	addu	$3,$3,$2
	lw	$2,16($fp)
	#nop
	sw	$3,0($2)
	b	$L6
$L7:
	lw	$2,40($fp)
	lw	$3,56($fp)
	#nop
	sw	$3,32($fp)
	sw	$2,36($fp)
	lw	$3,32($fp)
	li	$2,268435456			# 0x10000000
	addu	$2,$3,$2
	lw	$4,36($fp)
	li	$3,-32			# 0xffffffffffffffe0
	and	$3,$4,$3
 #APP
 # 36 "../../plasoc/plasoc_cpu.h" 1
	sw $3, 0($2)
sw $0, 0($3)

 # 0 "" 2
 #NO_APP
	lw	$3,40($fp)
	lw	$2,0($fp)
	#nop
	addu	$2,$3,$2
	sw	$2,40($fp)
$L6:
	lw	$3,40($fp)
	lw	$2,44($fp)
	#nop
	bne	$3,$2,$L7
	b	$L1
$L8:
	.set	noreorder
	nop
	.set	reorder
$L1:
	move	$sp,$fp
	lw	$fp,52($sp)
	addiu	$sp,$sp,56
	jr	$31
	.end	l1_cache_operate_on_line_range
	.size	l1_cache_operate_on_line_range, .-l1_cache_operate_on_line_range
	.ident	"GCC: (GNU) 6.3.0"
