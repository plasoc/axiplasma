	.file	1 "printf.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=32
	.module	nooddspreg
	.text
	.align	2
	.globl	tfp_format
	.set	nomips16
	.set	nomicromips
	.ent	tfp_format
	.type	tfp_format, @function
tfp_format:
	.frame	$sp,72,$31		# vars= 16, regs= 10/0, args= 16, gp= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-72
	sw	$22,56($sp)
	sw	$21,52($sp)
	sw	$20,48($sp)
	sw	$18,40($sp)
	sw	$17,36($sp)
	sw	$16,32($sp)
	sw	$31,68($sp)
	sw	$fp,64($sp)
	sw	$23,60($sp)
	sw	$19,44($sp)
	move	$18,$4
	move	$17,$5
	move	$16,$6
	move	$20,$7
	li	$21,37			# 0x25
	li	$22,48			# 0x30
$L2:
	lb	$5,0($16)
	nop
	beq	$5,$0,$L1
	nop

$L85:
	beq	$5,$21,$L3
	move	$4,$18

	jalr	$17
	addiu	$16,$16,1

	lb	$5,0($16)
	nop
	bne	$5,$0,$L85
	nop

$L1:
	lw	$31,68($sp)
	lw	$fp,64($sp)
	lw	$23,60($sp)
	lw	$22,56($sp)
	lw	$21,52($sp)
	lw	$20,48($sp)
	lw	$19,44($sp)
	lw	$18,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	jr	$31
	addiu	$sp,$sp,72

$L3:
	lb	$4,1($16)
	nop
	beq	$4,$22,$L5
	li	$6,1			# 0x1

	addiu	$16,$16,2
	move	$6,$0
$L6:
	addiu	$2,$4,-48
	andi	$2,$2,0x00ff
	sltu	$2,$2,10
	bne	$2,$0,$L8
	move	$2,$0

	li	$3,99			# 0x63
$L185:
	beq	$4,$3,$L13
	slt	$3,$4,100

$L184:
	bne	$3,$0,$L157
	li	$3,115			# 0x73

	beq	$4,$3,$L18
	slt	$3,$4,116

	bne	$3,$0,$L158
	li	$3,117			# 0x75

	bne	$4,$3,$L159
	li	$3,120			# 0x78

	lw	$4,0($20)
	nop
	sltu	$3,$4,10
	bne	$3,$0,$L93
	addiu	$20,$20,4

	li	$3,1			# 0x1
	sll	$5,$3,2
$L179:
	addu	$3,$5,$3
	sll	$3,$3,1
	bne	$3,$0,1f
	divu	$0,$4,$3
	break	7
1:
	mflo	$5
	sltu	$5,$5,10
	beq	$5,$0,$L179
	sll	$5,$3,2

	beq	$3,$0,$L160
	addiu	$11,$sp,16

$L22:
	addiu	$8,$sp,16
	move	$10,$0
	li	$12,10			# 0xa
$L25:
	bne	$12,$0,1f
	divu	$0,$3,$12
	break	7
1:
	addiu	$11,$8,1
	li	$5,87			# 0x57
	mflo	$9
	nop
	nop
	bne	$3,$0,1f
	divu	$0,$4,$3
	break	7
1:
	mfhi	$4
	mflo	$7
	bne	$10,$0,$L26
	move	$3,$9

	blez	$7,$L161
	nop

$L26:
	slt	$13,$7,10
	beq	$13,$0,$L180
	addu	$5,$5,$7

	li	$5,48			# 0x30
	addu	$5,$5,$7
$L180:
	addiu	$10,$10,1
	beq	$9,$0,$L24
	sb	$5,0($8)

	b	$L25
	move	$8,$11

$L160:
$L24:
	bne	$6,$0,$L162
	sb	$0,0($11)

$L96:
	li	$23,32			# 0x20
$L30:
	lb	$19,16($sp)
	nop
	beq	$19,$0,$L31
	nop

	beq	$2,$0,$L32
	addiu	$3,$sp,17

	b	$L195
	addiu	$3,$3,1

