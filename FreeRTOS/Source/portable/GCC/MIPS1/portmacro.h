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
#include "plasmasoc.h"

/* Scheduler includes. */
#include "FreeRTOS.h"
#include "task.h"

/* Type definitions. */
#define portCHAR		char
#define portFLOAT		float
#define portDOUBLE		double
#define portLONG		long
#define portSHORT		short
#define portSTACK_TYPE	uint32_t
#define portBASE_TYPE	int32_t
#define portUBASE_TYPE	uint32_t

typedef portSTACK_TYPE StackType_t;
typedef portBASE_TYPE BaseType_t;
typedef portUBASE_TYPE UBaseType_t;

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

extern void vTaskEnterCritical(void);
#define portENTER_CRITICAL() \
	vTaskEnterCritical();

extern void vTaskExitCritical(void);
#define portEXIT_CRITICAL() \
	vTaskExitCritical();
	
#define portYIELD() \
	portENTER_CRITICAL(); \
	vTaskSwitchContext(); \
	portEXIT_CRITICAL();

/* Task function macros as described on the FreeRTOS.org WEB site. */
#define portTASK_FUNCTION_PROTO( vFunction, pvParameters ) void vFunction( void *pvParameters )
#define portTASK_FUNCTION( vFunction, pvParameters ) void vFunction( void *pvParameters )

#ifdef __cplusplus
}
#endif

#endif /* PORTMACRO_H */
