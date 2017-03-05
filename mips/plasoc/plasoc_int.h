/**
 * @author Andrew Powell
 * @date January 28, 2017
 * @brief Contains hardware definitions and driver for the Plasma-SoC's Interrupt Controller.
 */

#ifndef PLASOC_INT_H_
#define PLASOC_INT_H_

#ifdef __cplusplus
extern "C" 
{
#endif

	/* L1 cache definitions. See plasoc_pac.vhd for more information on these hardware definitions. */
	#define PLASOC_INT_INTERRUPT_TOTAL		(8)
	#define PLASOC_INT_INTERRUPT_MASK		((1<<PLASOC_INT_INTERRUPT_TOTAL)-1)	
	#define PLASOC_INT_ENABLES_OFFSET		(0)
	#define PLASOC_INT_ID_OFFSET			(4)
	#define PLASOC_INT_ACTIVE_OFFSET		(8)

	/** @brief Interrupt Service Routine Type. */
	typedef void (plasoc_int_isr)(void*);
	
	/** @brief Represents an entry in the vector table. */
	typedef struct 
	{
		plasoc_int_isr* isr;	/**< Function pointer to ISR.*/
		void* ptr;				/**< Pointer used as input to the ISR.*/
	}
	plasoc_int_vector_entry;

	/**
	 * @brief Represents the Interrupt Controller.
	 */
	typedef struct 
	{
		unsigned base_address;												/**< Base address to Interrupt Controller. */
		plasoc_int_vector_entry vector_table[PLASOC_INT_INTERRUPT_TOTAL];	/**< Vector table. */
	}
	plasoc_int;

	/**
	 * @brief Configures the Interrupt Controller object. 
	 *
	 * Configuration includes storing the base_address and clearing the
	 * vector table.
	 *
	 * @param obj Pointer to the object.
	 * @param base_address Address of the Interrupt Controller's registers.
	 */
	static inline __attribute__ ((always_inline))
	void plasoc_int_setup(plasoc_int* obj,unsigned base_address)
	{
		/* Store base address of interrupt controller.*/
		obj->base_address = base_address;

		/* Clear the vector table.*/
		{
			plasoc_int_vector_entry* start=obj->vector_table;
			plasoc_int_vector_entry* end=start+PLASOC_INT_INTERRUPT_TOTAL;
			while (start!=end)
				(start++)->isr = (plasoc_int_isr*)0;
		}		
	}

	/**
	 * @brief Gets the Interrupt Identifier register. 
	 *
	 * The Interrupt Identifier register is set to the identifier of a
	 * device interrupt when there is an active interrupt. If there are 
	 * multiple active interrupts, the Interrupt Identifier register will
	 * be set to the active interrupt with the highest priority, which is 
	 * equivalent to the active interrupt with the lowest identifier.
	 * 
	 * If there are no active interrupts, the value in the Interrupt 
	 * Identifier register will be the number of possible interrupts,
	 * PLASOC_INT_INTERRUPT_TOTAL.
	 *
	 * @param obj Pointer to the object.
	 * @return Current value of the Interrupt Identifier register.
	 */
	static inline __attribute__ ((always_inline))
	unsigned plasoc_int_get_id(plasoc_int* obj)
	{
		return (unsigned)(*((unsigned volatile*)(obj->base_address+PLASOC_INT_ID_OFFSET)));
	}

	/**
	 * @brief Gets the Active Interrupt register. 
	 *
	 * Each bit in the Active Interrupt Register that is 
	 * high corresponds to an active device interrupt.
	 *
	 * @param obj Pointer to the object.
	 * @return Current value of the Active Interrupt register.
	 */
	static inline __attribute__ ((always_inline))
	unsigned plasoc_int_get_active(plasoc_int* obj)
	{
		return (unsigned)(*((unsigned volatile*)(obj->base_address+PLASOC_INT_ACTIVE_OFFSET)));
	}

	/**
	 * @brief Enables all device interrupts.
	 * @param obj Pointer to the object.
	 */
	static inline __attribute__ ((always_inline))
	void plasoc_int_enable_all(plasoc_int* obj)
	{
		__asm__ __volatile__ ( "" : : : "memory");
		*((unsigned volatile*)(obj->base_address+PLASOC_INT_ENABLES_OFFSET)) = PLASOC_INT_INTERRUPT_MASK;
	}

	/**
	 * @brief Disables all device interrupts.
	 * @param obj Pointer to the object.
	 */
	static inline __attribute__ ((always_inline))
	void plasoc_int_disable_all(plasoc_int* obj)
	{
		__asm__ __volatile__ ( "" : : : "memory");
		*((unsigned volatile*)(obj->base_address+PLASOC_INT_ENABLES_OFFSET)) = 0;
	}

	/**
	 * @brief Enables a specific device interrupt. NOT ATOMIC.
	 * @param obj Pointer to the object.
	 * @param id Identifier of the device interrupt to enable.
	 */
	static inline __attribute__ ((always_inline))
	void plasoc_int_enable(plasoc_int* obj,unsigned id)
	{
		__asm__ __volatile__ ( "" : : : "memory");
		*((unsigned volatile*)(obj->base_address+PLASOC_INT_ENABLES_OFFSET)) |= (1<<id);
	}

	/**
	 * @brief Disables a specific device interrupt. NOT ATOMIC.
	 * @param obj Pointer to the object.
	 * @param id Identifier of the device interrupt to enable.
	 */
	static inline __attribute__ ((always_inline))
	void plasoc_int_disable(plasoc_int* obj,unsigned id)
	{
		__asm__ __volatile__ ( "" : : : "memory");
		*((unsigned volatile*)(obj->base_address+PLASOC_INT_ENABLES_OFFSET)) &= ~(1<<id);
	}

	/**
	 * @brief Associate ISR and pointer with device interrupt.
	 * @param obj Pointer to the object.
	 * @param id Identifier of the device interrupt.
	 * @param isr ISR to associate with the identifier.
	 * @param ptr Pointer to associate with the identifier.
	 */
	static inline __attribute__ ((always_inline))
	void plasoc_int_attach_isr(plasoc_int* obj,unsigned id,plasoc_int_isr* isr,void* ptr)
	{
		plasoc_int_vector_entry* entry = obj->vector_table+id;
		entry->isr = isr;
		entry->ptr = ptr;
	}

	/**
	 * @brief Dissociate ISR and pointer from device interrupt.
	 * @param obj Pointer to the object.
	 * @param id Identifier of the device interrupt.
	 */
	static inline __attribute__ ((always_inline))
	void plasoc_int_detach_isr(plasoc_int* obj,unsigned id)
	{
		obj->vector_table[id].isr = (plasoc_int_isr*)0;
	}

	/**
	 * @brief Services active device interrupts.
	 *
	 * This method should be called by the CPU's ISR.
	 *
	 * @param obj Pointer to the object.
	 */
	static inline __attribute__ ((always_inline))
	void plasoc_int_service_interrupts(plasoc_int* obj)
	{
		plasoc_int_vector_entry* vector_table;
		plasoc_int_vector_entry* entry;
		unsigned id;

		/* Get interrupt service routine information. */
		vector_table = obj->vector_table;

		/* Acquire id of the active interrupt with the highest priority. */
		id = plasoc_int_get_id(obj);
		
		/* Keep servicing interrupts until every interrupt has been serviced. */
		while (id<PLASOC_INT_INTERRUPT_TOTAL) 
		{
			/* Execute the corresponding service routine. */
			entry = vector_table+id;
			entry->isr(entry->ptr);

			/* Check for another interrupt. */
			id = plasoc_int_get_id(obj);
		}
	}

#ifdef __cplusplus
}
#endif

#endif /* PLASOC_INT_H_ */
