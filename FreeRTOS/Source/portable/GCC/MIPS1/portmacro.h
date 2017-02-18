/*This file has been prepared for Doxygen automatic documentation generation.*/
/*! \file *********************************************************************
 *
 * \brief FreeRTOS port source for customized MIPS rev 1 architecture.
 *
 * - Compiler:			 GNU GCC for MIPS-1
 * - Supported devices:  https://github.com/andrewandrepowell/axiplasma
 *
 * \author				 Kaleb Barrett (Temple University 2017)
 *
 *****************************************************************************/


#ifndef PORTMACRO_H
#define PORTMACRO_H

#ifdef __cplusplus
extern "C" {
#endif

/* User includes */
#include "plasoc_cpu.h"
#include "plasoc_int.h"
#include "plasoc_timer.h"
#include "plasma.h"
#include "inttypes.h"

/* Type definitions. */
#define portCHAR		char
#define portFLOAT		float
#define portDOUBLE		double
#define portLONG		long
#define portSHORT		short
#define portSTACK_TYPE	uint32_t
#define portBASE_TYPE	int
#define portUBASE_TYPE	unsigned int

typedef uint32_t StackType_t;
typedef int32_t BaseType_t;
typedef uint32_t UBaseType_t;

#if( configUSE_16_BIT_TICKS == 1 )
	typedef uint16_t TickType_t;
	#define portMAX_DELAY ( TickType_t ) 0xffff
#else
	typedef uint32_t TickType_t;
	#define portMAX_DELAY ( TickType_t ) 0xffffffffUL
	#define portTICK_TYPE_IS_ATOMIC 1
#endif
/*-----------------------------------------------------------*/

/* Architecture specifics. */
#define portSTACK_GROWTH		( -1 )
#define portTICK_PERIOD_MS		( ( TickType_t ) 1000 / configTICK_RATE_HZ )
#define portBYTE_ALIGNMENT		1
#define portNOP()				{__asm__ __volatile__ ("nop");}
/*-----------------------------------------------------------*/

/*	Critical section management. */
#define portCRITICAL_NESTING_IN_TCB 1

#define portDISABLE_INTERRUPTS() \
	OS_AsmInterruptEnable(0);

#define portENABLE_INTERRUPTS()	\
	OS_AsmInterruptEnable(1);

// for enter and exit critical, use the given functions that allow for nesting
void vTaskEnterCritical(void);
#define portENTER_CRITICAL() \
	vTaskEnterCritical();

void vTaskExitCritical(void);
#define portEXIT_CRITICAL() \
	vTaskExitCritical();

__attribute__((always_inline)) static inline void portSAVE_CONTEXT(void)
{
	__asm__ __volatile__ (
		".set	noat											\n\t"
		".set	noreorder										\n\t"
		"addi	$29,	$29, -104	#adjust sp					\n\t"
		"sw		$1,		16($29)		#at							\n\t"
		"sw		$2,		20($29)		#v0							\n\t"
		"sw		$3,		24($29)		#v1							\n\t"
		"sw		$4,		28($29)		#a0							\n\t"
		"sw		$5,		32($29)		#a1							\n\t"
		"sw		$6,		36($29)		#a2							\n\t"
		"sw		$7,		40($29)		#a3							\n\t"
		"sw		$8,		44($29)		#t0							\n\t"
		"sw		$9,		48($29)		#t1							\n\t"
		"sw		$10,	52($29)		#t2							\n\t"
		"sw		$11,	56($29)		#t3							\n\t"
		"sw		$12,	60($29)		#t4							\n\t"
		"sw		$13,	64($29)		#t5							\n\t"
		"sw		$14,	68($29)		#t6							\n\t"
		"sw		$15,	72($29)		#t7							\n\t"
		"sw		$24,	76($29)		#t8							\n\t"
		"sw		$25,	80($29)		#t9							\n\t"
		"sw		$31,	84($29)		#lr							\n\t"
		"mfc0	$26,	$14			#C0_EPC=14 (Exception PC)	\n\t"
		"addi	$26,	$26, -4		#Backup one opcode			\n\t"
		"sw		$26,	88($29)		#pc							\n\t"
		"mfhi	$27												\n\t"
		"sw		$27,	92($29)		#hi							\n\t"
		"mflo	$27												\n\t"
		"sw		$27,	96($29)		#lo							\n\t"
		".set	reorder											\n\t"
		".set	at												"
		:
		:
		: "memory"
	);
}

__attribute__((always_inline)) static inline void portRESTORE_CONTEXT(void)
{
	__asm__ __volatile__ (
		".set	noat							\n\t"
		".set	noreorder						\n\t"
		"lw		$1,		16($29)		#at			\n\t"
		"lw		$2,		20($29)		#v0			\n\t"
		"lw		$3,		24($29)		#v1			\n\t"
		"lw		$4,		28($29)		#a0			\n\t"
		"lw		$5,		32($29)		#a1			\n\t"
		"lw		$6,		36($29)		#a2			\n\t"
		"lw		$7,		40($29)		#a3			\n\t"
		"lw		$8,		44($29)		#t0			\n\t"
		"lw		$9,		48($29)		#t1			\n\t"
		"lw		$10,	52($29)		#t2			\n\t"
		"lw		$11,	56($29)		#t3			\n\t"
		"lw		$12,	60($29)		#t4			\n\t"
		"lw		$13,	64($29)		#t5			\n\t"
		"lw		$14,	68($29)		#t6			\n\t"
		"lw		$15,	72($29)		#t7			\n\t"
		"lw		$24,	76($29)		#t8			\n\t"
		"lw		$25,	80($29)		#t9			\n\t"
		"lw		$31,	84($29)		#lr			\n\t"
		"lw		$26,	88($29)		#pc			\n\t"
		"lw		$27,	92($29)		#hi			\n\t"
		"mthi	$27								\n\t"
		"lw		$27,	96($29)		#lo			\n\t"
		"mtlo	$27								\n\t"
		"addi	$29, $29, 104		#adjust sp	\n\t"
		"jr		$26								\n\t"
		"nop									\n\t"
		".set	reorder							\n\t"
		".set	at								"
		:
		:
		: "memory"
	);
}

__attribute__((always_inline)) static inline void portSAVE_TASK_SP(void)
{
	__asm__ __volatile__ (
		".extern	pxCurrentTCB		\n\t"
		".set	noat					\n\t"
		".set	noreorder				\n\t"
		"la		$27,	pxCurrentTCB	\n\t"
		"sw		$29,	0($27)			\n\t"
		".set	reorder					\n\t"
		".set	at						"
	);

}

__attribute__((always_inline)) static inline void portLOAD_TASK_SP(void)
{
	__asm__ __volatile__ (
		".extern	pxCurrentTCB		\n\t"
		".set	noat					\n\t"
		".set	noreorder				\n\t"
		"la		$29,	pxCurrentTCB	\n\t"
		"lw		$29,	0($29)			\n\t"
		".set	reorder					\n\t"
		".set	at						"
	);
}

__attribute__((always_inline)) static inline void portYIELD(void)
{
	extern plasoc_timer timer_obj;
	extern BaseType_t xTaskIncrementTick(void);
	extern void vTaskSwitchContext(void);
	portSAVE_CONTEXT();
	portSAVE_TASK_SP();
	plasoc_timer_reload_start(&timer_obj,1);
	if( xTaskIncrementTick() != pdFALSE )
	{
		// A context switch is required
		vTaskSwitchContext();
	}
	portLOAD_TASK_SP();
	portRESTORE_CONTEXT();
}

/* Task function macros as described on the FreeRTOS.org WEB site. */
#define portTASK_FUNCTION_PROTO( vFunction, pvParameters ) void vFunction( void *pvParameters )
#define portTASK_FUNCTION( vFunction, pvParameters ) void vFunction( void *pvParameters )

void vAssertCalled(const char*, int);

#ifdef __cplusplus
}
#endif

#endif /* PORTMACRO_H */
