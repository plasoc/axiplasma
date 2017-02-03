/**
 * @author Andrew Powell
 * @date January 31, 2017
 * @brief Contains hardware definitions and driver for the Plasma-SoC's Timer Core.
 */

#ifndef PLASOC_TIMER_H_
#define PLASOC_TIMER_H_

#ifdef __cplusplus
extern "C" 
{
#endif

	/* Timer Core definitions. See plasoc_pac.vhd for more information on these hardware definitions. */
	#define PLASOC_TIMER_CONTROL_OFFSET             (0)
	#define PLASOC_TIMER_START_BIT_LOC              (0)
	#define PLASOC_TIMER_RELOAD_BIT_LOC             (1)
	#define PLASOC_TIMER_ACK_BIT_LOC                (2)
	#define PLASOC_TIMER_DONE_BIT_LOC               (3)
	#define PLASOC_TIMER_TRIG_VALUE_OFFSET          (4)
	#define PLASOC_TIMER_TICK_VALUE_OFFSET          (8)
	
	/* Represents the Timer Core. */
	typedef struct 
	{
		unsigned base_address; /**< Base address to Timer Core's registers. */
	}
	plasoc_timer;
	
	/**
	 * @brief Configures the Timer Core object. 
	 * @param obj Pointer to the object.
	 * @param base_address Base address of the Timer Core's registers.
	 */
	static inline __attribute__ ((always_inline))
	void plasoc_timer_setup(plasoc_timer* obj,unsigned base_address)
	{
		obj->base_address = base_address;
	}
	
	/**
	 * @brief Starts the Timer Core in normal operation.
	 *
	 * The normal operation imples that the Tick Value register will
	 * increment to the value in the Trigger Value register, and then stop.
	 * The Done bit in the Control register will then be set to high until
	 * the Time Core is stopped. 
	 *
	 * It should be noted the Trigger Value register is buffered when the
	 * Timer Core is in operation, and writing a new value to it during
	 * operation will not cause any effect until the Timer Core is stopped. 
	 *
	 * @param obj Pointer to the object.
	 */
	static inline __attribute__ ((always_inline))
	void plasoc_timer_start(plasoc_timer* obj)
	{
		*(volatile unsigned*)(obj->base_address+PLASOC_TIMER_CONTROL_OFFSET) = (1<<PLASOC_TIMER_START_BIT_LOC);
	}
	
	/**
	 * @brief Starts the Timer Core in reload operation.
	 *
	 * Similar to normal operation, the Tick Value register will increment until
	 * it equals the value in the Trigger Value register and then set the Done
	 * bit. However, in the reload operation, the Tick Value will reset back to zero
	 * and continue to increment back to the Trigger Value. The Done bit can be set 
	 * back to low by setting the Ack bit with this method.
	 *
	 * It should be noted the Trigger Value register is buffered when the
	 * Timer Core is in operation, and writing a new value to it during
	 * operation will not cause any effect until the Timer Core is stopped. 
	 *
	 * @param obj Pointer to the object.
	 * @param ack_flag Nonzero value will set the Ack bit.
	 */
	static inline __attribute__ ((always_inline))
	void plasoc_timer_reload_start(plasoc_timer* obj,unsigned ack_flag)
	{
		*(volatile unsigned*)(obj->base_address+PLASOC_TIMER_CONTROL_OFFSET) = 
			(1<<PLASOC_TIMER_START_BIT_LOC)|(1<<PLASOC_TIMER_RELOAD_BIT_LOC)|
			((ack_flag)?(1<<PLASOC_TIMER_ACK_BIT_LOC):0);
	}
	
	/**
	 * @brief Stops the Timer Core.
	 * @param obj Pointer to the object.
	 */
	static inline __attribute__ ((always_inline))
	void plasoc_timer_stop(plasoc_timer* obj)
	{
		*(volatile unsigned*)(obj->base_address+PLASOC_TIMER_CONTROL_OFFSET) = 0;
	}
	
	/**
	 * @brief Gets the done bit.
	 * @param obj Pointer to the object.
	 * @return Nonzero value implies the Done bit is set, otherwise it is low.
	 */
	static inline __attribute__ ((always_inline))
	unsigned plasoc_timer_get_done(plasoc_timer* obj)
	{
		return ((unsigned)*(volatile unsigned*)(obj->base_address+PLASOC_TIMER_CONTROL_OFFSET))&
			(1<<PLASOC_TIMER_DONE_BIT_LOC);
	}
	
	/**
	 * @brief Sets the Trigger Value.
	 * 
	 * It should be noted the Trigger Value register is buffered when the
	 * Timer Core is in operation, and writing a new value to it during
	 * operation will not cause any effect until the Timer Core is stopped. 
	 *
	 * @param obj Pointer to the object.
	 * @param trig_value The value to write to the Trigger Value register.
	 */
	static inline __attribute__ ((always_inline))
	void plasoc_timer_set_trig_value(plasoc_timer* obj,unsigned trig_value)
	{
		*(volatile unsigned*)(obj->base_address+PLASOC_TIMER_TRIG_VALUE_OFFSET) = trig_value;
	}
	
	/**
	 * @brief Get the Tick Value register.
	 * @param obj Pointer to the object.
	 * @return Value read from the Tick Value Register. 
	 */
	static inline __attribute__ ((always_inline))
	unsigned plasoc_timer_get_tick_value(plasoc_timer* obj)
	{
		return ((unsigned)*(volatile unsigned*)(obj->base_address+PLASOC_TIMER_TICK_VALUE_OFFSET));
	}
	
#ifdef __cplusplus
}
#endif

#endif /* PLASOC_TIMER_H_ */
