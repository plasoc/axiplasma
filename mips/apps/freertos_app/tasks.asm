	.file	1 "tasks.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=32
	.module	nooddspreg
	.text
	.align	2
	.set	nomips16
	.set	nomicromips
	.ent	prvSearchForNameWithinSingleList
	.type	prvSearchForNameWithinSingleList, @function
prvSearchForNameWithinSingleList:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lw	$2,0($4)
	nop
	beq	$2,$0,$L2
	addiu	$7,$4,8

	lw	$2,4($4)
	nop
	lw	$2,4($2)
	nop
	bne	$2,$7,$L3
	sw	$2,4($4)

	lw	$2,12($4)
	nop
	sw	$2,4($4)
$L3:
	lw	$2,4($4)
	nop
	lw	$9,12($2)
$L8:
	lw	$2,4($4)
	nop
	lw	$2,4($2)
	nop
	bne	$7,$2,$L4
	sw	$2,4($4)

	lw	$2,12($4)
	nop
	sw	$2,4($4)
$L4:
	lw	$2,4($4)
	move	$6,$5
	lw	$2,12($2)
	nop
	addiu	$3,$2,52
	addiu	$10,$2,68
$L7:
	lb	$11,0($3)
	lb	$8,0($6)
	nop
	bne	$8,$11,$L5
	nop

	beq	$8,$0,$L17
	addiu	$3,$3,1

	bne	$3,$10,$L7
	addiu	$6,$6,1

$L5:
	bne	$9,$2,$L8
	nop

$L2:
	move	$2,$0
$L17:
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	prvSearchForNameWithinSingleList
	.size	prvSearchForNameWithinSingleList, .-prvSearchForNameWithinSingleList
	.align	2
	.set	nomips16
	.set	nomicromips
	.ent	prvResetNextTaskUnblockTime
	.type	prvResetNextTaskUnblockTime, @function
prvResetNextTaskUnblockTime:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lw	$2,%gp_rel(pxDelayedTaskList)($28)
	nop
	lw	$2,0($2)
	nop
	bne	$2,$0,$L19
	nop

	li	$2,-1			# 0xffffffffffffffff
$L21:
	sw	$2,%gp_rel(xNextTaskUnblockTime)($28)
	jr	$31
	nop

$L19:
	lw	$2,%gp_rel(pxDelayedTaskList)($28)
	nop
	lw	$2,12($2)
	nop
	lw	$2,12($2)
	nop
	lw	$2,4($2)
	b	$L21
	nop

	.set	macro
	.set	reorder
	.end	prvResetNextTaskUnblockTime
	.size	prvResetNextTaskUnblockTime, .-prvResetNextTaskUnblockTime
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
$LC0:
	.ascii	"../../freertos/tasks.c\000"
	.text
	.align	2
	.set	nomips16
	.set	nomicromips
	.ent	prvTaskIsTaskSuspended
	.type	prvTaskIsTaskSuspended, @function
prvTaskIsTaskSuspended:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$16,16($sp)
	sw	$31,20($sp)
	bne	$4,$0,$L23
	move	$16,$4

	lui	$4,%hi($LC0)
	li	$5,1665			# 0x681
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L23:
	lui	$3,%hi(xSuspendedTaskList)
	lw	$4,20($16)
	addiu	$3,$3,%lo(xSuspendedTaskList)
	bne	$4,$3,$L22
	move	$2,$0

	lui	$3,%hi(xPendingReadyList)
	lw	$4,40($16)
	addiu	$3,$3,%lo(xPendingReadyList)
	beq	$4,$3,$L22
	nop

	sltu	$2,$4,1
$L22:
	lw	$31,20($sp)
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,24

	.set	macro
	.set	reorder
	.end	prvTaskIsTaskSuspended
	.size	prvTaskIsTaskSuspended, .-prvTaskIsTaskSuspended
	.align	2
	.set	nomips16
	.set	nomicromips
	.ent	prvAddCurrentTaskToDelayedList
	.type	prvAddCurrentTaskToDelayedList, @function
prvAddCurrentTaskToDelayedList:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, gp= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$17,%gp_rel(xTickCount)($28)
	move	$16,$4
	lw	$2,%gp_rel(pxCurrentTCB)($28)
	lw	$4,%gp_rel(pxCurrentTCB)($28)
	sw	$18,24($sp)
	sw	$31,28($sp)
	addiu	$4,$4,4
	sb	$0,85($2)
	jal	uxListRemove
	move	$18,$5

	li	$2,-1			# 0xffffffffffffffff
	bne	$16,$2,$L29
	nop

	beq	$18,$0,$L36
	addu	$16,$17,$16

	lw	$5,%gp_rel(pxCurrentTCB)($28)
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	lui	$4,%hi(xSuspendedTaskList)
	addiu	$5,$5,4
	addiu	$4,$4,%lo(xSuspendedTaskList)
	j	vListInsertEnd
	addiu	$sp,$sp,32

$L29:
	addu	$16,$17,$16
$L36:
	lw	$2,%gp_rel(pxCurrentTCB)($28)
	sltu	$17,$16,$17
	beq	$17,$0,$L30
	sw	$16,4($2)

	lw	$4,%gp_rel(pxOverflowDelayedTaskList)($28)
	lw	$5,%gp_rel(pxCurrentTCB)($28)
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addiu	$5,$5,4
	j	vListInsert
	addiu	$sp,$sp,32

$L30:
	lw	$4,%gp_rel(pxDelayedTaskList)($28)
	lw	$5,%gp_rel(pxCurrentTCB)($28)
	jal	vListInsert
	addiu	$5,$5,4

	lw	$2,%gp_rel(xNextTaskUnblockTime)($28)
	nop
	sltu	$2,$16,$2
	beq	$2,$0,$L28
	nop

	sw	$16,%gp_rel(xNextTaskUnblockTime)($28)
$L28:
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	prvAddCurrentTaskToDelayedList
	.size	prvAddCurrentTaskToDelayedList, .-prvAddCurrentTaskToDelayedList
	.align	2
	.globl	uxTaskPriorityGetFromISR
	.set	nomips16
	.set	nomicromips
	.ent	uxTaskPriorityGetFromISR
	.type	uxTaskPriorityGetFromISR, @function
uxTaskPriorityGetFromISR:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L38
	nop

	lw	$4,%gp_rel(pxCurrentTCB)($28)
	nop
$L38:
	lw	$2,44($4)
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	uxTaskPriorityGetFromISR
	.size	uxTaskPriorityGetFromISR, .-uxTaskPriorityGetFromISR
	.align	2
	.globl	xTaskResumeFromISR
	.set	nomips16
	.set	nomicromips
	.ent	xTaskResumeFromISR
	.type	xTaskResumeFromISR, @function
xTaskResumeFromISR:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, gp= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$17,20($sp)
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$16,16($sp)
	bne	$4,$0,$L41
	move	$17,$4

	lui	$4,%hi($LC0)
	li	$5,1762			# 0x6e2
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L41:
	jal	prvTaskIsTaskSuspended
	move	$4,$17

	beq	$2,$0,$L40
	move	$16,$0

	lw	$2,%gp_rel(uxSchedulerSuspended)($28)
	nop
	bne	$2,$0,$L43
	lui	$4,%hi(xPendingReadyList)

	lw	$2,%gp_rel(pxCurrentTCB)($28)
	lw	$16,44($17)
	lw	$2,44($2)
	addiu	$18,$17,4
	move	$4,$18
	jal	uxListRemove
	sltu	$16,$16,$2

	lw	$4,44($17)
	lw	$2,%gp_rel(uxTopReadyPriority)($28)
	nop
	sltu	$2,$2,$4
	beq	$2,$0,$L44
	xori	$16,$16,0x1

	sw	$4,%gp_rel(uxTopReadyPriority)($28)
$L44:
	sll	$2,$4,2
	addu	$2,$2,$4
	lui	$4,%hi(pxReadyTasksLists)
	sll	$2,$2,2
	addiu	$4,$4,%lo(pxReadyTasksLists)
	move	$5,$18
	addu	$4,$4,$2
$L48:
	jal	vListInsertEnd
	nop

$L40:
	lw	$31,28($sp)
	move	$2,$16
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,32

$L43:
	addiu	$5,$17,24
	b	$L48
	addiu	$4,$4,%lo(xPendingReadyList)

	.set	macro
	.set	reorder
	.end	xTaskResumeFromISR
	.size	xTaskResumeFromISR, .-xTaskResumeFromISR
	.align	2
	.globl	vTaskEndScheduler
	.set	nomips16
	.set	nomicromips
	.ent	vTaskEndScheduler
	.type	vTaskEndScheduler, @function
vTaskEndScheduler:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, gp= 0
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	jal	FreeRTOS_DisableInterrupts
	nop

	lw	$31,20($sp)
	addiu	$sp,$sp,24
	sw	$0,%gp_rel(xSchedulerRunning)($28)
	j	vPortEndScheduler
	nop

	.set	macro
	.set	reorder
	.end	vTaskEndScheduler
	.size	vTaskEndScheduler, .-vTaskEndScheduler
	.align	2
	.globl	vTaskSuspendAll
	.set	nomips16
	.set	nomicromips
	.ent	vTaskSuspendAll
	.type	vTaskSuspendAll, @function
vTaskSuspendAll:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lw	$2,%gp_rel(uxSchedulerSuspended)($28)
	nop
	addiu	$2,$2,1
	sw	$2,%gp_rel(uxSchedulerSuspended)($28)
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	vTaskSuspendAll
	.size	vTaskSuspendAll, .-vTaskSuspendAll
	.align	2
	.globl	xTaskGetTickCount
	.set	nomips16
	.set	nomicromips
	.ent	xTaskGetTickCount
	.type	xTaskGetTickCount, @function
xTaskGetTickCount:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lw	$2,%gp_rel(xTickCount)($28)
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	xTaskGetTickCount
	.size	xTaskGetTickCount, .-xTaskGetTickCount
	.align	2
	.globl	xTaskGetTickCountFromISR
	.set	nomips16
	.set	nomicromips
	.ent	xTaskGetTickCountFromISR
	.type	xTaskGetTickCountFromISR, @function
xTaskGetTickCountFromISR:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lw	$2,%gp_rel(xTickCount)($28)
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	xTaskGetTickCountFromISR
	.size	xTaskGetTickCountFromISR, .-xTaskGetTickCountFromISR
	.align	2
	.globl	uxTaskGetNumberOfTasks
	.set	nomips16
	.set	nomicromips
	.ent	uxTaskGetNumberOfTasks
	.type	uxTaskGetNumberOfTasks, @function
uxTaskGetNumberOfTasks:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lw	$2,%gp_rel(uxCurrentNumberOfTasks)($28)
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	uxTaskGetNumberOfTasks
	.size	uxTaskGetNumberOfTasks, .-uxTaskGetNumberOfTasks
	.align	2
	.globl	pcTaskGetName
	.set	nomips16
	.set	nomicromips
	.ent	pcTaskGetName
	.type	pcTaskGetName, @function
pcTaskGetName:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$16,16($sp)
	sw	$31,20($sp)
	bne	$4,$0,$L56
	move	$16,$4

	lw	$16,%gp_rel(pxCurrentTCB)($28)
	nop
	bne	$16,$0,$L56
	li	$5,2188			# 0x88c

	lui	$4,%hi($LC0)
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L56:
	lw	$31,20($sp)
	addiu	$2,$16,52
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,24

	.set	macro
	.set	reorder
	.end	pcTaskGetName
	.size	pcTaskGetName, .-pcTaskGetName
	.align	2
	.globl	xTaskGetIdleTaskHandle
	.set	nomips16
	.set	nomicromips
	.ent	xTaskGetIdleTaskHandle
	.type	xTaskGetIdleTaskHandle, @function
