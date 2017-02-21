	.file	1 "timers.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=32
	.module	nooddspreg
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
$LC0:
	.ascii	"TmrQ\000"
	.text
	.align	2
	.set	nomips16
	.set	nomicromips
	.ent	prvCheckForValidListAndQueue
	.type	prvCheckForValidListAndQueue, @function
prvCheckForValidListAndQueue:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, gp= 0
	.mask	0x80030000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$17,24($sp)
	jal	vTaskEnterCritical
	sw	$16,20($sp)

	lw	$2,%gp_rel(xTimerQueue)($28)
	nop
	bne	$2,$0,$L3
	lui	$17,%hi(xActiveTimerList1)

	addiu	$4,$17,%lo(xActiveTimerList1)
	jal	vListInitialise
	lui	$16,%hi(xActiveTimerList2)

	jal	vListInitialise
	addiu	$4,$16,%lo(xActiveTimerList2)

	addiu	$17,$17,%lo(xActiveTimerList1)
	addiu	$16,$16,%lo(xActiveTimerList2)
	move	$6,$0
	li	$5,16			# 0x10
	li	$4,10			# 0xa
	sw	$17,%gp_rel(pxCurrentTimerList)($28)
	jal	xQueueGenericCreate
	sw	$16,%gp_rel(pxOverflowTimerList)($28)

	beq	$2,$0,$L3
	sw	$2,%gp_rel(xTimerQueue)($28)

	lui	$5,%hi($LC0)
	addiu	$5,$5,%lo($LC0)
	jal	vQueueAddToRegistry
	move	$4,$2

$L3:
	lw	$31,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	j	vTaskExitCritical
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	prvCheckForValidListAndQueue
	.size	prvCheckForValidListAndQueue, .-prvCheckForValidListAndQueue
	.align	2
	.set	nomips16
	.set	nomicromips
	.ent	prvInsertTimerInActiveList
	.type	prvInsertTimerInActiveList, @function
prvInsertTimerInActiveList:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, gp= 0
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sltu	$2,$6,$5
	sw	$31,20($sp)
	sw	$5,4($4)
	bne	$2,$0,$L10
	sw	$4,16($4)

	subu	$6,$6,$7
	lw	$7,24($4)
	nop
	sltu	$6,$6,$7
	beq	$6,$0,$L9
	li	$2,1			# 0x1

	addiu	$5,$4,4
	lw	$4,%gp_rel(pxOverflowTimerList)($28)
$L16:
	jal	vListInsert
	nop

	move	$2,$0
$L9:
	lw	$31,20($sp)
	nop
	jr	$31
	addiu	$sp,$sp,24

$L10:
	sltu	$6,$6,$7
	beq	$6,$0,$L12
	nop

	sltu	$5,$5,$7
	beq	$5,$0,$L9
	li	$2,1			# 0x1

$L12:
	addiu	$5,$4,4
	lw	$4,%gp_rel(pxCurrentTimerList)($28)
	b	$L16
	nop

	.set	macro
	.set	reorder
	.end	prvInsertTimerInActiveList
	.size	prvInsertTimerInActiveList, .-prvInsertTimerInActiveList
	.section	.rodata.str1.4
	.align	2
$LC1:
	.ascii	"../../freertos/timers.c\000"
	.align	2
$LC2:
	.ascii	"Tmr Svc\000"
	.text
	.align	2
	.globl	xTimerCreateTimerTask
	.set	nomips16
	.set	nomicromips
	.ent	xTimerCreateTimerTask
	.type	xTimerCreateTimerTask, @function
xTimerCreateTimerTask:
	.frame	$sp,32,$31		# vars= 0, regs= 1/0, args= 24, gp= 0
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	jal	prvCheckForValidListAndQueue
	nop

	lw	$2,%gp_rel(xTimerQueue)($28)
	nop
	bne	$2,$0,$L18
	addiu	$2,$28,%gp_rel(xTimerTaskHandle)

	lui	$4,%hi($LC1)
$L25:
	li	$5,307			# 0x133
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC1)

	move	$2,$0
$L17:
	lw	$31,28($sp)
	nop
	jr	$31
	addiu	$sp,$sp,32

