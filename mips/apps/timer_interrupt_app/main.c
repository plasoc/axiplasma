#include "plasoc_cpu.h"
#include "plasoc_int.h"
#include "plasoc_timer.h"
#include "xgpio.h"
#define XGPIO_INPUT_BASE_ADDRESS		(0x40000000)
#define XGPIO_OUTPUT_BASE_ADDRESS		(0x40010000)
#define PLASOC_TIMER_BASE_ADDRESS		(0x44a10000)
//#define PLASOC_TIMER_HALF_SECOND_CYCLES	(25000000)
#define PLASOC_TIMER_HALF_SECOND_CYCLES	(512)
#define PLASOC_INT_BASE_ADDRESS			(0x44a00000)

#define INT_PLASOC_TIMER_ID				(0)
#define INT_XGPIO_INPUT_ID				(1)

plasoc_int int_obj;
plasoc_timer timer_obj;
xgpio xgpio_input_obj;
xgpio xgpio_output_obj;
volatile unsigned input_value;
volatile unsigned update_flag = 1;
volatile unsigned led_state = 0;

/* The following functions are defined in the boot loader assembly.
 They are necessary to initialize the interrupt of the CPU. */
extern void OS_AsmInterruptEnable(unsigned enable_flag);

/* Define the CPU's service routine such that it calls the
 interrupt controller's service method. */
extern void OS_InterruptServiceRoutine()
{
	plasoc_int_service_interrupts(&int_obj);
}

/* Service the timer. */
void timer_isr(void* ptr)
{
	/* Acknowledge timer and invert the state of the leds. */
	plasoc_timer_reload_start(&timer_obj,1);
	led_state = !led_state;
	update_flag = 1;
}

/* Service the gpio input. */
void input_gpio_isr(void* ptr)
{
	/* Acknowledge the interrupt, get the new data, 
	 and let the main application know to update output. */
	xgpio_ack_channel_interrupt(&xgpio_input_obj,1);
	input_value = xgpio_get_data(&xgpio_input_obj);
	update_flag = 1;
}

int main()
{
	/* Configure the interrupt controller. */
	plasoc_int_setup(&int_obj,PLASOC_INT_BASE_ADDRESS);

	/* Configure output gpio. */
	xgpio_setup(&xgpio_output_obj,XGPIO_OUTPUT_BASE_ADDRESS);
	xgpio_set_direction(&xgpio_output_obj,XGPIO_OUTPUTS);
	
	/* Configure input gpio. */
	xgpio_setup(&xgpio_input_obj,XGPIO_INPUT_BASE_ADDRESS);
	xgpio_set_direction(&xgpio_input_obj,XGPIO_INPUTS);
	xgpio_enable_global_interrupt(&xgpio_input_obj);
	xgpio_enable_channel_interrupt(&xgpio_input_obj,1);
	plasoc_int_attach_isr(&int_obj,INT_PLASOC_TIMER_ID,input_gpio_isr,0);

	/* Configure the timer. */
	plasoc_timer_setup(&timer_obj,PLASOC_TIMER_BASE_ADDRESS);
	plasoc_timer_set_trig_value(&timer_obj,PLASOC_TIMER_HALF_SECOND_CYCLES);
	plasoc_int_attach_isr(&int_obj,INT_XGPIO_INPUT_ID,timer_isr,0);

	/* Configure the interrupts of the CPU. */
	OS_AsmInterruptEnable(1);
	
	/* Enable all interrupts in the interrupt controller and start the timer in reload mode. */
	plasoc_int_enable_all(&int_obj);
	plasoc_timer_reload_start(&timer_obj,0);
	
	/* Run application's made loop. */
	while (1) 
	{
		/* In order to prevent constant access to on-chip interconnect, only update when new data is available. */
		if (update_flag)
		{
			/* In order to prevent race conditions, change state of flag in a critical section.
			 Set the output of the gpio. */
			plasoc_int_disable_all(&int_obj);
			update_flag = 0;
			xgpio_set_data(&xgpio_output_obj,input_value*led_state);
			plasoc_int_enable_all(&int_obj);
		}
	}

	return 0;
}


