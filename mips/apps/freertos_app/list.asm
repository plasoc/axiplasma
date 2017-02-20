	.file	1 "list.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=32
	.module	nooddspreg
	.text
	.align	2
	.globl	vListInitialise
	.set	nomips16
	.set	nomicromips
	.ent	vListInitialise
	.type	vListInitialise, @function
vListInitialise:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$2,$4,8
	li	$3,-1			# 0xffffffffffffffff
	sw	$2,4($4)
	sw	$3,8($4)
	sw	$2,12($4)
	sw	$2,16($4)
	jr	$31
	sw	$0,0($4)

	.set	macro
	.set	reorder
	.end	vListInitialise
	.size	vListInitialise, .-vListInitialise
	.align	2
	.globl	vListInitialiseItem
	.set	nomips16
	.set	nomicromips
	.ent	vListInitialiseItem
	.type	vListInitialiseItem, @function
vListInitialiseItem:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	jr	$31
	sw	$0,16($4)

	.set	macro
	.set	reorder
	.end	vListInitialiseItem
	.size	vListInitialiseItem, .-vListInitialiseItem
	.align	2
	.globl	vListInsertEnd
	.set	nomips16
	.set	nomicromips
	.ent	vListInsertEnd
	.type	vListInsertEnd, @function
vListInsertEnd:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lw	$2,4($4)
	nop
	lw	$3,8($2)
	sw	$2,4($5)
	sw	$3,8($5)
	lw	$3,8($2)
	nop
	sw	$5,4($3)
	sw	$5,8($2)
	lw	$2,0($4)
	sw	$4,16($5)
	addiu	$2,$2,1
	jr	$31
	sw	$2,0($4)

	.set	macro
	.set	reorder
	.end	vListInsertEnd
	.size	vListInsertEnd, .-vListInsertEnd
	.align	2
	.globl	vListInsert
	.set	nomips16
	.set	nomicromips
	.ent	vListInsert
	.type	vListInsert, @function
vListInsert:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lw	$6,0($5)
	li	$3,-1			# 0xffffffffffffffff
	bne	$6,$3,$L9
	addiu	$2,$4,8

	lw	$2,16($4)
	nop
$L6:
	lw	$3,4($2)
	nop
	sw	$3,4($5)
	sw	$5,8($3)
	sw	$2,8($5)
	sw	$5,4($2)
	lw	$2,0($4)
	sw	$4,16($5)
	addiu	$2,$2,1
	jr	$31
	sw	$2,0($4)

$L8:
	move	$2,$7
$L9:
	lw	$7,4($2)
	nop
	lw	$3,0($7)
	nop
	sltu	$3,$6,$3
	beq	$3,$0,$L8
	nop

	b	$L6
	nop

	.set	macro
	.set	reorder
	.end	vListInsert
	.size	vListInsert, .-vListInsert
	.align	2
	.globl	uxListRemove
	.set	nomips16
	.set	nomicromips
	.ent	uxListRemove
	.type	uxListRemove, @function
uxListRemove:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lw	$5,4($4)
	lw	$2,8($4)
	lw	$3,16($4)
	sw	$2,8($5)
	lw	$2,8($4)
	nop
	sw	$5,4($2)
	lw	$5,4($3)
	nop
	bne	$4,$5,$L11
	nop

	sw	$2,4($3)
$L11:
	lw	$2,0($3)
	sw	$0,16($4)
	addiu	$2,$2,-1
	jr	$31
	sw	$2,0($3)

	.set	macro
	.set	reorder
	.end	uxListRemove
	.size	uxListRemove, .-uxListRemove
	.ident	"GCC: (GNU) 6.3.0"