$L163:
	beq	$5,$0,$L32
	move	$2,$5

	addiu	$3,$3,1
$L195:
	lb	$4,-1($3)
	nop
	bne	$4,$0,$L163
	addiu	$5,$2,-1

	beq	$5,$0,$L32
	addiu	$fp,$2,-2

	move	$5,$23
$L181:
	move	$4,$18
	jalr	$17
	addiu	$fp,$fp,-1

	addiu	$2,$fp,1
	bgtz	$2,$L181
	move	$5,$23

	beq	$19,$0,$L2
	nop

$L32:
	addiu	$23,$sp,17
	move	$5,$19
$L182:
	move	$4,$18
	jalr	$17
	addiu	$23,$23,1

	lb	$19,-1($23)
	nop
	bne	$19,$0,$L182
	move	$5,$19

	b	$L2
	nop

$L157:
	beq	$4,$21,$L15
	li	$3,88			# 0x58

	beq	$4,$3,$L16
	nop

	beq	$4,$0,$L1
	nop

	b	$L2
	nop

$L164:
	addiu	$5,$4,-48
	sll	$3,$2,2
$L183:
	addu	$2,$3,$2
	addiu	$16,$16,1
	sll	$2,$2,1
	lb	$4,-1($16)
	addu	$2,$2,$5
$L8:
	andi	$3,$4,0x00ff
	addiu	$5,$3,-48
	addiu	$7,$3,-97
	sltu	$5,$5,10
	bne	$5,$0,$L164
	sltu	$7,$7,6

	addiu	$3,$3,-65
	beq	$7,$0,$L11
	sltu	$3,$3,6

	addiu	$5,$4,-87
$L17 = .
$L12:
	slt	$3,$5,11
	bne	$3,$0,$L183
	sll	$3,$2,2

	li	$3,99			# 0x63
	bne	$4,$3,$L184
	slt	$3,$4,100

$L13:
	lb	$5,3($20)
	move	$4,$18
	jalr	$17
	addiu	$20,$20,4

	b	$L2
	nop

$L11:
	beq	$3,$0,$L185
	li	$3,99			# 0x63

	b	$L12
	addiu	$5,$4,-55

$L5:
	lb	$4,2($16)
	b	$L6
	addiu	$16,$16,3

$L161:
	bne	$9,$0,$L166
	move	$11,$8

	addiu	$5,$7,48
	addiu	$11,$8,1
	sb	$5,0($8)
	beq	$6,$0,$L96
	sb	$0,0($11)

	b	$L30
	li	$23,48			# 0x30

$L158:
	li	$3,100			# 0x64
	bne	$4,$3,$L2
	nop

	lw	$5,0($20)
	nop
	bltz	$5,$L167
	addiu	$20,$20,4

	addiu	$8,$sp,16
$L38:
	slt	$3,$5,10
	bne	$3,$0,$L98
	move	$7,$5

	li	$3,1			# 0x1
	sll	$4,$3,2
$L186:
	addu	$3,$4,$3
	sll	$3,$3,1
	bne	$3,$0,1f
	divu	$0,$5,$3
	break	7
1:
	mflo	$4
	sltu	$4,$4,10
	beq	$4,$0,$L186
	sll	$4,$3,2

	beq	$3,$0,$L168
	move	$11,$8

$L39:
	move	$10,$0
	li	$12,10			# 0xa
$L42:
	bne	$12,$0,1f
	divu	$0,$3,$12
	break	7
1:
	addiu	$11,$8,1
	li	$4,87			# 0x57
	mflo	$9
	nop
	nop
	bne	$3,$0,1f
	divu	$0,$7,$3
	break	7
1:
	mfhi	$7
	mflo	$5
	bne	$10,$0,$L43
	move	$3,$9

	blez	$5,$L169
	nop

$L43:
	slt	$13,$5,10
	beq	$13,$0,$L187
	addu	$4,$4,$5

	li	$4,48			# 0x30
	addu	$4,$4,$5
