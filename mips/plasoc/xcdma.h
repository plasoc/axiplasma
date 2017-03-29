/**
 * @author Andrew Powell
 * @date 17 March 2017
 * @brief Contains a simple driver for the Xilinx Central Direct Memory Access (XCdma) core. 
 *
 * Since this driver is mainly used to verify the axiplasma design, it is made to only run
 * simply transfers --- in other words, it assumes no Scatter Gather IO --- with interrupts. 
 * It also assumes CDMA Store and Foward is enabled.
 *
 * Please view the documentation for the Xilinx XCdma core for more information.
 */

#ifndef XCDMA_H_
#define XCDMA_H_

#ifdef __cplusplus
extern "C" 
{
#endif

	#define XCDMA_CDMACR_OFFSET				(0x00)
	#define XCDMA_CDMASR_OFFSET				(0x04)
	#define XCDMA_SA_OFFSET					(0x18)
	#define XCDMA_DA_OFFSET					(0x20)
	#define XCMDA_BTT_OFFSET				(0x28)
	
	#define XCDMA_CDMASR_ERR_IRQEN_BIT_LOC		(14)
	#define XCDMA_CDMASR_IOC_IRQEN_BIT_LOC		(12)
	#define XCDMA_CDMASR_RESET_BIT_LOC			(2)
	
	#define XCDMA_CDMASR_ERR_IRQ_BIT_LOC		(14)
	#define XCDMA_CDMASR_IOC_IRQ_BIT_LOC		(12)
	#define XCDMA_CDMASR_DMADECERR_BIT_LOC		(6)
	#define XCDMA_CDMASR_DMASLVERR_BIT_LOC		(5)
	#define XCDMA_CDMASR_IDLE_BIT_LOC			(1)
	
	typedef struct 
	{
		unsigned base_address;
		unsigned local_cdmasr;
	}
	xcdma;
	
	static inline __attribute__ ((always_inline))
	void xcdma_setup(xcdma* obj,unsigned base_address)
	{
		obj->base_address = base_address;
		obj->local_cdmasr = 0;
	}
	
	static inline __attribute__ ((always_inline))
	void xcdma_reset(xcdma* obj)
	{
		*((volatile unsigned*)(obj->base_address+XCDMA_CDMACR_OFFSET)) = (1<<XCDMA_CDMASR_RESET_BIT_LOC);
	}
	
	static inline __attribute__ ((always_inline))
	void xcdma_enable_ints(xcdma* obj,unsigned error_enable,unsigned completion_enable)
	{
		*((volatile unsigned*)(obj->base_address+XCDMA_CDMACR_OFFSET)) =
			(error_enable?(1<<XCDMA_CDMASR_ERR_IRQEN_BIT_LOC):0)|
			(completion_enable?(1<<XCDMA_CDMASR_IOC_IRQ_BIT_LOC):0);
	}
	
	static inline __attribute__ ((always_inline))
	void xcdma_load_status(xcdma* obj)
	{
		unsigned local_cdmasr;
		local_cdmasr = *((volatile unsigned*)(obj->base_address+XCDMA_CDMASR_OFFSET));
		obj->local_cdmasr = local_cdmasr;
	}
	
	static inline __attribute__ ((always_inline))
	unsigned xcdma_get_status(xcdma* obj)
	{
		return obj->local_cdmasr;
	}
	
	static inline __attribute__ ((always_inline))
	unsigned xcdma_check_status_error(xcdma* obj)
	{
		return obj->local_cdmasr&(1<<XCDMA_CDMASR_ERR_IRQ_BIT_LOC);
	}
	
	static inline __attribute__ ((always_inline))
	unsigned xcdma_check_status_completion(xcdma* obj)
	{
		return obj->local_cdmasr&(1<<XCDMA_CDMASR_IOC_IRQ_BIT_LOC);
	}
	
	static inline __attribute__ ((always_inline))
	unsigned xcdma_check_status_decode(xcdma* obj)
	{
		return obj->local_cdmasr&(1<<XCDMA_CDMASR_DMADECERR_BIT_LOC);
	}
	
	static inline __attribute__ ((always_inline))
	unsigned xcdma_check_status_slave(xcdma* obj)
	{
		return obj->local_cdmasr&(1<<XCDMA_CDMASR_DMASLVERR_BIT_LOC);
	}
	
	static inline __attribute__ ((always_inline))
	unsigned xcdma_check_status_idle(xcdma* obj)
	{
		return obj->local_cdmasr&(1<<XCDMA_CDMASR_IDLE_BIT_LOC);
	}
	
	static inline __attribute__ ((always_inline))
	void xcdma_acknowledge_status_error(xcdma* obj)
	{
		*((volatile unsigned*)(obj->base_address+XCDMA_CDMASR_OFFSET)) = (1<<XCDMA_CDMASR_ERR_IRQ_BIT_LOC);
	}
	
	static inline __attribute__ ((always_inline))
	void xcdma_acknowledge_status_completion(xcdma* obj)
	{
		*((volatile unsigned*)(obj->base_address+XCDMA_CDMASR_OFFSET)) = (1<<XCDMA_CDMASR_IOC_IRQ_BIT_LOC);
	}
	
	static inline __attribute__ ((always_inline))
	void xcdma_start_transfer(xcdma* obj,unsigned source_address,unsigned destination_address,unsigned bytes_to_transfer)
	{
		unsigned base_address = obj->base_address;
		*((volatile unsigned*)(base_address+XCDMA_SA_OFFSET)) = source_address;
		*((volatile unsigned*)(base_address+XCDMA_DA_OFFSET)) = destination_address;
		*((volatile unsigned*)(base_address+XCMDA_BTT_OFFSET)) = bytes_to_transfer;
	}
	

#ifdef __cplusplus
}
#endif

#endif /* XCDMA_H_ */
