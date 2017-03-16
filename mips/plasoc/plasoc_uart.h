/**
 * @author Andrew Powell
 * @date March 16, 2017
 * @brief Contains hardware definitions and driver for the Plasma-SoC's UART Core.
 */

#ifndef PLASOC_UART_H_
#define PLASOC_UART_H_

#ifdef __cplusplus
extern "C" 
{
#endif

	/* Defines the address offsets and bit locations. */
	#define PLASOC_UART_CONTROL_OFFSET		(0)
	#define PLASOC_UART_STATUS_IN_AVAIL_BIT_LOC	(0)
	#define PLASOC_UART_STATUS_OUT_AVAIL_BIT_LOC	(1)
	#define PLASOC_UART_IN_OFFSET			(4)
	#define PLASOC_UART_OUT_OFFSET			(8)

	/**
	 * @brief Represents the GPIO Core. 
	 */
	typedef struct
	{
		unsigned base_address;	/**< Base address to GPIO Core. */
	}
	plasoc_uart;

	/**
	 * @brief Configures the UART Core object.
	 * @param obj Pointer to the object.
	 * @param base_address The address to the UART Core's register.
	 */
	static inline __attribute__ ((always_inline))
	void plasoc_uart_setup(plasoc_uart* obj,unsigned base_address)
	{
		obj->base_address = base_address;
	}

	/**
	 * @brief Writes an 8-bit value to the UART
	 */
	static inline __attribute__ ((always_inline))
	void plasoc_uart_set_out(plasoc_uart* obj,unsigned byte)
	{
		*((volatile unsigned*)(obj->base_address+PLASOC_UART_OUT_OFFSET)) = byte;
	}

	static inline __attribute__ ((always_inline))
	unsigned plasoc_uart_get_in(plasoc_uart* obj)
	{
		return *((volatile unsigned*)(obj->base_address+PLASOC_UART_IN_OFFSET));
	}

	static inline __attribute__ ((always_inline))
	unsigned plasoc_uart_get_status_in_avail(plasoc_uart* obj)
	{
		return (*((volatile unsigned*)(obj->base_address+PLASOC_UART_CONTROL_OFFSET)))&(1<<PLASOC_UART_STATUS_IN_AVAIL_BIT_LOC);
	}

	static inline __attribute__ ((always_inline))
	unsigned plasoc_uart_get_status_out_avail(plasoc_uart* obj)
	{
		return (*((volatile unsigned*)(obj->base_address+PLASOC_UART_CONTROL_OFFSET)))&(1<<PLASOC_UART_STATUS_OUT_AVAIL_BIT_LOC);
	}

#ifdef __cplusplus
}
#endif

#endif /* PLASOC_UART_H_ */
