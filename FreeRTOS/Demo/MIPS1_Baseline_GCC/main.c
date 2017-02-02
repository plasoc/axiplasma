
#include <stdlib.h>
#include <string.h>

/* User libraries */
#include "plasmasoc.h"
#include "xgpio.h"
#include "plasoc_int.h"
#include "plasoc_timer.h"

/* Scheduler include files. */
#include "FreeRTOS.h"
#include "task.h"

/* Demo file headers. */
#include "PollQ.h"
#include "integer.h"
#include "serial.h"
#include "comtest.h"
#include "crflash.h"
#include "print.h"
#include "partest.h"
#include "regtest.h"

/*	XGPIO config	*/
#define XGPIO_INPUT_BASE_ADDRESS		(0x40000000)
#define XGPIO_OUTPUT_BASE_ADDRESS		(0x40010000)
#define XGPIO_INPUT_TOTAL				(2)
#define XGPIO_SWITCHES_PER_INPUT		(8)

/*	Interrupt config	*/
#define PLASOC_INT_BASE_ADDRESS			(0x44a00000)
#define INT_XGPIO_INPUT_ID				(0)

/* Priority definitions for most of the tasks in the demo application.  Some
tasks just use the idle priority. */
#define LED_TIMER_TASK_PRIORITY		( tskIDLE_PRIORITY + 2 )
#define USER_INPUT_TASK_PRIORITY	( tskIDLE_PRIORITY + 3 )
#define RANDOM_TASK_PRIORITY		( tskIDLE_PRIORITY + 1 )

/*	task config	*/
#define RANDOM_WRITE_PERIOD		( TickType_t(10) / configTICK_PERIOD_MS )
#define USER_INPUT_MAX_DELAY	( TickType_t(100) / configTICK_PERIOD_MS )
#define BLINK_HALF_PERIOD		( TickType_t(1000) / configTICK_PERIOD_MS )

/* The following functions are defined in the boot loader assembly.
 They are necessary to initialize the interrupt of the CPU. */
extern void OS_AsmInterruptEnable(unsigned enable_flag);

/* Define the CPU's service routine such that it calls the
 interrupt controller's service method. */
extern void OS_InterruptServiceRoutine()
{
	plasoc_int_service_interrupts(&int_obj);
}
/*	other function declarations	*/
static void vRandomWriteTask(void*);
static void vBlinkTask(void*);
static void vUserInput(void*);
static void input_gpio_isr(void*);

/*	static variable declarations	*/
static plasoc_int int_obj;
static plasoc_timer timer_obj;
static xgpio xgpio_input_obj;
static xgpio xgpio_output_obj;
static volatile unsigned input_value = 0;
static volatile unsigned led_state = 0;

short main( void )
{
	/* Configure the interrupt controller. */
	plasoc_int_setup(&int_obj,PLASOC_INT_BASE_ADDRESS);

	/* Configure output gpio. */
	xgpio_setup(&xgpio_output_obj,XGPIO_OUTPUT_BASE_ADDRESS);
	xgpio_set_direction(&xgpio_output_obj,XGPIO_OUTPUTS);

	/* Configure input gpio and interrupts */
	xgpio_setup(&xgpio_input_obj,XGPIO_INPUT_BASE_ADDRESS);
	xgpio_set_direction(&xgpio_input_obj,XGPIO_INPUTS);
	xgpio_enable_channel_interrupt(&xgpio_input_obj,1);
	plasoc_int_attach_isr(&int_obj,INT_XGPIO_INPUT_ID,input_gpio_isr,0);

	/* Configure the interrupts of the CPU. */
	OS_AsmInterruptEnable(1);

	/* Enable all interrupts in the interrupt controller. */
	plasoc_int_enable_all(&int_obj);

	/* Create the standard demo tasks. */
	vStartIntegerMathTasks( tskIDLE_PRIORITY );
	vStartRegTestTasks();

	/* Create the tasks defined within this file. */
	xTaskCreate( vUserInputTask, "Get Switches", configMINIMAL_STACK_SIZE, NULL, USER_INPUT_TASK_PRIORITY, NULL );
	xTaskCreate( vBlinkTask, "Blink Rate", configMINIMAL_STACK_SIZE, NULL, BLINK_TASK_PRIORITY, NULL );
	xTaskCreate( vRandomWriteTask, "Random Write", configMINIMAL_STACK_SIZE, NULL, RANDOM_TASK_PRIORITY, NULL );


	/* In this port, to use preemptive scheduler define configUSE_PREEMPTION
	as 1 in portmacro.h.  To use the cooperative scheduler define
	configUSE_PREEMPTION as 0. */
	vTaskStartScheduler();

	return 0;
}

static void vRandomWriteTask(void* pvParameters)
{
	static int32_t random_mem[256] = {0};

	while (1)
	{
		random_mem[rand()&255] = rand();
		vTaskDelay(RANDOM_WRITE_PERIOD);
	}
}

#define outputLED() \
	xgpio_set_data(&xgpio_output_obj, led_state ? input_value : 0);

static void vBlinkTask(void* pvParameters)
{
	while (1)
	{
		led_state = !led_state;
		outputLED();
		vTaskDelay(BLINK_HALF_PERIOD);
	}
}

/* Service the gpio input. */
static void input_gpio_isr(void* ptr)
{
	/* Acknowledge the interrupt, get the new data,
	 and let the main application know to update output. */
	xgpio_ack_channel_interrupt(&xgpio_input_obj,1);
	input_value = xgpio_get_data(&xgpio_input_obj);
	outputLED();
}