$L187:
	addiu	$10,$10,1
	beq	$9,$0,$L41
	sb	$4,0($8)

	b	$L42
	move	$8,$11

$L18:
	lw	$23,0($20)
	addiu	$20,$20,4
	lb	$5,0($23)
	nop
	beq	$5,$0,$L78
	addiu	$19,$23,1

	beq	$2,$0,$L84
	move	$3,$19

	b	$L196
	addiu	$3,$3,1

$L170:
	beq	$6,$0,$L84
	move	$2,$6

	addiu	$3,$3,1
$L196:
	lb	$4,-1($3)
	nop
	bne	$4,$0,$L170
	addiu	$6,$2,-1

	beq	$6,$0,$L84
	addiu	$fp,$2,-2

	li	$5,32			# 0x20
$L188:
	move	$4,$18
	jalr	$17
	addiu	$fp,$fp,-1

	addiu	$2,$fp,1
	bgtz	$2,$L188
	li	$5,32			# 0x20

	lb	$5,0($23)
	nop
	beq	$5,$0,$L2
	nop

$L84:
	move	$4,$18
$L189:
	jalr	$17
	addiu	$19,$19,1

	lb	$5,-1($19)
	nop
	beq	$5,$0,$L2
	move	$4,$18

	jalr	$17
	addiu	$19,$19,1

	lb	$5,-1($19)
	nop
	bne	$5,$0,$L189
	move	$4,$18

	b	$L2
	nop

$L159:
	bne	$4,$3,$L2
	nop

$L16:
	lw	$5,0($20)
	nop
	sltu	$3,$5,16
	bne	$3,$0,$L102
	addiu	$20,$20,4

	li	$3,1			# 0x1
$L56:
	sll	$3,$3,4
	bne	$3,$0,1f
	divu	$0,$5,$3
	break	7
1:
	mflo	$7
	sltu	$7,$7,16
	beq	$7,$0,$L56
	nop

	beq	$3,$0,$L171
	nop

$L55:
	li	$7,88			# 0x58
	addiu	$9,$sp,16
	beq	$4,$7,$L59
	move	$10,$0

$L65:
	bne	$3,$0,1f
	divu	$0,$5,$3
	break	7
1:
	mfhi	$5
	mflo	$8
	bne	$10,$0,$L64
	srl	$3,$3,4

	blez	$8,$L172
	nop

$L64:
	slt	$11,$8,10
	addiu	$4,$9,1
	beq	$11,$0,$L61
	li	$7,87			# 0x57

	li	$7,48			# 0x30
$L61:
	addu	$7,$7,$8
	addiu	$10,$10,1
	beq	$3,$0,$L57
	sb	$7,0($9)

	b	$L65
	move	$9,$4

$L173:
	beq	$3,$0,$L190
	addiu	$7,$8,48

	move	$4,$9
$L68:
	move	$9,$4
$L59:
	bne	$3,$0,1f
	divu	$0,$5,$3
	break	7
1:
	mfhi	$5
	mflo	$8
	bne	$10,$0,$L66
	srl	$3,$3,4

	blez	$8,$L173
	nop

$L66:
	slt	$11,$8,10
	addiu	$4,$9,1
	beq	$11,$0,$L69
	li	$7,55			# 0x37

	li	$7,48			# 0x30
$L69:
	addu	$7,$7,$8
	addiu	$10,$10,1
	bne	$3,$0,$L68
	sb	$7,0($9)

$L57:
	bne	$6,$0,$L174
	sb	$0,0($4)

$L107:
	li	$23,32			# 0x20
$L70:
	lb	$19,16($sp)
	nop
	beq	$19,$0,$L71
	nop

	beq	$2,$0,$L72
	addiu	$3,$sp,17

	b	$L197
	addiu	$3,$3,1

$L175:
	beq	$5,$0,$L72
	move	$2,$5

	addiu	$3,$3,1
