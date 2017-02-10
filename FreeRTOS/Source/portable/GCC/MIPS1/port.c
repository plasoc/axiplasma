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
#include "plasoc_timer.h"

#define PLASOC_TIMER_BASE_ADDRESS		(0x44a10000)
#define PLASOC_INT_BASE_ADDRESS			(0x44a00000)

#define ucHeap = (*(volatile uint8_t (*)[PLASOC_HEAP_MAX_SIZE])(PLASOC_HEAP_BASE_ADDRESS))

static inline void SetupTickTimer(void);
static inline void StartFirstTask(void);
static inline void DisableTickTimer(void);

inline void portSAVE_CONTEXT()
{
	__asm__ __volatile__ (
"	addi  $29, $29, -104  #adjust sp				\
	sw    $1,  16($29)    #at						\
	sw    $2,  20($29)    #v0						\
	sw    $3,  24($29)    #v1						\
	sw    $4,  28($29)    #a0						\
	sw    $5,  32($29)    #a1						\
	sw    $6,  36($29)    #a2						\
	sw    $7,  40($29)    #a3						\
	sw    $8,  44($29)    #t0						\
	sw    $9,  48($29)    #t1						\
	sw    $10, 52($29)    #t2						\
	sw    $11, 56($29)    #t3						\
	sw    $12, 60($29)    #t4						\
	sw    $13, 64($29)    #t5						\
	sw    $14, 68($29)    #t6						\
	sw    $15, 72($29)    #t7						\
	sw    $24, 76($29)    #t8						\
	sw    $25, 80($29)    #t9						\
	sw    $31, 84($29)    #lr						\
	mfc0  $26, $14        #C0_EPC=14 (Exception PC)	\
	addi  $26, $26, -4    #Backup one opcode		\
	sw    $26, 88($29)    #pc						\
	mfhi  $27										\
	sw    $27, 92($29)    #hi						\
	mflo  $27										\
	sw    $27, 96($29)    #lo"
	:
	:
	: "memory"
	);
}

inline void portRESTORE_CONTEXT()
{
	__asm__ __volatile__ (
"	lw    $1,  16($29)    #at	\
	lw    $2,  20($29)    #v0	\
	lw    $3,  24($29)    #v1	\
	lw    $4,  28($29)    #a0	\
	lw    $5,  32($29)    #a1	\
	lw    $6,  36($29)    #a2	\
	lw    $7,  40($29)    #a3	\
	lw    $8,  44($29)    #t0	\
	lw    $9,  48($29)    #t1	\
	lw    $10, 52($29)    #t2	\
	lw    $11, 56($29)    #t3	\
	lw    $12, 60($29)    #t4	\
	lw    $13, 64($29)    #t5	\
	lw    $14, 68($29)    #t6	\
	lw    $15, 72($29)    #t7	\
	lw    $24, 76($29)    #t8	\
	lw    $25, 80($29)    #t9	\
	lw    $31, 84($29)    #lr	\
	lw    $26, 88($29)    #pc	\
	lw    $27, 92($29)    #hi	\
	mthi  $27					\
	lw    $27, 96($29)    #lo	\
	mtlo  $27					\
	addi  $29, $29, 104   #adjust sp"
	:
	:
	: "memory"
	)
}

void vAssertCalled(const char *file, int line)
{
	// right now just stop scheduler and loop forever
	// eventually this should do more than just that...

	portDISABLE_INTERRUPTS();

	vTaskSuspendAll();

	while(1) __asm__ __volatile__("");
}

StackType_t* pxPortInitialiseStack(StackType_t* pxTopOfStack, TaskFunction_t pxCode, void* pvParamters)
{
	// follows semantics of interrupt_service_routine from boot.asm

	// reserved for saving a0-a3
	pxTopOfStack -= 4;

	// at, v0 and v1
	pxTopOfStack -= 3;

	// a0 gets parameter list
	*pxTopOfStack-- = pvParameters;

	// a1-a3, t0-t9
	pxTopOfStack -= 13;

	// lr with (potentially) special value
	*pxTopOfStack-- = 0;

	// pc
	*pxTopOfStack-- = pxCode;

	// hi and lo
	pxTopOfStack -= 2;
}

BaseType_t xPortStartScheduler(void)
{
	// setup timer interrupt for FreeRTOS tick
	SetupTickTimer();

	// TODO: save link register so vPortEndScheduler can return from this function

	// start first task
	StartFirstTask();
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

static void FreeRTOSTick(void)
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
	plasoc_int_attach_isr(&int_obj, 0, FreeRTOSTick, 0);

	/* Configure the interrupts of the CPU. */
	OS_AsmInterruptEnable(1);

	/* Enable all interrupts in the interrupt controller and start the timer in reload mode. */
	plasoc_int_enable_all(&int_obj);
	plasoc_timer_reload_start(&timer_obj,0);
}

static inline void StartFirstTask(void)
{
	portRESTORE_CONTEXT();
}

static inline void DisableTickTimer(void)
{
	// because vPortEndScheduler only pauses execution
	// this doesn't have to be anything yet
	// TODO: fill out
}
