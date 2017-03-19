# Plasma AXI-based System-on-Chip 

The **Plasma AXI-based System-on-Chip (Plasma-SoC)** is an extension of *Steve Rhoads' Plasma MLite Core*, a processor that implements MIPS I with a small subset of Coprocessor 0 in order to provide limited support for interrupts and system calls. As its name implies, the cores of the Plasma-SoC relies on *ARM AMBA4 Advanced eXtensible Interfaces (AXI)* for communication over a configurable AXI4-Full Crossbar Interconnect.

The major hardware components of the Plasma-SoC consist of a *CPU*, *Timer*, *Interrupt Controller*, *GPIO*, *UART*, *Interconnect*, and an example design created to run on the Digilent Nexys4 board. The software includes *hardware drivers*, *FreeRTOS port*, *ICSP bootloader*, *Threadmetric Benchmark port*, and several other examples to test and demonstrate the hardware's functionality. There are also several utility programs not intended to run on the hardware.

## Getting Started

### File Structure

Take note of the Plasma-SoC's file structure shown below. For the sake of brevity, many of the sources are omitted from the structure. However, understand that the files not shown are still needed. Please see the sources themselves for more information.

+ hdl --- All the VHDL hardware sources. 
   + plasma --- Steve Rhoads' Plasma MLite Core.
   + plasoc --- Plasma-SoC cores, such as peripherals and interconnect. 
   + projects --- RTL examples.
      + Nexys4 --- Project developed specifically for the Digilent Nexys4 Artix-7 board.
+ mips --- All the C/MIPs sources, including applications, drivers, and operating system.
   + apps --- Application that can run on the Plasma-SoC.
      + bootloader_app --- Currently supports loading an application into memory with in-circuit serial programming (ICSP).
      + cache_app --- Tests the operations of the CPU's L1 cache.
      + freertos_app --- Runs a FreeRTOS example.
      + threadmetric_apps --- Contains several applications needed to generate benchmarks for the Plasma-SoC FreeRTOS port with ThreadMetric.
      + timer\_interrupt\_app --- Tests the Time Core. 
      + uart_app --- Tests the UART Core.
   + freertos --- FreeRTOS port for the Plasma-SoC.
   + plasma --- Sources related to Steve Rhoads' Plasma MLite Core. Note that boot source was modified for the purposes of the Plasma-SoC.
   + plasoc --- Sources needed for the Plasma-SoC. The drivers for the peripherals are located under this directory.
+ misc --- All the utility programs.
   + bin2coe.py
   + gencross.py
   + icsp.py

The applications located in the "mips/apps" and "hdl/projects/Nexys4" directories all depend on Makefiles in order to perform certain operations.

### Prerequisites

+ Msys/Windows or Linux ---
   + Cross compilation tools ---
+ Vivado ---

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