$L197:
	lb	$4,-1($3)
	nop
	bne	$4,$0,$L175
	addiu	$5,$2,-1

	beq	$5,$0,$L72
	addiu	$fp,$2,-2

	move	$5,$23
$L191:
	move	$4,$18
	jalr	$17
	addiu	$fp,$fp,-1

	addiu	$2,$fp,1
	bgtz	$2,$L191
	move	$5,$23

	beq	$19,$0,$L2
	nop

$L72:
	addiu	$23,$sp,17
	move	$5,$19
$L192:
	move	$4,$18
	jalr	$17
	addiu	$23,$23,1

	lb	$19,-1($23)
	nop
	bne	$19,$0,$L192
	move	$5,$19

	b	$L2
	nop

$L15:
	li	$5,37			# 0x25
	jalr	$17
	move	$4,$18

	b	$L2
	nop

$L166:
	b	$L25
	move	$8,$11

$L162:
	b	$L30
	li	$23,48			# 0x30

$L174:
	b	$L70
	li	$23,48			# 0x30

$L168:
$L41:
	beq	$6,$0,$L101
	sb	$0,0($11)

$L178:
	li	$23,48			# 0x30
$L47:
	lb	$19,16($sp)
	nop
	beq	$19,$0,$L48
	nop

	beq	$2,$0,$L49
	addiu	$3,$sp,17

	b	$L198
	addiu	$3,$3,1

$L176:
	beq	$5,$0,$L49
	move	$2,$5

	addiu	$3,$3,1
$L198:
	lb	$4,-1($3)
	nop
	bne	$4,$0,$L176
	addiu	$5,$2,-1

	beq	$5,$0,$L49
	addiu	$fp,$2,-2

	move	$5,$23
$L193:
	move	$4,$18
	jalr	$17
	addiu	$fp,$fp,-1

	addiu	$2,$fp,1
	bgtz	$2,$L193
	move	$5,$23

	beq	$19,$0,$L2
	nop

$L49:
	addiu	$23,$sp,17
	move	$5,$19
$L194:
	move	$4,$18
	jalr	$17
	addiu	$23,$23,1

	lb	$19,-1($23)
	nop
	bne	$19,$0,$L194
	move	$5,$19

	b	$L2
	nop

$L169:
	beq	$9,$0,$L44
	addiu	$4,$5,48

	move	$11,$8
	b	$L42
	move	$8,$11

$L172:
	bne	$3,$0,$L177
	move	$4,$9

	addiu	$7,$8,48
$L190:
	addiu	$4,$9,1
	sb	$7,0($9)
	beq	$6,$0,$L107
	sb	$0,0($4)

	b	$L70
	li	$23,48			# 0x30

$L44:
	addiu	$11,$8,1
	sb	$4,0($8)
	bne	$6,$0,$L178
	sb	$0,0($11)

$L101:
	b	$L47
	li	$23,32			# 0x20

$L177:
	b	$L65
	move	$9,$4

$L167:
	li	$3,45			# 0x2d
	subu	$5,$0,$5
	sb	$3,16($sp)
	b	$L38
	addiu	$8,$sp,17

$L171:
	b	$L57
	addiu	$4,$sp,16

$L98:
	b	$L39
	li	$3,1			# 0x1

$L102:
	b	$L55
	li	$3,1			# 0x1

$L93:
	b	$L22
	li	$3,1			# 0x1

$L48:
	beq	$2,$0,$L2
	addiu	$fp,$2,-1

	b	$L193
	move	$5,$23

$L78:
	beq	$2,$0,$L2
	addiu	$fp,$2,-1

	b	$L188
	li	$5,32			# 0x20

$L31:
	beq	$2,$0,$L2
	addiu	$fp,$2,-1

	b	$L181
	move	$5,$23

