# @author Andrew Powell
# @date March 17, 2017 
# @brief Implements the Jump application. 
#
# Really simple application. Its only purpose is to force the
# Plasma-SoC's CPU to jump to the location of the main application
# which is assumed to be in memory already.
	
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


