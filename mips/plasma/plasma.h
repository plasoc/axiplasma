/*--------------------------------------------------------------------
 * TITLE: Plasma Hardware Defines
 * AUTHOR: Steve Rhoads (rhoadss@yahoo.com)
 * DATE CREATED: 12/17/05
 * FILENAME: plasma.h
 * PROJECT: Plasma CPU core
 * COPYRIGHT: Software placed into the public domain by the author.
 *    Software 'as is' without warranty.  Author liable for nothing.
 * DESCRIPTION:
 *    Plasma Hardware Defines
 *--------------------------------------------------------------------*/
#ifndef __PLASMA_H__
#define __PLASMA_H__

#include "inttypes.h"

#define PLASMA_HZ 50000000

extern uint32_t OS_AsmInterruptEnable(uint32_t);
extern void OS_InterruptServiceRoutine(void);
extern void OS_AsmInterruptInit(void);
extern uint32_t OS_AsmMult(uint32_t a, uint32_t b);
// extern void OS_Syscall(void); Declaration correct? or even necessary?

typedef uint32_t jmp_buf[12];

extern int setjmp(jmp_buf env);
extern void longjmp(jmp_buf env, int value);

#endif //__PLASMA_H__

