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

#define PLASMA_HZ 50000000

typedef int jmp_buf[12];

void OS_AsmInterruptEnable(int);
int setjmp(jmp_buf env);
void longjmp(jmp_buf env, int value);
// there are other functions in boot.asm, but we don't need them

#endif //__PLASMA_H__

