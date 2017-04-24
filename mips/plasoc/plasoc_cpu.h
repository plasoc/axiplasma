/**
 * @author Andrew Powell
 * @date January 18, 2017
 * @brief Contains hardware definitions and drivers for the Plasma-SoC's CPU.
 */

#ifndef PLASOC_CPU_H_
#define PLASOC_CPU_H_

#include "plasma.h"
#include "plasoc_defs.h"

#ifdef __cplusplus
extern "C" 
{
#endif

	/**
	 * @brief Performs L1 cache operation.
	 * @warning NOT ATOMIC.
	 * @param oper_offset Can either be L1_CACHE_INVALIDATE_OFFSET for invalidation or L1_CACHE_FLUSH_OFFSET for flushing.
	 * @param addr The address on which the operation is performed. 
	 */
	static inline __attribute__ ((always_inline))
	void l1_cache_operate_on_line(unsigned oper_offset,unsigned addr)
	{
		__asm__ __volatile__ ( 
			"sw %1, 0(%0)\n" /* Write selected tag and index to cache control base + offset. */ 
			"sw $0, 0(%1)\n" /* Perform memory access to initiate cache operation. */ 
			: 
			: "r" (L1_CACHE_ADDRESS_BASE+oper_offset), "r" (((unsigned)addr)&~L1_CACHE_OFFSET_MASK) 
			: "memory" ); 
	}

	/**
	 * @brief Performs L1 cache invalidation operation.
	 * @warning NOT ATOMIC.
	 * @param addr The address on which the operation is performed. 
	 */
	static inline __attribute__ ((always_inline))
	void l1_cache_invalidate(unsigned addr)
	{
		l1_cache_operate_on_line(L1_CACHE_INVALIDATE_OFFSET,addr);
	}

	/**
	 * @brief Performs L1 cache flushing operation.
	 * @warning NOT ATOMIC.
	 * @param addr The address on which the operation is performed. 
	 */
	static inline __attribute__ ((always_inline))
	void l1_cache_flush(unsigned addr)
	{
		l1_cache_operate_on_line(L1_CACHE_FLUSH_OFFSET,addr);
	}

	/**
	 * @brief Performs L1 cache operation over a range of addresses.
	 * @param oper_offset Can either be L1_CACHE_INVALIDATE_OFFSET for invalidation or L1_CACHE_FLUSH_OFFSET for flushing.
	 * @param addr The address on which the operation is performed. 
	 * @param size The number of bytes over which the operation is performed.
	 */
	void l1_cache_operate_on_line_range(unsigned oper_offset, unsigned addr, unsigned size);

	/**
	 * @brief Performs L1 cache invalidation operation over a range of addresses.\
	 * @param addr The address on which the operation is performed. 
	 * @param size The number of bytes over which the operation is performed.
	 */
	static inline __attribute__ ((always_inline))
	void l1_cache_invalidate_range(unsigned addr, unsigned size)
	{
		l1_cache_operate_on_line_range(L1_CACHE_INVALIDATE_OFFSET,addr,size);
	}

	/**
	 * @brief Performs L1 cache flushing operation over a range of addresses.\
	 * @param addr The address on which the operation is performed. 
	 * @param size The number of bytes over which the operation is performed.
	 */
	static inline __attribute__ ((always_inline))
	void l1_cache_flush_range(unsigned addr, unsigned size)
	{
		l1_cache_operate_on_line_range(L1_CACHE_FLUSH_OFFSET,addr,size);
	}

	/**
	 * @brief Enables and disables the CPU's interrupt.
	 *
	 * Please note that the definition of this function can be found in /mips/plasma/boot.asm.
	 *
	 * @param enable A value of 1 sets the interrupt, whereas a value of 0 disables the interrupt.
	 * @return Returns the previous value of coprocessor 0 status register.
	 */
	extern unsigned OS_AsmInterruptEnable(unsigned enable);
	
	/**
	 * @brief Initiates a system call.
	 *
	 * Please note that the definition of this function can be found in /mips/plasma/boot.asm.
	 */
	extern void OS_Syscall();
	
	/**
	 * @brief Patches the instructions located at 0x3c such that the function 
	 * interrupt_service_routine is called from the correct location.
	 *
	 * It should be understood that when an external interrupt of a system call occurs,
	 * one of the critical operations is that the program counter is set to 0x3c, where the
	 * expected service routine should be located. However, because the application can
	 * be located at a different base address, the service routine --- which is the
	 * interrupt_service_routine --- will not be located at 0x3c. OS_AsmInterruptInit 
	 * corrects this inconsistency by writing new instructions at 0x3c. These new instructions
	 * perform a jump to where the service routine is actually located.
	 *
	 * Please note that the definition of this function can be found in /mips/plasma/boot.asm.
	 */
	extern void OS_AsmInterruptInit();

#ifdef __cplusplus
}
#endif

#endif /* PLASOC_CPU_H_ */
