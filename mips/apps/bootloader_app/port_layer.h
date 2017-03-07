#ifndef PORT_LAYER_H_
#define PORT_LAYER_H_

#ifdef __cplusplus
extern "C" 
{
#endif

	#include "plasoc_cpu.h"

	void initialize(void (*run)(void));
	void setbyte(unsigned byte);
	unsigned getbyte();
	void setword(unsigned word);
	unsigned getword();
	void cleanup();

#ifdef __cplusplus
}
#endif

#endif /* PORT_LAYER_H_ */
