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

static unsigned a = 0, b = 0;
static TaskHandle_t task1_handle, task2_handle;

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
    configASSERT(xTaskCreate(task1,"task1",configMINIMAL_STACK_SIZE,NULL,3,&task1_handle) == pdTrue);
    configASSERT(xTaskCreate(task2,"task2",configMINIMAL_STACK_SIZE,NULL,3,&task2_handle) == pdTrue);
}

int main(void)
{
    setup_benchmark_tasks();

    setup_benchmark_timer();

    for (int i = 0; i < NUM_TRIALS; i++)
    {
        reset_benchmark_timer();
        run_benchmark_tasks();
        usec_t time = get_benchmark_timer();
        printf("%ud\n", (unsigned)time);
    }

    return 0;
}