$L18:
	sw	$2,20($sp)
	lui	$5,%hi($LC2)
	li	$2,3			# 0x3
	lui	$4,%hi(prvTimerTask)
	sw	$2,16($sp)
	move	$7,$0
	li	$6,256			# 0x100
	addiu	$5,$5,%lo($LC2)
	jal	xTaskCreate
	addiu	$4,$4,%lo(prvTimerTask)

	bne	$2,$0,$L17
	nop

	b	$L25
	lui	$4,%hi($LC1)

	.set	macro
	.set	reorder
	.end	xTimerCreateTimerTask
	.size	xTimerCreateTimerTask, .-xTimerCreateTimerTask
	.align	2
	.globl	xTimerCreate
	.set	nomips16
	.set	nomicromips
	.ent	xTimerCreate
	.type	xTimerCreate, @function
xTimerCreate:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, gp= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-40
	sw	$20,32($sp)
	move	$20,$4
	li	$4,40			# 0x28
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	sw	$31,36($sp)
	move	$17,$5
	move	$19,$6
	jal	pvPortMalloc
	move	$18,$7

	beq	$2,$0,$L27
	move	$16,$2

	bne	$17,$0,$L28
	lui	$4,%hi($LC1)

	li	$5,396			# 0x18c
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC1)

$L28:
	jal	prvCheckForValidListAndQueue
	nop

	lw	$2,56($sp)
	sw	$20,0($16)
	sw	$17,24($16)
	sw	$19,28($16)
	sw	$18,32($16)
	sw	$2,36($16)
	jal	vListInitialiseItem
	addiu	$4,$16,4

$L27:
	lw	$31,36($sp)
	move	$2,$16
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,40

	.set	macro
	.set	reorder
	.end	xTimerCreate
	.size	xTimerCreate, .-xTimerCreate
	.align	2
	.globl	xTimerGenericCommand
	.set	nomips16
	.set	nomicromips
	.ent	xTimerGenericCommand
	.type	xTimerGenericCommand, @function
xTimerGenericCommand:
	.frame	$sp,56,$31		# vars= 16, regs= 5/0, args= 16, gp= 0
	.mask	0x800f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-56
	sw	$19,48($sp)
	sw	$18,44($sp)
	sw	$17,40($sp)
	sw	$16,36($sp)
	sw	$31,52($sp)
	move	$17,$4
	move	$16,$5
	move	$19,$6
	bne	$4,$0,$L34
	move	$18,$7

	lui	$4,%hi($LC1)
	li	$5,422			# 0x1a6
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC1)

$L34:
	lw	$4,%gp_rel(xTimerQueue)($28)
	nop
	beq	$4,$0,$L33
	move	$2,$0

	sw	$16,16($sp)
	slt	$16,$16,6
	sw	$19,20($sp)
	beq	$16,$0,$L36
	sw	$17,24($sp)

	jal	xTaskGetSchedulerState
	nop

	li	$3,2			# 0x2
	lw	$4,%gp_rel(xTimerQueue)($28)
	move	$7,$0
	bne	$2,$3,$L40
	move	$6,$0

	lw	$6,72($sp)
$L40:
	jal	xQueueGenericSend
	addiu	$5,$sp,16

$L33:
	lw	$31,52($sp)
	lw	$19,48($sp)
	lw	$18,44($sp)
	lw	$17,40($sp)
	lw	$16,36($sp)
	jr	$31
	addiu	$sp,$sp,56

$L36:
	move	$7,$0
	move	$6,$18
	jal	xQueueGenericSendFromISR
	addiu	$5,$sp,16

	b	$L33
	nop

	.set	macro
	.set	reorder
	.end	xTimerGenericCommand
	.size	xTimerGenericCommand, .-xTimerGenericCommand
	.align	2
	.set	nomips16
	.set	nomicromips
	.ent	prvSwitchTimerLists
	.type	prvSwitchTimerLists, @function
prvSwitchTimerLists:
	.frame	$sp,48,$31		# vars= 0, regs= 6/0, args= 24, gp= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-48
	sw	$17,28($sp)
	lui	$17,%hi($LC1)
	sw	$20,40($sp)
	sw	$31,44($sp)
	sw	$19,36($sp)
	sw	$18,32($sp)
	sw	$16,24($sp)
	li	$20,1			# 0x1
	addiu	$17,$17,%lo($LC1)