$L71:
	beq	$2,$0,$L2
	addiu	$fp,$2,-1

	b	$L191
	move	$5,$23

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
	addiu	$2,$sp,36
	sw	$5,36($sp)
	sw	$6,40($sp)
	lw	$5,%gp_rel(stdout_putf)($28)
	move	$6,$4
	lw	$4,%gp_rel(stdout_putp)($28)
	sw	$7,44($sp)
	move	$7,$2
	sw	$31,28($sp)
	jal	tfp_format
	sw	$2,16($sp)

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
	.frame	$sp,64,$31		# vars= 16, regs= 8/0, args= 16, gp= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-64
	sw	$21,52($sp)
	addiu	$21,$sp,72
	sw	$19,44($sp)
	sw	$18,40($sp)
	sw	$17,36($sp)
	sw	$31,60($sp)
	sw	$22,56($sp)
	sw	$20,48($sp)
	sw	$16,32($sp)
	move	$3,$4
	move	$17,$5
	sw	$6,72($sp)
	sw	$7,76($sp)
	sw	$21,28($sp)
	li	$18,37			# 0x25
	li	$19,48			# 0x30
$L203:
	lb	$2,0($17)
	nop
	beq	$2,$0,$L218
	nop

$L279:
	beq	$2,$18,$L204
	nop

	sb	$2,0($3)
	addiu	$17,$17,1
	lb	$2,0($17)
	nop
	bne	$2,$0,$L279
	addiu	$3,$3,1

$L218:
	sb	$0,0($3)
	lw	$31,60($sp)
	lw	$22,56($sp)
	lw	$21,52($sp)
	lw	$20,48($sp)
	lw	$19,44($sp)
	lw	$18,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	jr	$31
	addiu	$sp,$sp,64

$L204:
	lb	$4,1($17)
	nop
	beq	$4,$19,$L206
	li	$7,1			# 0x1

	addiu	$17,$17,2
	move	$7,$0
$L207:
	addiu	$2,$4,-48
	andi	$2,$2,0x00ff
	sltu	$2,$2,10
	bne	$2,$0,$L209
	move	$16,$0

	li	$2,99			# 0x63
$L373:
	beq	$4,$2,$L214
	slt	$2,$4,100

$L371:
	bne	$2,$0,$L342
	li	$2,115			# 0x73

	beq	$4,$2,$L219
	slt	$2,$4,116

	bne	$2,$0,$L343
	li	$2,117			# 0x75

	bne	$4,$2,$L344
	li	$2,120			# 0x78

	lw	$4,0($21)
	nop
	sltu	$2,$4,10
	bne	$2,$0,$L290
	addiu	$21,$21,4

	li	$2,1			# 0x1
	sll	$5,$2,2
$L368:
	addu	$2,$5,$2
	sll	$2,$2,1
	bne	$2,$0,1f
	divu	$0,$4,$2
	break	7
1:
	mflo	$5
	sltu	$5,$5,10
	beq	$5,$0,$L368
	sll	$5,$2,2

	beq	$2,$0,$L345
	addiu	$11,$sp,16

$L223:
	addiu	$8,$sp,16
	move	$10,$0
	li	$12,10			# 0xa
$L226:
	bne	$12,$0,1f
	divu	$0,$2,$12
	break	7
1:
	addiu	$11,$8,1
	li	$5,87			# 0x57
	mflo	$9
	nop
	nop
	bne	$2,$0,1f
	divu	$0,$4,$2
	break	7
1:
	mfhi	$4
	mflo	$6
	bne	$10,$0,$L227
	move	$2,$9

	blez	$6,$L346
	nop

$L227:
	slt	$13,$6,10
	beq	$13,$0,$L369
	addu	$5,$5,$6

	li	$5,48			# 0x30
	addu	$5,$5,$6
$L369:
	addiu	$10,$10,1
	beq	$9,$0,$L225
	sb	$5,0($8)

	b	$L226
	move	$8,$11

$L347:
	addiu	$5,$4,-48
	sll	$2,$16,2
$L370:
	addu	$16,$2,$16
	addiu	$17,$17,1
	sll	$16,$16,1
	lb	$4,-1($17)
	addu	$16,$16,$5
