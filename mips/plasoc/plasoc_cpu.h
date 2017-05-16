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
	 * @brief Enters a critical section defined by disabling the L1 cache.
	 *
	 * Can be used with leave_critical to form atomic operations.
	 *
	 * @return Returns the interrupt status mask which can be used to leave
	 * the critical section with the leave_critical function.
	 */
	static inline __attribute__ ((always_inline))
	unsigned enter_critical()
	{
		register unsigned int_mask;
		__asm__ __volatile__ (
			"mfc0 %0,$12\n" 
			"mtc0 $0,$12\n"
			:"=r"(int_mask)::"memory");
		return int_mask;
	}
	
	/**
	 * @brief Leaves a critical section defined by possibly enabling the L1 cache.
	 *
	 * Can be used with leave_critical to form atomic operations.
	 *
	 * @param int_mask The interrupt status mask is returned by the enter_critical function.
	 */
	static inline __attribute__ ((always_inline))
	void leave_critical(register unsigned int_mask)
	{
		__asm__ __volatile__ (
			"mtc0 %0,$12\n"
			::"r"(int_mask):"memory");
	}

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
	 * @brief Performs L1 cache operation.
	 * @warning NOT ATOMIC.
	 * @param oper_offset Can either be L1_CACHE_INVALIDATE_WAY_OFFSET for invalidation 
	 * or L1_CACHE_FLUSH_WAY_OFFSET for flushing.
	 * @param way The line within the row on which the operation is performed.
	 * @param index The row on which the operation is performed.
	 */
	static inline __attribute__ ((always_inline))
	void l1_cache_operate_way_on_line(unsigned oper_offset,unsigned way,unsigned index)
	{
		l1_cache_operate_on_line(oper_offset,
			(way<<(L1_CACHE_OFFSET_WIDTH+L1_CACHE_INDEX_WIDTH))|
			(index<<L1_CACHE_OFFSET_WIDTH));
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
	 * @brief Performs L1 cache invalidation operation.
	 * @warning NOT ATOMIC.
	 * @param way The line within the row on which the operation is performed.
	 * @param index The row on which the operation is performed.
	 */
	static inline __attribute__ ((always_inline))
	void l1_cache_invalidate_way(unsigned way,unsigned index)
	{
		l1_cache_operate_way_on_line(L1_CACHE_INVALIDATE_WAY_OFFSET,way,index);
	}
	
	/**
	 * @brief Performs L1 cache flushing operation.
	 * @warning NOT ATOMIC.
	 * @param way The line within the row on which the operation is performed.
	 * @param index The row on which the operation is performed. 
	 */
	static inline __attribute__ ((always_inline))
	void l1_cache_flush_way(unsigned way,unsigned index)
	{
		l1_cache_operate_way_on_line(L1_CACHE_FLUSH_WAY_OFFSET,way,index);
	}

	/**
	 * @brief Performs L1 cache operation over a range of addresses.
	 * @param oper_offset Can either be L1_CACHE_INVALIDATE_OFFSET for invalidation or L1_CACHE_FLUSH_OFFSET for flushing.
	 * @param addr The address on which the operation is performed. 
	 * @param size The number of bytes over which the operation is performed.
	 */
	__attribute__ ((optimize("O3")))
	void l1_cache_operate_on_line_range(unsigned oper_offset, unsigned addr, unsigned size);

	/**
	 * @brief Performs L1 cache invalidation operation over a range of addresses.
	 * @param addr The address on which the operation is performed. 
	 * @param size The number of bytes over which the operation is performed.
	 */
	static inline __attribute__ ((always_inline))
	void l1_cache_invalidate_range(unsigned addr, unsigned size)
	{
		l1_cache_operate_on_line_range(L1_CACHE_INVALIDATE_OFFSET,addr,size);
	}

	/**
	 * @brief Performs L1 cache flushing operation over a range of addresses.
	 * @param addr The address on which the operation is performed. 
	 * @param size The number of bytes over which the operation is performed.
	 */
	static inline __attribute__ ((always_inline))
	void l1_cache_flush_range(unsigned addr, unsigned size)
	{
		l1_cache_operate_on_line_range(L1_CACHE_FLUSH_OFFSET,addr,size);
	}
	
	/**
	 * @brief Performs L1 cache operation over entire cache.
	 * @param oper_offset Can either be L1_CACHE_INVALIDATE_WAY_OFFSET for invalidation or L1_CACHE_FLUSH_WAY_OFFSET for flushing.
	 * @warning Invalidating the entire cache is actually a dangerous operation, since both data and instructions
	 * share the same memory space. Specifically, if a portion of the CPU's stack is stored in cache, invalidation
	 * can potentially corrupt the stack with invalid instructions. In fact, the O3 optimization is needed to ensure
	 * the cache operation doesn't depend on the stack in order to run. Avoiding this issue can be done by either flushing
	 * the cache so that at least the stack is flushed or calling the safer l1_cache_memory_barrier function.
	 */
	__attribute__ ((optimize("O3")))
	void l1_cache_operate_on_line_all(unsigned oper_offset);

	/**
	 * @brief Performs L1 cache invalidation operation over entire cache.
	 * @warning Invalidating the entire cache is actually a dangerous operation, since both data and instructions
	 * share the same memory space. Specifically, if a portion of the CPU's stack is stored in cache, invalidation
	 * can potentially corrupt the stack with invalid instructions. In fact, the O3 optimization is needed to ensure
	 * the cache operation doesn't depend on the stack in order to run. Avoiding this issue can be done by either flushing
	 * the cache so that at least the stack is flushed or calling the safer l1_cache_memory_barrier function.
	 */
	static inline __attribute__ ((always_inline))
	void l1_cache_invalidate_all()
	{
		l1_cache_operate_on_line_all(L1_CACHE_INVALIDATE_WAY_OFFSET);
	}
	
	/**
	 * @brief Performs L1 cache flushing operation over entire cache.
	 */
	static inline __attribute__ ((always_inline))
	void l1_cache_flush_all()
	{
		l1_cache_operate_on_line_all(L1_CACHE_FLUSH_WAY_OFFSET);
	}
	
	/**
	 * @brief Performs the memory barrier operation.
	 *
	 * This operation is mainly intended for applications in which a consistent view of the same memory space is needed
	 * among multiple hardware components. For instance, if there are multiple CPUs that require shared access to the same
	 * memory space, memory barriers can be applied so that each CPU can have a consistent view of the memory. However,
	 * this particular implementation of the memory barrier operation is costly since it's currently implemented in
	 * software.
	 *
	 * This memory barrier is an atomic coarse-grained operation in which the cache is first fully flushed and then fully 
	 * invalidated.
	 */
	__attribute__ ((optimize("O3")))
	void l1_cache_memory_barrier();

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
