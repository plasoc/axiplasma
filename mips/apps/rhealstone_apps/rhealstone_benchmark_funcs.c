
#include "rhealstone_benchmark_funcs.h"
#include "plasoc_timer.h"

#define PLASOC_TIMER_1_BASE_ADDR

static plasoc_timer usec_timer;

void setup_benchmark_timer()
{
	plasoc_timer_setup(&usec_timer, PLASOC_TIMER_1_BASE_ADDR);
	plasoc_timer_set_trig_value(&usec_timer, (uint32_t)~0);
	plasoc_timer_start(&usec_timer);
}

usec_t get_benchmark_time()
{
	return (usec_t)(plasoc_timer_get_tick_value(&usec_timer)/(CPU_HZ/1000000));
}

void reset_benchmark_timer()
{
	plasoc_timer_stop(&usec_timer);
	plasoc_timer_start(&usec_timer);
}