xTaskGetIdleTaskHandle:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, gp= 0
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lw	$2,%gp_rel(xIdleTaskHandle)($28)
	addiu	$sp,$sp,-24
	bne	$2,$0,$L60
	sw	$31,20($sp)

	lui	$4,%hi($LC0)
	li	$5,2399			# 0x95f
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L60:
	lw	$31,20($sp)
	lw	$2,%gp_rel(xIdleTaskHandle)($28)
	jr	$31
	addiu	$sp,$sp,24

	.set	macro
	.set	reorder
	.end	xTaskGetIdleTaskHandle
	.size	xTaskGetIdleTaskHandle, .-xTaskGetIdleTaskHandle
	.align	2
	.globl	xTaskIncrementTick
	.set	nomips16
	.set	nomicromips
	.ent	xTaskIncrementTick
	.type	xTaskIncrementTick, @function
xTaskIncrementTick:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, gp= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lw	$2,%gp_rel(uxSchedulerSuspended)($28)
	addiu	$sp,$sp,-40
	sw	$31,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	bne	$2,$0,$L63
	sw	$16,16($sp)

	lw	$17,%gp_rel(xTickCount)($28)
	nop
	addiu	$17,$17,1
	sw	$17,%gp_rel(xTickCount)($28)
	bne	$17,$0,$L64
	nop

	lw	$2,%gp_rel(pxDelayedTaskList)($28)
	nop
	lw	$2,0($2)
	nop
	beq	$2,$0,$L65
	li	$5,2521			# 0x9d9

	lui	$4,%hi($LC0)
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L65:
	lw	$2,%gp_rel(pxDelayedTaskList)($28)
	lw	$3,%gp_rel(pxOverflowDelayedTaskList)($28)
	nop
	sw	$3,%gp_rel(pxDelayedTaskList)($28)
	sw	$2,%gp_rel(pxOverflowDelayedTaskList)($28)
	lw	$2,%gp_rel(xNumOfOverflows)($28)
	nop
	addiu	$2,$2,1
	sw	$2,%gp_rel(xNumOfOverflows)($28)
	jal	prvResetNextTaskUnblockTime
	nop

$L64:
	lw	$2,%gp_rel(xNextTaskUnblockTime)($28)
	lui	$16,%hi(pxReadyTasksLists)
	sltu	$2,$17,$2
	addiu	$16,$16,%lo(pxReadyTasksLists)
	bne	$2,$0,$L66
	move	$19,$0

$L67:
	lw	$2,%gp_rel(pxDelayedTaskList)($28)
	nop
	lw	$2,0($2)
	nop
	bne	$2,$0,$L68
	li	$2,-1			# 0xffffffffffffffff

$L86:
	sw	$2,%gp_rel(xNextTaskUnblockTime)($28)
$L66:
	lw	$2,%gp_rel(pxCurrentTCB)($28)
	nop
	lw	$3,44($2)
	nop
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$16,$16,$2
	lw	$2,0($16)
	nop
	sltu	$2,$2,2
	bne	$2,$0,$L73
	nop

	li	$19,1			# 0x1
$L73:
	lw	$2,%gp_rel(xYieldPending)($28)
	nop
	beq	$2,$0,$L62
	nop

	li	$19,1			# 0x1
$L62:
	lw	$31,36($sp)
	move	$2,$19
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,40

$L68:
	lw	$2,%gp_rel(pxDelayedTaskList)($28)
	nop
	lw	$2,12($2)
	nop
	lw	$18,12($2)
	nop
	lw	$2,4($18)
	nop
	sltu	$3,$17,$2
	bne	$3,$0,$L86
	addiu	$20,$18,4

	jal	uxListRemove
	move	$4,$20

	lw	$2,40($18)
	nop
	beq	$2,$0,$L70
	nop

	jal	uxListRemove
	addiu	$4,$18,24

$L70:
	lw	$2,44($18)
	lw	$3,%gp_rel(uxTopReadyPriority)($28)
	nop
	sltu	$3,$3,$2
	beq	$3,$0,$L71
	nop

	sw	$2,%gp_rel(uxTopReadyPriority)($28)
$L71:
	sll	$4,$2,2
	addu	$4,$4,$2
	sll	$4,$4,2
	move	$5,$20
	jal	vListInsertEnd
	addu	$4,$16,$4

	lw	$3,%gp_rel(pxCurrentTCB)($28)
	lw	$2,44($18)
	lw	$3,44($3)
	nop
	sltu	$2,$2,$3
	bne	$2,$0,$L67
	nop

	b	$L67
	li	$19,1			# 0x1

$L63:
	lw	$2,%gp_rel(uxPendedTicks)($28)
	move	$19,$0
	addiu	$2,$2,1
	sw	$2,%gp_rel(uxPendedTicks)($28)
	b	$L73
	nop

	.set	macro
	.set	reorder
	.end	xTaskIncrementTick
	.size	xTaskIncrementTick, .-xTaskIncrementTick
	.align	2
	.globl	vTaskSwitchContext
	.set	nomips16
	.set	nomicromips
	.ent	vTaskSwitchContext
	.type	vTaskSwitchContext, @function
vTaskSwitchContext:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, gp= 0
	.mask	0x800f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lw	$2,%gp_rel(uxSchedulerSuspended)($28)
	addiu	$sp,$sp,-40
	sw	$31,36($sp)
	sw	$19,32($sp)
	sw	$18,28($sp)
	sw	$17,24($sp)
	beq	$2,$0,$L88
	sw	$16,20($sp)

	li	$2,1			# 0x1
	sw	$2,%gp_rel(xYieldPending)($28)
$L87:
	lw	$31,36($sp)
	lw	$19,32($sp)
	lw	$18,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	jr	$31
	addiu	$sp,$sp,40

$L88:
	sw	$0,%gp_rel(xYieldPending)($28)
	lw	$16,%gp_rel(uxTopReadyPriority)($28)
	lui	$18,%hi(pxReadyTasksLists)
	sll	$17,$16,2
	addu	$17,$17,$16
	sll	$17,$17,2
	addiu	$18,$18,%lo(pxReadyTasksLists)
	lui	$19,%hi($LC0)
	addu	$17,$18,$17
	addiu	$19,$19,%lo($LC0)
$L90:
	lw	$2,0($17)
	nop
	beq	$2,$0,$L92
	sll	$3,$16,2

	addu	$2,$3,$16
	sll	$2,$2,2
	addu	$4,$18,$2
	lw	$5,4($4)
	addiu	$2,$2,8
	lw	$5,4($5)
	addu	$2,$18,$2
	bne	$5,$2,$L93
	sw	$5,4($4)

	lw	$2,4($5)
	nop
	sw	$2,4($4)
$L93:
	addu	$3,$3,$16
	sll	$3,$3,2
	addu	$18,$18,$3
	lw	$2,4($18)
	nop
	lw	$2,12($2)
	nop
	sw	$2,%gp_rel(pxCurrentTCB)($28)
	sw	$16,%gp_rel(uxTopReadyPriority)($28)
	b	$L87
	nop

$L92:
	bne	$16,$0,$L91
	li	$5,2806			# 0xaf6

	jal	vAssertCalled
	move	$4,$19

$L91:
	addiu	$16,$16,-1
	b	$L90
	addiu	$17,$17,-20

	.set	macro
	.set	reorder
	.end	vTaskSwitchContext
	.size	vTaskSwitchContext, .-vTaskSwitchContext
	.align	2
	.globl	vTaskPlaceOnEventList
	.set	nomips16
	.set	nomicromips
	.ent	vTaskPlaceOnEventList
	.type	vTaskPlaceOnEventList, @function
vTaskPlaceOnEventList:
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
	bne	$4,$0,$L96
	move	$17,$5

	lui	$4,%hi($LC0)
	li	$5,2822			# 0xb06
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L96:
	lw	$5,%gp_rel(pxCurrentTCB)($28)
	move	$4,$16
	jal	vListInsert
	addiu	$5,$5,24

	lw	$31,28($sp)
	lw	$16,20($sp)
	move	$4,$17
	lw	$17,24($sp)
	li	$5,1			# 0x1
	j	prvAddCurrentTaskToDelayedList
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	vTaskPlaceOnEventList
	.size	vTaskPlaceOnEventList, .-vTaskPlaceOnEventList
	.align	2
	.globl	vTaskPlaceOnUnorderedEventList
	.set	nomips16
	.set	nomicromips
	.ent	vTaskPlaceOnUnorderedEventList
	.type	vTaskPlaceOnUnorderedEventList, @function
