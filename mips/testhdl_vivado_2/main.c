#include "plasmasoc.h"
#include "xgpio.h"
#include "plasoc_int.h"
#define XGPIO_INPUT_0_BASE_ADDRESS		(0x40000000)
#define XGPIO_INPUT_1_BASE_ADDRESS		(0x40020000)
#define XGPIO_OUTPUT_BASE_ADDRESS		(0x40010000)
#define PLASOC_INT_BASE_ADDRESS			(0x44a00000)

#define XGPIO_INPUT_TOTAL				(2)
#define XGPIO_SWITCHES_PER_INPUT		(8)

plasoc_int int_obj;
xgpio xgpio_input_obj[2];
xgpio xgpio_output_obj;
volatile unsigned input_values[2];
volatile unsigned update_flag = 1;

/* The following functions are defined in the boot loader assembly.
 They are necessary to initialize the interrupt of the CPU. */
extern void OS_AsmInterruptInitModified();
extern void OS_AsmInterruptEnable();

/* Define the CPU's service routine such that it calls the
 interrupt controller's service method. */
extern void OS_InterruptServiceRoutine()
{
	plasoc_int_service_interrupts(&int_obj);
}

/* Service the interrupt. */
void input_gpio_isr(void* ptr)
{
	unsigned id;
	xgpio* xgpio_ptr;

	id = (unsigned)ptr;
	xgpio_ptr = xgpio_input_obj+id;

	/* Acknowledge the interrupt, get the new data, 
	 and let the main application know to update output. */
	xgpio_ack_channel_interrupt(xgpio_ptr,1);
	input_values[id] = xgpio_get_data(xgpio_ptr);
	update_flag = 1;
}

int main()
{
	/* Configure the interrupt controller. */
	plasoc_int_setup(&int_obj,PLASOC_INT_BASE_ADDRESS);

	/* Configure gpios with base addresses. */
	xgpio_setup(xgpio_input_obj+0,XGPIO_INPUT_0_BASE_ADDRESS);
	xgpio_setup(xgpio_input_obj+1,XGPIO_INPUT_1_BASE_ADDRESS);
	xgpio_setup(&xgpio_output_obj,XGPIO_OUTPUT_BASE_ADDRESS);

	/* Configure the direction of the output gpio. */
	xgpio_set_direction(&xgpio_output_obj,XGPIO_OUTPUTS);

	/* Perform configurations on the input gpios. These configurations
	 include setting direction and configuring the interrupts. */
	{
		unsigned each_gpio;
		for (each_gpio=0;each_gpio<XGPIO_INPUT_TOTAL;each_gpio++)
		{
			/* Perform configurations. */
			xgpio* ptr = xgpio_input_obj+each_gpio;
			xgpio_set_direction(ptr,XGPIO_INPUTS);
			xgpio_enable_global_interrupt(ptr);
			xgpio_enable_channel_interrupt(ptr,1);
			plasoc_int_attach_isr(&int_obj,each_gpio,input_gpio_isr,(void*)each_gpio);

			/* Initialize the input values.*/
			input_values[each_gpio] = xgpio_get_data(ptr);
		}
	}
	
	/* Configure the interrupts of the CPU. */
	//OS_AsmInterruptInitModified();
	OS_AsmInterruptEnable();

	/* Enable all interrupts in the interrupt controller. */
	plasoc_int_enable_all(&int_obj);
	
	/* Run application's made loop/ */
	while (1) 
	{
		/* In order to prevent constant access to on-chip interconnect, only update when new data is available. */
		if (update_flag)
		{
			/* In order to prevent race conditions, change state of flag in a critical section. */
			plasoc_int_disable_all(&int_obj);
			update_flag = 0;
			plasoc_int_enable_all(&int_obj);

			/* Set the output data. */
			xgpio_set_data(&xgpio_output_obj,(input_values[1]<<XGPIO_SWITCHES_PER_INPUT)|input_values[0]);
		}
	}

	return 0;
}


