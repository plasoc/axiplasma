#ifndef PLASOC_GPIO_H_
#define PLASOC_GPIO_H_

#ifdef __cplusplus
extern "C" 
{
#endif

	#define PLASOC_GPIO_CONTROL_OFFSET             (0)
	#define PLASOC_GPIO_CONTROL_ENABLE_BIT_LOC     (0)
	#define PLASOC_GPIO_CONTROL_ACK_BIT_LOC        (1)
	#define PLASOC_GPIO_DATA_IN_OFFSET             (4)
	#define PLASOC_GPIO_DATA_OUT_OFFSET            (8)
	
	typedef struct
	{
		unsigned base_address;
	}
	plasoc_gpio;
	
	static inline __attribute__ ((always_inline))
	void plasoc_gpio_setup(plasoc_gpio* obj,unsigned base_address)
	{
		obj->base_address = base_address;
	}
	
	static inline __attribute__ ((always_inline))
	void plasoc_gpio_enable_int(plasoc_gpio* obj,unsigned ack_flag)
	{
		__asm__ __volatile__ ( "" : : : "memory");
		*((volatile unsigned*)(obj->base_address+PLASOC_GPIO_CONTROL_OFFSET)) =
			(1<<PLASOC_GPIO_CONTROL_ENABLE_BIT_LOC)|
			((ack_flag)?(1<<PLASOC_GPIO_CONTROL_ACK_BIT_LOC):0);
	}
	
	static inline __attribute__ ((always_inline))
	void plasoc_gpio_disable_int(plasoc_gpio* obj)
	{
		__asm__ __volatile__ ( "" : : : "memory");
		*((volatile unsigned*)(obj->base_address+PLASOC_GPIO_CONTROL_OFFSET)) = 0;
	}
	
	static inline __attribute__ ((always_inline))
	void plasoc_gpio_set_data_out(plasoc_gpio* obj,unsigned data_out)
	{
		*((volatile unsigned*)(obj->base_address+PLASOC_GPIO_DATA_OUT_OFFSET)) = data_out;
	}
	
	static inline __attribute__ ((always_inline))
	unsigned plasoc_gpio_get_data_out(plasoc_gpio* obj)
	{
		return  *((volatile unsigned*)(obj->base_address+PLASOC_GPIO_DATA_OUT_OFFSET));
	}
	
	static inline __attribute__ ((always_inline))
	unsigned plasoc_gpio_get_data_in(plasoc_gpio* obj)
	{
		return  *((volatile unsigned*)(obj->base_address+PLASOC_GPIO_DATA_IN_OFFSET));
	}
	
	
#ifdef __cplusplus
}
#endif

#endif /* PLASOC_GPIO_H_ */