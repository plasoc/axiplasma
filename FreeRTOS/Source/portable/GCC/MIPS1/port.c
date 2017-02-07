/*This file has been prepared for Doxygen automatic documentation generation.*/
/*! \file *********************************************************************
 *
 * \brief FreeRTOS port source for customized MIPS rev 1 architecture.
 *
 * - Compiler:			 GNU GCC for MIPS1
 * - Supported devices:  https://github.com/andrewandrepowell/axiplasma
 *
 * \author				 Kaleb Barrett (Temple University 2017)
 *
 *****************************************************************************/

#include "portmacro.h"
#include "plasoc_cpu.h"

#define ucHeap = (*(volatile uint8_t (*)[PLASOC_HEAP_MAX_SIZE])(PLASOC_HEAP_BASE_ADDRESS))

void vTaskSuspendAll(void);
void vAssertCalled(const char *file, int line)
{
	// right now just stop scheduler and loop forever
	// eventually this should do more than just that...
	vTaskSuspendAll();
	portDISABLE_INTERRUPTS();
	while(1)
	{
		__asm__ __volatile__("");
	}
}

/*	TODO: Fill these functions out to finish the port
StackType_t* pxPortInitialiseStack(void)
{

}

BaseType_t xPortStartScheduler(void)
{

}

void vPortEndScheduler(void)
{

}
*/

