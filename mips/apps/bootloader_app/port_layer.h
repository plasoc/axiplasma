/**
 * @author Andrew Powell
 * @date March 18, 2017
 * @brief Contains the interface of the 
 * port layer needed to perform functions while abstracting the 
 * low level details.
 */

#ifndef PORT_LAYER_H_
#define PORT_LAYER_H_

#ifdef __cplusplus
extern "C" 
{
#endif

	#include "plasoc_cpu.h"

	/**
	 * @brief Initializes and configures the necessary hardware.
	 * @param run Pointer to the function that runs the main application. In other words, the port layer is given
	 * control on when the application gets to execute.
	 */
	void initialize(void (*run)(void));

	/**
	 * @brief Writes a byte.
	 * @param byte The output data. The data should be the least significant byte.
	 */
	void setbyte(unsigned byte);

	/**
	 * @brief Receives a byte.
	 * @return The input data. The data should be the least significant byte.
	 */
	unsigned getbyte();

	/**
	 * @brief Writes a word.
	 * @param The output data.
	 */
	void setword(unsigned word);

	/**
	 * @brief Receives a word.
	 * @return The input data. */
	unsigned getword();

	/**
	 * @brief When necessary, the function should be called to perform cleanup of resources. 
	 *
	 * In many cases, the initialize could simply perform the necessary cleanup without having to
	 * rely on a call to the cleanup function within the run function. However, in cases for which
	 * the run function needs to exit in an unconventional way, the cleanup may be needed to ensure
	 * proper cleanup is done.
	 */
	void cleanup();

#ifdef __cplusplus
}
#endif

#endif /* PORT_LAYER_H_ */
