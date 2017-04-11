#ifndef RHEALSTONE_APPS_RHEALSTONE_BENCHMARK_FUNCS_H
#define RHEALSTONE_APPS_RHEALSTONE_BENCHMARK_FUNCS_H

#include <inttypes.h>

#define RHEALSTONE_WORK_ITERS 50000

typedef uint32_t usec_t;

void setup_hardware(void);
void start_benchmark_timer(void);
void stop_benchmark_timer(void);
usec_t get_benchmark_time(void);

#endif //RHEALSTONE_APPS_RHEALSTONE_BENCHMARK_FUNCS_H
