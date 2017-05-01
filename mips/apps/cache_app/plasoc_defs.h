#ifndef PLASOC_DEFS_H_
#define PLASOC_DEFS_H_

/* L1 cache definitions. See plasoc_pac.vhd for more information on these hardware definitions. */
#define L1_CACHE_OFFSET_WIDTH				(4)				
#define L1_CACHE_OFFSET_MASK				((1<<L1_CACHE_OFFSET_WIDTH)-1)	
#define L1_CACHE_ADDRESS_WIDTH				(29)				
#define L1_CACHE_NONCACHEABLE_BASE_ADDRESS		(1<<L1_CACHE_ADDRESS_WIDTH)	
#define L1_CACHE_ADDRESS_BASE				(0xffffff00)			
#define L1_CACHE_INVALIDATE_OFFSET			(0)				
#define L1_CACHE_FLUSH_OFFSET				(4)	

#endif /* PLASOC_DEFS_H_ */