$L43:
	lw	$2,%gp_rel(pxCurrentTimerList)($28)
	nop
	lw	$3,0($2)
	nop
	bne	$3,$0,$L46
	nop

	lw	$3,%gp_rel(pxOverflowTimerList)($28)
	lw	$31,44($sp)
	lw	$20,40($sp)
	lw	$19,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	sw	$3,%gp_rel(pxCurrentTimerList)($28)
	sw	$2,%gp_rel(pxOverflowTimerList)($28)
	jr	$31
	addiu	$sp,$sp,48

$L46:
	lw	$2,12($2)
	nop
	lw	$16,12($2)
	lw	$18,0($2)
	addiu	$19,$16,4
	jal	uxListRemove
	move	$4,$19

	lw	$2,36($16)
	nop
	jalr	$2
	move	$4,$16

	lw	$2,28($16)
	nop
	bne	$2,$20,$L43
	nop

	lw	$2,24($16)
	nop
	addu	$2,$18,$2
	sltu	$3,$18,$2
	beq	$3,$0,$L44
	move	$7,$0

	lw	$4,%gp_rel(pxCurrentTimerList)($28)
	sw	$2,4($16)
	sw	$16,16($16)
	jal	vListInsert
	move	$5,$19

	b	$L43
	nop

$L44:
	sw	$0,16($sp)
	move	$6,$18
	move	$5,$0
	jal	xTimerGenericCommand
	move	$4,$16

	bne	$2,$0,$L43
	li	$5,914			# 0x392

	jal	vAssertCalled
	move	$4,$17

	b	$L43
	nop

	.set	macro
	.set	reorder
	.end	prvSwitchTimerLists
	.size	prvSwitchTimerLists, .-prvSwitchTimerLists
	.align	2
	.set	nomips16
	.set	nomicromips
	.ent	prvTimerTask
	.type	prvTimerTask, @function
prvTimerTask:
	.frame	$sp,72,$31		# vars= 16, regs= 7/0, args= 24, gp= 0
	.mask	0x803f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-72
	sw	$18,52($sp)
	lui	$18,%hi($LC1)
	sw	$20,60($sp)
	sw	$19,56($sp)
	sw	$31,68($sp)
	sw	$21,64($sp)
	sw	$17,48($sp)
	sw	$16,44($sp)
	li	$19,1			# 0x1
	addiu	$18,$18,%lo($LC1)
	li	$20,1			# 0x1
$L73:
	lw	$2,%gp_rel(pxCurrentTimerList)($28)
	nop
	lw	$16,0($2)
	nop
	beq	$16,$0,$L50
	move	$17,$0

	lw	$2,12($2)
	nop
	lw	$17,0($2)
$L50:
	jal	vTaskSuspendAll
	nop

	jal	xTaskGetTickCount
	nop

	move	$21,$2
	lw	$2,%gp_rel(xLastTime.2680)($28)
	nop
	sltu	$2,$21,$2
	beq	$2,$0,$L51
	move	$3,$0

	jal	prvSwitchTimerLists
	nop

	li	$3,1			# 0x1
$L51:
	bne	$3,$0,$L52
	sw	$21,%gp_rel(xLastTime.2680)($28)

	beq	$16,$0,$L53
	sltu	$2,$21,$17

	bne	$2,$0,$L54
	move	$6,$0

	jal	xTaskResumeAll
	nop

	lw	$2,%gp_rel(pxCurrentTimerList)($28)
	nop
	lw	$2,12($2)
	nop
	lw	$16,12($2)
	jal	uxListRemove
	addiu	$4,$16,4

	lw	$2,28($16)
	nop
	bne	$2,$19,$L56
	move	$7,$17

	lw	$5,24($16)
	move	$6,$21
	addu	$5,$17,$5
	jal	prvInsertTimerInActiveList
	move	$4,$16

	beq	$2,$0,$L56
	move	$7,$0

	sw	$0,16($sp)
	move	$6,$17
	move	$5,$0
	jal	xTimerGenericCommand
	move	$4,$16

	bne	$2,$0,$L56
	li	$5,520			# 0x208

	jal	vAssertCalled
	move	$4,$18

