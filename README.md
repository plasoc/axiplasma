# Plasma AXI-based System-on-Chip 

The **Plasma AXI-based System-on-Chip (Plasma-SoC)** is an extension of *Steve Rhoads' Plasma MLite Core*, a processor that implements MIPS I with a small subset of Coprocessor 0 in order to provide limited support for interrupts and system calls. As its name implies, the cores of the Plasma-SoC relies on *ARM AMBA4 Advanced eXtensible Interfaces (AXI)* for communication over a configurable AXI4-Full Crossbar Interconnect.

The major hardware components of the Plasma-SoC consist of a *CPU*, *Timer*, *Interrupt Controller*, *GPIO*, *UART*, *Interconnect*, and an example design created to run on the Digilent Nexys4 board. The software includes *hardware drivers*, *FreeRTOS port*, *ICSP bootloader*, *Threadmetric Benchmark port*, and several other examples to test and demonstrate the hardware's functionality. Additionally, there are several python utility programs intended to run on the host computer.

## Getting Started

### File Structure

+hdl
..+plasma
..+plasoc
..+projects
....+Nexys4
+mips
..+apps
....+bootloader_app
....+cache_app
....+freertos_app
....+threadmetric+apps
....+timer\_interrupt\_app
....+uart_app
..+freertos
..+plasma
..+plasoc
+misc

### Prerequisites

### Installing

## Simulations

## Deployment

## License

## Acknowledgments

[Kaleb Barrett's MIPS GCC Cross Compiler Makefile](https://github.com/ktbarrett/gcc-cross)

[Steve Rhoads' Plasma Core](https://opencores.org/project,plasma)

[Peter Bennett's UART Core](https://github.com/pabennett/uart)

[Real Time Engineer's FreeRTOS](http://www.freertos.org/)

[Express Logic's ThreadMetric Download](http://rtos.com/DownloadCenter/Thread-MetricForm.php)

[AMBA4 AXI Specification](http://www.gstitt.ece.ufl.edu/courses/fall15/eel4720_5721/labs/refs/AXI4_specification.pdf)

## Contact Information






