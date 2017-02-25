	.file	1 "queue.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=32
	.module	nooddspreg
	.text
	.align	2
	.set	nomips16
	.set	nomicromips
	.ent	prvCopyDataToQueue
	.type	prvCopyDataToQueue, @function
prvCopyDataToQueue:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, gp= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$18,24($sp)
	move	$18,$6
	lw	$6,64($4)
	sw	$17,20($sp)
	sw	$16,16($sp)
	sw	$31,28($sp)
	move	$16,$4
	lw	$17,56($4)
	bne	$6,$0,$L2
	nop

	lw	$3,0($4)
	nop
	bne	$3,$0,$L3
	move	$2,$0

	lw	$4,4($4)
	jal	xTaskPriorityDisinherit
	nop

	sw	$0,4($16)
$L3:
	lw	$31,28($sp)
	addiu	$17,$17,1
	sw	$17,56($16)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,32

$L2:
	bne	$18,$0,$L4
	nop

	lw	$4,8($4)
	jal	memcpy
	nop

	lw	$2,8($16)
	lw	$3,64($16)
	nop
	addu	$2,$2,$3
	lw	$3,4($16)
	sw	$2,8($16)
	sltu	$3,$2,$3
	bne	$3,$0,$L3
	move	$2,$0

	lw	$3,0($16)
	b	$L3
	sw	$3,8($16)

$L4:
	lw	$4,12($4)
	jal	memcpy
	nop

	lw	$3,64($16)
	lw	$2,12($16)
	subu	$3,$0,$3
	lw	$4,0($16)
	addu	$2,$2,$3
	sw	$2,12($16)
	sltu	$2,$2,$4
	beq	$2,$0,$L5
	nop

	lw	$2,4($16)
	nop
	addu	$3,$2,$3
	sw	$3,12($16)
$L5:
	li	$3,2			# 0x2
	bne	$18,$3,$L3
	move	$2,$0

	sltu	$3,$0,$17
	b	$L3
	subu	$17,$17,$3

	.set	macro
	.set	reorder
	.end	prvCopyDataToQueue
	.size	prvCopyDataToQueue, .-prvCopyDataToQueue
	.align	2
	.set	nomips16
	.set	nomicromips
	.ent	prvCopyDataFromQueue
	.type	prvCopyDataFromQueue, @function
prvCopyDataFromQueue:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	move	$2,$4
	lw	$6,64($2)
	nop
	beq	$6,$0,$L15
	move	$4,$5

	lw	$3,12($2)
	lw	$5,4($2)
	addu	$3,$3,$6
	sw	$3,12($2)
	sltu	$3,$3,$5
	bne	$3,$0,$L14
	nop

	lw	$3,0($2)
	nop
	sw	$3,12($2)
$L14:
	lw	$5,12($2)
	j	memcpy
	nop

$L15:
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	prvCopyDataFromQueue
	.size	prvCopyDataFromQueue, .-prvCopyDataFromQueue
	.align	2
	.set	nomips16
	.set	nomicromips
	.ent	prvUnlockQueue
	.type	prvUnlockQueue, @function
