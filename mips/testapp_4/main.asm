	.section .mdebug.abi32
	.previous
	.text				
	.align	2
	.globl	main
	.ent	main
	.type	main, @function
main:					# Increment the counter that connects to the LEDs.
	addi	$9, $9, 8		# Store the end value.
rep:	addi	$8, $8, 1		# Increment counter.
	bne	$8, $9, rep		# Keep repeating until completion.
spin:	beq	$0, $0, spin		# Never end program.
	jr	$31			# This line should be reached.
	.end	main
