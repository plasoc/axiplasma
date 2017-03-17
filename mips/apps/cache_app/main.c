#include <string.h>
#include "plasoc_cpu.h"
#include "plasoc_int.h"
#include "plasoc_timer.h"
#include "plasoc_gpio.h"
#include "plasoc_uart.h"
#define PLASOC_INT_BASE_ADDRESS			(0x44a00000)
#define PLASOC_GPIO_BASE_ADDRESS		(0x44a20000)
#define INT_PLASOC_GPIO_ID			(1)
#define DATA_SIZE				(16)
	
plasoc_int int_obj;
plasoc_gpio gpio_obj;

unsigned data[DATA_SIZE];
unsigned* noncacheable = (unsigned*)L1_CACHE_NONCACHEABLE_BASE_ADDRESS;

/* Define the CPU's service routine such that it calls the
 interrupt controller's service method. */
extern void OS_InterruptServiceRoutine()
{
	plasoc_int_service_interrupts(&int_obj);
}

/* Service the gpio input. */
void gpio_isr(void* ptr)
{
	plasoc_gpio_enable_int(&gpio_obj,1);
}

int main()
{
	/* Configure the interrupt controller. */
	plasoc_int_setup(&int_obj,PLASOC_INT_BASE_ADDRESS);

	/* Configure the gpio. */
	plasoc_gpio_setup(&gpio_obj,PLASOC_GPIO_BASE_ADDRESS);
	plasoc_int_attach_isr(&int_obj,INT_PLASOC_GPIO_ID,gpio_isr,0);
	plasoc_gpio_set_data_out(&gpio_obj,0x1);

	/* Configure the interrupts of the CPU. This is needed to patch the interrupt handler. */
	OS_AsmInterruptInit();
	OS_AsmInterruptEnable(1);
	
	/* Enable all interrupts in the interrupt controller. */
	plasoc_int_enable_all(&int_obj);
	plasoc_gpio_enable_int(&gpio_obj,0);

	/* Start running the application. */
	{
		int each_word;

		/* Store some arbitraty data directly into memory. This will force a read first from memory. */
		for (each_word=0; each_word<DATA_SIZE; each_word++)
			noncacheable[each_word] += each_word*2;

		/* Store some arbitrary data into cache. */
		for (each_word=0; each_word<DATA_SIZE; each_word++)
			data[each_word] = each_word*2;

		/* Signal location of application. */
		plasoc_gpio_set_data_out(&gpio_obj,0x2);		

		/* Flush cache. This should force the cache to write data back to main memory. */
		l1_cache_flush_range((unsigned)data,sizeof(data));

		/* Signal location of application. */
		plasoc_gpio_set_data_out(&gpio_obj,0x3);

		/* Invalidate cache. This should force the cache to invalidate the corresponding lines. */
		l1_cache_invalidate_range((unsigned)data,sizeof(data));

		/* Signal location of application. */
		plasoc_gpio_set_data_out(&gpio_obj,0x4);

		/* Clear array. This should force cache to read data from main memory. */
		memset((void*)data,0,sizeof(data));

		/* Signal location of application. */
		plasoc_gpio_set_data_out(&gpio_obj,0x5);

		/* Flush cache. This should force the zeroed cache to go into memory. */
		l1_cache_flush_range((unsigned)data,sizeof(data));

		/* Signal location of application. */
		plasoc_gpio_set_data_out(&gpio_obj,0x6);
	}

	while (1);

	return 0;
}

