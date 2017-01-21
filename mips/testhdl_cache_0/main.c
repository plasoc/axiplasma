#include "plasmasoc.h"
#define DATA_SIZE	(16)	
unsigned data[DATA_SIZE];
unsigned* noncacheable = (unsigned*)0x800;

void memset(void* destination, unsigned char value, unsigned bytes)
{
	/* Very slow way of writing a memset function. */
	unsigned char* cur = (unsigned char*)destination;
	unsigned char* end = cur+bytes;
	for (; cur!=end; cur++)
		*cur = value;
}

int main()
{
	int each_word;

	/* Store some arbitraty data directly into memory.*/
	for (each_word=0; each_word<DATA_SIZE; each_word++)
		noncacheable[each_word] += each_word*2;

	/* Store some arbitrary data into cache. */
	for (each_word=0; each_word<DATA_SIZE; each_word++)
		data[each_word] = each_word*2;

	/* Flush cache. This should force the cache to write data back to main memory. */
	l1_cache_flush_range((unsigned)data,sizeof(data));

	/* Invalidate cache. This should force the cache to invalidate the corresponding lines. */
	l1_cache_invalidate_range((unsigned)data,sizeof(data));

	/* Clear array. This should force cache to read data from main memory. */
	memset((void*)data,0,sizeof(data));

	/* Flush cache. This should force the zeroed cache to go into memory. */
	l1_cache_flush_range((unsigned)data,sizeof(data));
	return 0;
}


