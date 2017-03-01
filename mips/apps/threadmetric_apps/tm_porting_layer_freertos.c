/**************************************************************************/ 
/*                                                                        */ 
/*            Copyright (c) 1996-2016 by Express Logic Inc.               */ 
/*                                                                        */ 
/*  This Original Work may be modified, distributed, or otherwise used in */ 
/*  any manner with no obligations other than the following:              */ 
/*                                                                        */ 
/*    1. This legend must be retained in its entirety in any source code  */ 
/*       copies of this Work.                                             */ 
/*                                                                        */ 
/*    2. This software may not be used in the development of an operating */
/*       system product.                                                  */ 
/*                                                                        */  
/*  This Original Work is hereby provided on an "AS IS" BASIS and WITHOUT */ 
/*  WARRANTY, either express or implied, including, without limitation,   */ 
/*  the warranties of NON-INFRINGEMENT, MERCHANTABILITY or FITNESS FOR A  */ 
/*  PARTICULAR PURPOSE. THE ENTIRE RISK AS TO THE QUALITY OF this         */ 
/*  ORIGINAL WORK IS WITH the user.                                       */ 
/*                                                                        */ 
/*  Express Logic, Inc. reserves the right to modify this software        */ 
/*  without notice.                                                       */ 
/*                                                                        */ 
/*  Express Logic, Inc.                     info@expresslogic.com         */
/*  11423 West Bernardo Court               http://www.expresslogic.com   */
/*  San Diego, CA  92127                                                  */
/*                                                                        */
/**************************************************************************/

/**************************************************************************/
/**************************************************************************/
/**                                                                       */ 
/** Thread-Metric Component                                               */
/**                                                                       */
/**   Porting Layer (Must be completed with RTOS specifics)               */
/**                                                                       */
/**************************************************************************/
/**************************************************************************/


/* Include FreeRTOS headers.  */
#include "FreeRTOS.h"
#include "task.h"
#include "semphr.h"
#include "queue.h"

/* Include ThreadMetric header. */
#include "tm_api.h"

/* Include Plasma-SoC headers. */
#include "plasoc_cpu.h"
#include "plasoc_int.h"
#include "plasoc_timer.h"
#include "plasoc_gpio.h"

/* Define FreeRTOS mapping constants.  */
#define TM_FREERTOS_MAX_THREADS          	(10)
#define TM_FREERTOS_MAX_QUEUES           	(1)
#define TM_FREERTOS_MAX_SEMAPHORES       	(1)
#define TM_FREERTOS_MAX_MEMORY_POOLS     	(1)

#define TM_FREERTOS_THREAD_STACK_SIZE    	(512)
#define TM_FREERTOS_QUEUE_SIZE           	(200)
#define TM_FREERTOS_QUEUE_BYTES_PER_ITEM	(16)
#define TM_FREERTOS_TICKS_PER_SECOND    	(100)
#define TM_FREERTOS_MEMORY_POOL_SIZE		(128)

#define TM_MAX_PRIORITY						(31)

/* Hardware specific defines. */
#define PLASOC_INT_BASE_ADDRESS				(0x44a00000)
#define PLASOC_TIMER_BASE_ADDRESS			(0x44a10000)
#define PLASOC_GPIO_BASE_ADDRESS			(0x44a20000)
#define PLASOC_TIMER_MILLISECOND_CYCLES		(50000)
#define INT_PLASOC_TIMER_ID					(0)
#define INT_PLASOC_GPIO_ID					(1)

/* Define ThreadMetric FreeRTOS data structures. */
TaskHandle_t tm_thread_array[TM_FREERTOS_MAX_THREADS];
QueueHandle_t tm_queue_array[TM_FREERTOS_MAX_QUEUES];
SemaphoreHandle_t tm_semaphore_array[TM_FREERTOS_MAX_SEMAPHORES];
void* tm_block_pool_array[TM_FREERTOS_MAX_MEMORY_POOLS];

/* This flag is necessary in order to indicate to 
  to benchmark port functions when inside an interrupt. */
volatile unsigned FreeRTOS_InsideInt = 0;

/* Define Plasma-SoC objects. */
plasoc_int int_obj;
plasoc_timer timer_obj;
plasoc_gpio gpio_obj;

 __attribute__ ((weak))
void  tm_interrupt_preemption_handler(void)
{
	/* This function can be overloaded by threadmetric. */
}

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
	/* Interrupts should be serviced before the kernel performs its services. The FreeRTOS_InsideInt
	  flag is necessary to tell the threadmetric port functions when they're being called from 
	  within a ISR. The tm_interrupt_preemption_handler is the software interrupt handler needed for
	  threadmetric. */
	FreeRTOS_InsideInt = 1;
	plasoc_int_service_interrupts(&int_obj); 
	tm_interrupt_preemption_handler();
	FreeRTOS_InsideInt = 0;
	
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
	while (1);
}

