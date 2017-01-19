#include <stdint.h>
#include <string.h>
#include "plasmasoc.h"

int main()
{
	CACHE_INVALIDATE(0x11123);
	CACHE_INVALIDATE(0x433);
	CACHE_FLUSH(0x232);
	return 0;
}
