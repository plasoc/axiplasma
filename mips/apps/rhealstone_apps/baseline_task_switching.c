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

#define NUM_TRIAL 1

static void setup_benchmark_tasks(void)
{
    // don't have to do anything because no preemptive necessary
}

static unsigned a = 0, b = 0;

static void run_benchmark_tasks(void)
{
    // Task 1
    for (int i = 0; i < RHEALSTONE_WORK_ITERS; i++)
    {
        // "work"
        a = (a + i) ^ ~a;
    }
    // Task 2
    for (int i = 0; i < RHEALSTONE_WORK_ITERS; i++)
    {
        // "work"
        b = (b + i) ^ ~b;
    }
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
