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

#include "FreeRTOS.h"
#include "task.h"

#include "portmacro.h"
#include "plasoc_cpu.h"
#include "plasoc_int.h"
#include "plasoc_timer.h"

#define PLASOC_TIMER_BASE_ADDRESS		(0x44a10000)
#define PLASOC_INT_BASE_ADDRESS			(0x44a00000)

#define ucHeap = (*(volatile uint8_t (*)[PLASOC_HEAP_MAX_SIZE])(PLASOC_HEAP_BASE_ADDRESS))

static inline void SetupTickTimer(void);
static inline void DisableTickTimer(void);
#define StartFirstTask() \
	portRESTORE_CONTEXT();

void vAssertCalled(const char *file, int line)
{
	// right now just stop scheduler and loop forever
	// eventually this should do more than just that...

	portDISABLE_INTERRUPTS();

	vTaskSuspendAll();

	while(1) __asm__ __volatile__("");
}

StackType_t* pxPortInitialiseStack(StackType_t* pxTopOfStack, TaskFunction_t pxCode, void* pvParameters)
{
	// follows semantics of interrupt_service_routine from boot.asm

	// reserved for saving a0-a3
	pxTopOfStack -= 4;

	// at, v0 and v1
	pxTopOfStack -= 3;

	// a0 gets parameter list
	*pxTopOfStack-- = (StackType_t)pvParameters;

	// a1-a3, t0-t9
	pxTopOfStack -= 13;

	// lr with (potentially) special value
	*pxTopOfStack-- = 0;

	// pc
	*pxTopOfStack-- = (StackType_t)pxCode;

	// hi and lo
	pxTopOfStack -= 2;

	return pxTopOfStack;
}

BaseType_t xPortStartScheduler(void)
{
	// setup timer interrupt for FreeRTOS tick
	SetupTickTimer();

	// TODO: save link register so vPortEndScheduler can return from this function

	// start first task
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

static plasoc_int int_obj;
static plasoc_timer timer_obj;

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
	// initialize interrupt and timer objects
	plasoc_int_setup(&int_obj, PLASOC_INT_BASE_ADDRESS);
	plasoc_timer_setup(&timer_obj, PLASOC_TIMER_BASE_ADDRESS);

	// attach FreeRTOS's tick to trigger
	plasoc_timer_set_trig_value(&timer_obj, configTICK_RATE_HZ/PLASMA_HZ);
	plasoc_int_attach_isr(&int_obj, 0, FreeRTOSTick, NULL);

	/* Configure the interrupts of the CPU. */
	OS_AsmInterruptEnable(1);

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