/* Define the port's interface to toggling the external interrupts. */
extern void FreeRTOS_EnableInterrupts() { plasoc_int_enable_all(&int_obj); }
extern void FreeRTOS_DisableInterrupts() { plasoc_int_disable_all(&int_obj); }


/* This function called from main performs basic RTOS initialization, 
   calls the test initialization function, and then starts the RTOS function.  */
void  tm_initialize(void (*test_initialization_function)(void))
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
	
	/* Configure ThreadMetric application. */
	test_initialization_function();

	/* Start time in reload mode. */
	plasoc_timer_reload_start(&timer_obj,0);
	
	/* Signal that the scheduler is about to start. */
	plasoc_gpio_set_data_out(&gpio_obj,0x1);
	
	/* Start the scheduler. */
	vTaskStartScheduler();

	/* This point should never be reached. */
	configASSERT(0);
}


/* This function takes a thread ID and priority and attempts to create the
   file in the underlying RTOS.  Valid priorities range from 1 through 31, 
   where 1 is the highest priority and 31 is the lowest. If successful, 
   the function should return TM_SUCCESS. Otherwise, TM_ERROR should be returned.   */
int  tm_thread_create(int thread_id, int priority, void (*entry_function)(void))
{
	typedef void (FreeRTOSCodeType)(void*);
	BaseType_t xReturned; 
	UBaseType_t xFreeRTOSPriority = (TM_MAX_PRIORITY-priority)*configMAX_PRIORITIES/(TM_MAX_PRIORITY-1);
	xReturned = xTaskCreate((FreeRTOSCodeType*)entry_function,NULL,TM_FREERTOS_THREAD_STACK_SIZE,NULL,xFreeRTOSPriority,tm_thread_array+thread_id);
	return (xReturned==pdPASS)?TM_SUCCESS:TM_ERROR;
}


/* This function resumes the specified thread.  If successful, the function should
   return TM_SUCCESS. Otherwise, TM_ERROR should be returned.  */
int  tm_thread_resume(int thread_id)
{
	if (FreeRTOS_InsideInt)
	{
		BaseType_t xHigherPriorityTaskWoken = pdFALSE;
		xHigherPriorityTaskWoken = xTaskResumeFromISR(tm_thread_array[thread_id]);
		portYIELD_FROM_ISR(xHigherPriorityTaskWoken);
	}
	else
	{
		vTaskResume(tm_thread_array[thread_id]);
	}
	return TM_SUCCESS;
}


/* This function suspends the specified thread.  If successful, the function should
   return TM_SUCCESS. Otherwise, TM_ERROR should be returned.  */
int  tm_thread_suspend(int thread_id)
{
	vTaskSuspend(tm_thread_array[thread_id]);
	return TM_SUCCESS;
}


/* This function relinquishes to other ready threads at the same
   priority.  */
void tm_thread_relinquish(void)
{
	taskYIELD();
}


/* This function suspends the specified thread for the specified number
   of seconds.  If successful, the function should return TM_SUCCESS. 
   Otherwise, TM_ERROR should be returned.  */
void tm_thread_sleep(int seconds)
{
	const TickType_t xDelay = 1000*seconds/portTICK_PERIOD_MS;
	vTaskDelay(xDelay);
}


/* This function creates the specified queue.  If successful, the function should
   return TM_SUCCESS. Otherwise, TM_ERROR should be returned.  */
int  tm_queue_create(int queue_id)
{
	QueueHandle_t queue_hdl;
	queue_hdl = xQueueCreate(TM_FREERTOS_MAX_QUEUES,TM_FREERTOS_QUEUE_BYTES_PER_ITEM);
	tm_queue_array[queue_id] = queue_hdl;
	return (queue_hdl!=NULL)?TM_SUCCESS:TM_ERROR;
}


/* This function sends a 16-byte message to the specified queue.  If successful, 
   the function should return TM_SUCCESS. Otherwise, TM_ERROR should be returned.  */
int  tm_queue_send(int queue_id, unsigned long *message_ptr)
{
	BaseType_t xReturned;
	if (FreeRTOS_InsideInt)
	{
		BaseType_t xHigherPriorityTaskWoken = pdFALSE;
		xReturned = xQueueSendFromISR(tm_queue_array[queue_id],message_ptr,&xHigherPriorityTaskWoken);
		portYIELD_FROM_ISR(xHigherPriorityTaskWoken);
	}
	else
	{
		xReturned = xQueueSend(tm_queue_array[queue_id],message_ptr,portMAX_DELAY);
	}
	return (xReturned==pdTRUE)?TM_SUCCESS:TM_ERROR;
}


