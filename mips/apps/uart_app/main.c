#include <printf.h>
#include "plasoc_cpu.h"
#include "plasoc_int.h"
#include "plasoc_timer.h"
#include "plasoc_gpio.h"
#include "plasoc_uart.h"
#define PLASOC_INT_BASE_ADDRESS			(0x44a00000)
#define PLASOC_TIMER_BASE_ADDRESS		(0x44a10000)
#define PLASOC_GPIO_BASE_ADDRESS		(0x44a20000)
#define XILINX_CDMA_BASE_ADDRESS		(0x44a30000)
#define PLASOC_UART_BASE_ADDRESS		(0x44a40000)

#define PLASOC_TIMER_HALF_SECOND_CYCLES		(25000000)

#define INT_PLASOC_TIMER_ID			(0)
#define INT_PLASOC_GPIO_ID			(1)
#define INT_XILINX_CDMA_ID			(2)
#define INT_PLASOC_UART_ID			(3)

plasoc_int int_obj;
plasoc_gpio gpio_obj;
plasoc_uart uart_obj;

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

/* Service the uart input. */
void uart_isr(void* ptr)
{
	unsigned data;
	data = plasoc_uart_get_in(&uart_obj);
	printf("The letter typed was: %c\n\r",(char)data);	
}

void putc_port( void* p, char c)
{
	while (!plasoc_uart_get_status_out_avail(&uart_obj));
	plasoc_uart_set_out(&uart_obj,(unsigned)c);
}


int main()
{
	/* Configure the interrupt controller. */
	plasoc_int_setup(&int_obj,PLASOC_INT_BASE_ADDRESS);

	/* Configure the gpio. */
	plasoc_gpio_setup(&gpio_obj,PLASOC_GPIO_BASE_ADDRESS);
	plasoc_int_attach_isr(&int_obj,INT_PLASOC_GPIO_ID,gpio_isr,0);

	/* Configure uart. */
	plasoc_uart_setup(&uart_obj,PLASOC_UART_BASE_ADDRESS);
	init_printf(0,putc_port);
	plasoc_int_attach_isr(&int_obj,INT_PLASOC_UART_ID,uart_isr,0);

	/* Configure the interrupts of the CPU. */
	OS_AsmInterruptInit();
	OS_AsmInterruptEnable(1);
	
	/* Enable all interrupts in the interrupt controller and start the timer in reload mode. */
	plasoc_int_enable_all(&int_obj);
	plasoc_gpio_enable_int(&gpio_obj,0);

	/* Run application's main loop. */
	plasoc_gpio_set_data_out(&gpio_obj,0x1);

	
	while (0);

	return 0;
}