$L56:
	lw	$2,36($16)
	nop
	jalr	$2
	move	$4,$16

$L61:
	lw	$4,%gp_rel(xTimerQueue)($28)
	move	$7,$0
	move	$6,$0
	jal	xQueueGenericReceive
	addiu	$5,$sp,24

	beq	$2,$0,$L73
	nop

	lw	$2,24($sp)
	nop
	bgez	$2,$L86
	nop

	lw	$5,36($sp)
	lw	$4,32($sp)
	lw	$2,28($sp)
	nop
	jalr	$2
	nop

	lw	$2,24($sp)
	nop
$L86:
	bltz	$2,$L61
	nop

	lw	$16,32($sp)
	nop
	lw	$2,20($16)
	nop
	beq	$2,$0,$L62
	nop

	jal	uxListRemove
	addiu	$4,$16,4

$L62:
	jal	xTaskGetTickCount
	nop

	move	$17,$2
	lw	$2,%gp_rel(xLastTime.2680)($28)
	nop
	sltu	$2,$17,$2
	beq	$2,$0,$L63
	nop

	jal	prvSwitchTimerLists
	nop

$L63:
	lw	$3,24($sp)
	nop
	sltu	$2,$3,10
	beq	$2,$0,$L61
	sw	$17,%gp_rel(xLastTime.2680)($28)

	sll	$3,$19,$3
	andi	$2,$3,0x210
	bne	$2,$0,$L65
	andi	$2,$3,0xc7

	bne	$2,$0,$L66
	andi	$3,$3,0x20

	beq	$3,$0,$L61
	nop

	jal	vPortFree
	move	$4,$16

	b	$L61
	nop

$L53:
	lw	$2,%gp_rel(pxOverflowTimerList)($28)
	nop
	lw	$6,0($2)
	nop
	sltu	$6,$6,1
$L54:
	lw	$4,%gp_rel(xTimerQueue)($28)
	jal	vQueueWaitForMessageRestricted
	subu	$5,$17,$21

	jal	xTaskResumeAll
	nop

	bne	$2,$0,$L61
	nop

	jal	OS_Syscall
	nop

	b	$L61
	nop

$L52:
	jal	xTaskResumeAll
	nop

	b	$L61
	nop

$L66:
	lw	$5,24($16)
	lw	$7,28($sp)
	move	$6,$17
	addu	$5,$7,$5
	jal	prvInsertTimerInActiveList
	move	$4,$16

	beq	$2,$0,$L61
	nop

	lw	$2,36($16)
	nop
	jalr	$2
	move	$4,$16

	lw	$2,28($16)
	nop
	bne	$2,$20,$L61
	move	$7,$0

	lw	$2,24($16)
	lw	$6,28($sp)
	sw	$0,16($sp)
	addu	$6,$6,$2
	move	$5,$0
	jal	xTimerGenericCommand
	move	$4,$16

	bne	$2,$0,$L61
	li	$5,801			# 0x321

	jal	vAssertCalled
	move	$4,$18

	b	$L61
	nop

$L65:
	lw	$2,28($sp)
	nop
	bne	$2,$0,$L71
	sw	$2,24($16)

	li	$5,824			# 0x338
	jal	vAssertCalled
	move	$4,$18

$L71:
	lw	$5,24($16)
	move	$7,$17
	move	$6,$17
	addu	$5,$17,$5
	jal	prvInsertTimerInActiveList
	move	$4,$16

	b	$L61
	nop

	.set	macro
	.set	reorder
	.end	prvTimerTask
	.size	prvTimerTask, .-prvTimerTask
	.align	2
	.globl	xTimerGetTimerDaemonTaskHandle
	.set	nomips16
	.set	nomicromips
	.ent	xTimerGetTimerDaemonTaskHandle
	.type	xTimerGetTimerDaemonTaskHandle, @function
