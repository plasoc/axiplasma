	.file	1 "heap_1.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=32
	.module	nooddspreg
	.text
	.align	2
	.globl	pvPortMalloc
	.set	nomips16
	.set	nomicromips
	.ent	pvPortMalloc
	.type	pvPortMalloc, @function
pvPortMalloc:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, gp= 0
	.mask	0x80030000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	andi	$2,$4,0x3
	sw	$16,20($sp)
	sw	$31,28($sp)
	sw	$17,24($sp)
	beq	$2,$0,$L2
	move	$16,$4

	li	$4,-4			# 0xfffffffffffffffc
	and	$16,$16,$4
	addiu	$16,$16,4
$L2:
	jal	vTaskSuspendAll
	nop

	lw	$2,%gp_rel(pucAlignedHeap.2397)($28)
	nop
	bne	$2,$0,$L3
	lui	$2,%hi(ucHeap+4)

	li	$3,-4			# 0xfffffffffffffffc
	addiu	$2,$2,%lo(ucHeap+4)
	and	$2,$2,$3
	sw	$2,%gp_rel(pucAlignedHeap.2397)($28)
$L3:
	lw	$2,%gp_rel(xNextFreeByte)($28)
	nop
	addu	$16,$16,$2
	sltu	$3,$16,8188
	beq	$3,$0,$L4
	move	$17,$0

	sltu	$3,$2,$16
	beq	$3,$0,$L4
	nop

	lw	$17,%gp_rel(pucAlignedHeap.2397)($28)
	sw	$16,%gp_rel(xNextFreeByte)($28)
	addu	$17,$17,$2
$L4:
	jal	xTaskResumeAll
	nop

	lw	$31,28($sp)
	move	$2,$17
	lw	$16,20($sp)
	lw	$17,24($sp)
	jr	$31
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	pvPortMalloc
	.size	pvPortMalloc, .-pvPortMalloc
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
$LC0:
	.ascii	"../../freertos/heap_1.c\000"
	.text
	.align	2
	.globl	vPortFree
	.set	nomips16
	.set	nomicromips
	.ent	vPortFree
	.type	vPortFree, @function
vPortFree:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L13
	lui	$4,%hi($LC0)

	li	$5,171			# 0xab
	j	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L13:
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	vPortFree
	.size	vPortFree, .-vPortFree
	.align	2
	.globl	vPortInitialiseBlocks
	.set	nomips16
	.set	nomicromips
	.ent	vPortInitialiseBlocks
	.type	vPortInitialiseBlocks, @function
vPortInitialiseBlocks:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	jr	$31
	sw	$0,%gp_rel(xNextFreeByte)($28)

	.set	macro
	.set	reorder
	.end	vPortInitialiseBlocks
	.size	vPortInitialiseBlocks, .-vPortInitialiseBlocks
	.align	2
	.globl	xPortGetFreeHeapSize
	.set	nomips16
	.set	nomicromips
	.ent	xPortGetFreeHeapSize
	.type	xPortGetFreeHeapSize, @function
xPortGetFreeHeapSize:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lw	$2,%gp_rel(xNextFreeByte)($28)
	li	$3,8188			# 0x1ffc
	jr	$31
	subu	$2,$3,$2

	.set	macro
	.set	reorder
	.end	xPortGetFreeHeapSize
	.size	xPortGetFreeHeapSize, .-xPortGetFreeHeapSize
	.local	pucAlignedHeap.2397
	.comm	pucAlignedHeap.2397,4,4
	.local	xNextFreeByte
	.comm	xNextFreeByte,4,4
	.local	ucHeap
	.comm	ucHeap,8192,4
	.ident	"GCC: (GNU) 6.3.0"