$L209:
	andi	$2,$4,0x00ff
	addiu	$5,$2,-48
	addiu	$6,$2,-97
	sltu	$5,$5,10
	bne	$5,$0,$L347
	sltu	$6,$6,6

	addiu	$2,$2,-65
	beq	$6,$0,$L212
	sltu	$2,$2,6

	addiu	$5,$4,-87
$L213:
	slt	$2,$5,11
	bne	$2,$0,$L370
	sll	$2,$16,2

	li	$2,99			# 0x63
	bne	$4,$2,$L371
	slt	$2,$4,100

$L214:
	lw	$2,0($21)
	addiu	$3,$3,1
	sb	$2,-1($3)
	b	$L203
	addiu	$21,$21,4

$L345:
$L225:
	bne	$7,$0,$L349
	sb	$0,0($11)

$L293:
	li	$5,32			# 0x20
$L231:
	lb	$20,16($sp)
	nop
	beq	$20,$0,$L268
	nop

	beq	$16,$0,$L233
	addiu	$2,$sp,17

	b	$L380
	addiu	$2,$2,1

$L350:
	beq	$6,$0,$L233
	move	$16,$6

	addiu	$2,$2,1
$L380:
	lb	$4,-1($2)
	nop
	bne	$4,$0,$L350
	addiu	$6,$16,-1

	beq	$6,$0,$L233
	addiu	$16,$16,-2

	bltz	$16,$L351
	nop

$L286:
	addiu	$16,$16,1
	move	$4,$3
	jal	memset
	move	$6,$16

	addu	$3,$2,$16
$L233:
	addiu	$2,$sp,17
	addiu	$3,$3,1
$L372:
	addiu	$2,$2,1
	sb	$20,-1($3)
	lb	$20,-1($2)
	nop
	bne	$20,$0,$L372
	addiu	$3,$3,1

	b	$L203
	addiu	$3,$3,-1

$L212:
	beq	$2,$0,$L373
	li	$2,99			# 0x63

	b	$L213
	addiu	$5,$4,-55

$L342:
	beq	$4,$18,$L216
	li	$2,88			# 0x58

	beq	$4,$2,$L217
	nop

	beq	$4,$0,$L218
	nop

	b	$L203
	nop

$L206:
	lb	$4,2($17)
	b	$L207
	addiu	$17,$17,3

$L346:
	bne	$9,$0,$L352
	move	$11,$8

	addiu	$5,$6,48
	addiu	$11,$8,1
	sb	$5,0($8)
	beq	$7,$0,$L293
	sb	$0,0($11)

	b	$L231
	li	$5,48			# 0x30

$L343:
	li	$2,100			# 0x64
	bne	$4,$2,$L203
	nop

	lw	$5,0($21)
	nop
	bltz	$5,$L353
	addiu	$21,$21,4

	addiu	$8,$sp,16
$L237:
	slt	$2,$5,10
	bne	$2,$0,$L295
	move	$6,$5

	li	$2,1			# 0x1
	sll	$4,$2,2
$L374:
	addu	$2,$4,$2
	sll	$2,$2,1
	bne	$2,$0,1f
	divu	$0,$5,$2
	break	7
1:
	mflo	$4
	sltu	$4,$4,10
	beq	$4,$0,$L374
	sll	$4,$2,2

	beq	$2,$0,$L354
	move	$11,$8

$L238:
	move	$10,$0
	li	$12,10			# 0xa
$L241:
	bne	$12,$0,1f
	divu	$0,$2,$12
	break	7
1:
	addiu	$11,$8,1
	li	$4,87			# 0x57
	mflo	$9
	nop
	nop
	bne	$2,$0,1f
	divu	$0,$6,$2
	break	7
1:
	mfhi	$6
	mflo	$5
	bne	$10,$0,$L242
	move	$2,$9

	blez	$5,$L355
	nop

$L242:
	slt	$13,$5,10
	beq	$13,$0,$L375
	addu	$4,$4,$5

	li	$4,48			# 0x30
	addu	$4,$4,$5
