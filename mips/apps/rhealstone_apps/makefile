# MIPS_GCC_BIN is the location of gcc and the binutils
# MIPS_GCC_LIB is the location of the gcc libraries
MISC_DIR = ../../../misc
PLASMA_DIR = ../../plasma
PLASOC_DIR = ../../plasoc
FREERTOS_DIR = ../../freertos
CFLAGS = -O3 -Wall -s -I$(PLASMA_DIR) -I$(PLASOC_DIR) -I$(FREERTOS_DIR) -I. -DENABLE_PRINTF
LDSTART_ADDRESS = 0x01000000
LDFLAGS = 
LDAFTERFLAGS = -L$(MIPS_GCC_LIB) -static -lc -T$(PLASOC_DIR)/linker.ld 
ifeq ($(SERIALPORT),)
	SERIALPORT = /dev/ttyUSB1
endif
INSTALL_DIR = ../../../hdl/testbenches/timer_interrupt_tb/
PREFIX = $(MIPS_GCC_BIN)mips-none-elf-
SUFFIX =
C_SOURCES = ./rhealstone_benchmark_funcs.c $(PLASOC_DIR)/printf.c $(PLASOC_DIR)/plasoc_cpu.c $(FREERTOS_DIR)/list.c $(FREERTOS_DIR)/queue.c $(FREERTOS_DIR)/tasks.c $(FREERTOS_DIR)/port.c $(FREERTOS_DIR)/heap_4.c
ASM_SOURCES = $(PLASMA_DIR)/boot.asm $(FREERTOS_DIR)/port_asm.asm
ifndef PYTHON2
	PYTHON2 = python2
endif
BIN2COE = $(PYTHON2) $(MISC_DIR)/bin2coe.py --swap_bytes --vhdl_hex
ICSP = $(PYTHON2) $(MISC_DIR)/icsp.py 
ICSPFLAGS = --verbose --serial_port $(SERIALPORT)

CFLAGS += -c -fno-pic -mips1 -mno-abicalls

GCC_MIPS = $(PREFIX)gcc$(SUFFIX)
AS_MIPS = $(PREFIX)as$(SUFFIX)
LD_MIPS = $(PREFIX)ld$(SUFFIX)
DUMP_MIPS = $(PREFIX)objdump$(SUFFIX)
OBJCOPY_MIPS = $(PREFIX)objcopy$(SUFFIX)
STRIP_MIPS = $(PREFIX)strip$(SUFFIX)

ASM_OBJECTS = $(ASM_SOURCES:.asm=)
C_OBJECTS = $(C_SOURCES:.c=)
PROGRAMS = task_switching baseline_task_switching

.PHONY: $(PROGRAMS)
$(PROGRAMS): %:%.bin

$(PROGRAMS:%=%.launch): %:%.bin
	$(ICSP) $< $(ICSPFLAGS)
	
$(ASM_OBJECTS):%:%.asm
	$(AS_MIPS) -o $(notdir $@).o $<
	
$(C_OBJECTS):%:%.c
	$(GCC_MIPS) $(CFLAGS) -o $(notdir $@).o $@.c
ifdef DEBUG_MAKE
	$(GCC_MIPS) $(CFLAGS) -o $(notdir $@).s -S $@.c
endif

$(PROGRAMS:%=%.bin): $(C_OBJECTS) $(ASM_OBJECTS)
	$(GCC_MIPS) $(CFLAGS) -o $(@:%.bin=%.o) $(@:%.bin=%.c)
ifdef DEBUG_MAKE
	$(GCC_MIPS) $(CFLAGS) -o $(@:%.bin=%.s) -S $(@:%.bin=%.c)
endif
ifdef DEBUG_MAKE
	$(LD_MIPS) $(LDFLAGS) -Ttext=$(LDSTART_ADDRESS) -e entry -Map $(@:%.bin=%.map) -N -o $(@:%.bin=%.axf) \
		$(notdir $(ASM_OBJECTS:=.o)) $(@:%.bin=%.o) $(notdir $(C_OBJECTS:=.o)) $(LDAFTERFLAGS)
	$(DUMP_MIPS) --disassemble-all $(@:%.bin=%.axf) > $(@:%.bin=%.lst)
else
	$(LD_MIPS) $(LDFLAGS) -Ttext=$(LDSTART_ADDRESS) -e entry -s -N -o $(@:%.bin=%.axf) \
		$(notdir $(ASM_OBJECTS:=.o)) $(@:%.bin=%.o) $(notdir $(C_OBJECTS:=.o)) $(LDAFTERFLAGS)
endif
	$(OBJCOPY_MIPS) -I elf32-big -O binary $(@:%.bin=%.axf) $@
	$(BIN2COE) $@ $(@:%.bin=%_pack.vhd) --package_name main_pack
	
clean:
	find . -name "*.o" -type f -delete
	find . -name "*.axf" -type f -delete
	find . -name "*.hex" -type f -delete
	find . -name "*.map" -type f -delete
	find . -name "*.lst" -type f -delete
	find . -name "*.bin" -type f -delete
	find . -name "*.vhd" -type f -delete
	find . -name "*.s" -type f -delete

