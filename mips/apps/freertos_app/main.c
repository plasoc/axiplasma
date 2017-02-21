#include "FreeRTOS.h"
#include "task.h"
#include "plasoc_cpu.h"
#include "plasoc_int.h"
#include "plasoc_timer.h"
#include "plasoc_gpio.h"
#define PLASOC_INT_BASE_ADDRESS			(0x44a00000)
#define PLASOC_TIMER_BASE_ADDRESS		(0x44a10000)
#define PLASOC_GPIO_BASE_ADDRESS		(0x44a20000)
#define XILINX_CDMA_BASE_ADDRESS		(0x44a30000)
#define PLASOC_TIMER_MILLISECOND_CYCLES		(50000)

#define INT_PLASOC_TIMER_ID			(0)
#define INT_PLASOC_GPIO_ID			(1)
#define INT_XILINX_CDMA_ID			(2)

plasoc_int int_obj;
plasoc_timer timer_obj;
plasoc_gpio gpio_obj;
volatile unsigned input_value;
volatile unsigned update_flag = 1;
volatile unsigned led_state = 0;

void vAssertCalled(const char*, int);

void FreeRTOS_TickISR()
{
	xTaskIncrementTick();
	vTaskSwitchContext();
	plasoc_timer_reload_start(&timer_obj,1);
}

extern void FreeRTOS_UserISR()
{
	plasoc_int_service_interrupts(&int_obj);
}

void gpio_isr(void* ptr)
{
	input_value = plasoc_gpio_get_data_in(&gpio_obj);
	plasoc_gpio_enable_int(&gpio_obj,1);
}

void taskmain()
{
	/* Run application's main loop. */
	while (1) 
	{
		plasoc_gpio_set_data_out(&gpio_obj,input_value);
	}
}

int main()
{
	/* Configure the interrupt controller. */
	plasoc_int_setup(&int_obj,PLASOC_INT_BASE_ADDRESS);

	/* Configure the gpio. */
	plasoc_gpio_setup(&gpio_obj,PLASOC_GPIO_BASE_ADDRESS);
	plasoc_int_attach_isr(&int_obj,INT_PLASOC_GPIO_ID,gpio_isr,0);

	/* Configure the timer. */
	plasoc_timer_setup(&timer_obj,PLASOC_TIMER_BASE_ADDRESS);
	plasoc_timer_set_trig_value(&timer_obj,PLASOC_TIMER_MILLISECOND_CYCLES);
	plasoc_int_attach_isr(&int_obj,INT_PLASOC_TIMER_ID,FreeRTOS_TickISR,0);
	
	/* Enable all interrupts in the interrupt controller and start the timer in reload mode. */
	plasoc_int_enable_all(&int_obj);
	plasoc_timer_reload_start(&timer_obj,0);
	plasoc_gpio_enable_int(&gpio_obj,0);

	/* Create the tasks. */
	{
		BaseType_t xReturned = xTaskCreate(taskmain,"taskmain",configMINIMAL_STACK_SIZE,0,0,0);

		configASSERT( xReturned==pdPASS );
	}

	/* Start the scheduler. */
	vTaskStartScheduler();
	return 0;
}

void vAssertCalled(const char* str, int val)
{
	if (val==0)
	{
		plasoc_gpio_set_data_out(&gpio_obj,0xffff);
		while (1);
	}
}

