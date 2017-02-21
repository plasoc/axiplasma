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
extern "C" 
{
#endif

#include "plasoc_cpu.h"

#define portCHAR		char
#define portFLOAT		float
#define portDOUBLE		double
#define portLONG		long
#define portSHORT		short
#define portSTACK_TYPE		unsigned
#define portBASE_TYPE		int
#define portUBASE_TYPE		unsigned

typedef portSTACK_TYPE StackType_t;
typedef portBASE_TYPE BaseType_t;
typedef portUBASE_TYPE UBaseType_t;
typedef unsigned TickType_t;

#define portMAX_DELAY 			(( TickType_t ) 0xffffffffUL)
#define portTICK_TYPE_IS_ATOMIC 	(1)

#define portSTACK_GROWTH		(-1)
#define portTICK_PERIOD_MS		((TickType_t)1000/configTICK_RATE_HZ)
#define portBYTE_ALIGNMENT		(4)
#define portNOP()			{__asm__ __volatile__ ("nop":::"memory");}

#define portCRITICAL_NESTING_IN_TCB	(1)
#define portENTER_CRITICAL()		{vTaskEnterCritical();}
#define portEXIT_CRITICAL()		{vTaskExitCritical();}
#define portYIELD()			{OS_Syscall();}

#define portDISABLE_INTERRUPTS()	{FreeRTOS_DisableInterrupts();}
#define portENABLE_INTERRUPTS()		{FreeRTOS_EnableInterrupts();}	

#define portTASK_FUNCTION_PROTO( vFunction, pvParameters ) 	void vFunction( void *pvParameters )
#define portTASK_FUNCTION( vFunction, pvParameters ) 		void vFunction( void *pvParameters )

void vTaskEnterCritical( void );
void vTaskExitCritical( void );
void vAssertCalled(const char*, int);
void FreeRTOS_EnableInterrupts();
void FreeRTOS_DisableInterrupts();

#ifdef __cplusplus
}
#endif

#endif /* PORTMACRO_H */
