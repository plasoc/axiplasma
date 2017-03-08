	.file	1 "printf.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=32
	.module	nooddspreg
	.text
	.align	2
	.set	nomips16
	.set	nomicromips
	.ent	ui2a
	.type	ui2a, @function
ui2a:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	li	$2,1			# 0x1
$L2:
	bne	$2,$0,1f
	divu	$0,$4,$2
	break	7
1:
	mflo	$3
	sltu	$3,$3,$5
	beq	$3,$0,$L3
	mult	$2,$5

	move	$8,$0
$L4:
	bne	$2,$0,$L8
	nop

	jr	$31
	sb	$0,0($7)

$L3:
	mflo	$2
	b	$L2
	nop

$L8:
	bne	$2,$0,1f
	divu	$0,$4,$2
	break	7
1:
	mfhi	$4
	mflo	$9
	nop
	nop
	bne	$5,$0,1f
	divu	$0,$2,$5
	break	7
1:
	mflo	$2
	bne	$8,$0,$L11
	slt	$10,$9,10

	bgtz	$9,$L12
	addiu	$11,$7,1

	bne	$2,$0,$L4
	nop

$L11:
	addiu	$11,$7,1
$L12:
	bne	$10,$0,$L7
	li	$3,48			# 0x30

	bne	$6,$0,$L7
	li	$3,55			# 0x37

	li	$3,87			# 0x57
$L7:
	addu	$3,$3,$9
	sb	$3,0($7)
	addiu	$8,$8,1
	b	$L4
	move	$7,$11

	.set	macro
	.set	reorder
	.end	ui2a
	.size	ui2a, .-ui2a
	.align	2
	.set	nomips16
	.set	nomicromips
	.ent	putchw
	.type	putchw, @function
putchw:
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
	sw	$31,36($sp)
	sw	$16,16($sp)
	move	$18,$4
	move	$19,$5
	lw	$17,56($sp)
	beq	$7,$0,$L14
	li	$20,32			# 0x20

	li	$20,48			# 0x30
$L14:
	move	$2,$17
$L15:
	addiu	$2,$2,1
	lb	$3,-1($2)
	nop
	bne	$3,$0,$L16
	move	$16,$6

$L17:
	blez	$16,$L19
	move	$5,$20

	jalr	$19
	move	$4,$18

	b	$L17
	addiu	$16,$16,-1

$L18:
	b	$L15
	addiu	$6,$6,-1

$L16:
	bgtz	$6,$L18
	nop

$L19:
	addiu	$17,$17,1
$L26:
	lb	$5,-1($17)
	nop
	bne	$5,$0,$L22
	nop

	lw	$31,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	jr	$31
	addiu	$sp,$sp,40

$L22:
	jalr	$19
	move	$4,$18

	b	$L26
	addiu	$17,$17,1

	.set	macro
	.set	reorder
	.end	putchw
	.size	putchw, .-putchw
	.align	2
	.set	nomips16
	.set	nomicromips
	.ent	putcp
	.type	putcp, @function
putcp:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	lw	$2,0($4)
	nop
	addiu	$3,$2,1
	sw	$3,0($4)
	jr	$31
	sb	$5,0($2)

	.set	macro
	.set	reorder
	.end	putcp
	.size	putcp, .-putcp
	.align	2
	.globl	tfp_format
	.set	nomips16
	.set	nomicromips
	.ent	tfp_format
	.type	tfp_format, @function
tfp_format:
	.frame	$sp,72,$31		# vars= 16, regs= 8/0, args= 24, gp= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-72
	sw	$21,60($sp)
	sw	$20,56($sp)
	sw	$19,52($sp)
	sw	$18,48($sp)
	sw	$17,44($sp)
	sw	$16,40($sp)
	sw	$31,68($sp)
	sw	$22,64($sp)
	move	$18,$4
	move	$19,$5
	move	$17,$6
	move	$16,$7
	li	$20,37			# 0x25
	li	$21,48			# 0x30
$L29:
	lb	$5,0($17)
	nop
	beq	$5,$0,$L28
	nop

	beq	$5,$20,$L30
	nop

	addiu	$17,$17,1
$L58:
	jalr	$19
	move	$4,$18

	b	$L29
	nop

$L30:
	lb	$6,1($17)
	nop
	beq	$6,$21,$L32
	li	$13,1			# 0x1

	addiu	$17,$17,2
	move	$13,$0
$L33:
	addiu	$2,$6,-48
	andi	$2,$2,0x00ff
	sltu	$2,$2,10
	beq	$2,$0,$L34
	move	$12,$0

$L35:
	andi	$2,$6,0x00ff
	addiu	$3,$2,-48
	sltu	$3,$3,10
	beq	$3,$0,$L36
	addiu	$3,$2,-97

	addiu	$3,$6,-48
	sll	$2,$12,2
$L62:
	addu	$12,$2,$12
	sll	$12,$12,1
	addiu	$17,$17,1
	lb	$6,-1($17)
	b	$L35
	addu	$12,$12,$3

$L32:
	lb	$6,2($17)
	b	$L33
	addiu	$17,$17,3

