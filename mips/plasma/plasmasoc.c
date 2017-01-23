/**
 * @author Andrew Powell
 * @date 18 January 2017
 * @brief Contains hardware definitions and drivers for the Plasma-SoC.
 */

#include "plasmasoc.h"

static inline __attribute__ ((always_inline))
void l1_cache_find_range(unsigned addr, unsigned size, unsigned* cur_addr, unsigned* end_addr)
{
	const unsigned inc_addr = (L1_CACHE_OFFSET_MASK+1);
	unsigned addr_0 = addr+size;
	unsigned addr_1 = addr_0&~L1_CACHE_OFFSET_MASK;

	*cur_addr = addr&~L1_CACHE_OFFSET_MASK;
	*end_addr = addr_1+inc_addr;
	*end_addr += (addr_0>addr_1)?inc_addr:0;
}

void l1_cache_operate_on_line_range(unsigned oper_offset,unsigned addr, unsigned size)
{
	const unsigned inc_addr = (L1_CACHE_OFFSET_MASK+1);
	unsigned cur_addr;
	unsigned end_addr;

	if (size==0) return;
	l1_cache_find_range(addr,size,&cur_addr,&end_addr);

	for (;cur_addr!=end_addr;cur_addr += inc_addr)
		l1_cache_operate_on_line(oper_offset,cur_addr);
}