prvUnlockQueue:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, gp= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$16,16($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$31,28($sp)
	jal	vTaskEnterCritical
	move	$16,$4

	lbu	$17,69($16)
	addiu	$18,$16,36
	sll	$17,$17,24
	sra	$17,$17,24
$L17:
	bgtz	$17,$L20
	li	$2,-1			# 0xffffffffffffffff

$L38:
	sb	$2,69($16)
	jal	vTaskExitCritical
	nop

	jal	vTaskEnterCritical
	nop

	lbu	$17,68($16)
	addiu	$18,$16,16
	sll	$17,$17,24
	sra	$17,$17,24
$L21:
	bgtz	$17,$L24
	li	$2,-1			# 0xffffffffffffffff

$L39:
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	sb	$2,68($16)
	lw	$16,16($sp)
	j	vTaskExitCritical
	addiu	$sp,$sp,32

$L20:
	lw	$2,36($16)
	nop
	beq	$2,$0,$L38
	li	$2,-1			# 0xffffffffffffffff

	jal	xTaskRemoveFromEventList
	move	$4,$18

	beq	$2,$0,$L19
	nop

	jal	vTaskMissedYield
	nop

$L19:
	addiu	$17,$17,-1
	sll	$17,$17,24
	b	$L17
	sra	$17,$17,24

$L24:
	lw	$2,16($16)
	nop
	beq	$2,$0,$L39
	li	$2,-1			# 0xffffffffffffffff

	jal	xTaskRemoveFromEventList
	move	$4,$18

	beq	$2,$0,$L23
	nop

	jal	vTaskMissedYield
	nop

$L23:
	addiu	$17,$17,-1
	sll	$17,$17,24
	b	$L21
	sra	$17,$17,24

	.set	macro
	.set	reorder
	.end	prvUnlockQueue
	.size	prvUnlockQueue, .-prvUnlockQueue
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
$LC0:
	.ascii	"../../freertos/queue.c\000"
	.text
	.align	2
	.globl	xQueueGenericReset
	.set	nomips16
	.set	nomicromips
	.ent	xQueueGenericReset
	.type	xQueueGenericReset, @function
xQueueGenericReset:
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
	bne	$4,$0,$L41
	move	$17,$5

	lui	$4,%hi($LC0)
	li	$5,283			# 0x11b
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L41:
	jal	vTaskEnterCritical
	nop

	lw	$5,64($16)
	lw	$3,60($16)
	lw	$4,0($16)
	mult	$5,$3
	sw	$0,56($16)
	sw	$4,8($16)
	mflo	$2
	addu	$3,$4,$2
	subu	$2,$2,$5
	addu	$2,$4,$2
	sw	$2,12($16)
	li	$2,-1			# 0xffffffffffffffff
	sb	$2,68($16)
	sw	$3,4($16)
	sb	$2,69($16)
	bne	$17,$0,$L42
	nop

	lw	$2,16($16)
	nop
	beq	$2,$0,$L44
	nop

	jal	xTaskRemoveFromEventList
	addiu	$4,$16,16

	beq	$2,$0,$L44
	li	$2,1			# 0x1

	sw	$2,%gp_rel(FreeRTOS_Yield)($28)
	jal	OS_Syscall
	nop

$L44:
	jal	vTaskExitCritical
	nop

	lw	$31,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	li	$2,1			# 0x1
	jr	$31
	addiu	$sp,$sp,32

$L42:
	jal	vListInitialise
	addiu	$4,$16,16

	jal	vListInitialise
	addiu	$4,$16,36

	b	$L44
	nop

	.set	macro
	.set	reorder
	.end	xQueueGenericReset
	.size	xQueueGenericReset, .-xQueueGenericReset
	.align	2
	.globl	xQueueGenericCreate
	.set	nomips16
	.set	nomicromips
	.ent	xQueueGenericCreate
	.type	xQueueGenericCreate, @function
xQueueGenericCreate:
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
	move	$18,$4
	bne	$4,$0,$L51
	move	$17,$5

	lui	$4,%hi($LC0)
	li	$5,392			# 0x188
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L51:
	mult	$18,$17
	mflo	$4
	jal	pvPortMalloc
	addiu	$4,$4,72

	beq	$2,$0,$L52
	move	$16,$2

	bne	$17,$0,$L53
	nop

	sw	$2,0($16)
$L54:
	sw	$18,60($16)
	sw	$17,64($16)
	li	$5,1			# 0x1
	jal	xQueueGenericReset
	move	$4,$16

$L52:
	lw	$31,28($sp)
	move	$2,$16
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,32

$L53:
	addiu	$2,$2,72
	b	$L54
	sw	$2,0($16)

	.set	macro
	.set	reorder
	.end	xQueueGenericCreate
	.size	xQueueGenericCreate, .-xQueueGenericCreate
	.align	2
	.globl	xQueueCreateCountingSemaphore
	.set	nomips16
	.set	nomicromips
	.ent	xQueueCreateCountingSemaphore
	.type	xQueueCreateCountingSemaphore, @function
xQueueCreateCountingSemaphore:
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
	bne	$4,$0,$L60
	move	$17,$5

	lui	$4,%hi($LC0)
	li	$5,701			# 0x2bd
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L60:
	sltu	$2,$16,$17
	beq	$2,$0,$L67
	li	$6,2			# 0x2

	lui	$4,%hi($LC0)
	li	$5,702			# 0x2be
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

	li	$6,2			# 0x2
$L67:
	move	$5,$0
	jal	xQueueGenericCreate
	move	$4,$16

	beq	$2,$0,$L59
	nop

	sw	$17,56($2)
$L59:
	lw	$31,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	jr	$31
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	xQueueCreateCountingSemaphore
	.size	xQueueCreateCountingSemaphore, .-xQueueCreateCountingSemaphore
	.align	2
	.globl	xQueueGenericSend
	.set	nomips16
	.set	nomicromips
	.ent	xQueueGenericSend
	.type	xQueueGenericSend, @function
xQueueGenericSend:
	.frame	$sp,64,$31		# vars= 8, regs= 9/0, args= 16, gp= 0
	.mask	0x80ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-64
	sw	$19,40($sp)
	sw	$17,32($sp)
	sw	$16,28($sp)
	sw	$31,60($sp)
	sw	$23,56($sp)
	sw	$22,52($sp)
	sw	$21,48($sp)
	sw	$20,44($sp)
	sw	$18,36($sp)
	move	$16,$4
	move	$19,$5
	sw	$6,72($sp)
	bne	$4,$0,$L69
	move	$17,$7

	lui	$4,%hi($LC0)
	li	$5,729			# 0x2d9
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L69:
	bne	$19,$0,$L102
	li	$2,2			# 0x2

	lw	$2,64($16)
	nop
	bne	$2,$0,$L71
	li	$5,730			# 0x2da

	li	$2,2			# 0x2
$L102:
	bne	$17,$2,$L72
	li	$2,1			# 0x1

	lw	$3,60($16)
	nop
	bne	$3,$2,$L73
	lui	$4,%hi($LC0)

$L72:
	jal	xTaskGetSchedulerState
	nop

	bne	$2,$0,$L103
	move	$22,$0

	lw	$2,72($sp)
	nop
	beq	$2,$0,$L103
	lui	$4,%hi($LC0)

	li	$5,734			# 0x2de
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

	move	$22,$0
$L103:
	li	$21,2			# 0x2
	li	$18,-1			# 0xffffffffffffffff
	b	$L90
	addiu	$20,$16,16

$L77:
	lw	$2,72($sp)
	nop
	bne	$2,$0,$L83
	nop

	jal	vTaskExitCritical
	nop

	b	$L68
	move	$2,$0

$L83:
	bne	$22,$0,$L84
	nop

	jal	vTaskSetTimeOutState
	addiu	$4,$sp,16

$L84:
	jal	vTaskExitCritical
	nop

	jal	vTaskSuspendAll
	nop

	jal	vTaskEnterCritical
	nop

	lbu	$2,68($16)
	nop
	sll	$2,$2,24
	sra	$2,$2,24
	bne	$2,$18,$L85
	nop

	sb	$0,68($16)
$L85:
	lbu	$2,69($16)
	nop
	sll	$2,$2,24
	sra	$2,$2,24
	bne	$2,$18,$L86
	nop

	sb	$0,69($16)
$L86:
	jal	vTaskExitCritical
	nop

	addiu	$5,$sp,72
	jal	xTaskCheckForTimeOut
	addiu	$4,$sp,16

	bne	$2,$0,$L87
	nop

	jal	vTaskEnterCritical
	nop

	lw	$23,56($16)
	lw	$22,60($16)
	jal	vTaskExitCritical
	nop

	bne	$23,$22,$L88
	nop

	lw	$5,72($sp)
	jal	vTaskPlaceOnEventList
	move	$4,$20

	jal	prvUnlockQueue
	move	$4,$16

	jal	xTaskResumeAll
	nop

	bne	$2,$0,$L90
	li	$22,1			# 0x1

	li	$2,1			# 0x1
	sw	$2,%gp_rel(FreeRTOS_Yield)($28)
	jal	OS_Syscall
	li	$22,1			# 0x1

$L90:
	jal	vTaskEnterCritical
	nop

	lw	$2,56($16)
	lw	$3,60($16)
	nop
	sltu	$2,$2,$3
	bne	$2,$0,$L104
	move	$6,$17

	bne	$17,$21,$L77
	nop

$L104:
	move	$5,$19
	jal	prvCopyDataToQueue
	move	$4,$16

	lw	$3,36($16)
	nop
	beq	$3,$0,$L78
	nop

	jal	xTaskRemoveFromEventList
	addiu	$4,$16,36

$L78:
	beq	$2,$0,$L80
	li	$2,1			# 0x1

	sw	$2,%gp_rel(FreeRTOS_Yield)($28)
	jal	OS_Syscall
	nop

$L80:
	jal	vTaskExitCritical
	nop

	li	$2,1			# 0x1
$L68:
	lw	$31,60($sp)
	lw	$23,56($sp)
	lw	$22,52($sp)
	lw	$21,48($sp)
	lw	$20,44($sp)
	lw	$19,40($sp)
	lw	$18,36($sp)
	lw	$17,32($sp)
	lw	$16,28($sp)
	jr	$31
	addiu	$sp,$sp,64

$L88:
	jal	prvUnlockQueue
	move	$4,$16

	jal	xTaskResumeAll
	li	$22,1			# 0x1

	b	$L90
	nop

$L87:
	jal	prvUnlockQueue
	move	$4,$16

	jal	xTaskResumeAll
	nop

	b	$L68
	move	$2,$0

$L71:
	lui	$4,%hi($LC0)
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

	b	$L102
	li	$2,2			# 0x2

$L73:
	li	$5,731			# 0x2db
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

	b	$L72
	nop

	.set	macro
	.set	reorder
	.end	xQueueGenericSend
	.size	xQueueGenericSend, .-xQueueGenericSend
	.align	2
	.globl	xQueueCreateMutex
	.set	nomips16
	.set	nomicromips
	.ent	xQueueCreateMutex
	.type	xQueueCreateMutex, @function
xQueueCreateMutex:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	move	$6,$4
	move	$5,$0
	sw	$16,16($sp)
	sw	$31,20($sp)
	jal	xQueueGenericCreate
	li	$4,1			# 0x1

	beq	$2,$0,$L106
	move	$16,$2

	sw	$0,4($2)
	sw	$0,0($2)
	sw	$0,12($2)
	move	$7,$0
	move	$6,$0
	move	$5,$0
	jal	xQueueGenericSend
	move	$4,$2

$L106:
	lw	$31,20($sp)
	move	$2,$16
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,24

	.set	macro
	.set	reorder
	.end	xQueueCreateMutex
	.size	xQueueCreateMutex, .-xQueueCreateMutex
	.align	2
	.globl	xQueueGiveMutexRecursive
	.set	nomips16
	.set	nomicromips
	.ent	xQueueGiveMutexRecursive
	.type	xQueueGiveMutexRecursive, @function
xQueueGiveMutexRecursive:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, gp= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$16,16($sp)
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	bne	$4,$0,$L112
	move	$16,$4

	lui	$4,%hi($LC0)
	li	$5,577			# 0x241
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L112:
	lw	$18,4($16)
	jal	xTaskGetCurrentTaskHandle
	move	$17,$0

	bne	$18,$2,$L111
	nop

	lw	$2,12($16)
	li	$17,1			# 0x1
	addiu	$2,$2,-1
	bne	$2,$0,$L111
	sw	$2,12($16)

	move	$7,$0
	move	$6,$0
	move	$5,$0
	jal	xQueueGenericSend
	move	$4,$16

$L111:
	lw	$31,28($sp)
	move	$2,$17
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	xQueueGiveMutexRecursive
	.size	xQueueGiveMutexRecursive, .-xQueueGiveMutexRecursive
	.align	2
	.globl	xQueueGenericSendFromISR
	.set	nomips16
	.set	nomicromips
	.ent	xQueueGenericSendFromISR
	.type	xQueueGenericSendFromISR, @function
xQueueGenericSendFromISR:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, gp= 0
	.mask	0x803f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-48
	sw	$20,36($sp)
	sw	$19,32($sp)
	sw	$18,28($sp)
	sw	$16,20($sp)
	sw	$31,44($sp)
	sw	$21,40($sp)
	sw	$17,24($sp)
	move	$16,$4
	move	$19,$5
	move	$20,$6
	bne	$4,$0,$L118
	move	$18,$7

	lui	$4,%hi($LC0)
	li	$5,927			# 0x39f
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L118:
	bne	$19,$0,$L137
	li	$2,2			# 0x2

	lw	$2,64($16)
	nop
	bne	$2,$0,$L120
	li	$5,928			# 0x3a0

	li	$2,2			# 0x2
$L137:
	bne	$18,$2,$L121
	li	$2,1			# 0x1

	lw	$3,60($16)
	nop
	bne	$3,$2,$L122
	li	$5,929			# 0x3a1

$L121:
	lw	$2,56($16)
	lw	$3,60($16)
	nop
	sltu	$2,$2,$3
	bne	$2,$0,$L123
	li	$3,2			# 0x2

	bne	$18,$3,$L117
	nop

$L123:
	lbu	$17,69($16)
	move	$6,$18
	sll	$21,$17,24
	move	$5,$19
	jal	prvCopyDataToQueue
	move	$4,$16

	sra	$21,$21,24
	li	$2,-1			# 0xffffffffffffffff
	bne	$21,$2,$L125
	nop

	lw	$2,36($16)
	nop
	bne	$2,$0,$L126
	nop

$L136:
	b	$L117
	li	$2,1			# 0x1

$L126:
	jal	xTaskRemoveFromEventList
	addiu	$4,$16,36

	beq	$2,$0,$L136
	nop

	beq	$20,$0,$L117
	li	$2,1			# 0x1

	sw	$2,0($20)
$L117:
	lw	$31,44($sp)
	lw	$21,40($sp)
	lw	$20,36($sp)
	lw	$19,32($sp)
	lw	$18,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	jr	$31
	addiu	$sp,$sp,48

$L125:
	addiu	$17,$17,1
	sll	$17,$17,24
	sra	$17,$17,24
	sb	$17,69($16)
	b	$L117
	li	$2,1			# 0x1

$L120:
	lui	$4,%hi($LC0)
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

	b	$L137
	li	$2,2			# 0x2

$L122:
	lui	$4,%hi($LC0)
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

	b	$L121
	nop

	.set	macro
	.set	reorder
	.end	xQueueGenericSendFromISR
	.size	xQueueGenericSendFromISR, .-xQueueGenericSendFromISR
	.align	2
	.globl	xQueueGiveFromISR
	.set	nomips16
	.set	nomicromips
	.ent	xQueueGiveFromISR
	.type	xQueueGiveFromISR, @function
xQueueGiveFromISR:
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
	bne	$4,$0,$L139
	move	$17,$5

	lui	$4,%hi($LC0)
	li	$5,1084			# 0x43c
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L139:
	lw	$2,64($16)
	nop
	beq	$2,$0,$L140
	li	$5,1088			# 0x440

	lui	$4,%hi($LC0)
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L140:
	lw	$2,0($16)
	nop
	bne	$2,$0,$L141
	nop

	lw	$2,4($16)
	nop
	bne	$2,$0,$L142
	lui	$4,%hi($LC0)

$L141:
	lw	$3,56($16)
	lw	$4,60($16)
	nop
	sltu	$4,$3,$4
	beq	$4,$0,$L138
	move	$2,$0

	lbu	$2,69($16)
	addiu	$3,$3,1
	sll	$4,$2,24
	sw	$3,56($16)
	sra	$4,$4,24
	li	$3,-1			# 0xffffffffffffffff
	bne	$4,$3,$L144
	addiu	$2,$2,1

	lw	$2,36($16)
	nop
	bne	$2,$0,$L145
	nop

$L158:
	b	$L138
	li	$2,1			# 0x1

$L145:
	jal	xTaskRemoveFromEventList
	addiu	$4,$16,36

	beq	$2,$0,$L158
	nop

	beq	$17,$0,$L138
	li	$2,1			# 0x1

	sw	$2,0($17)
$L138:
	lw	$31,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	jr	$31
	addiu	$sp,$sp,32

$L144:
	sll	$2,$2,24
	sra	$2,$2,24
	sb	$2,69($16)
	b	$L138
	li	$2,1			# 0x1

$L142:
	li	$5,1093			# 0x445
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

	b	$L141
	nop

	.set	macro
	.set	reorder
	.end	xQueueGiveFromISR
	.size	xQueueGiveFromISR, .-xQueueGiveFromISR
	.align	2
	.globl	xQueueGenericReceive
	.set	nomips16
	.set	nomicromips
	.ent	xQueueGenericReceive
	.type	xQueueGenericReceive, @function
xQueueGenericReceive:
	.frame	$sp,64,$31		# vars= 8, regs= 9/0, args= 16, gp= 0
	.mask	0x80ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-64
	sw	$22,52($sp)
	sw	$19,40($sp)
	sw	$16,28($sp)
	sw	$31,60($sp)
	sw	$23,56($sp)
	sw	$21,48($sp)
	sw	$20,44($sp)
	sw	$18,36($sp)
	sw	$17,32($sp)
	move	$16,$4
	move	$19,$5
	sw	$6,72($sp)
	bne	$4,$0,$L160
	move	$22,$7

	lui	$4,%hi($LC0)
	li	$5,1244			# 0x4dc
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L160:
	bne	$19,$0,$L161
	nop

	lw	$2,64($16)
	nop
	bne	$2,$0,$L162
	lui	$4,%hi($LC0)

$L161:
	jal	xTaskGetSchedulerState
	nop

	bne	$2,$0,$L200
	move	$23,$0

	lw	$2,72($sp)
	nop
	beq	$2,$0,$L200
	lui	$4,%hi($LC0)

	li	$5,1248			# 0x4e0
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

	move	$23,$0
$L200:
	li	$18,-1			# 0xffffffffffffffff
	addiu	$21,$16,36
	b	$L181
	li	$20,1			# 0x1

$L166:
	lw	$2,36($16)
	nop
	beq	$2,$0,$L169
	sw	$18,12($16)

	addiu	$4,$16,36
$L199:
	jal	xTaskRemoveFromEventList
	nop

	beq	$2,$0,$L169
	li	$2,1			# 0x1

	sw	$2,%gp_rel(FreeRTOS_Yield)($28)
	jal	OS_Syscall
	nop

	b	$L169
	nop

$L165:
	lw	$2,72($sp)
	nop
	bne	$2,$0,$L172
	nop

	jal	vTaskExitCritical
	nop

	b	$L159
	move	$2,$0

$L172:
	bne	$23,$0,$L173
	nop

	jal	vTaskSetTimeOutState
	addiu	$4,$sp,16

$L173:
	jal	vTaskExitCritical
	nop

	jal	vTaskSuspendAll
	nop

	jal	vTaskEnterCritical
	nop

	lbu	$2,68($16)
	nop
	sll	$2,$2,24
	sra	$2,$2,24
	bne	$2,$18,$L174
	nop

	sb	$0,68($16)
$L174:
	lbu	$2,69($16)
	nop
	sll	$2,$2,24
	sra	$2,$2,24
	bne	$2,$18,$L175
	nop

	sb	$0,69($16)
$L175:
	jal	vTaskExitCritical
	nop

	addiu	$5,$sp,72
	jal	xTaskCheckForTimeOut
	addiu	$4,$sp,16

	bne	$2,$0,$L176
	nop

	jal	vTaskEnterCritical
	nop

	lw	$17,56($16)
	jal	vTaskExitCritical
	nop

	bne	$17,$0,$L177
	nop

	lw	$2,0($16)
	nop
	bne	$2,$0,$L178
	nop

	jal	vTaskEnterCritical
	nop

	lw	$4,4($16)
	jal	vTaskPriorityInherit
	nop

	jal	vTaskExitCritical
	nop

$L178:
	lw	$5,72($sp)
	jal	vTaskPlaceOnEventList
	move	$4,$21

	jal	prvUnlockQueue
	move	$4,$16

	jal	xTaskResumeAll
	nop

	bne	$2,$0,$L181
	li	$23,1			# 0x1

	sw	$20,%gp_rel(FreeRTOS_Yield)($28)
	jal	OS_Syscall
	li	$23,1			# 0x1

$L181:
	jal	vTaskEnterCritical
	nop

	lw	$17,56($16)
	nop
	beq	$17,$0,$L165
	move	$5,$19

	lw	$18,12($16)
	jal	prvCopyDataFromQueue
	move	$4,$16

	bne	$22,$0,$L166
	addiu	$17,$17,-1

	lw	$2,0($16)
	sw	$17,56($16)
	bne	$2,$0,$L167
	nop

	jal	pvTaskIncrementMutexHeldCount
	nop

	sw	$2,4($16)
$L167:
	lw	$2,16($16)
	nop
	bne	$2,$0,$L199
	addiu	$4,$16,16

$L169:
	jal	vTaskExitCritical
	nop

	li	$2,1			# 0x1
$L159:
	lw	$31,60($sp)
	lw	$23,56($sp)
	lw	$22,52($sp)
	lw	$21,48($sp)
	lw	$20,44($sp)
	lw	$19,40($sp)
	lw	$18,36($sp)
	lw	$17,32($sp)
	lw	$16,28($sp)
	jr	$31
	addiu	$sp,$sp,64

$L177:
	jal	prvUnlockQueue
	move	$4,$16

	jal	xTaskResumeAll
	li	$23,1			# 0x1

	b	$L181
	nop

$L176:
	jal	prvUnlockQueue
	move	$4,$16

	jal	xTaskResumeAll
	nop

	jal	vTaskEnterCritical
	nop

	lw	$17,56($16)
	jal	vTaskExitCritical
	nop

	bne	$17,$0,$L181
	li	$23,1			# 0x1

	b	$L159
	move	$2,$0

$L162:
	li	$5,1245			# 0x4dd
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

	b	$L161
	nop

	.set	macro
	.set	reorder
	.end	xQueueGenericReceive
	.size	xQueueGenericReceive, .-xQueueGenericReceive
	.align	2
	.globl	xQueueTakeMutexRecursive
	.set	nomips16
	.set	nomicromips
	.ent	xQueueTakeMutexRecursive
	.type	xQueueTakeMutexRecursive, @function
xQueueTakeMutexRecursive:
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
	bne	$4,$0,$L202
	move	$17,$5

	lui	$4,%hi($LC0)
	li	$5,632			# 0x278
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L202:
	lw	$18,4($16)
	jal	xTaskGetCurrentTaskHandle
	nop

	bne	$18,$2,$L203
	move	$7,$0

	lw	$2,12($16)
	nop
	addiu	$2,$2,1
	sw	$2,12($16)
	li	$2,1			# 0x1
$L201:
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,32

$L203:
	move	$6,$17
	move	$5,$0
	jal	xQueueGenericReceive
	move	$4,$16

	beq	$2,$0,$L201
	nop

	lw	$3,12($16)
	nop
	addiu	$3,$3,1
	b	$L201
	sw	$3,12($16)

	.set	macro
	.set	reorder
	.end	xQueueTakeMutexRecursive
	.size	xQueueTakeMutexRecursive, .-xQueueTakeMutexRecursive
	.align	2
	.globl	xQueueReceiveFromISR
	.set	nomips16
	.set	nomicromips
	.ent	xQueueReceiveFromISR
	.type	xQueueReceiveFromISR, @function
xQueueReceiveFromISR:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, gp= 0
	.mask	0x803f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-48
	sw	$20,36($sp)
	sw	$19,32($sp)
	sw	$16,20($sp)
	sw	$31,44($sp)
	sw	$21,40($sp)
	sw	$18,28($sp)
	sw	$17,24($sp)
	move	$16,$4
	move	$19,$5
	bne	$4,$0,$L210
	move	$20,$6

	lui	$4,%hi($LC0)
	li	$5,1440			# 0x5a0
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L210:
	bne	$19,$0,$L211
	nop

	lw	$2,64($16)
	nop
	bne	$2,$0,$L212
	li	$5,1441			# 0x5a1

$L211:
	lw	$18,56($16)
	nop
	beq	$18,$0,$L209
	move	$2,$0

	lbu	$17,68($16)
	move	$5,$19
	sll	$21,$17,24
	jal	prvCopyDataFromQueue
	move	$4,$16

	addiu	$18,$18,-1
	sra	$21,$21,24
	li	$2,-1			# 0xffffffffffffffff
	sw	$18,56($16)
	bne	$21,$2,$L214
	nop

	lw	$2,16($16)
	nop
	bne	$2,$0,$L215
	nop

$L226:
	b	$L209
	li	$2,1			# 0x1

$L215:
	jal	xTaskRemoveFromEventList
	addiu	$4,$16,16

	beq	$2,$0,$L226
	nop

	beq	$20,$0,$L209
	li	$2,1			# 0x1

	sw	$2,0($20)
$L209:
	lw	$31,44($sp)
	lw	$21,40($sp)
	lw	$20,36($sp)
	lw	$19,32($sp)
	lw	$18,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	jr	$31
	addiu	$sp,$sp,48

$L214:
	addiu	$17,$17,1
	sll	$17,$17,24
	sra	$17,$17,24
	sb	$17,68($16)
	b	$L209
	li	$2,1			# 0x1

$L212:
	lui	$4,%hi($LC0)
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

	b	$L211
	nop

	.set	macro
	.set	reorder
	.end	xQueueReceiveFromISR
	.size	xQueueReceiveFromISR, .-xQueueReceiveFromISR
	.align	2
	.globl	xQueuePeekFromISR
	.set	nomips16
	.set	nomicromips
	.ent	xQueuePeekFromISR
	.type	xQueuePeekFromISR, @function
xQueuePeekFromISR:
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
	bne	$4,$0,$L228
	move	$17,$5

	lui	$4,%hi($LC0)
	li	$5,1532			# 0x5fc
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L228:
	bne	$17,$0,$L229
	nop

	lw	$2,64($16)
	nop
	bne	$2,$0,$L230
	li	$5,1533			# 0x5fd

$L229:
	lw	$2,64($16)
	nop
	bne	$2,$0,$L231
	li	$5,1534			# 0x5fe

	lui	$4,%hi($LC0)
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L231:
	lw	$3,56($16)
	nop
	beq	$3,$0,$L227
	move	$2,$0

	lw	$18,12($16)
	move	$5,$17
	jal	prvCopyDataFromQueue
	move	$4,$16

	sw	$18,12($16)
	li	$2,1			# 0x1
$L227:
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,32

$L230:
	lui	$4,%hi($LC0)
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

	b	$L229
	nop

	.set	macro
	.set	reorder
	.end	xQueuePeekFromISR
	.size	xQueuePeekFromISR, .-xQueuePeekFromISR
	.align	2
	.globl	uxQueueMessagesWaiting
	.set	nomips16
	.set	nomicromips
	.ent	uxQueueMessagesWaiting
	.type	uxQueueMessagesWaiting, @function
uxQueueMessagesWaiting:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$16,16($sp)
	sw	$31,20($sp)
	bne	$4,$0,$L237
	move	$16,$4

	lui	$4,%hi($LC0)
	li	$5,1583			# 0x62f
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L237:
	jal	vTaskEnterCritical
	nop

	lw	$16,56($16)
	jal	vTaskExitCritical
	nop

	lw	$31,20($sp)
	move	$2,$16
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,24

	.set	macro
	.set	reorder
	.end	uxQueueMessagesWaiting
	.size	uxQueueMessagesWaiting, .-uxQueueMessagesWaiting
	.align	2
	.globl	uxQueueSpacesAvailable
	.set	nomips16
	.set	nomicromips
	.ent	uxQueueSpacesAvailable
	.type	uxQueueSpacesAvailable, @function
uxQueueSpacesAvailable:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, gp= 0
	.mask	0x80030000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$17,24($sp)
	sw	$31,28($sp)
	sw	$16,20($sp)
	bne	$4,$0,$L240
	move	$17,$4

	lui	$4,%hi($LC0)
	li	$5,1601			# 0x641
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L240:
	jal	vTaskEnterCritical
	nop

	lw	$2,56($17)
	lw	$16,60($17)
	jal	vTaskExitCritical
	subu	$16,$16,$2

	lw	$31,28($sp)
	move	$2,$16
	lw	$17,24($sp)
	lw	$16,20($sp)
	jr	$31
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	uxQueueSpacesAvailable
	.size	uxQueueSpacesAvailable, .-uxQueueSpacesAvailable
	.align	2
	.globl	uxQueueMessagesWaitingFromISR
	.set	nomips16
	.set	nomicromips
	.ent	uxQueueMessagesWaitingFromISR
	.type	uxQueueMessagesWaitingFromISR, @function
uxQueueMessagesWaitingFromISR:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$16,16($sp)
	sw	$31,20($sp)
	bne	$4,$0,$L243
	move	$16,$4

	lui	$4,%hi($LC0)
	li	$5,1617			# 0x651
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L243:
	lw	$31,20($sp)
	lw	$2,56($16)
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,24

	.set	macro
	.set	reorder
	.end	uxQueueMessagesWaitingFromISR
	.size	uxQueueMessagesWaitingFromISR, .-uxQueueMessagesWaitingFromISR
	.align	2
	.globl	xQueueIsQueueEmptyFromISR
	.set	nomips16
	.set	nomicromips
	.ent	xQueueIsQueueEmptyFromISR
	.type	xQueueIsQueueEmptyFromISR, @function
xQueueIsQueueEmptyFromISR:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$16,16($sp)
	sw	$31,20($sp)
	bne	$4,$0,$L246
	move	$16,$4

	lui	$4,%hi($LC0)
	li	$5,1939			# 0x793
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L246:
	lw	$2,56($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	sltu	$2,$2,1
	jr	$31
	addiu	$sp,$sp,24

	.set	macro
	.set	reorder
	.end	xQueueIsQueueEmptyFromISR
	.size	xQueueIsQueueEmptyFromISR, .-xQueueIsQueueEmptyFromISR
	.align	2
	.globl	xQueueIsQueueFullFromISR
	.set	nomips16
	.set	nomicromips
	.ent	xQueueIsQueueFullFromISR
	.type	xQueueIsQueueFullFromISR, @function
xQueueIsQueueFullFromISR:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$16,16($sp)
	sw	$31,20($sp)
	bne	$4,$0,$L249
	move	$16,$4

	lui	$4,%hi($LC0)
	li	$5,1978			# 0x7ba
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L249:
	lw	$3,56($16)
	lw	$2,60($16)
	lw	$31,20($sp)
	xor	$2,$2,$3
	lw	$16,16($sp)
	sltu	$2,$2,1
	jr	$31
	addiu	$sp,$sp,24

	.set	macro
	.set	reorder
	.end	xQueueIsQueueFullFromISR
	.size	xQueueIsQueueFullFromISR, .-xQueueIsQueueFullFromISR
	.align	2
	.globl	vQueueAddToRegistry
	.set	nomips16
	.set	nomicromips
	.ent	vQueueAddToRegistry
	.type	vQueueAddToRegistry, @function
vQueueAddToRegistry:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lui	$3,%hi(xQueueRegistry)
	addiu	$3,$3,%lo(xQueueRegistry)
	move	$2,$0
	move	$6,$3
	li	$7,10			# 0xa
$L254:
	lw	$8,0($3)
	nop
	bne	$8,$0,$L252
	addiu	$2,$2,1

	addiu	$2,$2,-1
	sll	$2,$2,3
	addu	$2,$6,$2
	sw	$5,0($2)
	jr	$31
	sw	$4,4($2)

$L252:
	bne	$2,$7,$L254
	addiu	$3,$3,8

	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	vQueueAddToRegistry
	.size	vQueueAddToRegistry, .-vQueueAddToRegistry
	.align	2
	.globl	pcQueueGetName
	.set	nomips16
	.set	nomicromips
	.ent	pcQueueGetName
	.type	pcQueueGetName, @function
pcQueueGetName:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lui	$3,%hi(xQueueRegistry)
	addiu	$3,$3,%lo(xQueueRegistry)
	move	$2,$0
	move	$5,$3
	li	$6,10			# 0xa
$L259:
	lw	$7,4($3)
	nop
	bne	$7,$4,$L257
	addiu	$2,$2,1

	addiu	$2,$2,-1
	sll	$2,$2,3
	addu	$2,$5,$2
	lw	$2,0($2)
	jr	$31
	nop

$L257:
	bne	$2,$6,$L259
	addiu	$3,$3,8

	jr	$31
	move	$2,$0

	.set	macro
	.set	reorder
	.end	pcQueueGetName
	.size	pcQueueGetName, .-pcQueueGetName
	.align	2
	.globl	vQueueUnregisterQueue
	.set	nomips16
	.set	nomicromips
	.ent	vQueueUnregisterQueue
	.type	vQueueUnregisterQueue, @function
vQueueUnregisterQueue:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lui	$3,%hi(xQueueRegistry)
	addiu	$3,$3,%lo(xQueueRegistry)
	move	$2,$0
	move	$5,$3
	li	$6,10			# 0xa
$L264:
	lw	$7,4($3)
	nop
	bne	$7,$4,$L262
	addiu	$2,$2,1

	addiu	$2,$2,-1
	sll	$2,$2,3
	addu	$2,$5,$2
	sw	$0,0($2)
	jr	$31
	sw	$0,4($2)

$L262:
	bne	$2,$6,$L264
	addiu	$3,$3,8

	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	vQueueUnregisterQueue
	.size	vQueueUnregisterQueue, .-vQueueUnregisterQueue
	.align	2
	.globl	vQueueDelete
	.set	nomips16
	.set	nomicromips
	.ent	vQueueDelete
	.type	vQueueDelete, @function
vQueueDelete:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$16,16($sp)
	sw	$31,20($sp)
	bne	$4,$0,$L267
	move	$16,$4

	lui	$4,%hi($LC0)
	li	$5,1629			# 0x65d
	jal	vAssertCalled
	addiu	$4,$4,%lo($LC0)

$L267:
	jal	vQueueUnregisterQueue
	move	$4,$16

	lw	$31,20($sp)
	move	$4,$16
	lw	$16,16($sp)
	j	vPortFree
	addiu	$sp,$sp,24

	.set	macro
	.set	reorder
	.end	vQueueDelete
	.size	vQueueDelete, .-vQueueDelete

	.comm	xQueueRegistry,80,4
	.ident	"GCC: (GNU) 6.3.0"
