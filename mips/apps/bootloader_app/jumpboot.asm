	JUMP_ADDRESS	= 0x01000000	

	.data

	.text
	.section	.text.startup

	.align 		2

	.global 	entry
	.ent		entry
entry:
   	.set 		noreorder
	
	lui		$8, %hi(JUMP_ADDRESS)
	ori		$8, %lo(JUMP_ADDRESS)
	jr		$8
	nop

	.set 		reorder
	.end		entry


