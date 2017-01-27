#include "plasmasoc.h"
#include "xgpio.h"
#define XGPIO_INPUT_BASE_ADDRESS		(0x40000000)
#define XGPIO_OUTPUT_BASE_ADDRESS		(0x40010000)
xgpio xgpio_input_obj;
xgpio xgpio_output_obj;

int main()
{
	/* Configure gpios with base addresses. */
	xgpio_setup(&xgpio_input_obj,XGPIO_INPUT_BASE_ADDRESS);
	xgpio_setup(&xgpio_output_obj,XGPIO_OUTPUT_BASE_ADDRESS);

	/* Set directions of the gpios. */
	xgpio_set_direction(&xgpio_input_obj,XGPIO_INPUTS);
	xgpio_set_direction(&xgpio_output_obj,XGPIO_OUTPUTS);

	/* This test application should run indefinitely.*/
	while (1)
	{
		unsigned input_word;		

		/* Acquire word from input gpio. */
		input_word = xgpio_get_data(&xgpio_input_obj);

		/* For now, simply write the word back to the output gpio. */
		xgpio_set_data(&xgpio_output_obj,input_word);
	}

	return 0;
}


