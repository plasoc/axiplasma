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

	#define INT_XGPIO_INPUT_ID		(0)
	#define XGPIO_GPIO_DATA_OFFSET	(0x0000)
	#define XGPIO_GPIO_TRI_OFFSET	(0x0004)
	#define XGPIO_GIER_OFFSET		(0x011c)
	#define XGPIO_IP_IER_OFFSET		(0x0128)
	#define XGPIO_IP_ISR_OFFSET		(0x0120)
	#define XGPIO_OUTPUTS			(0x00000)
	#define XGPIO_INPUTS			(0xfffff)
	#define XGPIO_GIER_ENABLE_MASK	(1<<31)

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
		*((volatile unsigned*)(obj->base_address+XGPIO_GPIO_DATA_OFFSET)) = data;
	}

	static inline __attribute__ ((always_inline))
	unsigned xgpio_get_data(xgpio* obj)
	{
		return (unsigned)(*((volatile unsigned*)(obj->base_address+XGPIO_GPIO_DATA_OFFSET)));
	}

	static inline __attribute__ ((always_inline))
	void xgpio_set_direction(xgpio* obj,unsigned direction)
	{
		*((volatile unsigned*)(obj->base_address+XGPIO_GPIO_TRI_OFFSET)) = direction;
	}

	static inline __attribute__ ((always_inline))
	void xgpio_enable_global_interrupt(xgpio* obj)
	{
		*((volatile unsigned*)(obj->base_address+XGPIO_GIER_OFFSET)) = XGPIO_GIER_ENABLE_MASK;
	}

	static inline __attribute__ ((always_inline))
	void xgpio_disable_global_interrupt(xgpio* obj)
	{
		*((volatile unsigned*)(obj->base_address+XGPIO_GIER_OFFSET)) = 0;
	}

	static inline __attribute__ ((always_inline))
	void xgpio_enable_channel_interrupt(xgpio* obj,unsigned channel)
	{
		*((volatile unsigned*)(obj->base_address+XGPIO_IP_IER_OFFSET)) |= (1<<(channel-1));
	}

	static inline __attribute__ ((always_inline))
	void xgpio_disable_channel_interrupt(xgpio* obj,unsigned channel)
	{
		*((volatile unsigned*)(obj->base_address+XGPIO_IP_IER_OFFSET)) &= ~(1<<(channel-1));
	}

	static inline __attribute__ ((always_inline))
	void xgpio_ack_channel_interrupt(xgpio* obj,unsigned channel)
	{
		*((volatile unsigned*)(obj->base_address+XGPIO_IP_ISR_OFFSET)) = (1<<(channel-1));
	}


#ifdef __cplusplus
}
#endif

#endif /* XGPIO_H_ */