vTaskPlaceOnUnorderedEventList:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, gp= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	sw	$31,28($sp)
	move	$17,$4
	move	$16,$5
	bne	$4,$0,$L99
	move	$18,$6

	lui	$4,%hi($LC0)
	li	$5,2839			# 0xb17
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L99:
	lw	$2,%gp_rel(uxSchedulerSuspended)($28)
	nop
	bne	$2,$0,$L100
	lui	$4,%hi($LC0)

	li	$5,2843			# 0xb1b
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L100:
	lw	$2,%gp_rel(pxCurrentTCB)($28)
	li	$3,-2147483648			# 0xffffffff80000000
	lw	$5,%gp_rel(pxCurrentTCB)($28)
	or	$16,$16,$3
	move	$4,$17
	sw	$16,24($2)
	jal	vListInsertEnd
	addiu	$5,$5,24

	lw	$31,28($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	move	$4,$18
	lw	$18,24($sp)
	li	$5,1			# 0x1
	j	prvAddCurrentTaskToDelayedList
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	vTaskPlaceOnUnorderedEventList
	.size	vTaskPlaceOnUnorderedEventList, .-vTaskPlaceOnUnorderedEventList
	.align	2
	.globl	xTaskRemoveFromEventList
	.set	nomips16
	.set	nomicromips
	.ent	xTaskRemoveFromEventList
	.type	xTaskRemoveFromEventList, @function
xTaskRemoveFromEventList:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, gp= 0
	.mask	0x80030000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lw	$2,12($4)
	addiu	$sp,$sp,-32
	sw	$16,20($sp)
	lw	$16,12($2)
	sw	$31,28($sp)
	bne	$16,$0,$L103
	sw	$17,24($sp)

	lui	$4,%hi($LC0)
	li	$5,2913			# 0xb61
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L103:
	addiu	$17,$16,24
	jal	uxListRemove
	move	$4,$17

	lw	$2,%gp_rel(uxSchedulerSuspended)($28)
	nop
	bne	$2,$0,$L104
	lui	$4,%hi(xPendingReadyList)

	addiu	$17,$16,4
	jal	uxListRemove
	move	$4,$17

	lw	$4,44($16)
	lw	$2,%gp_rel(uxTopReadyPriority)($28)
	nop
	sltu	$2,$2,$4
	beq	$2,$0,$L105
	nop

	sw	$4,%gp_rel(uxTopReadyPriority)($28)
$L105:
	sll	$2,$4,2
	addu	$2,$2,$4
	lui	$4,%hi(pxReadyTasksLists)
	sll	$2,$2,2
	addiu	$4,$4,%lo(pxReadyTasksLists)
	move	$5,$17
	addu	$4,$4,$2
$L110:
	jal	vListInsertEnd
	nop

	lw	$2,%gp_rel(pxCurrentTCB)($28)
	lw	$3,44($16)
	lw	$2,44($2)
	nop
	sltu	$3,$2,$3
	beq	$3,$0,$L102
	move	$2,$0

	li	$2,1			# 0x1
	sw	$2,%gp_rel(xYieldPending)($28)
$L102:
	lw	$31,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	jr	$31
	addiu	$sp,$sp,32

$L104:
	move	$5,$17
	b	$L110
	addiu	$4,$4,%lo(xPendingReadyList)

	.set	macro
	.set	reorder
	.end	xTaskRemoveFromEventList
	.size	xTaskRemoveFromEventList, .-xTaskRemoveFromEventList
	.align	2
	.globl	xTaskRemoveFromUnorderedEventList
	.set	nomips16
	.set	nomicromips
	.ent	xTaskRemoveFromUnorderedEventList
	.type	xTaskRemoveFromUnorderedEventList, @function
xTaskRemoveFromUnorderedEventList:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, gp= 0
	.mask	0x80030000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lw	$2,%gp_rel(uxSchedulerSuspended)($28)
	addiu	$sp,$sp,-32
	sw	$17,24($sp)
	sw	$16,20($sp)
	sw	$31,28($sp)
	move	$17,$4
	bne	$2,$0,$L112
	move	$16,$5

	lui	$4,%hi($LC0)
	li	$5,2969			# 0xb99
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L112:
	li	$2,-2147483648			# 0xffffffff80000000
	or	$16,$16,$2
	sw	$16,0($17)
	lw	$16,12($17)
	nop
	bne	$16,$0,$L113
	li	$5,2977			# 0xba1

	lui	$4,%hi($LC0)
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L113:
	move	$4,$17
	jal	uxListRemove
	addiu	$17,$16,4

	jal	uxListRemove
	move	$4,$17

	lw	$4,44($16)
	lw	$2,%gp_rel(uxTopReadyPriority)($28)
	nop
	sltu	$2,$2,$4
	beq	$2,$0,$L114
	nop

	sw	$4,%gp_rel(uxTopReadyPriority)($28)
$L114:
	sll	$2,$4,2
	addu	$2,$2,$4
	lui	$4,%hi(pxReadyTasksLists)
	sll	$2,$2,2
	addiu	$4,$4,%lo(pxReadyTasksLists)
	addu	$4,$4,$2
	jal	vListInsertEnd
	move	$5,$17

	lw	$2,%gp_rel(pxCurrentTCB)($28)
	lw	$3,44($16)
	lw	$2,44($2)
	nop
	sltu	$3,$2,$3
	beq	$3,$0,$L111
	move	$2,$0

	li	$2,1			# 0x1
	sw	$2,%gp_rel(xYieldPending)($28)
$L111:
	lw	$31,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	jr	$31
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	xTaskRemoveFromUnorderedEventList
	.size	xTaskRemoveFromUnorderedEventList, .-xTaskRemoveFromUnorderedEventList
	.align	2
	.globl	vTaskSetTimeOutState
	.set	nomips16
	.set	nomicromips
	.ent	vTaskSetTimeOutState
	.type	vTaskSetTimeOutState, @function
vTaskSetTimeOutState:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$16,16($sp)
	sw	$31,20($sp)
	bne	$4,$0,$L119
	move	$16,$4

	lui	$4,%hi($LC0)
	li	$5,3009			# 0xbc1
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L119:
	lw	$2,%gp_rel(xNumOfOverflows)($28)
	lw	$31,20($sp)
	sw	$2,0($16)
	lw	$2,%gp_rel(xTickCount)($28)
	nop
	sw	$2,4($16)
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,24

	.set	macro
	.set	reorder
	.end	vTaskSetTimeOutState
	.size	vTaskSetTimeOutState, .-vTaskSetTimeOutState
	.align	2
	.globl	vTaskMissedYield
	.set	nomips16
	.set	nomicromips
	.ent	vTaskMissedYield
	.type	vTaskMissedYield, @function
vTaskMissedYield:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	li	$2,1			# 0x1
	sw	$2,%gp_rel(xYieldPending)($28)
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	vTaskMissedYield
	.size	vTaskMissedYield, .-vTaskMissedYield
	.align	2
	.globl	uxTaskGetStackHighWaterMark
	.set	nomips16
	.set	nomicromips
	.ent	uxTaskGetStackHighWaterMark
	.type	uxTaskGetStackHighWaterMark, @function
uxTaskGetStackHighWaterMark:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L123
	nop

	lw	$4,%gp_rel(pxCurrentTCB)($28)
	nop
$L123:
	lw	$4,48($4)
	li	$5,165			# 0xa5
	move	$3,$4
$L124:
	lbu	$6,0($3)
	nop
	beq	$6,$5,$L125
	subu	$2,$3,$4

	srl	$2,$2,2
	jr	$31
	andi	$2,$2,0xffff

$L125:
	b	$L124
	addiu	$3,$3,1

	.set	macro
	.set	reorder
	.end	uxTaskGetStackHighWaterMark
	.size	uxTaskGetStackHighWaterMark, .-uxTaskGetStackHighWaterMark
	.align	2
	.globl	xTaskGetCurrentTaskHandle
	.set	nomips16
	.set	nomicromips
	.ent	xTaskGetCurrentTaskHandle
	.type	xTaskGetCurrentTaskHandle, @function
xTaskGetCurrentTaskHandle:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lw	$2,%gp_rel(pxCurrentTCB)($28)
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	xTaskGetCurrentTaskHandle
	.size	xTaskGetCurrentTaskHandle, .-xTaskGetCurrentTaskHandle
	.align	2
	.globl	xTaskGetSchedulerState
	.set	nomips16
	.set	nomicromips
	.ent	xTaskGetSchedulerState
	.type	xTaskGetSchedulerState, @function
xTaskGetSchedulerState:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lw	$3,%gp_rel(xSchedulerRunning)($28)
	nop
	beq	$3,$0,$L133
	li	$2,1			# 0x1

	lw	$2,%gp_rel(uxSchedulerSuspended)($28)
	nop
	sltu	$2,$2,1
	sll	$2,$2,1
$L133:
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	xTaskGetSchedulerState
	.size	xTaskGetSchedulerState, .-xTaskGetSchedulerState
	.align	2
	.globl	vTaskPriorityInherit
	.set	nomips16
	.set	nomicromips
	.ent	vTaskPriorityInherit
	.type	vTaskPriorityInherit, @function
vTaskPriorityInherit:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, gp= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L146
	nop

	lw	$2,%gp_rel(pxCurrentTCB)($28)
	lw	$3,44($4)
	lw	$2,44($2)
	addiu	$sp,$sp,-32
	sltu	$2,$3,$2
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	beq	$2,$0,$L134
	sw	$16,16($sp)

	lw	$2,24($4)
	nop
	bltz	$2,$L147
	sll	$2,$3,2

	lw	$2,%gp_rel(pxCurrentTCB)($28)
	nop
	lw	$5,44($2)
	li	$2,5			# 0x5
	subu	$2,$2,$5
	sw	$2,24($4)
	sll	$2,$3,2
$L147:
	addu	$2,$2,$3
	lui	$17,%hi(pxReadyTasksLists)
	sll	$2,$2,2
	addiu	$17,$17,%lo(pxReadyTasksLists)
	lw	$3,20($4)
	addu	$2,$17,$2
	bne	$3,$2,$L137
	addiu	$18,$4,4

	move	$16,$4
	jal	uxListRemove
	move	$4,$18

	lw	$2,%gp_rel(pxCurrentTCB)($28)
	lw	$3,%gp_rel(uxTopReadyPriority)($28)
	lw	$2,44($2)
	nop
	sltu	$3,$3,$2
	beq	$3,$0,$L138
	sw	$2,44($16)

	sw	$2,%gp_rel(uxTopReadyPriority)($28)
$L138:
	sll	$4,$2,2
	addu	$4,$4,$2
	sll	$4,$4,2
	lw	$31,28($sp)
	lw	$16,16($sp)
	move	$5,$18
	addu	$4,$17,$4
	lw	$18,24($sp)
	lw	$17,20($sp)
	j	vListInsertEnd
	addiu	$sp,$sp,32

$L137:
	lw	$2,%gp_rel(pxCurrentTCB)($28)
	nop
	lw	$2,44($2)
	nop
	sw	$2,44($4)
$L134:
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addiu	$sp,$sp,32
$L146:
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	vTaskPriorityInherit
	.size	vTaskPriorityInherit, .-vTaskPriorityInherit
	.align	2
	.globl	xTaskPriorityDisinherit
	.set	nomips16
	.set	nomicromips
	.ent	xTaskPriorityDisinherit
	.type	xTaskPriorityDisinherit, @function
xTaskPriorityDisinherit:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, gp= 0
	.mask	0x80030000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L149
	move	$2,$0

	jr	$31
	nop

$L153:
	move	$2,$0
$L148:
	lw	$31,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	jr	$31
	addiu	$sp,$sp,32

$L149:
	lw	$2,%gp_rel(pxCurrentTCB)($28)
	addiu	$sp,$sp,-32
	sw	$16,20($sp)
	sw	$31,28($sp)
	sw	$17,24($sp)
	beq	$4,$2,$L151
	move	$16,$4

	lui	$4,%hi($LC0)
	li	$5,3783			# 0xec7
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L151:
	lw	$2,76($16)
	nop
	bne	$2,$0,$L158
	lui	$4,%hi($LC0)

	li	$5,3785			# 0xec9
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

	lw	$2,76($16)
$L158:
	lw	$4,44($16)
	lw	$3,72($16)
	addiu	$2,$2,-1
	beq	$4,$3,$L153
	sw	$2,76($16)

	bne	$2,$0,$L148
	move	$2,$0

	addiu	$17,$16,4
	jal	uxListRemove
	move	$4,$17

	lw	$4,72($16)
	li	$2,5			# 0x5
	subu	$2,$2,$4
	sw	$2,24($16)
	lw	$2,%gp_rel(uxTopReadyPriority)($28)
	nop
	sltu	$2,$2,$4
	beq	$2,$0,$L154
	sw	$4,44($16)

	sw	$4,%gp_rel(uxTopReadyPriority)($28)
$L154:
	sll	$2,$4,2
	addu	$4,$2,$4
	lui	$2,%hi(pxReadyTasksLists)
	addiu	$2,$2,%lo(pxReadyTasksLists)
	sll	$4,$4,2
	addu	$4,$2,$4
	jal	vListInsertEnd
	move	$5,$17

	b	$L148
	li	$2,1			# 0x1

	.set	macro
	.set	reorder
	.end	xTaskPriorityDisinherit
	.size	xTaskPriorityDisinherit, .-xTaskPriorityDisinherit
	.align	2
	.globl	vTaskEnterCritical
	.set	nomips16
	.set	nomicromips
	.ent	vTaskEnterCritical
	.type	vTaskEnterCritical, @function
vTaskEnterCritical:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, gp= 0
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	jal	FreeRTOS_DisableInterrupts
	nop

	lw	$2,%gp_rel(xSchedulerRunning)($28)
	nop
	beq	$2,$0,$L159
	nop

	lw	$3,%gp_rel(pxCurrentTCB)($28)
	nop
	lw	$2,68($3)
	nop
	addiu	$2,$2,1
	sw	$2,68($3)
	lw	$2,%gp_rel(pxCurrentTCB)($28)
$L159:
	lw	$31,20($sp)
	nop
	jr	$31
	addiu	$sp,$sp,24

	.set	macro
	.set	reorder
	.end	vTaskEnterCritical
	.size	vTaskEnterCritical, .-vTaskEnterCritical
	.align	2
	.globl	vTaskExitCritical
	.set	nomips16
	.set	nomicromips
	.ent	vTaskExitCritical
	.type	vTaskExitCritical, @function
vTaskExitCritical:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lw	$2,%gp_rel(xSchedulerRunning)($28)
	nop
	beq	$2,$0,$L172
	nop

	lw	$2,%gp_rel(pxCurrentTCB)($28)
	nop
	lw	$2,68($2)
	nop
	beq	$2,$0,$L172
	nop

	lw	$3,%gp_rel(pxCurrentTCB)($28)
	nop
	lw	$2,68($3)
	nop
	addiu	$2,$2,-1
	sw	$2,68($3)
	lw	$2,%gp_rel(pxCurrentTCB)($28)
	nop
	lw	$2,68($2)
	nop
	bne	$2,$0,$L172
	nop

	j	FreeRTOS_EnableInterrupts
	nop

$L172:
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	vTaskExitCritical
	.size	vTaskExitCritical, .-vTaskExitCritical
	.align	2
	.globl	xTaskCreate
	.set	nomips16
	.set	nomicromips
	.ent	xTaskCreate
	.type	xTaskCreate, @function
xTaskCreate:
	.frame	$sp,56,$31		# vars= 0, regs= 9/0, args= 16, gp= 0
	.mask	0x80ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-56
	sw	$18,28($sp)
	sll	$18,$6,2
	sw	$20,36($sp)
	move	$20,$4
	move	$4,$18
	sw	$22,44($sp)
	sw	$21,40($sp)
	sw	$19,32($sp)
	sw	$17,24($sp)
	sw	$31,52($sp)
	sw	$23,48($sp)
	sw	$16,20($sp)
	move	$17,$5
	lw	$19,76($sp)
	jal	pvPortMalloc
	move	$21,$7

	beq	$2,$0,$L173
	li	$22,-1			# 0xffffffffffffffff

	li	$4,88			# 0x58
	jal	pvPortMalloc
	move	$23,$2

	beq	$2,$0,$L175
	move	$16,$2

	move	$6,$18
	li	$5,165			# 0xa5
	sw	$23,48($2)
	jal	memset
	move	$4,$23

	addiu	$2,$18,-4
	lw	$18,48($16)
	move	$5,$17
	addu	$18,$18,$2
	li	$2,-4			# 0xfffffffffffffffc
	and	$18,$18,$2
	addiu	$3,$17,16
	addiu	$2,$16,52
$L176:
	lb	$4,0($5)
	nop
	sb	$4,0($2)
	lb	$4,0($5)
	nop
	beq	$4,$0,$L177
	addiu	$5,$5,1

	bne	$3,$5,$L176
	addiu	$2,$2,1

$L177:
	lw	$22,72($sp)
	nop
	sltu	$2,$22,5
	bne	$2,$0,$L178
	sb	$0,67($16)

	li	$22,4			# 0x4
$L178:
	addiu	$17,$16,4
	sw	$22,44($16)
	sw	$22,72($16)
	move	$4,$17
	jal	vListInitialiseItem
	sw	$0,76($16)

	jal	vListInitialiseItem
	addiu	$4,$16,24

	li	$2,5			# 0x5
	subu	$22,$2,$22
	sw	$0,80($16)
	sw	$16,16($16)
	sw	$22,24($16)
	sw	$16,36($16)
	sw	$0,68($16)
	sb	$0,84($16)
	sb	$0,85($16)
	move	$6,$21
	move	$5,$20
	jal	pxPortInitialiseStack
	move	$4,$18

	beq	$19,$0,$L179
	sw	$2,0($16)

	sw	$16,0($19)
$L179:
	jal	vTaskEnterCritical
	nop

	lw	$2,%gp_rel(uxCurrentNumberOfTasks)($28)
	lui	$18,%hi(pxReadyTasksLists)
	addiu	$2,$2,1
	sw	$2,%gp_rel(uxCurrentNumberOfTasks)($28)
	lw	$2,%gp_rel(pxCurrentTCB)($28)
	nop
	bne	$2,$0,$L180
	nop

	sw	$16,%gp_rel(pxCurrentTCB)($28)
	lw	$3,%gp_rel(uxCurrentNumberOfTasks)($28)
	li	$2,1			# 0x1
	bne	$3,$2,$L182
	nop

	jal	vListInitialise
	addiu	$4,$18,%lo(pxReadyTasksLists)

	lui	$4,%hi(pxReadyTasksLists+20)
	jal	vListInitialise
	addiu	$4,$4,%lo(pxReadyTasksLists+20)

	lui	$4,%hi(pxReadyTasksLists+40)
	jal	vListInitialise
	addiu	$4,$4,%lo(pxReadyTasksLists+40)

	lui	$4,%hi(pxReadyTasksLists+60)
	jal	vListInitialise
	addiu	$4,$4,%lo(pxReadyTasksLists+60)

	lui	$4,%hi(pxReadyTasksLists+80)
	addiu	$4,$4,%lo(pxReadyTasksLists+80)
	jal	vListInitialise
	lui	$20,%hi(xDelayedTaskList1)

	lui	$19,%hi(xDelayedTaskList2)
	jal	vListInitialise
	addiu	$4,$20,%lo(xDelayedTaskList1)

	jal	vListInitialise
	addiu	$4,$19,%lo(xDelayedTaskList2)

	lui	$4,%hi(xPendingReadyList)
	jal	vListInitialise
	addiu	$4,$4,%lo(xPendingReadyList)

	lui	$4,%hi(xTasksWaitingTermination)
	jal	vListInitialise
	addiu	$4,$4,%lo(xTasksWaitingTermination)

	lui	$4,%hi(xSuspendedTaskList)
	addiu	$4,$4,%lo(xSuspendedTaskList)
	addiu	$20,$20,%lo(xDelayedTaskList1)
	jal	vListInitialise
	addiu	$19,$19,%lo(xDelayedTaskList2)

	sw	$20,%gp_rel(pxDelayedTaskList)($28)
	sw	$19,%gp_rel(pxOverflowDelayedTaskList)($28)
$L182:
	lw	$2,%gp_rel(uxTaskNumber)($28)
	lw	$4,44($16)
	addiu	$2,$2,1
	sw	$2,%gp_rel(uxTaskNumber)($28)
	lw	$2,%gp_rel(uxTopReadyPriority)($28)
	nop
	sltu	$2,$2,$4
	beq	$2,$0,$L197
	sll	$2,$4,2

	sw	$4,%gp_rel(uxTopReadyPriority)($28)
	sll	$2,$4,2
$L197:
	addu	$2,$2,$4
	sll	$2,$2,2
	addiu	$4,$18,%lo(pxReadyTasksLists)
	addu	$4,$4,$2
	jal	vListInsertEnd
	move	$5,$17

	jal	vTaskExitCritical
	nop

	lw	$2,%gp_rel(xSchedulerRunning)($28)
	nop
	beq	$2,$0,$L173
	li	$22,1			# 0x1

	lw	$2,%gp_rel(pxCurrentTCB)($28)
	lw	$3,44($16)
	lw	$2,44($2)
	nop
	sltu	$2,$2,$3
	beq	$2,$0,$L173
	nop

	sw	$22,%gp_rel(FreeRTOS_Yield)($28)
	jal	OS_Syscall
	nop

	b	$L173
	nop

$L175:
	jal	vPortFree
	move	$4,$23

	li	$22,-1			# 0xffffffffffffffff
$L173:
	lw	$31,52($sp)
	move	$2,$22
	lw	$23,48($sp)
	lw	$22,44($sp)
	lw	$21,40($sp)
	lw	$20,36($sp)
	lw	$19,32($sp)
	lw	$18,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	jr	$31
	addiu	$sp,$sp,56

$L180:
	lw	$2,%gp_rel(xSchedulerRunning)($28)
	nop
	bne	$2,$0,$L182
	nop

	lw	$2,%gp_rel(pxCurrentTCB)($28)
	lw	$3,44($16)
	lw	$2,44($2)
	nop
	sltu	$2,$3,$2
	bne	$2,$0,$L182
	nop

	sw	$16,%gp_rel(pxCurrentTCB)($28)
	b	$L182
	nop

	.set	macro
	.set	reorder
	.end	xTaskCreate
	.size	xTaskCreate, .-xTaskCreate
	.section	.rodata.str1.4
	.align	2
$LC1:
	.ascii	"IDLE\000"
	.text
	.align	2
	.globl	vTaskStartScheduler
	.set	nomips16
	.set	nomicromips
	.ent	vTaskStartScheduler
	.type	vTaskStartScheduler, @function
vTaskStartScheduler:
	.frame	$sp,32,$31		# vars= 0, regs= 2/0, args= 24, gp= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	addiu	$2,$28,%gp_rel(xIdleTaskHandle)
	lui	$5,%hi($LC1)
	lui	$4,%hi(prvIdleTask)
	move	$7,$0
	sw	$2,20($sp)
	sw	$0,16($sp)
	li	$6,256			# 0x100
	addiu	$5,$5,%lo($LC1)
	sw	$16,24($sp)
	sw	$31,28($sp)
	jal	xTaskCreate
	addiu	$4,$4,%lo(prvIdleTask)

	move	$16,$2
	li	$2,1			# 0x1
	bne	$16,$2,$L199
	li	$2,-1			# 0xffffffffffffffff

	jal	FreeRTOS_DisableInterrupts
	nop

	li	$2,-1			# 0xffffffffffffffff
	sw	$2,%gp_rel(xNextTaskUnblockTime)($28)
	lw	$31,28($sp)
	sw	$16,%gp_rel(xSchedulerRunning)($28)
	lw	$16,24($sp)
	addiu	$sp,$sp,32
	sw	$0,%gp_rel(xTickCount)($28)
	j	xPortStartScheduler
	nop

$L199:
	bne	$16,$2,$L198
	lui	$4,%hi($LC0)

	lw	$31,28($sp)
	lw	$16,24($sp)
	li	$5,1924			# 0x784
	addiu	$4,$4,%lo($LC0)
	j	vAssertCalled
	addiu	$sp,$sp,32

$L198:
	lw	$31,28($sp)
	lw	$16,24($sp)
	jr	$31
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	vTaskStartScheduler
	.size	vTaskStartScheduler, .-vTaskStartScheduler
	.align	2
	.globl	vTaskDelete
	.set	nomips16
	.set	nomicromips
	.ent	vTaskDelete
	.type	vTaskDelete, @function
vTaskDelete:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, gp= 0
	.mask	0x80030000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$16,20($sp)
	move	$16,$4
	sw	$31,28($sp)
	jal	vTaskEnterCritical
	sw	$17,24($sp)

	bne	$16,$0,$L220
	addiu	$17,$16,4

	lw	$16,%gp_rel(pxCurrentTCB)($28)
	nop
	addiu	$17,$16,4
$L220:
	jal	uxListRemove
	move	$4,$17

	lw	$2,40($16)
	nop
	beq	$2,$0,$L204
	nop

	jal	uxListRemove
	addiu	$4,$16,24

$L204:
	lw	$2,%gp_rel(uxTaskNumber)($28)
	nop
	addiu	$2,$2,1
	sw	$2,%gp_rel(uxTaskNumber)($28)
	lw	$2,%gp_rel(pxCurrentTCB)($28)
	nop
	bne	$16,$2,$L205
	move	$5,$17

	lui	$4,%hi(xTasksWaitingTermination)
	jal	vListInsertEnd
	addiu	$4,$4,%lo(xTasksWaitingTermination)

	lw	$2,%gp_rel(uxDeletedTasksWaitingCleanUp)($28)
	nop
	addiu	$2,$2,1
	sw	$2,%gp_rel(uxDeletedTasksWaitingCleanUp)($28)
$L206:
	jal	vTaskExitCritical
	nop

	lw	$2,%gp_rel(xSchedulerRunning)($28)
	nop
	beq	$2,$0,$L202
	nop

	lw	$2,%gp_rel(pxCurrentTCB)($28)
	nop
	bne	$16,$2,$L202
	nop

	lw	$2,%gp_rel(uxSchedulerSuspended)($28)
	nop
	beq	$2,$0,$L208
	li	$5,1125			# 0x465

	lui	$4,%hi($LC0)
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L208:
	lw	$31,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	li	$2,1			# 0x1
	addiu	$sp,$sp,32
	sw	$2,%gp_rel(FreeRTOS_Yield)($28)
	j	OS_Syscall
	nop

$L205:
	lw	$2,%gp_rel(uxCurrentNumberOfTasks)($28)
	lw	$4,48($16)
	addiu	$2,$2,-1
	sw	$2,%gp_rel(uxCurrentNumberOfTasks)($28)
	jal	vPortFree
	nop

	jal	vPortFree
	move	$4,$16

	jal	prvResetNextTaskUnblockTime
	nop

	b	$L206
	nop

$L202:
	lw	$31,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	jr	$31
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	vTaskDelete
	.size	vTaskDelete, .-vTaskDelete
	.align	2
	.globl	eTaskGetState
	.set	nomips16
	.set	nomicromips
	.ent	eTaskGetState
	.type	eTaskGetState, @function
eTaskGetState:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, gp= 0
	.mask	0x80030000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$17,24($sp)
	sw	$31,28($sp)
	sw	$16,20($sp)
	bne	$4,$0,$L222
	move	$17,$4

	lui	$4,%hi($LC0)
	li	$5,1275			# 0x4fb
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L222:
	lw	$3,%gp_rel(pxCurrentTCB)($28)
	nop
	beq	$17,$3,$L221
	move	$2,$0

	jal	vTaskEnterCritical
	nop

	lw	$16,20($17)
	jal	vTaskExitCritical
	nop

	lw	$3,%gp_rel(pxDelayedTaskList)($28)
	nop
	beq	$16,$3,$L221
	li	$2,2			# 0x2

	lw	$3,%gp_rel(pxOverflowDelayedTaskList)($28)
	nop
	beq	$16,$3,$L221
	nop

	lui	$2,%hi(xSuspendedTaskList)
	addiu	$2,$2,%lo(xSuspendedTaskList)
	bne	$16,$2,$L224
	lui	$3,%hi(xTasksWaitingTermination)

	lw	$2,40($17)
	nop
	sltu	$2,$2,1
	addiu	$2,$2,2
$L221:
	lw	$31,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	jr	$31
	addiu	$sp,$sp,32

$L224:
	addiu	$3,$3,%lo(xTasksWaitingTermination)
	beq	$16,$3,$L221
	li	$2,4			# 0x4

	beq	$16,$0,$L221
	nop

	b	$L221
	li	$2,1			# 0x1

	.set	macro
	.set	reorder
	.end	eTaskGetState
	.size	eTaskGetState, .-eTaskGetState
	.align	2
	.globl	uxTaskPriorityGet
	.set	nomips16
	.set	nomicromips
	.ent	uxTaskPriorityGet
	.type	uxTaskPriorityGet, @function
uxTaskPriorityGet:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$16,16($sp)
	sw	$31,20($sp)
	jal	vTaskEnterCritical
	move	$16,$4

	bne	$16,$0,$L233
	move	$4,$16

	lw	$4,%gp_rel(pxCurrentTCB)($28)
	nop
$L233:
	lw	$16,44($4)
	jal	vTaskExitCritical
	nop

	lw	$31,20($sp)
	move	$2,$16
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,24

	.set	macro
	.set	reorder
	.end	uxTaskPriorityGet
	.size	uxTaskPriorityGet, .-uxTaskPriorityGet
	.align	2
	.globl	vTaskPrioritySet
	.set	nomips16
	.set	nomicromips
	.ent	vTaskPrioritySet
	.type	vTaskPrioritySet, @function
vTaskPrioritySet:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, gp= 0
	.mask	0x800f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-40
	sltu	$2,$5,5
	sw	$18,28($sp)
	sw	$16,20($sp)
	sw	$31,36($sp)
	sw	$19,32($sp)
	sw	$17,24($sp)
	move	$16,$4
	bne	$2,$0,$L238
	move	$18,$5

	lui	$4,%hi($LC0)
	li	$5,1408			# 0x580
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

	li	$18,4			# 0x4
$L238:
	jal	vTaskEnterCritical
	nop

	bne	$16,$0,$L239
	nop

	lw	$16,%gp_rel(pxCurrentTCB)($28)
	nop
$L239:
	lw	$2,72($16)
	nop
	beq	$18,$2,$L241
	sltu	$3,$2,$18

	beq	$3,$0,$L242
	nop

	lw	$3,%gp_rel(pxCurrentTCB)($28)
	nop
	beq	$16,$3,$L243
	move	$17,$0

	lw	$3,%gp_rel(pxCurrentTCB)($28)
	nop
	lw	$17,44($3)
	nop
	sltu	$17,$18,$17
	xori	$17,$17,0x1
$L243:
	lw	$3,44($16)
	nop
	bne	$2,$3,$L244
	nop

	sw	$18,44($16)
$L244:
	lw	$2,24($16)
	nop
	bltz	$2,$L245
	sw	$18,72($16)

	li	$5,5			# 0x5
	subu	$18,$5,$18
	sw	$18,24($16)
$L245:
	sll	$2,$3,2
	addu	$2,$2,$3
	lui	$18,%hi(pxReadyTasksLists)
	sll	$2,$2,2
	addiu	$18,$18,%lo(pxReadyTasksLists)
	lw	$3,20($16)
	addu	$2,$18,$2
	bne	$3,$2,$L246
	addiu	$19,$16,4

	jal	uxListRemove
	move	$4,$19

	lw	$2,44($16)
	lw	$3,%gp_rel(uxTopReadyPriority)($28)
	nop
	sltu	$3,$3,$2
	beq	$3,$0,$L247
	nop

	sw	$2,%gp_rel(uxTopReadyPriority)($28)
$L247:
	sll	$4,$2,2
	addu	$4,$4,$2
	sll	$4,$4,2
	move	$5,$19
	jal	vListInsertEnd
	addu	$4,$18,$4

$L246:
	beq	$17,$0,$L241
	nop

	li	$2,1			# 0x1
	sw	$2,%gp_rel(FreeRTOS_Yield)($28)
	jal	OS_Syscall
	nop

$L241:
	lw	$31,36($sp)
	lw	$19,32($sp)
	lw	$18,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	j	vTaskExitCritical
	addiu	$sp,$sp,40

$L242:
	lw	$17,%gp_rel(pxCurrentTCB)($28)
	nop
	xor	$17,$16,$17
	b	$L243
	sltu	$17,$17,1

	.set	macro
	.set	reorder
	.end	vTaskPrioritySet
	.size	vTaskPrioritySet, .-vTaskPrioritySet
	.align	2
	.globl	vTaskSuspend
	.set	nomips16
	.set	nomicromips
	.ent	vTaskSuspend
	.type	vTaskSuspend, @function
vTaskSuspend:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, gp= 0
	.mask	0x80030000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$16,20($sp)
	move	$16,$4
	sw	$31,28($sp)
	jal	vTaskEnterCritical
	sw	$17,24($sp)

	bne	$16,$0,$L275
	addiu	$17,$16,4

	lw	$16,%gp_rel(pxCurrentTCB)($28)
	nop
	addiu	$17,$16,4
$L275:
	jal	uxListRemove
	move	$4,$17

	lw	$2,40($16)
	nop
	beq	$2,$0,$L276
	move	$5,$17

	jal	uxListRemove
	addiu	$4,$16,24

	move	$5,$17
$L276:
	lui	$17,%hi(xSuspendedTaskList)
	jal	vListInsertEnd
	addiu	$4,$17,%lo(xSuspendedTaskList)

	jal	vTaskExitCritical
	nop

	lw	$2,%gp_rel(xSchedulerRunning)($28)
	nop
	beq	$2,$0,$L259
	nop

	jal	vTaskEnterCritical
	nop

	jal	prvResetNextTaskUnblockTime
	nop

	jal	vTaskExitCritical
	nop

$L259:
	lw	$2,%gp_rel(pxCurrentTCB)($28)
	nop
	bne	$16,$2,$L256
	nop

	lw	$2,%gp_rel(xSchedulerRunning)($28)
	nop
	beq	$2,$0,$L261
	nop

	lw	$2,%gp_rel(uxSchedulerSuspended)($28)
	nop
	beq	$2,$0,$L262
	lui	$4,%hi($LC0)

	li	$5,1623			# 0x657
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L262:
	lw	$31,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	li	$2,1			# 0x1
	addiu	$sp,$sp,32
	sw	$2,%gp_rel(FreeRTOS_Yield)($28)
	j	OS_Syscall
	nop

$L261:
	lw	$2,%gp_rel(uxCurrentNumberOfTasks)($28)
	lw	$3,%lo(xSuspendedTaskList)($17)
	nop
	bne	$3,$2,$L263
	nop

	sw	$0,%gp_rel(pxCurrentTCB)($28)
$L256:
	lw	$31,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	jr	$31
	addiu	$sp,$sp,32

$L263:
	lw	$31,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	j	vTaskSwitchContext
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	vTaskSuspend
	.size	vTaskSuspend, .-vTaskSuspend
	.align	2
	.globl	vTaskResume
	.set	nomips16
	.set	nomicromips
	.ent	vTaskResume
	.type	vTaskResume, @function
vTaskResume:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, gp= 0
	.mask	0x80030000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L278
	li	$5,1707			# 0x6ab

	lui	$4,%hi($LC0)
	j	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L283:
	jal	vTaskEnterCritical
	move	$16,$4

	jal	prvTaskIsTaskSuspended
	move	$4,$16

	beq	$2,$0,$L280
	addiu	$17,$16,4

	jal	uxListRemove
	move	$4,$17

	lw	$4,44($16)
	lw	$2,%gp_rel(uxTopReadyPriority)($28)
	nop
	sltu	$2,$2,$4
	beq	$2,$0,$L287
	sll	$2,$4,2

	sw	$4,%gp_rel(uxTopReadyPriority)($28)
	sll	$2,$4,2
$L287:
	addu	$2,$2,$4
	lui	$4,%hi(pxReadyTasksLists)
	sll	$2,$2,2
	addiu	$4,$4,%lo(pxReadyTasksLists)
	addu	$4,$4,$2
	jal	vListInsertEnd
	move	$5,$17

	lw	$3,%gp_rel(pxCurrentTCB)($28)
	lw	$2,44($16)
	lw	$3,44($3)
	nop
	sltu	$2,$2,$3
	bne	$2,$0,$L280
	li	$2,1			# 0x1

	sw	$2,%gp_rel(FreeRTOS_Yield)($28)
	jal	OS_Syscall
	nop

$L280:
	lw	$31,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	j	vTaskExitCritical
	addiu	$sp,$sp,32

$L278:
	lw	$2,%gp_rel(pxCurrentTCB)($28)
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$17,24($sp)
	bne	$4,$2,$L283
	sw	$16,20($sp)

	lw	$31,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	jr	$31
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	vTaskResume
	.size	vTaskResume, .-vTaskResume
	.align	2
	.globl	xTaskResumeAll
	.set	nomips16
	.set	nomicromips
	.ent	xTaskResumeAll
	.type	xTaskResumeAll, @function
xTaskResumeAll:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, gp= 0
	.mask	0x803f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lw	$2,%gp_rel(uxSchedulerSuspended)($28)
	addiu	$sp,$sp,-48
	sw	$31,44($sp)
	sw	$21,40($sp)
	sw	$20,36($sp)
	sw	$19,32($sp)
	sw	$18,28($sp)
	sw	$17,24($sp)
	bne	$2,$0,$L289
	sw	$16,20($sp)

	lui	$4,%hi($LC0)
	li	$5,2024			# 0x7e8
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L289:
	jal	vTaskEnterCritical
	nop

	lw	$2,%gp_rel(uxSchedulerSuspended)($28)
	nop
	addiu	$2,$2,-1
	sw	$2,%gp_rel(uxSchedulerSuspended)($28)
	lw	$2,%gp_rel(uxSchedulerSuspended)($28)
	nop
	beq	$2,$0,$L290
	nop

$L292:
	move	$16,$0
$L291:
	jal	vTaskExitCritical
	nop

	lw	$31,44($sp)
	move	$2,$16
	lw	$21,40($sp)
	lw	$20,36($sp)
	lw	$19,32($sp)
	lw	$18,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	jr	$31
	addiu	$sp,$sp,48

$L290:
	lw	$2,%gp_rel(uxCurrentNumberOfTasks)($28)
	nop
	beq	$2,$0,$L292
	lui	$20,%hi(xPendingReadyList)

	lui	$17,%hi(pxReadyTasksLists)
	move	$16,$0
	addiu	$18,$20,%lo(xPendingReadyList)
	addiu	$17,$17,%lo(pxReadyTasksLists)
	li	$19,1			# 0x1
$L293:
	lw	$2,%lo(xPendingReadyList)($20)
	nop
	bne	$2,$0,$L296
	nop

	beq	$16,$0,$L297
	nop

	jal	prvResetNextTaskUnblockTime
	nop

$L297:
	lw	$16,%gp_rel(uxPendedTicks)($28)
	nop
	beq	$16,$0,$L298
	li	$17,1			# 0x1

$L300:
	jal	xTaskIncrementTick
	nop

	beq	$2,$0,$L299
	nop

	sw	$17,%gp_rel(xYieldPending)($28)
$L299:
	addiu	$16,$16,-1
	bne	$16,$0,$L300
	nop

	sw	$0,%gp_rel(uxPendedTicks)($28)
$L298:
	lw	$2,%gp_rel(xYieldPending)($28)
	nop
	beq	$2,$0,$L292
	li	$2,1			# 0x1

	sw	$2,%gp_rel(FreeRTOS_Yield)($28)
	jal	OS_Syscall
	li	$16,1			# 0x1

	b	$L291
	nop

$L296:
	lw	$2,12($18)
	nop
	lw	$16,12($2)
	nop
	addiu	$4,$16,24
	jal	uxListRemove
	addiu	$21,$16,4

	jal	uxListRemove
	move	$4,$21

	lw	$2,44($16)
	lw	$3,%gp_rel(uxTopReadyPriority)($28)
	nop
	sltu	$3,$3,$2
	beq	$3,$0,$L294
	nop

	sw	$2,%gp_rel(uxTopReadyPriority)($28)
$L294:
	sll	$4,$2,2
	addu	$4,$4,$2
	sll	$4,$4,2
	move	$5,$21
	jal	vListInsertEnd
	addu	$4,$17,$4

	lw	$3,%gp_rel(pxCurrentTCB)($28)
	lw	$2,44($16)
	lw	$3,44($3)
	nop
	sltu	$2,$2,$3
	bne	$2,$0,$L293
	nop

	sw	$19,%gp_rel(xYieldPending)($28)
	b	$L293
	nop

	.set	macro
	.set	reorder
	.end	xTaskResumeAll
	.size	xTaskResumeAll, .-xTaskResumeAll
	.align	2
	.globl	vTaskDelayUntil
	.set	nomips16
	.set	nomicromips
	.ent	vTaskDelayUntil
	.type	vTaskDelayUntil, @function
vTaskDelayUntil:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, gp= 0
	.mask	0x80030000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$17,24($sp)
	sw	$16,20($sp)
	sw	$31,28($sp)
	move	$17,$4
	bne	$4,$0,$L319
	move	$16,$5

	lui	$4,%hi($LC0)
	li	$5,1145			# 0x479
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L319:
	bne	$16,$0,$L320
	li	$5,1146			# 0x47a

	lui	$4,%hi($LC0)
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L320:
	lw	$2,%gp_rel(uxSchedulerSuspended)($28)
	nop
	beq	$2,$0,$L321
	lui	$4,%hi($LC0)

	li	$5,1147			# 0x47b
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L321:
	jal	vTaskSuspendAll
	nop

	lw	$3,0($17)
	lw	$4,%gp_rel(xTickCount)($28)
	addu	$16,$16,$3
	sltu	$5,$4,$3
	beq	$5,$0,$L322
	sltu	$3,$16,$3

	beq	$3,$0,$L323
	move	$5,$0

$L336:
	b	$L323
	sltu	$5,$4,$16

$L322:
	beq	$3,$0,$L336
	li	$5,1			# 0x1

$L323:
	beq	$5,$0,$L324
	sw	$16,0($17)

	move	$5,$0
	jal	prvAddCurrentTaskToDelayedList
	subu	$4,$16,$4

$L324:
	jal	xTaskResumeAll
	nop

	bne	$2,$0,$L318
	li	$2,1			# 0x1

	lw	$31,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	addiu	$sp,$sp,32
	sw	$2,%gp_rel(FreeRTOS_Yield)($28)
	j	OS_Syscall
	nop

$L318:
	lw	$31,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	jr	$31
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	vTaskDelayUntil
	.size	vTaskDelayUntil, .-vTaskDelayUntil
	.align	2
	.globl	vTaskDelay
	.set	nomips16
	.set	nomicromips
	.ent	vTaskDelay
	.type	vTaskDelay, @function
vTaskDelay:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	bne	$4,$0,$L338
	sw	$16,16($sp)

$L340:
	lw	$31,20($sp)
	lw	$16,16($sp)
	li	$2,1			# 0x1
	addiu	$sp,$sp,24
	sw	$2,%gp_rel(FreeRTOS_Yield)($28)
	j	OS_Syscall
	nop

$L338:
	lw	$2,%gp_rel(uxSchedulerSuspended)($28)
	nop
	beq	$2,$0,$L339
	move	$16,$4

	lui	$4,%hi($LC0)
	li	$5,1231			# 0x4cf
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L339:
	jal	vTaskSuspendAll
	move	$5,$0

	jal	prvAddCurrentTaskToDelayedList
	move	$4,$16

	jal	xTaskResumeAll
	nop

	beq	$2,$0,$L340
	nop

	lw	$31,20($sp)
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,24

	.set	macro
	.set	reorder
	.end	vTaskDelay
	.size	vTaskDelay, .-vTaskDelay
	.align	2
	.globl	xTaskGetHandle
	.set	nomips16
	.set	nomicromips
	.ent	xTaskGetHandle
	.type	xTaskGetHandle, @function
xTaskGetHandle:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, gp= 0
	.mask	0x80030000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$17,24($sp)
	sw	$31,28($sp)
	sw	$16,20($sp)
	jal	strlen
	move	$17,$4

	sltu	$2,$2,16
	bne	$2,$0,$L349
	li	$5,2262			# 0x8d6

	lui	$4,%hi($LC0)
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L349:
	jal	vTaskSuspendAll
	lui	$13,%hi(pxReadyTasksLists)

	move	$12,$0
	addiu	$13,$13,%lo(pxReadyTasksLists)
	li	$14,-100			# 0xffffffffffffff9c
	addiu	$4,$12,80
$L358:
	move	$5,$17
	jal	prvSearchForNameWithinSingleList
	addu	$4,$13,$4

	bne	$2,$0,$L350
	move	$16,$2

	addiu	$12,$12,-20
	bne	$12,$14,$L358
	addiu	$4,$12,80

	lw	$4,%gp_rel(pxDelayedTaskList)($28)
	jal	prvSearchForNameWithinSingleList
	move	$5,$17

	bne	$2,$0,$L350
	move	$16,$2

	lw	$4,%gp_rel(pxOverflowDelayedTaskList)($28)
	jal	prvSearchForNameWithinSingleList
	move	$5,$17

	bne	$2,$0,$L350
	move	$16,$2

	lui	$4,%hi(xSuspendedTaskList)
	move	$5,$17
	jal	prvSearchForNameWithinSingleList
	addiu	$4,$4,%lo(xSuspendedTaskList)

	bne	$2,$0,$L350
	move	$16,$2

	lui	$4,%hi(xTasksWaitingTermination)
	move	$5,$17
	jal	prvSearchForNameWithinSingleList
	addiu	$4,$4,%lo(xTasksWaitingTermination)

	move	$16,$2
$L350:
	jal	xTaskResumeAll
	nop

	lw	$31,28($sp)
	move	$2,$16
	lw	$17,24($sp)
	lw	$16,20($sp)
	jr	$31
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	xTaskGetHandle
	.size	xTaskGetHandle, .-xTaskGetHandle
	.align	2
	.set	nomips16
	.set	nomicromips
	.ent	prvIdleTask
	.type	prvIdleTask, @function
prvIdleTask:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, gp= 0
	.mask	0x800f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-40
	sw	$17,24($sp)
	lui	$17,%hi(xTasksWaitingTermination)
	sw	$19,32($sp)
	sw	$18,28($sp)
	sw	$31,36($sp)
	sw	$16,20($sp)
	addiu	$19,$17,%lo(xTasksWaitingTermination)
	lui	$18,%hi(pxReadyTasksLists)
$L361:
	lw	$2,%gp_rel(uxDeletedTasksWaitingCleanUp)($28)
	nop
	bne	$2,$0,$L362
	nop

	lw	$2,%lo(pxReadyTasksLists)($18)
	nop
	sltu	$2,$2,2
	bne	$2,$0,$L361
	li	$2,1			# 0x1

	sw	$2,%gp_rel(FreeRTOS_Yield)($28)
	jal	OS_Syscall
	nop

	b	$L361
	nop

$L362:
	jal	vTaskSuspendAll
	nop

	lw	$16,%lo(xTasksWaitingTermination)($17)
	jal	xTaskResumeAll
	nop

	beq	$16,$0,$L361
	nop

	jal	vTaskEnterCritical
	nop

	lw	$2,12($19)
	nop
	lw	$16,12($2)
	jal	uxListRemove
	addiu	$4,$16,4

	lw	$2,%gp_rel(uxCurrentNumberOfTasks)($28)
	nop
	addiu	$2,$2,-1
	sw	$2,%gp_rel(uxCurrentNumberOfTasks)($28)
	lw	$2,%gp_rel(uxDeletedTasksWaitingCleanUp)($28)
	nop
	addiu	$2,$2,-1
	sw	$2,%gp_rel(uxDeletedTasksWaitingCleanUp)($28)
	jal	vTaskExitCritical
	nop

	lw	$4,48($16)
	jal	vPortFree
	nop

	jal	vPortFree
	move	$4,$16

	b	$L361
	nop

	.set	macro
	.set	reorder
	.end	prvIdleTask
	.size	prvIdleTask, .-prvIdleTask
	.align	2
	.globl	xTaskAbortDelay
	.set	nomips16
	.set	nomicromips
	.ent	xTaskAbortDelay
	.type	xTaskAbortDelay, @function
xTaskAbortDelay:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, gp= 0
	.mask	0x80030000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$16,20($sp)
	sw	$31,28($sp)
	sw	$17,24($sp)
	bne	$4,$0,$L370
	move	$16,$4

	lui	$4,%hi($LC0)
	li	$5,2432			# 0x980
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L370:
	jal	vTaskSuspendAll
	move	$4,$16

	jal	eTaskGetState
	nop

	li	$3,2			# 0x2
	bne	$2,$3,$L372
	addiu	$17,$16,4

	jal	uxListRemove
	move	$4,$17

	jal	vTaskEnterCritical
	nop

	lw	$2,40($16)
	nop
	beq	$2,$0,$L373
	nop

	jal	uxListRemove
	addiu	$4,$16,24

	li	$2,1			# 0x1
	sb	$2,85($16)
$L373:
	jal	vTaskExitCritical
	nop

	lw	$4,44($16)
	lw	$2,%gp_rel(uxTopReadyPriority)($28)
	nop
	sltu	$2,$2,$4
	beq	$2,$0,$L380
	sll	$2,$4,2

	sw	$4,%gp_rel(uxTopReadyPriority)($28)
	sll	$2,$4,2
$L380:
	addu	$2,$2,$4
	lui	$4,%hi(pxReadyTasksLists)
	sll	$2,$2,2
	addiu	$4,$4,%lo(pxReadyTasksLists)
	addu	$4,$4,$2
	jal	vListInsertEnd
	move	$5,$17

	lw	$3,%gp_rel(pxCurrentTCB)($28)
	lw	$2,44($16)
	lw	$3,44($3)
	nop
	sltu	$2,$3,$2
	beq	$2,$0,$L372
	li	$2,1			# 0x1

	sw	$2,%gp_rel(xYieldPending)($28)
$L372:
	jal	xTaskResumeAll
	nop

	lw	$31,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	move	$2,$0
	jr	$31
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	xTaskAbortDelay
	.size	xTaskAbortDelay, .-xTaskAbortDelay
	.align	2
	.globl	xTaskCheckForTimeOut
	.set	nomips16
	.set	nomicromips
	.ent	xTaskCheckForTimeOut
	.type	xTaskCheckForTimeOut, @function
xTaskCheckForTimeOut:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, gp= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$31,28($sp)
	sw	$16,16($sp)
	move	$17,$4
	bne	$4,$0,$L382
	move	$18,$5

	lui	$4,%hi($LC0)
	li	$5,3019			# 0xbcb
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L382:
	bne	$18,$0,$L383
	lui	$4,%hi($LC0)

	li	$5,3020			# 0xbcc
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L383:
	jal	vTaskEnterCritical
	nop

	lw	$4,%gp_rel(xTickCount)($28)
	lw	$2,%gp_rel(pxCurrentTCB)($28)
	nop
	lbu	$2,85($2)
	nop
	beq	$2,$0,$L384
	li	$2,-1			# 0xffffffffffffffff

	lw	$2,%gp_rel(pxCurrentTCB)($28)
	li	$16,1			# 0x1
	sb	$0,85($2)
$L385:
	jal	vTaskExitCritical
	nop

	lw	$31,28($sp)
	move	$2,$16
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,32

$L384:
	lw	$3,0($18)
	nop
	beq	$3,$2,$L385
	move	$16,$0

	lw	$5,%gp_rel(xNumOfOverflows)($28)
	lw	$6,0($17)
	lw	$2,4($17)
	beq	$6,$5,$L386
	sltu	$5,$4,$2

	beq	$5,$0,$L385
	li	$16,1			# 0x1

$L386:
	subu	$5,$4,$2
	sltu	$5,$5,$3
	beq	$5,$0,$L385
	li	$16,1			# 0x1

	subu	$3,$3,$4
	addu	$3,$3,$2
	sw	$3,0($18)
	jal	vTaskSetTimeOutState
	move	$4,$17

	b	$L385
	move	$16,$0

	.set	macro
	.set	reorder
	.end	xTaskCheckForTimeOut
	.size	xTaskCheckForTimeOut, .-xTaskCheckForTimeOut
	.align	2
	.globl	uxTaskResetEventItemValue
	.set	nomips16
	.set	nomicromips
	.ent	uxTaskResetEventItemValue
	.type	uxTaskResetEventItemValue, @function
uxTaskResetEventItemValue:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lw	$2,%gp_rel(pxCurrentTCB)($28)
	lw	$4,%gp_rel(pxCurrentTCB)($28)
	lw	$3,%gp_rel(pxCurrentTCB)($28)
	lw	$2,24($2)
	lw	$5,44($3)
	li	$3,5			# 0x5
	subu	$3,$3,$5
	jr	$31
	sw	$3,24($4)

	.set	macro
	.set	reorder
	.end	uxTaskResetEventItemValue
	.size	uxTaskResetEventItemValue, .-uxTaskResetEventItemValue
	.align	2
	.globl	pvTaskIncrementMutexHeldCount
	.set	nomips16
	.set	nomicromips
	.ent	pvTaskIncrementMutexHeldCount
	.type	pvTaskIncrementMutexHeldCount, @function
pvTaskIncrementMutexHeldCount:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lw	$2,%gp_rel(pxCurrentTCB)($28)
	nop
	beq	$2,$0,$L393
	nop

	lw	$3,%gp_rel(pxCurrentTCB)($28)
	nop
	lw	$2,76($3)
	nop
	addiu	$2,$2,1
	sw	$2,76($3)
$L393:
	lw	$2,%gp_rel(pxCurrentTCB)($28)
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	pvTaskIncrementMutexHeldCount
	.size	pvTaskIncrementMutexHeldCount, .-pvTaskIncrementMutexHeldCount
	.align	2
	.globl	ulTaskNotifyTake
	.set	nomips16
	.set	nomicromips
	.ent	ulTaskNotifyTake
	.type	ulTaskNotifyTake, @function
ulTaskNotifyTake:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, gp= 0
	.mask	0x80030000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$17,24($sp)
	sw	$16,20($sp)
	sw	$31,28($sp)
	move	$17,$4
	jal	vTaskEnterCritical
	move	$16,$5

	lw	$2,%gp_rel(pxCurrentTCB)($28)
	nop
	lw	$2,80($2)
	nop
	bne	$2,$0,$L399
	nop

	lw	$2,%gp_rel(pxCurrentTCB)($28)
	li	$3,1			# 0x1
	sb	$3,84($2)
	beq	$16,$0,$L399
	li	$5,1			# 0x1

	jal	prvAddCurrentTaskToDelayedList
	move	$4,$16

	li	$2,1			# 0x1
	sw	$2,%gp_rel(FreeRTOS_Yield)($28)
	jal	OS_Syscall
	nop

$L399:
	jal	vTaskExitCritical
	nop

	jal	vTaskEnterCritical
	nop

	lw	$2,%gp_rel(pxCurrentTCB)($28)
	nop
	lw	$16,80($2)
	nop
	beq	$16,$0,$L401
	nop

	lw	$2,%gp_rel(pxCurrentTCB)($28)
	beq	$17,$0,$L402
	addiu	$3,$16,-1

	sw	$0,80($2)
$L401:
	lw	$2,%gp_rel(pxCurrentTCB)($28)
	nop
	sb	$0,84($2)
	jal	vTaskExitCritical
	nop

	lw	$31,28($sp)
	move	$2,$16
	lw	$17,24($sp)
	lw	$16,20($sp)
	jr	$31
	addiu	$sp,$sp,32

$L402:
	sw	$3,80($2)
	b	$L401
	nop

	.set	macro
	.set	reorder
	.end	ulTaskNotifyTake
	.size	ulTaskNotifyTake, .-ulTaskNotifyTake
	.align	2
	.globl	xTaskNotifyWait
	.set	nomips16
	.set	nomicromips
	.ent	xTaskNotifyWait
	.type	xTaskNotifyWait, @function
xTaskNotifyWait:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, gp= 0
	.mask	0x800f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-40
	sw	$19,32($sp)
	sw	$18,28($sp)
	sw	$17,24($sp)
	sw	$16,20($sp)
	sw	$31,36($sp)
	move	$17,$4
	move	$16,$5
	move	$18,$6
	jal	vTaskEnterCritical
	move	$19,$7

	lw	$2,%gp_rel(pxCurrentTCB)($28)
	li	$3,2			# 0x2
	lbu	$2,84($2)
	nop
	andi	$2,$2,0x00ff
	beq	$2,$3,$L412
	nop

	lw	$2,%gp_rel(pxCurrentTCB)($28)
	nor	$17,$0,$17
	lw	$4,80($2)
	li	$3,1			# 0x1
	and	$17,$17,$4
	sw	$17,80($2)
	lw	$2,%gp_rel(pxCurrentTCB)($28)
	nop
	sb	$3,84($2)
	beq	$19,$0,$L412
	li	$5,1			# 0x1

	jal	prvAddCurrentTaskToDelayedList
	move	$4,$19

	li	$2,1			# 0x1
	sw	$2,%gp_rel(FreeRTOS_Yield)($28)
	jal	OS_Syscall
	nop

$L412:
	jal	vTaskExitCritical
	nop

	jal	vTaskEnterCritical
	nop

	beq	$18,$0,$L414
	nop

	lw	$2,%gp_rel(pxCurrentTCB)($28)
	nop
	lw	$2,80($2)
	nop
	sw	$2,0($18)
$L414:
	lw	$2,%gp_rel(pxCurrentTCB)($28)
	move	$17,$0
	lbu	$3,84($2)
	li	$2,1			# 0x1
	andi	$3,$3,0x00ff
	beq	$3,$2,$L415
	nop

	lw	$2,%gp_rel(pxCurrentTCB)($28)
	nor	$16,$0,$16
	lw	$3,80($2)
	li	$17,1			# 0x1
	and	$16,$16,$3
	sw	$16,80($2)
$L415:
	lw	$2,%gp_rel(pxCurrentTCB)($28)
	nop
	sb	$0,84($2)
	jal	vTaskExitCritical
	nop

	lw	$31,36($sp)
	move	$2,$17
	lw	$19,32($sp)
	lw	$18,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	jr	$31
	addiu	$sp,$sp,40

	.set	macro
	.set	reorder
	.end	xTaskNotifyWait
	.size	xTaskNotifyWait, .-xTaskNotifyWait
	.align	2
	.globl	xTaskGenericNotify
	.set	nomips16
	.set	nomicromips
	.ent	xTaskGenericNotify
	.type	xTaskGenericNotify, @function
xTaskGenericNotify:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, gp= 0
	.mask	0x800f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-40
	sw	$19,32($sp)
	sw	$18,28($sp)
	sw	$17,24($sp)
	sw	$16,20($sp)
	sw	$31,36($sp)
	move	$16,$4
	move	$18,$5
	move	$17,$6
	bne	$4,$0,$L425
	move	$19,$7

	lui	$4,%hi($LC0)
	li	$5,4349			# 0x10fd
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L425:
	jal	vTaskEnterCritical
	nop

	beq	$19,$0,$L426
	nop

	lw	$2,80($16)
	nop
	sw	$2,0($19)
$L426:
	lbu	$3,84($16)
	li	$2,2			# 0x2
	sb	$2,84($16)
	li	$2,2			# 0x2
	beq	$17,$2,$L428
	andi	$3,$3,0x00ff

	sltu	$4,$17,3
	beq	$4,$0,$L429
	nop

	li	$2,1			# 0x1
	beq	$17,$2,$L430
	nop

$L427:
	li	$2,1			# 0x1
$L449:
	beq	$3,$2,$L434
	nop

$L447:
	b	$L433
	li	$17,1			# 0x1

$L429:
	li	$4,3			# 0x3
	beq	$17,$4,$L446
	li	$4,4			# 0x4

	bne	$17,$4,$L427
	nop

	bne	$3,$2,$L446
	move	$17,$0

$L433:
	jal	vTaskExitCritical
	nop

	lw	$31,36($sp)
	move	$2,$17
	lw	$19,32($sp)
	lw	$18,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	jr	$31
	addiu	$sp,$sp,40

$L430:
	lw	$2,80($16)
	nop
	or	$18,$2,$18
$L446:
	sw	$18,80($16)
	b	$L449
	li	$2,1			# 0x1

$L428:
	lw	$2,80($16)
	nop
	addiu	$2,$2,1
	sw	$2,80($16)
	b	$L449
	li	$2,1			# 0x1

$L434:
	addiu	$17,$16,4
	jal	uxListRemove
	move	$4,$17

	lw	$4,44($16)
	lw	$2,%gp_rel(uxTopReadyPriority)($28)
	nop
	sltu	$2,$2,$4
	beq	$2,$0,$L450
	sll	$2,$4,2

	sw	$4,%gp_rel(uxTopReadyPriority)($28)
	sll	$2,$4,2
$L450:
	addu	$2,$2,$4
	lui	$4,%hi(pxReadyTasksLists)
	sll	$2,$2,2
	addiu	$4,$4,%lo(pxReadyTasksLists)
	addu	$4,$4,$2
	jal	vListInsertEnd
	move	$5,$17

	lw	$2,40($16)
	nop
	beq	$2,$0,$L436
	lui	$4,%hi($LC0)

	li	$5,4405			# 0x1135
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L436:
	lw	$3,%gp_rel(pxCurrentTCB)($28)
	lw	$2,44($16)
	lw	$3,44($3)
	nop
	sltu	$2,$3,$2
	beq	$2,$0,$L447
	li	$2,1			# 0x1

	sw	$2,%gp_rel(FreeRTOS_Yield)($28)
	jal	OS_Syscall
	li	$17,1			# 0x1

	b	$L433
	nop

	.set	macro
	.set	reorder
	.end	xTaskGenericNotify
	.size	xTaskGenericNotify, .-xTaskGenericNotify
	.align	2
	.globl	xTaskGenericNotifyFromISR
	.set	nomips16
	.set	nomicromips
	.ent	xTaskGenericNotifyFromISR
	.type	xTaskGenericNotifyFromISR, @function
xTaskGenericNotifyFromISR:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, gp= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-40
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	sw	$31,36($sp)
	move	$16,$4
	move	$19,$5
	move	$17,$6
	lw	$18,56($sp)
	bne	$4,$0,$L452
	move	$20,$7

	lui	$4,%hi($LC0)
	li	$5,4456			# 0x1168
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L452:
	beq	$20,$0,$L453
	nop

	lw	$2,80($16)
	nop
	sw	$2,0($20)
$L453:
	lbu	$3,84($16)
	li	$2,2			# 0x2
	li	$4,2			# 0x2
	andi	$3,$3,0x00ff
	sb	$2,84($16)
	beq	$17,$4,$L455
	nop

	sltu	$2,$17,3
	beq	$2,$0,$L456
	li	$2,3			# 0x3

	li	$2,1			# 0x1
	beq	$17,$2,$L457
	nop

$L454:
	li	$2,1			# 0x1
$L478:
	beq	$3,$2,$L461
	nop

$L466:
	b	$L451
	li	$2,1			# 0x1

$L456:
	beq	$17,$2,$L476
	nop

	li	$2,4			# 0x4
	bne	$17,$2,$L454
	nop

	bne	$3,$4,$L476
	move	$2,$0

$L451:
	lw	$31,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,40

$L457:
	lw	$2,80($16)
	nop
	or	$19,$2,$19
$L476:
	sw	$19,80($16)
	b	$L478
	li	$2,1			# 0x1

$L455:
	lw	$2,80($16)
	nop
	addiu	$2,$2,1
	sw	$2,80($16)
	b	$L478
	li	$2,1			# 0x1

$L461:
	lw	$2,40($16)
	nop
	beq	$2,$0,$L462
	li	$5,4527			# 0x11af

	lui	$4,%hi($LC0)
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L462:
	lw	$2,%gp_rel(uxSchedulerSuspended)($28)
	nop
	bne	$2,$0,$L463
	lui	$4,%hi(xPendingReadyList)

	addiu	$17,$16,4
	jal	uxListRemove
	move	$4,$17

	lw	$4,44($16)
	lw	$2,%gp_rel(uxTopReadyPriority)($28)
	nop
	sltu	$2,$2,$4
	beq	$2,$0,$L479
	sll	$2,$4,2

	sw	$4,%gp_rel(uxTopReadyPriority)($28)
	sll	$2,$4,2
$L479:
	addu	$2,$2,$4
	lui	$4,%hi(pxReadyTasksLists)
	sll	$2,$2,2
	addiu	$4,$4,%lo(pxReadyTasksLists)
	move	$5,$17
	addu	$4,$4,$2
$L477:
	jal	vListInsertEnd
	nop

	lw	$3,%gp_rel(pxCurrentTCB)($28)
	lw	$2,44($16)
	lw	$3,44($3)
	nop
	sltu	$2,$3,$2
	beq	$2,$0,$L466
	nop

	beq	$18,$0,$L467
	li	$2,1			# 0x1

	b	$L451
	sw	$2,0($18)

$L463:
	addiu	$5,$16,24
	b	$L477
	addiu	$4,$4,%lo(xPendingReadyList)

$L467:
	sw	$2,%gp_rel(xYieldPending)($28)
	b	$L451
	nop

	.set	macro
	.set	reorder
	.end	xTaskGenericNotifyFromISR
	.size	xTaskGenericNotifyFromISR, .-xTaskGenericNotifyFromISR
	.align	2
	.globl	vTaskNotifyGiveFromISR
	.set	nomips16
	.set	nomicromips
	.ent	vTaskNotifyGiveFromISR
	.type	vTaskNotifyGiveFromISR, @function
vTaskNotifyGiveFromISR:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, gp= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$17,20($sp)
	sw	$16,16($sp)
	sw	$31,28($sp)
	sw	$18,24($sp)
	move	$16,$4
	bne	$4,$0,$L481
	move	$17,$5

	lui	$4,%hi($LC0)
	li	$5,4579			# 0x11e3
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L481:
	li	$3,2			# 0x2
	lbu	$2,84($16)
	sb	$3,84($16)
	lw	$3,80($16)
	andi	$2,$2,0x00ff
	addiu	$3,$3,1
	sw	$3,80($16)
	li	$3,1			# 0x1
	bne	$2,$3,$L480
	nop

	lw	$2,40($16)
	nop
	beq	$2,$0,$L484
	li	$5,4617			# 0x1209

	lui	$4,%hi($LC0)
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L484:
	lw	$2,%gp_rel(uxSchedulerSuspended)($28)
	nop
	bne	$2,$0,$L485
	lui	$4,%hi(xPendingReadyList)

	addiu	$18,$16,4
	jal	uxListRemove
	move	$4,$18

	lw	$4,44($16)
	lw	$2,%gp_rel(uxTopReadyPriority)($28)
	nop
	sltu	$2,$2,$4
	beq	$2,$0,$L495
	sll	$2,$4,2

	sw	$4,%gp_rel(uxTopReadyPriority)($28)
	sll	$2,$4,2
$L495:
	addu	$2,$2,$4
	lui	$4,%hi(pxReadyTasksLists)
	sll	$2,$2,2
	addiu	$4,$4,%lo(pxReadyTasksLists)
	move	$5,$18
	addu	$4,$4,$2
$L494:
	jal	vListInsertEnd
	nop

	lw	$3,%gp_rel(pxCurrentTCB)($28)
	lw	$2,44($16)
	lw	$3,44($3)
	nop
	sltu	$2,$3,$2
	beq	$2,$0,$L480
	nop

	beq	$17,$0,$L489
	li	$2,1			# 0x1

	sw	$2,0($17)
$L480:
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,32

$L485:
	addiu	$5,$16,24
	b	$L494
	addiu	$4,$4,%lo(xPendingReadyList)

$L489:
	sw	$2,%gp_rel(xYieldPending)($28)
	b	$L480
	nop

	.set	macro
	.set	reorder
	.end	vTaskNotifyGiveFromISR
	.size	vTaskNotifyGiveFromISR, .-vTaskNotifyGiveFromISR
	.align	2
	.globl	xTaskNotifyStateClear
	.set	nomips16
	.set	nomicromips
	.ent	xTaskNotifyStateClear
	.type	xTaskNotifyStateClear, @function
xTaskNotifyStateClear:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, gp= 0
	.mask	0x80030000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$16,20($sp)
	sw	$31,28($sp)
	sw	$17,24($sp)
	bne	$4,$0,$L497
	move	$16,$4

	lw	$16,%gp_rel(pxCurrentTCB)($28)
$L497:
	jal	vTaskEnterCritical
	nop

	lbu	$3,84($16)
	li	$2,2			# 0x2
	andi	$3,$3,0x00ff
	bne	$3,$2,$L498
	move	$17,$0

	sb	$0,84($16)
	li	$17,1			# 0x1
$L498:
	jal	vTaskExitCritical
	nop

	lw	$31,28($sp)
	move	$2,$17
	lw	$16,20($sp)
	lw	$17,24($sp)
	jr	$31
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	xTaskNotifyStateClear
	.size	xTaskNotifyStateClear, .-xTaskNotifyStateClear
	.local	uxSchedulerSuspended
	.comm	uxSchedulerSuspended,4,4
	.local	xIdleTaskHandle
	.comm	xIdleTaskHandle,4,4
	.local	xNextTaskUnblockTime
	.comm	xNextTaskUnblockTime,4,4
	.local	uxTaskNumber
	.comm	uxTaskNumber,4,4
	.local	xNumOfOverflows
	.comm	xNumOfOverflows,4,4
	.local	xYieldPending
	.comm	xYieldPending,4,4
	.local	uxPendedTicks
	.comm	uxPendedTicks,4,4
	.local	xSchedulerRunning
	.comm	xSchedulerRunning,4,4
	.local	uxTopReadyPriority
	.comm	uxTopReadyPriority,4,4
	.local	xTickCount
	.comm	xTickCount,4,4
	.local	uxCurrentNumberOfTasks
	.comm	uxCurrentNumberOfTasks,4,4
	.local	xSuspendedTaskList
	.comm	xSuspendedTaskList,20,4
	.local	uxDeletedTasksWaitingCleanUp
	.comm	uxDeletedTasksWaitingCleanUp,4,4
	.local	xTasksWaitingTermination
	.comm	xTasksWaitingTermination,20,4
	.local	xPendingReadyList
	.comm	xPendingReadyList,20,4
	.local	pxOverflowDelayedTaskList
	.comm	pxOverflowDelayedTaskList,4,4
	.local	pxDelayedTaskList
	.comm	pxDelayedTaskList,4,4
	.local	xDelayedTaskList2
	.comm	xDelayedTaskList2,20,4
	.local	xDelayedTaskList1
	.comm	xDelayedTaskList1,20,4
	.local	pxReadyTasksLists
	.comm	pxReadyTasksLists,100,4
	.globl	pxCurrentTCB
	.section	.sbss,"aw",@nobits
	.align	2
	.type	pxCurrentTCB, @object
	.size	pxCurrentTCB, 4
pxCurrentTCB:
	.space	4
	.ident	"GCC: (GNU) 6.3.0"
