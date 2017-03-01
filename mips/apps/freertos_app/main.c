#include "FreeRTOS.h"
#include "task.h"
#include "semphr.h"
#include "queue.h"
#include "string.h"
#include "plasoc_cpu.h"
#include "plasoc_int.h"
#include "plasoc_timer.h"
#include "plasoc_gpio.h"
#include "xcdma.h"
#define PLASOC_INT_BASE_ADDRESS			(0x44a00000)
#define PLASOC_TIMER_BASE_ADDRESS		(0x44a10000)
#define PLASOC_GPIO_BASE_ADDRESS		(0x44a20000)
#define XILINX_CDMA_BASE_ADDRESS		(0x44a30000)

#define PLASOC_TIMER_MILLISECOND_CYCLES		(50000)
#define XILINX_CDMA_SOURCE_ADDRESS			(0x00008000)
#define XILINX_CDMA_DESTINATION_ADDRESS		(0x00009000)
#define XILINX_CDMA_BYTES_TO_TRANSFER		(64)

#define INT_PLASOC_TIMER_ID			(0)
#define INT_PLASOC_GPIO_ID			(1)
#define INT_XILINX_CDMA_ID			(2)

#define GPIO_AMOUNT				(16)
#define TICK_THRESHOLD				(2)
#define TIMER_THRESHOLD				(2)
#define QUEUE_AMOUNT				(8)
#define SEM_AMOUNT				(8)

plasoc_int int_obj;
plasoc_timer timer_obj;
plasoc_gpio gpio_obj;
xcdma xcdma_obj;
QueueHandle_t queue_input_obj;
SemaphoreHandle_t sem_time_obj;
TaskHandle_t task_input_obj;
TaskHandle_t task_copy_obj;
volatile unsigned ticks_ary[GPIO_AMOUNT];

/* This ISR is necessary to ensure FreeRTOS runs in preemptive mode with
  time slices. */
void FreeRTOS_TickISR()
{
	portYIELD_FROM_ISR(xTaskIncrementTick());
	plasoc_timer_reload_start(&timer_obj,1);
}

/* This ISR is necessary to check for interrupts and execute context switches with FreeRTOS. */
extern void FreeRTOS_UserISR() 
{ 
	/* Interrupts should be serviced before the kernel performs its services. */
	plasoc_int_service_interrupts(&int_obj); 

	/* The FreeRTOS_Yield flag is defined in portmacro. This flag is needed
	 to force context switches from system and interrupt calls. */
	if (FreeRTOS_Yield)
	{
		FreeRTOS_Yield = 0;
		vTaskSwitchContext();
	}
}

/* So, I think it's best not to let FreeRTOS have control over the CPU's interrupt
  due to the fact the ISR already has the job of enabling the CPU's int. */
extern void FreeRTOS_EnableInterrupts() { plasoc_int_enable_all(&int_obj); }
extern void FreeRTOS_DisableInterrupts() { plasoc_int_disable_all(&int_obj); }

extern void vAssertCalled(const char* str, int val)
{
	plasoc_gpio_set_data_out(&gpio_obj,(unsigned)val);
	while (1);
}

void gpio_isr(void* ptr)
{
	BaseType_t xHigherPriorityTaskWoken = pdFALSE;
	plasoc_gpio_enable_int(&gpio_obj,1);
	vTaskNotifyGiveFromISR(task_input_obj,&xHigherPriorityTaskWoken);
	portYIELD_FROM_ISR(xHigherPriorityTaskWoken);
}

void xcdma_isr(void* ptr)
{
	BaseType_t xHigherPriorityTaskWoken = pdFALSE;
	xcdma_load_status(&xcdma_obj);
	xcdma_acknowledge_status_error(&xcdma_obj);
	xcdma_acknowledge_status_completion(&xcdma_obj);
	vTaskNotifyGiveFromISR(task_copy_obj,&xHigherPriorityTaskWoken);
	portYIELD_FROM_ISR(xHigherPriorityTaskWoken);
}

void task_input_code(void* ptr)
{
	unsigned input_value;
	while (1)
	{
		input_value = plasoc_gpio_get_data_in(&gpio_obj);
		xQueueSend(queue_input_obj,&input_value,portMAX_DELAY);
		ulTaskNotifyTake(pdTRUE,portMAX_DELAY);		
	}
}

void task_time_code(void* ptr)
{
	TickType_t xLastWakeTime;
	xLastWakeTime = xTaskGetTickCount();
	while (1)
	{
		vTaskDelayUntil(&xLastWakeTime,TIMER_THRESHOLD);
		xSemaphoreGive(sem_time_obj);
	}
}