$L375:
	addiu	$10,$10,1
	beq	$9,$0,$L240
	sb	$4,0($8)

	b	$L241
	move	$8,$11

$L219:
	lw	$22,0($21)
	addiu	$21,$21,4
	lb	$2,0($22)
	nop
	beq	$2,$0,$L273
	addiu	$20,$22,1

	beq	$16,$0,$L278
	move	$4,$20

	b	$L381
	addiu	$4,$4,1

$L356:
	beq	$6,$0,$L278
	move	$16,$6

	addiu	$4,$4,1
$L381:
	lb	$5,-1($4)
	nop
	bne	$5,$0,$L356
	addiu	$6,$16,-1

	beq	$6,$0,$L278
	addiu	$16,$16,-2

$L285:
	bltz	$16,$L357
	nop

$L277:
	addiu	$16,$16,1
	move	$4,$3
	move	$6,$16
	jal	memset
	li	$5,32			# 0x20

	move	$3,$2
	lb	$2,0($22)
	nop
	beq	$2,$0,$L203
	addu	$3,$3,$16

$L278:
	addiu	$3,$3,1
$L376:
	sb	$2,-1($3)
	addiu	$20,$20,1
	lb	$2,-1($20)
	nop
	beq	$2,$0,$L203
	addiu	$20,$20,1

	addiu	$3,$3,1
	sb	$2,-1($3)
	lb	$2,-1($20)
	nop
	bne	$2,$0,$L376
	addiu	$3,$3,1

	b	$L203
	addiu	$3,$3,-1

$L344:
	bne	$4,$2,$L203
	nop

$L217:
	lw	$5,0($21)
	nop
	sltu	$2,$5,16
	bne	$2,$0,$L299
	addiu	$21,$21,4

	li	$2,1			# 0x1
$L253:
	sll	$2,$2,4
	bne	$2,$0,1f
	divu	$0,$5,$2
	break	7
1:
	mflo	$6
	sltu	$6,$6,16
	beq	$6,$0,$L253
	nop

	beq	$2,$0,$L358
	nop

$L252:
	li	$6,88			# 0x58
	addiu	$9,$sp,16
	beq	$4,$6,$L256
	move	$10,$0

$L262:
	bne	$2,$0,1f
	divu	$0,$5,$2
	break	7
1:
	mfhi	$5
	mflo	$8
	bne	$10,$0,$L261
	srl	$2,$2,4

	blez	$8,$L359
	nop

$L261:
	slt	$11,$8,10
	addiu	$4,$9,1
	beq	$11,$0,$L258
	li	$6,87			# 0x57

	li	$6,48			# 0x30
$L258:
	addu	$6,$6,$8
	addiu	$10,$10,1
	beq	$2,$0,$L254
	sb	$6,0($9)

	b	$L262
	move	$9,$4

$L360:
	beq	$2,$0,$L377
	addiu	$6,$8,48

	move	$4,$9
$L265:
	move	$9,$4
$L256:
	bne	$2,$0,1f
	divu	$0,$5,$2
	break	7
1:
	mfhi	$5
	mflo	$8
	bne	$10,$0,$L263
	srl	$2,$2,4

	blez	$8,$L360
	nop

$L263:
	slt	$11,$8,10
	addiu	$4,$9,1
	beq	$11,$0,$L266
	li	$6,55			# 0x37

	li	$6,48			# 0x30
$L266:
	addu	$6,$6,$8
	addiu	$10,$10,1
	bne	$2,$0,$L265
	sb	$6,0($9)

$L254:
	bne	$7,$0,$L361
	sb	$0,0($4)

$L304:
	li	$5,32			# 0x20
$L267:
	lb	$20,16($sp)
	nop
	beq	$20,$0,$L268
	nop

	beq	$16,$0,$L269
	addiu	$2,$sp,17

	b	$L382
	addiu	$2,$2,1

$L362:
	beq	$6,$0,$L269
	move	$16,$6

	addiu	$2,$2,1
