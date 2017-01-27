/**
 * @author Andrew Powell
 * @date 26 January 2017
 * @brief Contains a simple driver for the Xilinx XGpio core. Since this driver is mainly used
 * to verify the axiplasma design, it only implements a single interface which can either be all 
 * inputs or all outputs.
 */

#ifndef XGPIO_H_
#define XGPIO_H_

#ifdef __cplusplus
extern "C" 
{
#endif

	#define XGPIO_GPIO_DATA		(0x0000)
	#define XGPIO_GPIO_TRI		(0x0004)
	#define XGPIO_OUTPUTS		(0x00000)
	#define XGPIO_INPUTS		(0xfffff)

	typedef struct 
	{
		unsigned base_address;
	}
	xgpio;

	static inline __attribute__ ((always_inline))
	void xgpio_setup(xgpio* obj,unsigned base_address)
	{
		obj->base_address = base_address;
	}

	static inline __attribute__ ((always_inline))
	void xgpio_set_data(xgpio* obj,unsigned data)
	{
		*((volatile unsigned*)(obj->base_address+XGPIO_GPIO_DATA)) = data;
	}

	static inline __attribute__ ((always_inline))
	unsigned xgpio_get_data(xgpio* obj)
	{
		return (unsigned)(*((volatile unsigned*)(obj->base_address+XGPIO_GPIO_DATA)));
	}

	static inline __attribute__ ((always_inline))
	void xgpio_set_direction(xgpio* obj,unsigned direction)
	{
		*((volatile unsigned*)(obj->base_address+XGPIO_GPIO_TRI)) = direction;
	}


#ifdef __cplusplus
}
#endif

#endif /* XGPIO_H_ */
