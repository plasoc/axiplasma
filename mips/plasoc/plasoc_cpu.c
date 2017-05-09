/**
 * @author Andrew Powell
 * @date January 18, 2017
 * @brief Contains hardware definitions and drivers for the Plasma-SoC's CPU. See header file 
 * for more information.
 */

#include "plasoc_cpu.h"

static inline __attribute__ ((always_inline,optimize("O3")))
void l1_cache_find_range(unsigned addr, unsigned size, unsigned* cur_addr, unsigned* end_addr)
{
	const unsigned inc_addr = (L1_CACHE_OFFSET_MASK+1);
	unsigned addr_0 = addr+size;
	unsigned addr_1 = addr_0&~L1_CACHE_OFFSET_MASK;

	*cur_addr = addr&~L1_CACHE_OFFSET_MASK;
	*end_addr = addr_1+inc_addr;
	*end_addr += (addr_0>addr_1)?inc_addr:0;
}

__attribute__ ((optimize("O3")))
void l1_cache_operate_on_line_range(unsigned oper_offset,unsigned addr, unsigned size)
{
	const unsigned inc_addr = (L1_CACHE_OFFSET_MASK+1);
	unsigned cur_addr;
	unsigned end_addr;
	register unsigned int_mask;

	if (size==0) return;
	l1_cache_find_range(addr,size,&cur_addr,&end_addr);

	/* This operation must be completed within a critical section. */
	int_mask = enter_critical();
	for (;cur_addr!=end_addr;cur_addr += inc_addr)
		l1_cache_operate_on_line(oper_offset,cur_addr);
	leave_critical(int_mask);
}

__attribute__ ((optimize("O3")))
void l1_cache_operate_on_line_all(unsigned oper_offset)
{
	register unsigned int_mask;
	unsigned each_way;
	unsigned each_index;
	
	/* This operation must be completed within a critical section. */
	int_mask = enter_critical();
	for (each_index=0;each_index<(1<<L1_CACHE_INDEX_WIDTH);each_index++)
		for (each_way=0;each_way<(1<<L1_CACHE_WAY_WIDTH);each_way++)
			l1_cache_operate_way_on_line(oper_offset,each_way,each_index);
	leave_critical(int_mask);
}

__attribute__ ((optimize("O3")))
void l1_cache_memory_barrier()
	{
		register unsigned int_mask;
		int_mask = enter_critical();
		l1_cache_flush_all();
		l1_cache_invalidate_all();
		leave_critical(int_mask);
	}