xTimerGetTimerDaemonTaskHandle:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, gp= 0
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lw	$2,%gp_rel(xTimerTaskHandle)($28)
	addiu	$sp,$sp,-24
	bne	$2,$0,$L88
	sw	$31,20($sp)

	lui	$4,%hi($LC1)
	li	$5,464			# 0x1d0
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC1)

$L88:
	lw	$31,20($sp)
	lw	$2,%gp_rel(xTimerTaskHandle)($28)
	jr	$31
	addiu	$sp,$sp,24

	.set	macro
	.set	reorder
	.end	xTimerGetTimerDaemonTaskHandle
	.size	xTimerGetTimerDaemonTaskHandle, .-xTimerGetTimerDaemonTaskHandle
	.align	2
	.globl	xTimerGetPeriod
	.set	nomips16
	.set	nomicromips
	.ent	xTimerGetPeriod
	.type	xTimerGetPeriod, @function
xTimerGetPeriod:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$16,16($sp)
	sw	$31,20($sp)
	bne	$4,$0,$L91
	move	$16,$4

	lui	$4,%hi($LC1)
	li	$5,473			# 0x1d9
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC1)

$L91:
	lw	$31,20($sp)
	lw	$2,24($16)
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,24

	.set	macro
	.set	reorder
	.end	xTimerGetPeriod
	.size	xTimerGetPeriod, .-xTimerGetPeriod
	.align	2
	.globl	xTimerGetExpiryTime
	.set	nomips16
	.set	nomicromips
	.ent	xTimerGetExpiryTime
	.type	xTimerGetExpiryTime, @function
xTimerGetExpiryTime:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$16,16($sp)
	sw	$31,20($sp)
	bne	$4,$0,$L94
	move	$16,$4

	lui	$4,%hi($LC1)
	li	$5,483			# 0x1e3
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC1)

$L94:
	lw	$31,20($sp)
	lw	$2,4($16)
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,24

	.set	macro
	.set	reorder
	.end	xTimerGetExpiryTime
	.size	xTimerGetExpiryTime, .-xTimerGetExpiryTime
	.align	2
	.globl	pcTimerGetName
	.set	nomips16
	.set	nomicromips
	.ent	pcTimerGetName
	.type	pcTimerGetName, @function
pcTimerGetName:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$16,16($sp)
	sw	$31,20($sp)
	bne	$4,$0,$L97
	move	$16,$4

	lui	$4,%hi($LC1)
	li	$5,493			# 0x1ed
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC1)

$L97:
	lw	$31,20($sp)
	lw	$2,0($16)
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,24

	.set	macro
	.set	reorder
	.end	pcTimerGetName
	.size	pcTimerGetName, .-pcTimerGetName
	.align	2
	.globl	xTimerIsTimerActive
	.set	nomips16
	.set	nomicromips
	.ent	xTimerIsTimerActive
	.type	xTimerIsTimerActive, @function
xTimerIsTimerActive:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$16,16($sp)
	sw	$31,20($sp)
	bne	$4,$0,$L100
	move	$16,$4

	lui	$4,%hi($LC1)
	li	$5,986			# 0x3da
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC1)

$L100:
	jal	vTaskEnterCritical
	nop

	lw	$16,20($16)
	jal	vTaskExitCritical
	sltu	$16,$0,$16

	lw	$31,20($sp)
	move	$2,$16
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,24

	.set	macro
	.set	reorder
	.end	xTimerIsTimerActive
	.size	xTimerIsTimerActive, .-xTimerIsTimerActive
	.align	2
	.globl	pvTimerGetTimerID
	.set	nomips16
	.set	nomicromips
	.ent	pvTimerGetTimerID
	.type	pvTimerGetTimerID, @function
pvTimerGetTimerID:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$16,16($sp)
	sw	$31,20($sp)
	bne	$4,$0,$L103
	move	$16,$4

	lui	$4,%hi($LC1)
	li	$5,1007			# 0x3ef
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC1)

$L103:
	jal	vTaskEnterCritical
	nop

	lw	$16,32($16)
	jal	vTaskExitCritical
	nop

	lw	$31,20($sp)
	move	$2,$16
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,24

	.set	macro
	.set	reorder
	.end	pvTimerGetTimerID
	.size	pvTimerGetTimerID, .-pvTimerGetTimerID
	.align	2
	.globl	vTimerSetTimerID
	.set	nomips16
	.set	nomicromips
	.ent	vTimerSetTimerID
	.type	vTimerSetTimerID, @function
