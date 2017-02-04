#ifndef PLASOC_TIMER_H_
#define PLASOC_TIMER_H_

#ifdef __cplusplus
extern "C" 
{
#endif

	#define PLASOC_TIMER_CONTROL_OFFSET		(0)
	#define PLASOC_TIMER_START_BIT_LOC		(0)
	#define PLASOC_TIMER_RELOAD_BIT_LOC		(1)
	#define PLASOC_TIMER_ACK_BIT_LOC		(2)
	#define PLASOC_TIMER_DONE_BIT_LOC		(3)
	#define PLASOC_TIMER_TRIG_VALUE_OFFSET	(4)
	#define PLASOC_TIMER_TICK_VALUE_OFFSET	(8)
	
	typedef struct 
	{
		unsigned base_address;
	}
	plasoc_timer;
	
	static inline __attribute__ ((always_inline))
	void plasoc_timer_setup(plasoc_timer* obj,unsigned base_address)
	{
		obj->base_address = base_address;
	}
	
	static inline __attribute__ ((always_inline))
	void plasoc_timer_start(plasoc_timer* obj)
	{
		*(volatile unsigned*)(obj->base_address+PLASOC_TIMER_CONTROL_OFFSET) = (1<<PLASOC_TIMER_START_BIT_LOC);
	}
	
	static inline __attribute__ ((always_inline))
	void plasoc_timer_reload_start(plasoc_timer* obj,unsigned ack_flag)
	{
		*(volatile unsigned*)(obj->base_address+PLASOC_TIMER_CONTROL_OFFSET) = 
			(1<<PLASOC_TIMER_START_BIT_LOC)|(1<<PLASOC_TIMER_RELOAD_BIT_LOC)|
			((ack_flag)?(1<<PLASOC_TIMER_ACK_BIT_LOC):0);
	}
	
	static inline __attribute__ ((always_inline))
	void plasoc_timer_stop(plasoc_timer* obj)
	{
		*(volatile unsigned*)(obj->base_address+PLASOC_TIMER_CONTROL_OFFSET) = 0;
	}
	
	static inline __attribute__ ((always_inline))
	unsigned plasoc_timer_get_done(plasoc_timer* obj)
	{
		return ((unsigned)*(volatile unsigned*)(obj->base_address+PLASOC_TIMER_CONTROL_OFFSET))&
			(1<<PLASOC_TIMER_DONE_BIT_LOC);
	}
	
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
