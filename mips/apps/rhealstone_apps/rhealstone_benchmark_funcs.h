#ifndef RHEALSTONE_APPS_RHEALSTONE_BENCHMARK_FUNCS_H
#define RHEALSTONE_APPS_RHEALSTONE_BENCHMARK_FUNCS_H

#define RHEALSTONE_WORK_ITERS

typedef uint32_t usec_t;

void setup_benchmark_timer(void);
usec_t get_benchmark_timer(void);
void reset_benchmark_timer(void);

#endif //RHEALSTONE_APPS_RHEALSTONE_BENCHMARK_FUNCS_H
