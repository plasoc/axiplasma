/**
 * @author Andrew Powell
 * @date 18 January 2017
 * @brief Contains hardware definitions and drivers for the Plasma-SoC.
 */

#ifndef PLASMA_SOC_H_
#define PLASMA_SOC_H_

#ifdef __cplusplus
extern "C" 
{
#endif

	/* L1 cache definitions. */
	#define L1_CACHE_OFFSET_WIDTH			(5)				
	#define L1_CACHE_OFFSET_MASK			((1<<L1_CACHE_OFFSET_WIDTH)-1)	
	#define L1_CACHE_ADDRESS_WIDTH			(12)				
	#define L1_CACHE_NONCACHEABLE_BASE_ADDRESS	(1<<L1_CACHE_ADDRESS_WIDTH)	
	#define L1_CACHE_ADDRESS_BASE			(0x10000000)			
	#define L1_CACHE_INVALIDATE_OFFSET		(0)				
	#define L1_CACHE_FLUSH_OFFSET			(4)				

	/**
	 * @brief Performs L1 cache operation.
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
	 * @param addr The address on which the operation is performed. 
	 */
	static inline __attribute__ ((always_inline))
	void l1_cache_invalidate(unsigned addr)
	{
		l1_cache_operate_on_line(L1_CACHE_INVALIDATE_OFFSET,addr);
	}

	/**
	 * @brief Performs L1 cache flushing operation.
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

#ifdef __cplusplus
}
#endif

#endif /* PLASMA_SOC_H_ */
