#include "FreeRTOS.h"
#include "task.h"
#include "semphr.h"
#include "queue.h"
#include "plasoc_cpu.h"
#include "plasoc_int.h"
#include "plasoc_timer.h"
#include "plasoc_gpio.h"
#include "plasoc_uart.h"
#include "printf.h"
#include "rhealstone_benchmark_funcs.h"

#define NUM_TRIALS 100

static unsigned a = 0, b = 0;
static TaskHandle_t task1_handle, task2_handle, finishtask_handle;

static void task1(void* ptr)
{
    (void)ptr;
    for (int i = 0; i < RHEALSTONE_WORK_ITERS; i++)
    {
        // "work"
        a = (a + i) ^ ~0;
        taskYIELD();
    }
    vTaskDelete(&task1_handle);
}

static void task2(void* ptr)
{
    (void)ptr;
    for (int i = 0; i < RHEALSTONE_WORK_ITERS; i++)
    {
        // "work"
        b = (b + i) ^ ~0;
        taskYIELD();
    }
    vTaskDelete(&task2_handle);
}

static void setup_benchmark_tasks(void)
{
    configASSERT(xTaskCreate(task1,"task1",configMINIMAL_STACK_SIZE,NULL,3,&task1_handle) == pdTRUE);
    configASSERT(xTaskCreate(task2,"task2",configMINIMAL_STACK_SIZE,NULL,3,&task2_handle) == pdTRUE);
}

static void finishtask(void* ptr)
{
	(void)ptr;
	uint64_t avg = 0;
    for (int i = 0; i < NUM_TRIALS; i++)
    {
		setup_benchmark_tasks();
		start_benchmark_timer();
		taskYIELD();
        avg += get_benchmark_time();
		stop_benchmark_timer();
    }
	avg /= NUM_TRIALS;
	while (1) {
		printf("Finished\n");
		printf("Average: %d\n", avg);
	}
}

int main(void)
{
	setup_hardware();

    configASSERT(xTaskCreate(finishtask,"finish task",configMINIMAL_STACK_SIZE,NULL,1,&finishtask_handle) == pdTRUE);
	vTaskStartScheduler();

    return 0;
}

