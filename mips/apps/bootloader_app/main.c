#include "port_layer.h"
#define BOOT_LOADER_START_ADDRESS			(0x10000000)
#define BOOT_LOADER_START_WORD				(0xf0f0f0f0)
#define BOOT_LOADER_ACK_SUCCESS_BYTE		(0x01)	
#define BOOT_LOADER_ACK_FAILURE_BYTE		(0x02)
#define BOOT_LOADER_STATUS_MORE				(0x01)
#define BOOT_LOADER_STATUS_DONE				(0x02)
#define BOOT_LOADER_CHECKSUM_DIVISOR		(230)							

static void run()
{
	while (1)
	{
		unsigned input_word = getword();
		if (input_word==BOOT_LOADER_START_WORD)
		{
			unsigned code_word;
			unsigned char checksum;
			unsigned char status;
			unsigned* load_address;

			load_address = (unsigned*)BOOT_LOADER_START_ADDRESS;
			setbyte(BOOT_LOADER_ACK_SUCCESS_BYTE);
			do
			{
				code_word = getword();
				checksum = getbyte();
				status = getbyte();
				
				if ((code_word%BOOT_LOADER_CHECKSUM_DIVISOR)==checksum)
				{
					*(load_address++) = code_word;
					setbyte(BOOT_LOADER_ACK_SUCCESS_BYTE);
				}
				else
				{
					setbyte(BOOT_LOADER_ACK_FAILURE_BYTE);
				}
			}
			while (status!=BOOT_LOADER_STATUS_DONE);
			
			__asm__ __volatile__ ("jr %0"::"r"(BOOT_LOADER_START_ADDRESS):"memory");
		}
	}
}

int main()
{
	initialize(run);
	return 0;
}