void task_copy_code(void* ptr)
{
	{
		unsigned char each_byte;
		for (each_byte=0;each_byte<XILINX_CDMA_BYTES_TO_TRANSFER;++each_byte)
			*(((volatile unsigned char*)XILINX_CDMA_SOURCE_ADDRESS)+each_byte) = each_byte;
	}
	while (1)
	{
		xcdma_start_transfer(&xcdma_obj,XILINX_CDMA_SOURCE_ADDRESS,XILINX_CDMA_DESTINATION_ADDRESS,XILINX_CDMA_BYTES_TO_TRANSFER);
		ulTaskNotifyTake(pdTRUE,portMAX_DELAY);	
		configASSERT(xcdma_check_status_decode(&xcdma_obj)==0);
		configASSERT(xcdma_check_status_slave(&xcdma_obj)==0);
		configASSERT(xcdma_check_status_idle(&xcdma_obj)!=0);
	}
}

void task_main_code()
{
	unsigned cur_value=0;
	unsigned led_value=0;
	while (1)
	{
		unsigned new_value;
		if (xQueueReceive(queue_input_obj,&new_value,0)==pdTRUE)
		{
			unsigned each_sw;
			for (each_sw=0;each_sw<GPIO_AMOUNT;each_sw++)
				if ((~new_value)&(1<<each_sw))
					ticks_ary[each_sw] = 0;
			cur_value = new_value;
		}
		if (xSemaphoreTake(sem_time_obj,0)==pdTRUE)
		{
			unsigned each_led;
			for (each_led=0;each_led<GPIO_AMOUNT;each_led++)
			{
				unsigned led_mask = (1<<each_led);
				if (cur_value&led_mask)
				{
					if (ticks_ary[each_led]==(TICK_THRESHOLD-1))
					{
						ticks_ary[each_led] = 0;
						if (led_value&led_mask)
						{
							led_value &= ~led_mask;
						}
						else
						{
							led_value |= led_mask;
						}
						
					}
					else
					{
						ticks_ary[each_led]++;
					}
				}
				else
				{
					led_value &= ~led_mask;
				}
			}
			plasoc_gpio_set_data_out(&gpio_obj,led_value);
		}
	}
}



int main()
{
	/* Probably not necessary, but let's ensure the CPU interrupt is diasabled. */
	OS_AsmInterruptEnable(0);

	/* Configure the interrupt controller. */
	plasoc_int_setup(&int_obj,PLASOC_INT_BASE_ADDRESS);

	/* Configure the gpio. */
	plasoc_gpio_setup(&gpio_obj,PLASOC_GPIO_BASE_ADDRESS);
	plasoc_int_attach_isr(&int_obj,INT_PLASOC_GPIO_ID,gpio_isr,0);

	/* Configure the timer. */
	plasoc_timer_setup(&timer_obj,PLASOC_TIMER_BASE_ADDRESS);
	plasoc_timer_set_trig_value(&timer_obj,PLASOC_TIMER_MILLISECOND_CYCLES);
	plasoc_int_attach_isr(&int_obj,INT_PLASOC_TIMER_ID,FreeRTOS_TickISR,0);
	
	/* Configure the cdma. */
	xcdma_setup(&xcdma_obj,XILINX_CDMA_BASE_ADDRESS);
	xcdma_reset(&xcdma_obj);
	plasoc_int_attach_isr(&int_obj,INT_XILINX_CDMA_ID,xcdma_isr,0);
	
	/* Clear timer values. */
	memset((void*)ticks_ary,0,sizeof(ticks_ary));

	/* Create FreeRTOS objects tasks. */
	{
		BaseType_t xReturned;
		queue_input_obj = xQueueCreate(QUEUE_AMOUNT,sizeof(unsigned));
		configASSERT(queue_input_obj!=0);
		sem_time_obj = xSemaphoreCreateCounting(SEM_AMOUNT,0);
		configASSERT(sem_time_obj!=0);
		xReturned = xTaskCreate(task_main_code,"main",configMINIMAL_STACK_SIZE,0,3,0);
		configASSERT(xReturned==pdPASS);
		xReturned = xTaskCreate(task_input_code,"input",configMINIMAL_STACK_SIZE,0,5,&task_input_obj);
		configASSERT(xReturned==pdPASS);
		xReturned = xTaskCreate(task_time_code,"time",configMINIMAL_STACK_SIZE,0,5,0);
		configASSERT(xReturned==pdPASS);
		xReturned = xTaskCreate(task_copy_code,"copy",configMINIMAL_STACK_SIZE,0,3,&task_copy_obj);
		configASSERT(xReturned==pdPASS);
	}

	/* Enable all interrupts in the interrupt controller and start the timer in reload mode. */
	plasoc_timer_reload_start(&timer_obj,0);
	plasoc_gpio_enable_int(&gpio_obj,0);
	xcdma_enable_ints(&xcdma_obj,1,1);

	/* Let the test bench know it's about to go down! */
	plasoc_gpio_set_data_out(&gpio_obj,0x1);

	/* Start the scheduler. */
	vTaskStartScheduler();

	/* This point should never be reached. */
	configASSERT(0);
	return 0;
}