$L382:
	lb	$4,-1($2)
	nop
	bne	$4,$0,$L362
	addiu	$6,$16,-1

	beq	$6,$0,$L269
	addiu	$16,$16,-2

	bltz	$16,$L363
	nop

$L288:
	addiu	$16,$16,1
	move	$4,$3
	jal	memset
	move	$6,$16

	addu	$3,$2,$16
$L269:
	addiu	$2,$sp,17
	addiu	$3,$3,1
$L378:
	addiu	$2,$2,1
	sb	$20,-1($3)
	lb	$20,-1($2)
	nop
	bne	$20,$0,$L378
	addiu	$3,$3,1

	b	$L203
	addiu	$3,$3,-1

$L216:
	sb	$18,0($3)
	b	$L203
	addiu	$3,$3,1

$L352:
	b	$L226
	move	$8,$11

$L349:
	b	$L231
	li	$5,48			# 0x30

$L361:
	b	$L267
	li	$5,48			# 0x30

$L354:
$L240:
	beq	$7,$0,$L298
	sb	$0,0($11)

$L366:
	li	$5,48			# 0x30
$L246:
	lb	$20,16($sp)
	nop
	beq	$20,$0,$L268
	nop

	beq	$16,$0,$L248
	addiu	$2,$sp,17

	b	$L383
	addiu	$2,$2,1

$L364:
	beq	$6,$0,$L248
	move	$16,$6

	addiu	$2,$2,1
$L383:
	lb	$4,-1($2)
	nop
	bne	$4,$0,$L364
	addiu	$6,$16,-1

	beq	$6,$0,$L248
	addiu	$16,$16,-2

	bltz	$16,$L365
	nop

$L287:
	addiu	$16,$16,1
	move	$4,$3
	jal	memset
	move	$6,$16

	addu	$3,$2,$16
$L248:
	addiu	$2,$sp,17
	addiu	$3,$3,1
$L379:
	addiu	$2,$2,1
	sb	$20,-1($3)
	lb	$20,-1($2)
	nop
	bne	$20,$0,$L379
	addiu	$3,$3,1

	b	$L203
	addiu	$3,$3,-1

$L355:
	beq	$9,$0,$L243
	addiu	$4,$5,48

	move	$11,$8
	b	$L241
	move	$8,$11

$L243:
	addiu	$11,$8,1
	sb	$4,0($8)
	bne	$7,$0,$L366
	sb	$0,0($11)

$L298:
	b	$L246
	li	$5,32			# 0x20

$L359:
	bne	$2,$0,$L367
	move	$4,$9

	addiu	$6,$8,48
$L377:
	addiu	$4,$9,1
	sb	$6,0($9)
	beq	$7,$0,$L304
	sb	$0,0($4)

	b	$L267
	li	$5,48			# 0x30

$L367:
	b	$L262
	move	$9,$4

$L353:
	li	$2,45			# 0x2d
	subu	$5,$0,$5
	sb	$2,16($sp)
	b	$L237
	addiu	$8,$sp,17

$L358:
	b	$L254
	addiu	$4,$sp,16

$L268:
	beq	$16,$0,$L203
	move	$4,$3

	jal	memset
	move	$6,$16

	b	$L203
	addu	$3,$2,$16

$L357:
	b	$L277
	move	$16,$0

$L363:
	b	$L288
	move	$16,$0

$L351:
	b	$L286
	move	$16,$0

$L365:
	b	$L287
	move	$16,$0

$L295:
	b	$L238
	li	$2,1			# 0x1

$L299:
	b	$L252
	li	$2,1			# 0x1

$L290:
	b	$L223
	li	$2,1			# 0x1

$L273:
	beq	$16,$0,$L203
	addiu	$16,$16,-1

	b	$L285
	nop

	.set	macro
	.set	reorder
	.end	tfp_sprintf
	.size	tfp_sprintf, .-tfp_sprintf
	.local	stdout_putp
	.comm	stdout_putp,4,4
	.local	stdout_putf
	.comm	stdout_putf,4,4
	.ident	"GCC: (GNU) 6.3.0"
