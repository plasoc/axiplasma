#include "port_layer.h"
#define PLASOC_INT_BASE_ADDRESS			(0x44a00000)
#define PLASOC_UART_BASE_ADDRESS		(0x44a40000)
#define INT_PLASOC_UART_ID				(3)
#define PLASOC_UART_FIFO_DEPTH			(512)

plasoc_int int_obj;
plasoc_uart uart_obj;

volatile unsigned char uart_fifo[PLASOC_UART_FIFO_DEPTH];
volatile unsigned uart_in_ptr = 0;
volatile unsigned uart_out_ptr = 0;

/* Define the CPU's service routine such that it calls the
 interrupt controller's service method. */
extern void OS_InterruptServiceRoutine()
{
	plasoc_int_service_interrupts(&int_obj);
}

/* Service the uart input. */
void uart_isr(void* ptr)
{
	unsigned byte;
	unsigned next_uart_in_ptr;
	
	byte = plasoc_uart_get_in(&uart_obj);
	next_uart_in_ptr = (uart_in_ptr+1)%PLASOC_UART_FIFO_DEPTH;
	if (next_uart_in_ptr!=uart_out_ptr)
	{
		uart_fifo[uart_in_ptr] = (unsigned char)byte;
		uart_in_ptr = next_uart_in_ptr;
	}
}

void initialize(void (*run)(void))
{
	plasoc_int_setup(&int_obj,PLASOC_INT_BASE_ADDRESS);

	plasoc_uart_setup(&uart_obj,PLASOC_UART_BASE_ADDRESS);
	plasoc_int_attach_isr(&int_obj,INT_PLASOC_UART_ID,uart_isr,0);
	plasoc_int_enable(&int_obj,INT_PLASOC_UART_ID);
	
	OS_AsmInterruptEnable(1);
	
	if (run!=0) run();
}

void setbyte(unsigned byte)
{
	while (!plasoc_uart_get_status_out_avail(&uart_obj));
	plasoc_uart_set_out(&uart_obj,byte);
}

unsigned getbyte()
{
	unsigned byte;

	while (1)
	{
		OS_AsmInterruptEnable(0);
		if (uart_in_ptr!=uart_out_ptr)
		{
			byte = (unsigned)uart_fifo[uart_out_ptr];
			uart_out_ptr = (uart_out_ptr+1)%PLASOC_UART_FIFO_DEPTH;
			OS_AsmInterruptEnable(1);
			break;
		}
		OS_AsmInterruptEnable(1);
	}
	
	return byte;
}

void setword(unsigned word)
{
	unsigned each_byte;
	for (each_byte=0;each_byte<4;each_byte++)
	{
		setbyte(word&0xff);
		word >>= 8;
	}	
}

unsigned getword()
{
	unsigned each_byte;
	unsigned word = 0;
	for (each_byte=0;each_byte<sizeof(unsigned);each_byte++)
		word = word|(getbyte()<<(each_byte*8));
	return word;
}