$L36:
	sltu	$3,$3,6
	beq	$3,$0,$L38
	addiu	$2,$2,-65

	addiu	$3,$6,-87
$L44 = .
$L39:
	slt	$2,$3,11
	bne	$2,$0,$L62
	sll	$2,$12,2

$L34:
	li	$2,99			# 0x63
$L63:
	beq	$6,$2,$L40
	slt	$2,$6,100

	beq	$2,$0,$L41
	li	$2,115			# 0x73

	beq	$6,$20,$L42
	li	$2,88			# 0x58

	beq	$6,$2,$L43
	nop

	bne	$6,$0,$L29
	nop

$L28:
	lw	$31,68($sp)
	lw	$22,64($sp)
	lw	$21,60($sp)
	lw	$20,56($sp)
	lw	$19,52($sp)
	lw	$18,48($sp)
	lw	$17,44($sp)
	lw	$16,40($sp)
	jr	$31
	addiu	$sp,$sp,72

$L38:
	sltu	$2,$2,6
	beq	$2,$0,$L63
	li	$2,99			# 0x63

	b	$L39
	addiu	$3,$6,-55

$L41:
	beq	$6,$2,$L45
	slt	$2,$6,116

	beq	$2,$0,$L46
	li	$2,117			# 0x75

	li	$2,100			# 0x64
	bne	$6,$2,$L29
	addiu	$22,$16,4

	lw	$4,0($16)
	nop
	bgez	$4,$L49
	addiu	$7,$sp,24

	li	$2,45			# 0x2d
	subu	$4,$0,$4
	sb	$2,24($sp)
	addiu	$7,$sp,25
$L49:
	move	$6,$0
	li	$5,10			# 0xa
$L60:
	jal	ui2a
	nop

	addiu	$2,$sp,24
	sw	$2,16($sp)
	move	$7,$13
$L59:
	move	$6,$12
	move	$5,$19
	jal	putchw
	move	$4,$18

	b	$L29
	move	$16,$22

$L46:
	beq	$6,$2,$L48
	addiu	$22,$16,4

	li	$2,120			# 0x78
	bne	$6,$2,$L29
	nop

$L43:
	xori	$6,$6,0x58
	addiu	$22,$16,4
	addiu	$7,$sp,24
	sltu	$6,$6,1
	b	$L61
	li	$5,16			# 0x10

$L48:
	addiu	$7,$sp,24
	move	$6,$0
	li	$5,10			# 0xa
$L61:
	lw	$4,0($16)
	b	$L60
	nop

$L40:
	lb	$5,3($16)
	move	$4,$18
	jalr	$19
	addiu	$22,$16,4

	b	$L29
	move	$16,$22

$L45:
	lw	$2,0($16)
	addiu	$22,$16,4
	sw	$2,16($sp)
	b	$L59
	move	$7,$0

$L42:
	b	$L58
	li	$5,37			# 0x25

	.set	macro
	.set	reorder
	.end	tfp_format
	.size	tfp_format, .-tfp_format
	.align	2
	.globl	init_printf
	.set	nomips16
	.set	nomicromips
	.ent	init_printf
	.type	init_printf, @function
init_printf:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	sw	$5,%gp_rel(stdout_putf)($28)
	jr	$31
	sw	$4,%gp_rel(stdout_putp)($28)

	.set	macro
	.set	reorder
	.end	init_printf
	.size	init_printf, .-init_printf
	.align	2
	.globl	tfp_printf
	.set	nomips16
	.set	nomicromips
	.ent	tfp_printf
	.type	tfp_printf, @function
tfp_printf:
	.frame	$sp,32,$31		# vars= 8, regs= 1/0, args= 16, gp= 0
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$5,36($sp)
	sw	$6,40($sp)
	lw	$5,%gp_rel(stdout_putf)($28)
	move	$6,$4
	lw	$4,%gp_rel(stdout_putp)($28)
	sw	$7,44($sp)
	addiu	$7,$sp,36
	sw	$31,28($sp)
	jal	tfp_format
	sw	$7,16($sp)

	lw	$31,28($sp)
	nop
	jr	$31
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	tfp_printf
	.size	tfp_printf, .-tfp_printf
	.align	2
	.globl	tfp_sprintf
	.set	nomips16
	.set	nomicromips
	.ent	tfp_sprintf
	.type	tfp_sprintf, @function
tfp_sprintf:
	.frame	$sp,32,$31		# vars= 8, regs= 1/0, args= 16, gp= 0
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$6,40($sp)
	move	$6,$5
	lui	$5,%hi(putcp)
	sw	$4,32($sp)
	sw	$7,44($sp)
	addiu	$4,$sp,32
	addiu	$7,$sp,40
	addiu	$5,$5,%lo(putcp)
	sw	$31,28($sp)
	jal	tfp_format
	sw	$7,16($sp)

	lw	$2,32($sp)
	nop
	sb	$0,0($2)
	lw	$31,28($sp)
	nop
	jr	$31
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	tfp_sprintf
	.size	tfp_sprintf, .-tfp_sprintf
	.local	stdout_putp
	.comm	stdout_putp,4,4
	.local	stdout_putf
	.comm	stdout_putf,4,4
	.ident	"GCC: (GNU) 6.3.0"
