/*! \file *********************************************************************
 *
 * \brief FreeRTOS port source for customized MIPS R2000 architecture.
 *
 * - Compiler:			 GNU GCC for MIPS1
 * - Supported devices:  https://github.com/andrewandrepowell/axiplasma
 *
 * \author				 Kaleb Barrett (Temple University 2017)
 *
 *****************************************************************************/

#include "FreeRTOS.h"
#include "task.h"

#include "portmacro.h"
#include "plasoc_cpu.h"
#include "plasoc_int.h"
#include "plasoc_timer.h"
#include "xgpio.h"

void vAssertCalled(const char* const file, const int line)
{
	// right now just stop scheduler and loop forever
	// eventually this should do more than just that...
	portDISABLE_INTERRUPTS();

	vTaskSuspendAll();

	while(1) __asm__ __volatile__("");
}

StackType_t *pxPortInitialiseStack( StackType_t *pxTopOfStack, TaskFunction_t pxCode, void *pvParameters )
{
	// at, v0, v1
	pxTopOfStack -= 3;

	// a0 holds parameter list
	*pxTopOfStack-- = (StackType_t)pvParameters;

	// a1-a3, t0-t7, s0-s7, t8-t9, fp
	pxTopOfStack -= 22;

	// lr
	*pxTopOfStack-- = (StackType_t)pxCode;

	// hi and lo
	pxTopOfStack -= 2;

	return pxTopOfStack;
}

static void FreeRTOSTick(void* args)
{
	extern plasoc_timer timer_obj;
	(void)args;
	portSAVE_TASK_SP();
	plasoc_timer_reload_start(&timer_obj,1);
	if( xTaskIncrementTick() != pdFALSE )
	{
		// A context switch is required
		vTaskSwitchContext();
	}
	portENABLE_INTERRUPTS();
	portLOAD_TASK_SP();
	portRESTORE_CONTEXT();
}

static inline void SetupTickTimer(void)
{
	extern plasoc_int int_obj;
	extern plasoc_timer timer_obj;

	// attach FreeRTOS's tick to trigger
	plasoc_timer_set_trig_value(&timer_obj, PLASMA_HZ/configTICK_RATE_HZ);
	plasoc_int_attach_isr(&int_obj, INT_PLASOC_TIMER_ID, FreeRTOSTick, NULL);

	/* Enable all interrupts in the interrupt controller and start the timer in reload mode. */
	plasoc_int_enable_all(&int_obj);
	plasoc_timer_reload_start(&timer_obj,0);
}

static inline void DisableTickTimer(void)
{
	// because vPortEndScheduler only pauses execution
	// this doesn't have to be anything yet
	// TODO: fill out
}

static inline void StartFirstTask(void)
{
	portLOAD_TASK_SP();
	portRESTORE_CONTEXT();
}

BaseType_t xPortStartScheduler(void)
{
	extern plasoc_int int_obj;
	extern plasoc_timer timer_obj;

	// for testing
	xgpio xgpio_output_obj;
	xgpio_setup(&xgpio_output_obj,0x40010000);
	xgpio_set_direction(&xgpio_output_obj,XGPIO_OUTPUTS);
	xgpio_set_data(&xgpio_output_obj, 1);

	// setup timer interrupt for FreeRTOS tick
	SetupTickTimer();

	// TODO: save link register so vPortEndScheduler can return from this function

	xgpio_set_data(&xgpio_output_obj, 0);
	portENABLE_INTERRUPTS();

	// Start first task
	StartFirstTask();

	// shouldn't reach here unless vPortEndScheduler is called
	return pdTRUE;
}

void vPortEndScheduler(void)
{
	// disable FreeRTOS tick
	DisableTickTimer();

	// TODO: return to main where start scheduler was called
	// for now just stop
	configASSERT(1);
}

