#include "port_layer.h"
#define BOOT_LOADER_START_ADDRESS		(0x01000000)
#define BOOT_LOADER_START_WORD			(0xf0f0f0f0)
#define BOOT_LOADER_ACK_SUCCESS_BYTE		(0x01)	
#define BOOT_LOADER_ACK_FAILURE_BYTE		(0x02)
#define BOOT_LOADER_STATUS_MORE			(0x01)
#define BOOT_LOADER_STATUS_DONE			(0x02)
#define BOOT_LOADER_CHECKSUM_DIVISOR		(230)		
#define BOOT_LOADER_CACHE_FLUSH_THRESHOLD	(1<<(L1_CACHE_OFFSET_WIDTH-2))					

static void run()
{
	/* DEBUG */
	//*((volatile unsigned*)0x44a20008) = 1;

	while (1)
	{
		unsigned input_word = getword();
		if (input_word==BOOT_LOADER_START_WORD)
		{
			unsigned cache_address;
			unsigned cache_counter;
			unsigned code_word;
			unsigned char checksum;
			unsigned char status;
			unsigned* load_address;

			cache_address = BOOT_LOADER_START_ADDRESS;
			cache_counter = 0;
			load_address = (unsigned*)BOOT_LOADER_START_ADDRESS;
			setbyte(BOOT_LOADER_ACK_SUCCESS_BYTE);

			do
			{
				code_word = getword();
				checksum = getbyte();
				status = getbyte();
				
				if ((code_word%BOOT_LOADER_CHECKSUM_DIVISOR)==checksum)
				{
					*load_address = code_word;
					load_address++;
					
					if (cache_counter==(BOOT_LOADER_CACHE_FLUSH_THRESHOLD-1))
					{
						l1_cache_flush_range(cache_address,BOOT_LOADER_CACHE_FLUSH_THRESHOLD<<2);
						cache_address = (unsigned)load_address;
						cache_counter = 0;
					}
					else
					{
						cache_counter++;
					}

					setbyte(BOOT_LOADER_ACK_SUCCESS_BYTE);
				}
				else
				{
					setbyte(BOOT_LOADER_ACK_FAILURE_BYTE);
				}
			}
			while (status!=BOOT_LOADER_STATUS_DONE);

			l1_cache_flush_range(cache_address,BOOT_LOADER_CACHE_FLUSH_THRESHOLD<<2);

			cleanup();
			
			__asm__ __volatile__ ("jr %0"::"r"(BOOT_LOADER_START_ADDRESS):"memory");
		}
	}
}

int main()
{
	initialize(run);
	return 0;
}



