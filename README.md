# Plasma AXI-based System-on-Chip 

The **Plasma AXI-based System-on-Chip (Plasma-SoC)** is an extension of *[Steve Rhoads' Plasma MLite Core](https://opencores.org/project,plasma)*, a processor that implements MIPS I with a small subset of Coprocessor 0 in order to provide limited support for interrupts and system calls. As its name implies, the cores of the Plasma-SoC relies on *ARM AMBA4 Advanced eXtensible Interfaces (AXI)* for communication over a configurable AXI4-Full Crossbar Interconnect.

The major hardware components of the Plasma-SoC consist of a *CPU*, *Timer*, *Interrupt Controller*, *GPIO*, *UART*, *Interconnect*, and an example design created to run on the Digilent Nexys4 board. The software includes *hardware drivers*, *FreeRTOS port*, *ICSP bootloader*, *Threadmetric Benchmark port*, and several other examples to test and demonstrate the hardware's functionality. There are also several utility programs not intended to run on the hardware.

## Getting Started

### File Structure

Take note of the Plasma-SoC's file structure shown below. For the sake of brevity, many of the sources are omitted from the structure. However, understand that the files not shown are still needed. Please see the sources themselves for more information.

+ hdl --- All the VHDL hardware sources. 
   + plasma --- Steve Rhoads' Plasma MLite Core.
   + plasoc --- Plasma-SoC cores, such as peripherals and interconnect. 
      + plasoc_cpu.vhd --- CPU Core. Consists of the MLite Core and Configurable Associative/Direct Write-Back Cache.
      + plasoc_cross.vhd --- Crossbar Core. This core acts as the Plasma-SoC's interconnect. A wrapper should be generated instead of instantiating this core directly.
      + plasoc\_axi4\_full2lite.vhd --- Plasma-SoC's Slave AXI4-Full to Master AXI4-Lite Core.
      + plasoc_gpio.vhd --- GPIO Core.
      + plasoc_int.vhd --- Interrupt Controller.
      + plasoc_timer.vhd --- Timer Core.
      + plasoc_uart.vhd --- UART Core.
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
   + bin2coe.py --- A command line program that generates either a COE file or a custom VHDL source that contains the HEX of a binary.
   + gencross.py --- A command line program that generates the wrapper for the crossbar interconnect.
   + icsp.py --- A command line program that loads a binary to the Plasma-SoC provided that the Plasma-SoC is running the bootloader.

### Prerequisites

+ Cross compilation tools --- A GCC MIPS cross compiler and bin utilities are necessary to build binary. It is recommended to run this [Makefile that downloads and builds the MIPS compiler and bin utilities](https://github.com/ktbarrett/gcc-cross). The Makefile has been tested on Ubuntu and Windows with Msys2. Alternatively, compilation and build tools can be immediately downloaded from [uClib's download page](https://www.uclibc.org/downloads/binaries/0.9.30.1/), although these only work on Linux and are not fully updated.
+ EDA --- The project located under "hdl/projects/Nexys4" is generated with Vivado. All of the testing up to this point has also been done with Xilinx's Vivado Design Suite IDE. However, the Plasma-SoC is developed for portability; it should run with any EDA or configurable logic development tools. It should be noted the version of Vivado used for development was [2016.4](https://www.xilinx.com/support/download.html).
+ Python2.7 --- In order to run the utility programs, a Python2.7 interpreter is needed. It is recommended to use [Anaconda](https://www.continuum.io/downloads).
+ PySerial --- The icsp.py command line utility program requires the [PySerial module](https://github.com/pyserial/pyserial) in order to operate.
+ Serial Console --- In order to view messages from the UART Core, the host computer needs a serial console. The protocol is 9600 Baud 8N1. For Ubuntu, Minicom should already be installed. On Windows, [Putty](http://www.putty.org/) is recommended.

### Installing

#### Hardware

Applying the Plasma-SoC consists of setting up the RTL project with a selected EDA, compiling a binary for the hardware to execute, and deployment. These steps don't necessarily have to be completed in the order given.

All RTL development and testing so far been completed in Vivado 2016.4 IDE for the Digilent Nexys4 board. With the IDE, a project can be generated by the following steps.

1. Start Vivado IDE.
2. In the TCL command line, use the "cd" command to change the directory to "/hdl/projects/Nexys4".
3. Under the tools menu, use "Run TCL script.." to run the create_project.tcl script located in "/hdl/projects/Nexys4".

At this point, the simulator can be started to demonstrate an application and compilation can be started to generate a bit file that already has the bootloader loaded into BRAM. More documentation can be found in the sources themselves.

#### Software

The applications located in the "mips/apps" directory all depend on Makefiles in order to perform operations, such as building a binary or loading the binary on to the hardware. In each Makefile it is important that the variables BIN\_DIR and LD\_DIR are set to the appropriate directorys containing the cross compiler and libraries, respectively. In some Makefiles, these variables are instead called MIPS\_GCC\_BIN and MIPS\_GCC\_LIB respectively. They're always located at the beginning of every Makefile, however.

The make commands are described as the following.

+ bootloader_app
   + make all --- Builds the bootloader binary and generates a boot_pack.vhd, which contains the binary in HEX. Adding the DEBUG\_MAKE=1 argument causes the build to generate several files useful for debugging.
   + make install --- Copies boot_pack.vhd into "/hdl/projects/Nexys4".
   + make jump\_build --- Builds the jump binary and generates a jump\_pack.vhd, which contains the binary in HEX. Adding the DEBUG\_MAKE=1 argument causes the build to generate several files useful for debugging.
   + make jump\_install --- Copies jump\_pack.vhd into "/hdl/projects/Nexys4".
   + make clean --- Removes all built files from directory.
+ cache\_app, freertos\_app, timer\_interrupt\_app, uart\_app
   + make all --- Builds the application binary and generates a main_pack.vhd, which contains the binary in HEX. Adding the DEBUG\_MAKE=1 argument causes the build to generate several files useful for debugging.
   + make install --- Copies main_pack.vhd into "/hdl/projects/Nexys4".
   + make launch --- Uploads the binary on to the hardware with ISCP. The SERIALPORT variable should be set to the serial port of the hardware.
   + make clean --- Removes all built files from directory.
+ threadmetric_apps --- "make all" builds all the applications, and "make clean" removes all the built files. The majority of the other commands end with either \_build or \_launch. The former builds the application, whereas the latter uploads the binary on to the hardware with ISCP. The argument DEBUG\_MAKE=1 can be used after either \_build or all to generate debugging files. The prefixes related to the ThreadMetric benchmark applications are the following.
   + make tm\_basic\_processing\_test 
   + make tm\_cooperative\_scheduling_test --- **PLEASE READ. In order to run this application properly, the configUSE\_PREEMPTION needs to be set to 0 before building the binary. The flag is located in FreeRTOSConfig.h under "mips/freertos". Every other applications require this flag to be set to 1.** 
   + make tm\_interrupt\_preemption\_processing\_test
   + make tm\_interrupt\_processing\_test
   + make tm\_memory\_allocation\_test
   + make tm\_message\_processing\_test
   + make tm\_preemptive\_scheduling\_test

There's also a Makefile located in "hdl/projects/Nexys4" that contains the command that generates the crossbar wrapper.

## License

## Acknowledgments

[Kaleb Barrett's MIPS GCC Cross Compiler Makefile](https://github.com/ktbarrett/gcc-cross)

[Steve Rhoads' Plasma Core](https://opencores.org/project,plasma)

[Peter Bennett's UART Core](https://github.com/pabennett/uart)

[Real Time Engineer's FreeRTOS](http://www.freertos.org/)

[Express Logic's ThreadMetric Download](http://rtos.com/DownloadCenter/Thread-MetricForm.php)

[AMBA4 AXI Specification](http://www.gstitt.ece.ufl.edu/courses/fall15/eel4720_5721/labs/refs/AXI4_specification.pdf)

[Xilinx Vivado Design Suite 2016.4](https://www.xilinx.com/support/download.html)

## Contact Information






