#include <stdint.h>
#include <string.h>
#define BUFFER_SIZE 64
char str_0[BUFFER_SIZE] = "This is a string";
char str_1[BUFFER_SIZE] = " that needs to be extended.";

uint32_t start_value = 32;
uint32_t end_value = 0;

int main()
{
	// Test string concatentation function.
	strcat(str_0,str_1);

	// Copy contents of value to signify end of test.
	memcpy(&end_value,&start_value,sizeof(uint32_t));
	return 0;
}
