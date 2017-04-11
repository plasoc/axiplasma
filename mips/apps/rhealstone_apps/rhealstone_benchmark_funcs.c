
#include "FreeRTOS.h"
#include "task.h"
#include "plasoc_cpu.h"
#include "plasoc_int.h"
#include "plasoc_timer.h"
#include "plasoc_gpio.h"
#include "plasoc_uart.h"
#include "printf.h"
#include "rhealstone_benchmark_funcs.h"
#include <inttypes.h>

/* Hardware specific defines. */
#define PLASOC_INT_BASE_ADDRESS				(0x44a00000)
#define PLASOC_TIMER_BASE_ADDRESS			(0x44a10000)
#define PLASOC_GPIO_BASE_ADDRESS			(0x44a20000)
#define XILINX_CDMA_BASE_ADDRESS			(0x44a30000)
#define PLASOC_UART_BASE_ADDRESS			(0x44a40000)
#define PLASOC_TIMER_EXTRA_0_BASE_ADDR		(0x44a50000)
#define INT_PLASOC_TIMER_ID					(0)
#define INT_PLASOC_GPIO_ID					(1)
#define INT_PLASOC_UART_ID					(3)
#define INT_PLASOC_TIMER_EXTRA_0_ID			(4)
#define PLASOC_TIMER_MICROSECOND_CYCLES		(PLASMA_HZ/1000000)
#define PLASOC_TIMER_MILLISECOND_CYCLES		(PLASOC_TIMER_MICROSECOND_CYCLES*1000)

/* Define Plasma-SoC objects. */
static plasoc_int int_obj;
static plasoc_timer timer_obj;
static plasoc_gpio gpio_obj;
static plasoc_uart uart_obj;
static plasoc_timer usec_timer;

/* This ISR is necessary to ensure FreeRTOS runs in preemptive mode with
  time slices. */
extern void FreeRTOS_TickISR()
{
	portYIELD_FROM_ISR(xTaskIncrementTick());
	plasoc_timer_reload_start(&timer_obj,1);
}

/* This ISR is necessary to check for interrupts and execute context switches with FreeRTOS. */
extern void FreeRTOS_UserISR() 
{ 
	/* Interrupts should be serviced before the kernel performs its services */
	plasoc_int_service_interrupts(&int_obj); 
	
	/* The FreeRTOS_Yield flag is defined in portmacro. This flag is needed
	 to force context switches from system and interrupt calls. */
	if (FreeRTOS_Yield)
	{
		FreeRTOS_Yield = 0;
		vTaskSwitchContext();
	}
}

/* Errors should set all LEDs to high. */
extern void vAssertCalled(const char* str, int val)
{
	plasoc_gpio_set_data_out(&gpio_obj,0xffff);
	while (1)
		printf("Assert:\n\rMessage:%s\n\rLine:%d\n\r",str,val);
}

/* Define the port's interface to toggling the external interrupts. */
extern void FreeRTOS_EnableInterrupts() { plasoc_int_enable_all(&int_obj); }
extern void FreeRTOS_DisableInterrupts() { plasoc_int_disable_all(&int_obj); }

static void uart_isr(void* ptr)
{
	(void)plasoc_uart_get_in(&uart_obj);
	printf("Alive...\n\r");
}

/* Needed for the portable printf function. */
extern void putc_port( void* p, char c)
{
	while (plasoc_uart_get_status_out_avail(&uart_obj)==0);
	plasoc_uart_set_out(&uart_obj,(unsigned)c);
}

static void timeout_isr(void* ptr)
{
	while(1)
		printf("TIMEOUT");
}

void setup_hardware()
{
	/* Probably not necessary, but let's ensure the CPU interrupt is diasabled. */
	OS_AsmInterruptEnable(0);
	
	/* Configure the interrupt controller. */
	plasoc_int_setup(&int_obj,PLASOC_INT_BASE_ADDRESS);
	
	/* Configure the gpio. */
	plasoc_gpio_setup(&gpio_obj,PLASOC_GPIO_BASE_ADDRESS);
	
	/* Configure the timer. */
	plasoc_timer_setup(&timer_obj,PLASOC_TIMER_BASE_ADDRESS);
	plasoc_timer_set_trig_value(&timer_obj,PLASOC_TIMER_MILLISECOND_CYCLES);
	plasoc_int_attach_isr(&int_obj,INT_PLASOC_TIMER_ID,FreeRTOS_TickISR,0);
	
	/* Configure the uart. */
	plasoc_uart_setup(&uart_obj,PLASOC_UART_BASE_ADDRESS);
	plasoc_int_attach_isr(&int_obj,INT_PLASOC_UART_ID,uart_isr,0);
	init_printf(0,putc_port);

	/* Configure the usec timer */
	plasoc_timer_setup(&usec_timer, PLASOC_TIMER_EXTRA_0_BASE_ADDR);
	plasoc_timer_set_trig_value(&usec_timer, (uint32_t)~0);
	plasoc_int_attach_isr(&int_obj,INT_PLASOC_TIMER_EXTRA_0_ID,timeout_isr,0);
	
	/* Start time in reload mode. */
	plasoc_timer_reload_start(&timer_obj,0);
	
	/* Signal that the scheduler is about to start. */
	plasoc_gpio_set_data_out(&gpio_obj,0x1);
}

void stop_benchmark_timer()
{
	plasoc_timer_stop(&usec_timer);
}

usec_t get_benchmark_time()
{
	return (usec_t)(plasoc_timer_get_tick_value(&usec_timer)/PLASOC_TIMER_MICROSECOND_CYCLES);
}

void start_benchmark_timer()
{
	plasoc_timer_reload_start(&usec_timer, 0);
}

