/*--------------------------------------------------------------------
 * TITLE: Plasma-SoC Baseline Processor  Hardware Defines
 * AUTHOR: Andrew Powell (andrewandrepowell2@gmail.com)
 * DATE CREATED: 01/18/17
 * FILENAME: plasmasoc.h
 * PROJECT: Plasma-SoC Baseline Processor (extension of the Plasma CPU project)
 * COPYRIGHT: Software placed into the public domain by the author.
 *    Software 'as is' without warranty.  Author liable for nothing.
 * DESCRIPTION:
 *--------------------------------------------------------------------*/

#ifndef PLASMA_SOC_H_
#define PLASMA_SOC_H_

#define CACHE_OFFSET_WIDTH			(4)
#define CACHE_OFFSET_MASK			((1<<CACHE_OFFSET_WIDTH)-1)
#define CACHE_ADDRESS_BASE			(0x10000000)
#define CACHE_INVALIDATE_OFFSET			(0)
#define CACHE_FLUSH_OFFSET			(4)
#define CACHE_OPERATE_ON_LINE(oper_offset,addr) \
	{ \
		asm volatile ( \
			"sw $0, 0(%0)\n" /* Write cache control base + offset. */ \
			"sw $0, 0(%1)\n" /* Write selected tag and index. */ \
			: \
			: "r" (CACHE_ADDRESS_BASE+(oper_offset)), "r" ((addr)&~CACHE_OFFSET_MASK) \
			: "memory" ); \
	}
#define CACHE_INVALIDATE(addr)			(CACHE_OPERATE_ON_LINE(CACHE_INVALIDATE_OFFSET,(addr)))
#define CACHE_FLUSH(addr)			(CACHE_OPERATE_ON_LINE(CACHE_FLUSH_OFFSET,(addr)))

#endif
