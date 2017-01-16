#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#define ARY_SIZE 16

int array_0[8] = {3,2,7,6,1,5,4,8};
void bubblesort(int* array, int n);

int main()
{
	bubblesort(array_0,sizeof(array_0)/sizeof(array_0[0]));
	return 0;
}

void bubblesort(int* array, int n)
{
	for(int x=0; x<n; x++)
	{
		for(int y=0; y<n-1; y++)
		{
			if(array[y]>array[y+1])
			{
				int temp = array[y+1];
				array[y+1] = array[y];
				array[y] = temp;
			}
		}
	}
}