/* This function receives a 16-byte message from the specified queue.  If successful, 
   the function should return TM_SUCCESS. Otherwise, TM_ERROR should be returned.  */
int  tm_queue_receive(int queue_id, unsigned long *message_ptr)
{
	BaseType_t xReturned;
	if (FreeRTOS_InsideInt)
	{
		BaseType_t xHigherPriorityTaskWoken = pdFALSE;
		xReturned = xQueueReceiveFromISR(tm_queue_array[queue_id],message_ptr,&xHigherPriorityTaskWoken);
		portYIELD_FROM_ISR(xHigherPriorityTaskWoken);
	}
	else
	{
		xReturned = xQueueReceive(tm_queue_array[queue_id],message_ptr,portMAX_DELAY);
	}
	return (xReturned==pdTRUE)?TM_SUCCESS:TM_ERROR;
}


/* This function creates the specified semaphore.  If successful, the function should
   return TM_SUCCESS. Otherwise, TM_ERROR should be returned.  */
int  tm_semaphore_create(int semaphore_id)
{
	SemaphoreHandle_t semphr_hdl;
	semphr_hdl = xSemaphoreCreateCounting(1,1);
	tm_semaphore_array[semaphore_id] = semphr_hdl;
	return (semphr_hdl!=NULL)?TM_SUCCESS:TM_ERROR;
}


/* This function gets the specified semaphore.  If successful, the function should
   return TM_SUCCESS. Otherwise, TM_ERROR should be returned.  */
int  tm_semaphore_get(int semaphore_id)
{
	BaseType_t xReturned;
	if (FreeRTOS_InsideInt)
	{
		BaseType_t xHigherPriorityTaskWoken = pdFALSE;
		xReturned = xSemaphoreTakeFromISR(tm_semaphore_array[semaphore_id],&xHigherPriorityTaskWoken);
		portYIELD_FROM_ISR(xHigherPriorityTaskWoken);
	}
	else
	{
		xReturned = xSemaphoreTake(tm_semaphore_array[semaphore_id],portMAX_DELAY);
	}
	return (xReturned==pdTRUE)?TM_SUCCESS:TM_ERROR;
}


/* This function puts the specified semaphore.  If successful, the function should
   return TM_SUCCESS. Otherwise, TM_ERROR should be returned.  */
int  tm_semaphore_put(int semaphore_id)
{
	BaseType_t xReturned;
	if (FreeRTOS_InsideInt)
	{
		BaseType_t xHigherPriorityTaskWoken = pdFALSE;
		xReturned = xSemaphoreGiveFromISR(tm_semaphore_array[semaphore_id],&xHigherPriorityTaskWoken);
		portYIELD_FROM_ISR(xHigherPriorityTaskWoken);
	}
	else
	{
		xReturned = xSemaphoreGive(tm_semaphore_array[semaphore_id]);
	}
	return (xReturned==pdTRUE)?TM_SUCCESS:TM_ERROR;
}

/* This function creates the specified memory pool that can support one or more
   allocations of 128 bytes.  If successful, the function should
   return TM_SUCCESS. Otherwise, TM_ERROR should be returned.  */
int  tm_memory_pool_create(int pool_id)
{
	/* Doesn't need to do anything. */
	return TM_SUCCESS;
}


/* This function allocates a 128 byte block from the specified memory pool.  
   If successful, the function should return TM_SUCCESS. Otherwise, TM_ERROR 
   should be returned.  */
int  tm_memory_pool_allocate(int pool_id, unsigned char **memory_ptr)
{
	void* pool_ptr;
	pool_ptr = pvPortMalloc(TM_FREERTOS_MEMORY_POOL_SIZE);
	tm_block_pool_array[pool_id] = pool_ptr;
	*memory_ptr = (unsigned char*)pool_ptr;
	return (pool_ptr!=NULL)?TM_SUCCESS:TM_ERROR; 
}


/* This function releases a previously allocated 128 byte block from the specified 
   memory pool. If successful, the function should return TM_SUCCESS. Otherwise, TM_ERROR 
   should be returned.  */
int  tm_memory_pool_deallocate(int pool_id, unsigned char *memory_ptr)
{
	if (memory_ptr!=(unsigned char*)tm_block_pool_array[pool_id])
		return TM_ERROR;
	vPortFree((void*)memory_ptr);
	return TM_SUCCESS;
}


