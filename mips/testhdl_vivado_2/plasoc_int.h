#ifndef PLASOC_INT_H_
#define PLASOC_INT_H_

#ifdef __cplusplus
extern "C" 
{
#endif

	#define PLASOC_INT_INTERRUPT_TOTAL		(8)
	#define PLASOC_INT_ENABLES_OFFSET		(0)
	#define PLASOC_INT_ID_OFFSET			(4)

	typedef void (plasoc_int_isr)(void*);

	typedef struct 
	{
		unsigned base_address;
		plasoc_int_isr* vector_table[PLASOC_INT_INTERRUPT_TOTAL];
	}
	plasoc_int;

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

	void plasoc_int_set_enables(plasoc_int* obj,unsigned mask)
	{
		*((unsigned volatile*)(obj->base_address+PLASOC_INT_ENABLES_OFFSET)) = mask;
	}

	unsigned plasoc_int_get_enables(plasoc_int* obj)
	{
		return (unsigned)(*((unsigned volatile*)(obj->base_address+PLASOC_INT_ENABLES_OFFSET)));
	}

	unsigned plasoc_int_get_id(plasoc_int* obj)
	{
		return (unsigned)(*((unsigned volatile*)(obj->base_address+PLASOC_INT_ID_OFFSET)));
	}

	void plasoc_int_enable(plasoc_int* obj,unsigned id)
	{
		
	}

	void plasoc_int_attach_isr(plasoc_int* obj,unsigned id,plasoc_int_isr* isr)
	{
		obj->vector_table[id] = isr;
	}

	void plasoc_int_detach_isr(plasoc_int* obj,unsigned id)
	{
		obj->vector_table[id] = (plasoc_int_isr*)0;
	}

	void plasoc_int_callback(plasoc_int* obj)
	{
	}

#ifdef __cplusplus
}
#endif

#endif /* PLASOC_INT_H_ */
