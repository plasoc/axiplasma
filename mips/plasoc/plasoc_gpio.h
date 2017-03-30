/**
 * @author Andrew Powell
 * @date March 16, 2017
 * @brief Contains hardware definitions and driver for the Plasma-SoC's GPIO Core.
 */

#ifndef PLASOC_GPIO_H_
#define PLASOC_GPIO_H_

#ifdef __cplusplus
extern "C" 
{
#endif

	/* Defines the address offsets and bit locations. */
	#define PLASOC_GPIO_CONTROL_OFFSET             (0)
	#define PLASOC_GPIO_CONTROL_ENABLE_BIT_LOC     (0)
	#define PLASOC_GPIO_CONTROL_ACK_BIT_LOC        (1)
	#define PLASOC_GPIO_DATA_IN_OFFSET             (4)
	#define PLASOC_GPIO_DATA_OUT_OFFSET            (8)
	
	/**
	 * @brief Represents the GPIO Core. 
	 */
	typedef struct
	{
		unsigned base_address;	/**< Base address to GPIO Core. */
	}
	plasoc_gpio;
	
	/**
	 * @brief Configures the GPIO Core object.
	 * @param obj Pointer to the object.
	 * @param base_address The address to the GPIO Core's register.
	 */
	static inline __attribute__ ((always_inline))
	void plasoc_gpio_setup(plasoc_gpio* obj,unsigned base_address)
	{
		obj->base_address = base_address;
	}
	
	/**
	 * @brief Enables interruption due to a change in the Data In.
	 * @param obj Pointer to the object.
	 * @param ack_flag A nonzero flag sends an acknowledgement to the GPIO Core.
	 */
	static inline __attribute__ ((always_inline))
	void plasoc_gpio_enable_int(plasoc_gpio* obj,unsigned ack_flag)
	{
		__asm__ __volatile__ ( "" : : : "memory");
		*((volatile unsigned*)(obj->base_address+PLASOC_GPIO_CONTROL_OFFSET)) =
			(1<<PLASOC_GPIO_CONTROL_ENABLE_BIT_LOC)|
			((ack_flag)?(1<<PLASOC_GPIO_CONTROL_ACK_BIT_LOC):0);
	}
	
	/**
	 * @brief Disables interruption.
	 * @param obj Pointer to the object.
	 */
	static inline __attribute__ ((always_inline))
	void plasoc_gpio_disable_int(plasoc_gpio* obj)
	{
		__asm__ __volatile__ ( "" : : : "memory");
		*((volatile unsigned*)(obj->base_address+PLASOC_GPIO_CONTROL_OFFSET)) = 0;
	}
	
	/**
	 * @brief Write to Data Out.
	 * @param obj Pointer to the object.
	 * @param data_out The data that will be written to Data Out.
	 */
	static inline __attribute__ ((always_inline))
	void plasoc_gpio_set_data_out(plasoc_gpio* obj,unsigned data_out)
	{
		*((volatile unsigned*)(obj->base_address+PLASOC_GPIO_DATA_OUT_OFFSET)) = data_out;
	}
	
	/**
	 * @brief Read from Data Out.
	 * @param obj Pointer to the object.
	 * @return Returns the value from Data Out.
	 */
	static inline __attribute__ ((always_inline))
	unsigned plasoc_gpio_get_data_out(plasoc_gpio* obj)
	{
		return  *((volatile unsigned*)(obj->base_address+PLASOC_GPIO_DATA_OUT_OFFSET));
	}
	
	/**
	 * @brief Read from Data In.
	 * @param obj Pointer to the object.
	 * @return Returns the value from Data In.
	 */
	static inline __attribute__ ((always_inline))
	unsigned plasoc_gpio_get_data_in(plasoc_gpio* obj)
	{
		return  *((volatile unsigned*)(obj->base_address+PLASOC_GPIO_DATA_IN_OFFSET));
	}
	
	
#ifdef __cplusplus
}
#endif

#endif /* PLASOC_GPIO_H_ */