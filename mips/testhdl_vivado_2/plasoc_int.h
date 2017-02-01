#ifndef PLASOC_INT_H_
#define PLASOC_INT_H_

#ifdef __cplusplus
extern "C" 
{
#endif

	#define PLASOC_INT_INTERRUPT_TOTAL		(8)
	#define PLASOC_INT_INTERRUPT_MASK		((1<<PLASOC_INT_INTERRUPT_TOTAL)-1)	
	#define PLASOC_INT_ENABLES_OFFSET		(0)
	#define PLASOC_INT_ID_OFFSET			(4)
	#define PLASOC_INT_ACTIVE_OFFSET		(8)

	typedef void (plasoc_int_isr)(void*);

	typedef struct 
	{
		unsigned base_address;
		plasoc_int_isr* vector_table[PLASOC_INT_INTERRUPT_TOTAL];
		void* ptrs[PLASOC_INT_INTERRUPT_TOTAL];
	}
	plasoc_int;

	static inline __attribute__ ((always_inline))
	void plasoc_int_setup(plasoc_int* obj,unsigned base_address)
	{
		/* Store base address of interrupt controller.*/
		obj->base_address = base_address;

		/* Clear the vector table.*/
		{
			plasoc_int_isr** start=obj->vector_table;
			plasoc_int_isr** end=start+PLASOC_INT_INTERRUPT_TOTAL;
			while (start!=end)
				*(start++) = (plasoc_int_isr*)0;
		}		
	}

	static inline __attribute__ ((always_inline))
	void plasoc_int_set_enables(plasoc_int* obj,unsigned mask)
	{
		__asm__ __volatile__ ( "" : : : "memory");
		*((unsigned volatile*)(obj->base_address+PLASOC_INT_ENABLES_OFFSET)) = mask;
	}

	static inline __attribute__ ((always_inline))
	unsigned plasoc_int_get_enables(plasoc_int* obj)
	{
		return (unsigned)(*((unsigned volatile*)(obj->base_address+PLASOC_INT_ENABLES_OFFSET)));
	}

	static inline __attribute__ ((always_inline))
	unsigned plasoc_int_get_id(plasoc_int* obj)
	{
		return (unsigned)(*((unsigned volatile*)(obj->base_address+PLASOC_INT_ID_OFFSET)));
	}

	static inline __attribute__ ((always_inline))
	unsigned plasoc_int_get_active(plasoc_int* obj)
	{
		return (unsigned)(*((unsigned volatile*)(obj->base_address+PLASOC_INT_ACTIVE_OFFSET)));
	}

	static inline __attribute__ ((always_inline))
	void plasoc_int_enable_all(plasoc_int* obj)
	{
		__asm__ __volatile__ ( "" : : : "memory");
		*((unsigned volatile*)(obj->base_address+PLASOC_INT_ENABLES_OFFSET)) = PLASOC_INT_INTERRUPT_MASK;
	}

	static inline __attribute__ ((always_inline))
	void plasoc_int_disable_all(plasoc_int* obj)
	{
		__asm__ __volatile__ ( "" : : : "memory");
		*((unsigned volatile*)(obj->base_address+PLASOC_INT_ENABLES_OFFSET)) = 0;
	}

	static inline __attribute__ ((always_inline))
	void plasoc_int_enable(plasoc_int* obj,unsigned id)
	{
		__asm__ __volatile__ ( "" : : : "memory");
		*((unsigned volatile*)(obj->base_address+PLASOC_INT_ENABLES_OFFSET)) |= (1<<id);
	}

	static inline __attribute__ ((always_inline))
	void plasoc_int_disable(plasoc_int* obj,unsigned id)
	{
		__asm__ __volatile__ ( "" : : : "memory");
		*((unsigned volatile*)(obj->base_address+PLASOC_INT_ENABLES_OFFSET)) &= ~(1<<id);
	}

	static inline __attribute__ ((always_inline))
	void plasoc_int_attach_isr(plasoc_int* obj,unsigned id,plasoc_int_isr* isr,void* ptr)
	{
		obj->vector_table[id] = isr;
		obj->ptrs[id] = ptr;
	}

	static inline __attribute__ ((always_inline))
	void plasoc_int_detach_isr(plasoc_int* obj,unsigned id)
	{
		obj->vector_table[id] = (plasoc_int_isr*)0;
	}

	static inline __attribute__ ((always_inline))
	void plasoc_int_service_interrupts(plasoc_int* obj)
	{
		plasoc_int_isr** vector_table;
		void** ptrs;
		unsigned id;

		/* Get interrupt service routine information. */
		vector_table = obj->vector_table;
		ptrs = obj->ptrs;

		/* Acquire id of the active interrupt with the highest priority. */
		id = plasoc_int_get_id(obj);
		do 
		{
			/* Execute the corresponding service routine. */
			vector_table[id](ptrs[id]);

			/* Check for another interrupt. */
			id = plasoc_int_get_id(obj);

		/* Keep servicing interrupts until every interrupt has been serviced. */
		}
		while (id<PLASOC_INT_INTERRUPT_TOTAL);
	}

#ifdef __cplusplus
}
#endif

#endif /* PLASOC_INT_H_ */