vTimerSetTimerID:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, gp= 0
	.mask	0x80030000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$17,24($sp)
	sw	$16,20($sp)
	sw	$31,28($sp)
	move	$16,$4
	bne	$4,$0,$L106
	move	$17,$5

	lui	$4,%hi($LC1)
	li	$5,1023			# 0x3ff
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC1)

$L106:
	jal	vTaskEnterCritical
	nop

	sw	$17,32($16)
	lw	$31,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	j	vTaskExitCritical
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	vTimerSetTimerID
	.size	vTimerSetTimerID, .-vTimerSetTimerID
	.align	2
	.globl	xTimerPendFunctionCallFromISR
	.set	nomips16
	.set	nomicromips
	.ent	xTimerPendFunctionCallFromISR
	.type	xTimerPendFunctionCallFromISR, @function
xTimerPendFunctionCallFromISR:
	.frame	$sp,40,$31		# vars= 16, regs= 1/0, args= 16, gp= 0
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-40
	move	$2,$7
	sw	$4,20($sp)
	lw	$4,%gp_rel(xTimerQueue)($28)
	sw	$5,24($sp)
	sw	$6,28($sp)
	li	$3,-2			# 0xfffffffffffffffe
	addiu	$5,$sp,16
	move	$7,$0
	move	$6,$2
	sw	$31,36($sp)
	jal	xQueueGenericSendFromISR
	sw	$3,16($sp)

	lw	$31,36($sp)
	nop
	jr	$31
	addiu	$sp,$sp,40

	.set	macro
	.set	reorder
	.end	xTimerPendFunctionCallFromISR
	.size	xTimerPendFunctionCallFromISR, .-xTimerPendFunctionCallFromISR
	.align	2
	.globl	xTimerPendFunctionCall
	.set	nomips16
	.set	nomicromips
	.ent	xTimerPendFunctionCall
	.type	xTimerPendFunctionCall, @function
xTimerPendFunctionCall:
	.frame	$sp,56,$31		# vars= 16, regs= 5/0, args= 16, gp= 0
	.mask	0x800f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lw	$2,%gp_rel(xTimerQueue)($28)
	addiu	$sp,$sp,-56
	sw	$19,48($sp)
	sw	$18,44($sp)
	sw	$17,40($sp)
	sw	$16,36($sp)
	sw	$31,52($sp)
	move	$19,$4
	move	$18,$5
	move	$17,$6
	bne	$2,$0,$L111
	move	$16,$7

	lui	$4,%hi($LC1)
	li	$5,1067			# 0x42b
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC1)

$L111:
	lw	$4,%gp_rel(xTimerQueue)($28)
	li	$2,-1			# 0xffffffffffffffff
	move	$6,$16
	addiu	$5,$sp,16
	move	$7,$0
	sw	$19,20($sp)
	sw	$18,24($sp)
	sw	$17,28($sp)
	jal	xQueueGenericSend
	sw	$2,16($sp)

	lw	$31,52($sp)
	lw	$19,48($sp)
	lw	$18,44($sp)
	lw	$17,40($sp)
	lw	$16,36($sp)
	jr	$31
	addiu	$sp,$sp,56

	.set	macro
	.set	reorder
	.end	xTimerPendFunctionCall
	.size	xTimerPendFunctionCall, .-xTimerPendFunctionCall
	.local	xLastTime.2680
	.comm	xLastTime.2680,4,4
	.local	xTimerTaskHandle
	.comm	xTimerTaskHandle,4,4
	.local	xTimerQueue
	.comm	xTimerQueue,4,4
	.local	pxOverflowTimerList
	.comm	pxOverflowTimerList,4,4
	.local	pxCurrentTimerList
	.comm	pxCurrentTimerList,4,4
	.local	xActiveTimerList2
	.comm	xActiveTimerList2,20,4
	.local	xActiveTimerList1
	.comm	xActiveTimerList1,20,4
	.ident	"GCC: (GNU) 6.3.0"
