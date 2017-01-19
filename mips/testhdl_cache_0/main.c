#include <stdint.h>
#include <string.h>
#include "plasmasoc.h"
#define BYTES(array) 	(sizeof((array))/sizeof((array)[0]))
#define DATA_SIZE	(16)	
volatile unsigned data[DATA_SIZE];
volatile unsigned data2[DATA_SIZE];

int main()
{
	int each_word;

	/* Store some arbitrary data into cache. */
	for (each_word=0; each_word<DATA_SIZE; each_word++)
		data[each_word] = (each_word+6)*5;

	/* Flush cache. This should force the cache to write data back to main memory. */
	l1_cache_flush_range((unsigned)data,BYTES(data));

	/* Clear array. This should clear the copy of the array in main memory. */
	memset((void*)data,0,BYTES(data));

	/* Invalidate cache. This should force the cache to invalidate the corresponding lines. */
	l1_cache_invalidate_range((unsigned)data,BYTES(data));

	/* Since the cache is invalidated, this should force the cache to read the invalidated data into the cache. */
	memcpy((void*)data2,(void*)data,BYTES(data));
	return 0;
}
