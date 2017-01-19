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

#define L1_CACHE_OFFSET_WIDTH			(4)
#define L1_CACHE_OFFSET_MASK			((1<<L1_CACHE_OFFSET_WIDTH)-1)
#define L1_CACHE_ADDRESS_BASE			(0x10000000)
#define L1_CACHE_INVALIDATE_OFFSET		(0)
#define L1_CACHE_FLUSH_OFFSET			(4)

static inline __attribute__ ((always_inline))
void l1_cache_operate_on_line(unsigned oper_offset,unsigned addr)
{
	__asm__ __volatile__ ( 
		"sw $0, 0(%0)\n" /* Write cache control base + offset. */ 
		"sw $0, 0(%1)\n" /* Write selected tag and index. */ 
		: 
		: "r" (L1_CACHE_ADDRESS_BASE+oper_offset), "r" (((unsigned)addr)&~L1_CACHE_OFFSET_MASK) 
		: "memory" ); 
}

static inline __attribute__ ((always_inline))
void l1_cache_invalidate(unsigned addr)
{
	l1_cache_operate_on_line(L1_CACHE_INVALIDATE_OFFSET,addr);
}

static inline __attribute__ ((always_inline))
void l1_cache_flush(unsigned addr)
{
	l1_cache_operate_on_line(L1_CACHE_FLUSH_OFFSET,addr);
}

void l1_cache_operate_on_line_range(void (*oper)(unsigned), unsigned addr, unsigned size);

static inline __attribute__ ((always_inline))
void l1_cache_invalidate_range(unsigned addr, unsigned size)
{
	l1_cache_operate_on_line_range(l1_cache_invalidate,addr,size);
}

static inline __attribute__ ((always_inline))
void l1_cache_flush_range(unsigned addr, unsigned size)
{
	l1_cache_operate_on_line_range(l1_cache_flush,addr,size);
}

#endif
