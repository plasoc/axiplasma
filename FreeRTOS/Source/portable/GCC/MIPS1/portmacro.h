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

#define portSAVE_CONTEXT()							\
	__asm__ __volatile__ (							\
"	addi  $29, $29, -104  #adjust sp				\n"\
"	sw    $1,  16($29)    #at						\n"\
"	sw    $2,  20($29)    #v0						\n"\
"	sw    $3,  24($29)    #v1						\n"\
"	sw    $4,  28($29)    #a0						\n"\
"	sw    $5,  32($29)    #a1						\n"\
"	sw    $6,  36($29)    #a2						\n"\
"	sw    $7,  40($29)    #a3						\n"\
"	sw    $8,  44($29)    #t0						\n"\
"	sw    $9,  48($29)    #t1						\n"\
"	sw    $10, 52($29)    #t2						\n"\
"	sw    $11, 56($29)    #t3						\n"\
"	sw    $12, 60($29)    #t4						\n"\
"	sw    $13, 64($29)    #t5						\n"\
"	sw    $14, 68($29)    #t6						\n"\
"	sw    $15, 72($29)    #t7						\n"\
"	sw    $24, 76($29)    #t8						\n"\
"	sw    $25, 80($29)    #t9						\n"\
"	sw    $31, 84($29)    #lr						\n"\
"	mfc0  $26, $14        #C0_EPC=14 (Exception PC)	\n"\
"	addi  $26, $26, -4    #Backup one opcode		\n"\
"	sw    $26, 88($29)    #pc						\n"\
"	mfhi  $27										\n"\
"	sw    $27, 92($29)    #hi						\n"\
"	mflo  $27										\n"\
"	sw    $27, 96($29)    #lo						\n"\
	:												\
	:												\
	: "memory"										\
	);

#define portRESTORE_CONTEXT()			\
	__asm__ __volatile__ (				\
"	lw    $1,  16($29)    #at			\n"\
"	lw    $2,  20($29)    #v0			\n"\
"	lw    $3,  24($29)    #v1			\n"\
"	lw    $4,  28($29)    #a0			\n"\
"	lw    $5,  32($29)    #a1			\n"\
"	lw    $6,  36($29)    #a2			\n"\
"	lw    $7,  40($29)    #a3			\n"\
"	lw    $8,  44($29)    #t0			\n"\
"	lw    $9,  48($29)    #t1			\n"\
"	lw    $10, 52($29)    #t2			\n"\
"	lw    $11, 56($29)    #t3			\n"\
"	lw    $12, 60($29)    #t4			\n"\
"	lw    $13, 64($29)    #t5			\n"\
"	lw    $14, 68($29)    #t6			\n"\
"	lw    $15, 72($29)    #t7			\n"\
"	lw    $24, 76($29)    #t8			\n"\
"	lw    $25, 80($29)    #t9			\n"\
"	lw    $31, 84($29)    #lr			\n"\
"	lw    $26, 88($29)    #pc			\n"\
"	lw    $27, 92($29)    #hi			\n"\
"	mthi  $27							\n"\
"	lw    $27, 96($29)    #lo			\n"\
"	mtlo  $27							\n"\
"	addi  $29, $29, 104   #adjust sp	\n"\
	:									\
	:									\
	: "memory"							\
	);

/*	Critical section management. */
#define portCRITICAL_NESTING_IN_TCB 1

#define portDISABLE_INTERRUPTS() \
	OS_AsmInterruptEnable(0);

#define portENABLE_INTERRUPTS()	\
	OS_AsmInterruptEnable(1);

void vTaskEnterCritical(void);
#define portENTER_CRITICAL() \
	vTaskEnterCritical();

void vTaskExitCritical(void);
#define portEXIT_CRITICAL() \
	vTaskExitCritical();
	
#define portYIELD() \
	portENTER_CRITICAL(); \
	vTaskSwitchContext(); \
	portEXIT_CRITICAL();

/* Task function macros as described on the FreeRTOS.org WEB site. */
#define portTASK_FUNCTION_PROTO( vFunction, pvParameters ) void vFunction( void *pvParameters )
#define portTASK_FUNCTION( vFunction, pvParameters ) void vFunction( void *pvParameters )

void vAssertCalled(const char*, int);

#ifdef __cplusplus
}
#endif

#endif /* PORTMACRO_H */
