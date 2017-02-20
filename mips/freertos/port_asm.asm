
	.extern FreeRTOS_UserISR
	.extern	pxCurrentTCB
	.extern InitStack

	.text

	.global	pxPortInitialiseStack
	.ent	pxPortInitialiseStack
pxPortInitialiseStack:
	.set noreorder
   	.set noat

	addi	$2,	$4,	-104  	# Determine next stack pointer.
	sw	$5,	88($2)		# Store the program counter of the task.
	jr	$31
	sw	$6,	28($2)		# Store the parameter pointer.

	.set reorder
	.set at
	.end pxPortInitialiseStack

	.global	portSAVE_CONTEXT
	.ent	portSAVE_CONTEXT
portSAVE_CONTEXT:
	.set noreorder
   	.set noat

	# Store the state of the CPU.
	addi	$29,	$29, -104  #adjust sp	
	sw	$1,	16($29)    #at	
	sw	$2,	20($29)    #v0
	sw	$3,	24($29)    #v1	
	sw	$4,	28($29)    #a0
	sw	$5,	32($29)    #a1	
	sw	$6,	36($29)    #a2
	sw	$7,	40($29)    #a3	
	sw	$8,	44($29)    #t0
	sw	$9,	48($29)    #t1	
	sw	$10,	52($29)    #t2
	sw	$11,	56($29)    #t3	
	sw	$12,	60($29)    #t4
	sw	$13,	64($29)    #t5	
	sw	$14,	68($29)    #t6
	sw	$15,	72($29)    #t7	
	sw	$24,	76($29)    #t8
	sw	$25,	80($29)    #t9	
	sw	$31,	84($29)    #lr
	mfc0	$26,	$14        #C0_EPC=14 (Exception PC)	
	addi	$26,	$26, -4    #Backup one opcode
	sw	$26,	88($29)    #pc	
	mfhi	$27
	sw	$27,	92($29)    #hi	
	mflo	$27
	sw	$27,	96($29)    #lo

	# FreeRTOS: Store the state of the current task.
	lui	$26,	%hi(pxCurrentTCB)	# Load the pointer to the current TCB.
	addi	$26,	%lo(pxCurrentTCB) 
	sw	$29,	0($26)			# Store the current task's stack pointer.

	# FreeRTOS: Load the stack pointer for the CPU.
	lui	$26,	%hi(InitStack)		# Load the pointer to the CPU stack.
	addi	$26,	%lo(InitStack) 
	jr	$31				# Prepare to return to calling function.
	lw	$29,	0($26)			# Load the CPU stack pointer.

	.set reorder
	.set at
	.end portSAVE_CONTEXT

	.global	portRESTORE_CONTEXT
	.ent	portRESTORE_CONTEXT
portRESTORE_CONTEXT:
	.set noreorder
   	.set noat
	
	# FreeRTOS: Save the stack pointer for the CPU.
	lui	$26,	%hi(InitStack)		# Load the pointer to the CPU stack.
	addi	$26,	%lo(InitStack) 
	sw	$29,	0($26)			# Store the CPU stack pointer.

	# FreeRTOS: Load the stack pointer for the current task.
	lui	$26,	%hi(pxCurrentTCB)	# Load the pointer to the current TCB.
	addi	$26,	%lo(pxCurrentTCB)
	lw	$29,	0($26)			# Load the stack pointer from the current TCB.
	
	# Resore the state of the CPU with context of task.
	lw    $1,  16($29)    #at	
	lw    $2,  20($29)    #v0	
	lw    $3,  24($29)    #v1
	lw    $4,  28($29)    #a0	
	lw    $5,  32($29)    #a1
	lw    $6,  36($29)    #a2	
	lw    $7,  40($29)    #a3
	lw    $8,  44($29)    #t0	
	lw    $9,  48($29)    #t1
	lw    $10, 52($29)    #t2	
	lw    $11, 56($29)    #t3
	lw    $12, 60($29)    #t4	
	lw    $13, 64($29)    #t5
	lw    $14, 68($29)    #t6	
	lw    $15, 72($29)    #t7
	lw    $24, 76($29)    #t8	
	lw    $25, 80($29)    #t9
	lw    $31, 84($29)    #lr	
	lw    $26, 88($29)    #pc
	lw    $27, 92($29)    #hi	
	mthi  $27
	lw    $27, 96($29)    #lo	
	mtlo  $27
	jr    $31
	addi  $29, $29, 104   #adjust	sp

	.set reorder
	.set at
	.end portRESTORE_CONTEXT

	.global	FreeRTOS_ISR
   	.ent 	FreeRTOS_ISR	
FreeRTOS_ISR:   	
	.set 	noreorder
   	.set 	noat

	# Perform interrupt-related operations.
	jal	portSAVE_CONTEXT	# Save the context of the current task.
	jal	FreeRTOS_UserISR	# Jump to user-defined ISR.
	jal	portRESTORE_CONTEXT	# Restore context. The PC should be on register 26.

	# Re-enables interrupts and return to restored state.
	addiu	$27, $0, 1		# Prepare status mask.		
	jr	$26			# Prepare to return to restored task.
	mtc0	$27, $12		# Enable interrupts.

	.set 	reorder
	.set	at
	.end 	FreeRTOS_ISR

	.global	FreeRTOS_AsmInterruptInit
	.ent	FreeRTOS_AsmInterruptInit
FreeRTOS_AsmInterruptInit:
	.set 	noreorder
	la	$5,	FreeRTOS_AsmPatchValue
	lw	$6,	0($5)
	sw	$6,	0x3c($0)
	lw	$6,	4($5)
	sw	$6,	0x40($0)
	lw	$6,	8($5)
	sw	$6,	0x44($0)
	lw	$6,	12($5)
	jr	$31
	sw	$6,	0x48($0)

FreeRTOS_AsmPatchValue:
	lui	$26,	%hi(FreeRTOS_ISR)
	addi	$26,	%lo(FreeRTOS_ISR)
	jr	$26 
	nop

	.set 	reorder
	.end 	FreeRTOS_AsmInterruptInit

	.global	vPortStartFirstTask
	.ent	vPortStartFirstTask
vPortStartFirstTask:
	.set 	noreorder

	# Set the context to the current task.
	jal	portRESTORE_CONTEXT	# Restore context. The PC should be on register 26.

	# Re-enables interrupts and return to restored state.
	addiu	$27, $0, 1		# Prepare status mask.		
	jr	$26			# Prepare to return to restored task.
	mtc0	$27, $12		# Enable interrupts.

	.set 	reorder
	.end 	vPortStartFirstTask


   
