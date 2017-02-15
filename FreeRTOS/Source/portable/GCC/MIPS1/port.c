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

static inline void SetupTickTimer(void);
static inline void DisableTickTimer(void);
extern void StartFirstTask(void);

void vAssertCalled(const char *file, int line)
{
	// right now just stop scheduler and loop forever
	// eventually this should do more than just that...

	portDISABLE_INTERRUPTS();

	vTaskSuspendAll();

	while(1) __asm__ __volatile__("");
}

BaseType_t xPortStartScheduler(void)
{
	static xgpio xgpio_output_obj;
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

/******		Tick functions		******/

extern plasoc_int int_obj;
extern plasoc_timer timer_obj;

static void FreeRTOSTick(void* extraArgs)
{
	portENTER_CRITICAL();
	plasoc_timer_reload_start(&timer_obj,1);
	if( xTaskIncrementTick() != pdFALSE )
	{
		// A context switch is required
		vTaskSwitchContext();
	}
	portEXIT_CRITICAL();
}

static inline void SetupTickTimer(void)
{

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
