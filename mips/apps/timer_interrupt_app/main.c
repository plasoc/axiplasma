#include "plasoc_cpu.h"
#include "plasoc_int.h"
#include "plasoc_timer.h"
#include "plasoc_gpio.h"
#define PLASOC_INT_BASE_ADDRESS			(0x44a00000)
#define PLASOC_TIMER_BASE_ADDRESS		(0x44a10000)
#define PLASOC_GPIO_BASE_ADDRESS		(0x44a20000)
#define XILINX_CDMA_BASE_ADDRESS		(0x44a30000)

#define PLASOC_TIMER_HALF_SECOND_CYCLES		(25000000)

#define INT_PLASOC_TIMER_ID			(0)
#define INT_PLASOC_GPIO_ID			(1)
#define INT_XILINX_CDMA_ID			(2)

plasoc_int int_obj;
plasoc_timer timer_obj;
plasoc_gpio gpio_obj;
volatile unsigned input_value;
volatile unsigned update_flag = 1;
volatile unsigned led_state = 0;

/* Define the CPU's service routine such that it calls the
 interrupt controller's service method. */
extern void OS_InterruptServiceRoutine()
{
	plasoc_int_service_interrupts(&int_obj);
}

/* Service the timer. */
void timer_isr(void* ptr)
{
	led_state = !led_state;
	update_flag = 1;
	plasoc_timer_reload_start(&timer_obj,1);
}

/* Service the gpio input. */
void gpio_isr(void* ptr)
{
	input_value = plasoc_gpio_get_data_in(&gpio_obj);
	led_state = 1; /* Setting the led state is not really a good idea if GPIO interrupt occurs simultaneously with timer's. */
	update_flag = 1;
	plasoc_gpio_enable_int(&gpio_obj,1);
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
	plasoc_timer_set_trig_value(&timer_obj,PLASOC_TIMER_HALF_SECOND_CYCLES);
	plasoc_int_attach_isr(&int_obj,INT_PLASOC_TIMER_ID,timer_isr,0);

	/* Configure the interrupts of the CPU. This is needed to patch the interrupt handler. */
	OS_AsmInterruptInit();
	OS_AsmInterruptEnable(1);
	
	/* Enable all interrupts in the interrupt controller and start the timer in reload mode. */
	plasoc_int_enable_all(&int_obj);
	plasoc_timer_reload_start(&timer_obj,0);
	plasoc_gpio_enable_int(&gpio_obj,0);

	/* Run application's main loop. */
	while (1) 
	{
		/* In order to prevent constant access to on-chip interconnect, only update when new data is available. */
		if (update_flag)
		{
			/* In order to prevent race conditions, change state of flag in a critical section.
			 Set the output of the gpio. */
			plasoc_int_disable_all(&int_obj);
			update_flag = 0;
			plasoc_gpio_set_data_out(&gpio_obj,input_value*led_state);
			plasoc_int_enable_all(&int_obj);
		}
	}

	return 0;
}


