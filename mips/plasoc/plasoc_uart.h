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
	#define PLASOC_UART_IN_OFFSET			(4) /* In Fifo. */
	#define PLASOC_UART_OUT_OFFSET			(8) /* Out Fifo. */

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
	 * @brief Attempts to write an 8-bit value to the UART Core.
	 * 
	 * This method should be used in conjunction with plasoc_uart_get_status_out_avail.
	 * If the FIFO associated with the Out Fifo register is full, then the byte 
	 * written to the Out Fifo register will be lost.
	 *
	 * @param obj Pointer to the object.
	 * @param byte The output data. Only the least significant byte is applicable.
	 */
	static inline __attribute__ ((always_inline))
	void plasoc_uart_set_out(plasoc_uart* obj,unsigned byte)
	{
		*((volatile unsigned*)(obj->base_address+PLASOC_UART_OUT_OFFSET)) = byte;
	}

	/**
	 * @brief Attempts to receive an 8-bit value from the UART Core.
	 * 
	 * This method should be used in conjunction with plasoc_uart_get_status_in_avail.
	 * If the FIFO associated with the In Fifo register is empty, then the byte acquired
	 * from the In Fifo register will be zero.
	 *
	 * Note that Status In Avail signal from the UART Core itself is also the
	 * Status In Avail bit in the Control register. In order to reset this signal,
	 * plasoc_uart_get_in must be called until the FIFO is empty.
	 *
	 * @param obj Pointer to the object.
	 * @return The input data. Only the least significant byte is applicable.
	 */
	static inline __attribute__ ((always_inline))
	unsigned plasoc_uart_get_in(plasoc_uart* obj)
	{
		return *((volatile unsigned*)(obj->base_address+PLASOC_UART_IN_OFFSET));
	}

	/**
	 * @brief Checks to see whether or not input data is available.
	 *
	 * This method should be used in conjunction with plasoc_uart_get_in.
	 * If the FIFO associated with the In Fifo register is empty, then the byte acquired
	 * from the In Fifo register will be zero.
	 *
	 * Note that Status In Avail signal from the UART Core itself is also the
	 * Status In Avail bit in the Control register. In order to reset this signal,
	 * plasoc_uart_get_in must be called until the FIFO is empty.
	 *
	 * @param obj Pointer to the object.
	 * @return A nonzero value implies the FIFO contains input data, otherwise the FIFO is empty.
	 */
	static inline __attribute__ ((always_inline))
	unsigned plasoc_uart_get_status_in_avail(plasoc_uart* obj)
	{
		return (*((volatile unsigned*)(obj->base_address+PLASOC_UART_CONTROL_OFFSET)))&(1<<PLASOC_UART_STATUS_IN_AVAIL_BIT_LOC);
	}

	/**
	 * @brief Checks to see whether or not output data can be written to the associated FIFO.
	 *
	 * This method should be used in conjunction with plasoc_uart_set_out.
	 * If the FIFO associated with the Out Fifo register is full, then the byte 
	 * written to the Out Fifo register will be lost.
	 *
	 * @param obj Pointer to the object.
	 * @return A nonzero value implies there is available space in the FIFO for output data, otherwise the FIFO is full.
	 */
	static inline __attribute__ ((always_inline))
	unsigned plasoc_uart_get_status_out_avail(plasoc_uart* obj)
	{
		return (*((volatile unsigned*)(obj->base_address+PLASOC_UART_CONTROL_OFFSET)))&(1<<PLASOC_UART_STATUS_OUT_AVAIL_BIT_LOC);
	}

#ifdef __cplusplus
}
#endif

#endif /* PLASOC_UART_H_ */
