# GCC MIPS cross compiler for Linux/Msys2 is assumed.
MIPS_GCC_BIN = C:/mips-none-elf-newlib/bin/
MIPS_GCC_LIB = C:/mips-none-elf-newlib/mips-none-elf/lib
#MIPS_GCC_BIN = /opt/mips_cross_compiler/mips/bin/
#MIPS_GCC_LIB = /opt/mips_cross_compiler/mips/mips-none-elf
MISC_DIR = ../../../misc
PLASMA_DIR = ../../plasma
PLASOC_DIR = ../../plasoc
FREERTOS_DIR = ../../freertos
CFLAGS = -Os -Wall -s -I$(PLASMA_DIR) -I$(PLASOC_DIR) -I$(FREERTOS_DIR) -DENABLE_PRINTF

# When configuring the address, it is important to consider the addresses of
# the abi flags and reg info. Both sections should be located immediately after 
# the end of the application. 
LDSTART_ADDRESS = 0x01000000
LDFLAGS = -L$(LD_DIR) -static
LDAFTERFLAGS = -lc -T$(PLASOC_DIR)/linker.ld
ASFLAGS = 

# Following are REQUIRED variables, but can be editted
SERIALPORT = /dev/ttyUSB1
INSTALL_DIR = ../../../hdl/testbenches/timer_interrupt_tb/
PREFIX = $(MIPS_GCC_BIN)mips-none-elf-
SUFFIX =
C_SOURCES = ./tm_porting_layer_freertos.c $(PLASOC_DIR)/printf.c $(PLASOC_DIR)/plasoc_cpu.c $(FREERTOS_DIR)/list.c $(FREERTOS_DIR)/queue.c $(FREERTOS_DIR)/tasks.c $(FREERTOS_DIR)/port.c $(FREERTOS_DIR)/heap_4.c
ASM_SOURCES = $(PLASMA_DIR)/boot.asm $(FREERTOS_DIR)/port_asm.asm
BIN2COE = python2 $(MISC_DIR)/bin2coe.py --swap_bytes --vhdl_hex --word_count 8192 --full_count 16384
ICSPFLAGS = --serial_port $(SERIALPORT)

# No user editing or variables below this line

CFLAGS += -c -fno-pic -mips1 -mno-abicalls
LDFLAGS += -L$(MIPS_GCC_LIB)
ASFLAGS += 

RM = find 

EXEC_NAME = main
GCC_MIPS = $(PREFIX)gcc$(SUFFIX)
AS_MIPS = $(PREFIX)as$(SUFFIX)
LD_MIPS = $(PREFIX)ld$(SUFFIX)
DUMP_MIPS = $(PREFIX)objdump$(SUFFIX)
OBJCOPY_MIPS = $(PREFIX)objcopy$(SUFFIX)
STRIP_MIPS = $(PREFIX)strip$(SUFFIX)

ASM_OBJECTS = $(ASM_SOURCES:.asm=)
C_OBJECTS = $(C_SOURCES:.c=)

EXEC_NAME_0 = tm_basic_processing_test
C_SOURCES_0 = ./$(EXEC_NAME_0).c $(C_SOURCES)
C_OBJECTS_0 = $(C_SOURCES_0:.c=)
OBJECTS_0 = $(ASM_OBJECTS) $(C_OBJECTS_0)

EXEC_NAME_1 = tm_cooperative_scheduling_test
C_SOURCES_1 = ./$(EXEC_NAME_1).c $(C_SOURCES)
C_OBJECTS_1 = $(C_SOURCES_1:.c=)
OBJECTS_1 = $(ASM_OBJECTS) $(C_OBJECTS_1)

EXEC_NAME_2 = tm_interrupt_preemption_processing_test
C_SOURCES_2 = ./$(EXEC_NAME_2).c $(C_SOURCES)
C_OBJECTS_2 = $(C_SOURCES_2:.c=)
OBJECTS_2 = $(ASM_OBJECTS) $(C_OBJECTS_2)

EXEC_NAME_3 = tm_interrupt_processing_test
C_SOURCES_3 = ./$(EXEC_NAME_3).c $(C_SOURCES)
C_OBJECTS_3 = $(C_SOURCES_3:.c=)
OBJECTS_3 = $(ASM_OBJECTS) $(C_OBJECTS_3)

EXEC_NAME_4 = tm_memory_allocation_test
C_SOURCES_4 = ./$(EXEC_NAME_4).c $(C_SOURCES)
C_OBJECTS_4 = $(C_SOURCES_4:.c=)
OBJECTS_4 = $(ASM_OBJECTS) $(C_OBJECTS_4)

EXEC_NAME_5 = tm_message_processing_test
C_SOURCES_5 = ./$(EXEC_NAME_5).c $(C_SOURCES)
C_OBJECTS_5 = $(C_SOURCES_5:.c=)
OBJECTS_5 = $(ASM_OBJECTS) $(C_OBJECTS_5)

EXEC_NAME_6 = tm_preemptive_scheduling_test
C_SOURCES_6 = ./$(EXEC_NAME_6).c $(C_SOURCES)
C_OBJECTS_6 = $(C_SOURCES_6:.c=)
OBJECTS_6 = $(ASM_OBJECTS) $(C_OBJECTS_6)

all: tm_basic_processing_test_build tm_cooperative_scheduling_test_build tm_interrupt_preemption_processing_test_build tm_interrupt_processing_test_build tm_memory_allocation_test_build tm_message_processing_test_build tm_preemptive_scheduling_test_build
	
tm_basic_processing_test_build: $(ASM_OBJECTS) $(C_OBJECTS) build_0
tm_cooperative_scheduling_test_build: $(ASM_OBJECTS) $(C_OBJECTS) build_1
tm_interrupt_preemption_processing_test_build: $(ASM_OBJECTS) $(C_OBJECTS) build_2
tm_interrupt_processing_test_build: $(ASM_OBJECTS) $(C_OBJECTS) build_3
tm_memory_allocation_test_build: $(ASM_OBJECTS) $(C_OBJECTS) build_4
tm_message_processing_test_build: $(ASM_OBJECTS) $(C_OBJECTS) build_5
tm_preemptive_scheduling_test_build: $(ASM_OBJECTS) $(C_OBJECTS) build_6
	
$(ASM_OBJECTS):%:%.asm
	$(AS_MIPS) -o $(notdir $@).o $@.asm
	
$(C_OBJECTS):%:%.c
	$(GCC_MIPS) $(CFLAGS) -o $(notdir $@).o $@.c
ifdef DEBUG_MAKE
	$(GCC_MIPS) $(CFLAGS) -o $(notdir $@).s -S $@.c
endif

build_0:

	$(GCC_MIPS) $(CFLAGS) -o $(EXEC_NAME_0).o $(EXEC_NAME_0).c
ifdef DEBUG_MAKE
	$(GCC_MIPS) $(CFLAGS) -o $(EXEC_NAME_0).s -S $(EXEC_NAME_0).c
endif

ifdef DEBUG_MAKE
	$(LD_MIPS) $(LDFLAGS) -Ttext=$(LDSTART_ADDRESS) -e entry -Map $(EXEC_NAME_0).map -s -N -o $(EXEC_NAME_0).axf \
		$(notdir $(OBJECTS_0:=.o)) $(LDAFTERFLAGS)
	$(DUMP_MIPS) --disassemble-all $(EXEC_NAME_0).axf > $(EXEC_NAME_0).lst
else
	$(LD_MIPS) $(LDFLAGS) -Ttext=$(LDSTART_ADDRESS) -e entry -s -N -o $(EXEC_NAME_0).axf \
		$(notdir $(OBJECTS_0:=.o)) $(LDAFTERFLAGS)
endif
	$(OBJCOPY_MIPS) -I elf32-big -O binary $(EXEC_NAME_0).axf $(EXEC_NAME_0).bin
	$(BIN2COE) $(EXEC_NAME_0).bin $(EXEC_NAME_0).vhdl
	
build_1:

	$(GCC_MIPS) $(CFLAGS) -o $(EXEC_NAME_1).o $(EXEC_NAME_1).c
ifdef DEBUG_MAKE
	$(GCC_MIPS) $(CFLAGS) -o $(EXEC_NAME_1).s -S $(EXEC_NAME_1).c
endif

ifdef DEBUG_MAKE
	$(LD_MIPS) $(LDFLAGS) -Ttext=$(LDSTART_ADDRESS) -e entry -Map $(EXEC_NAME_1).map -s -N -o $(EXEC_NAME_1).axf \
		$(notdir $(OBJECTS_1:=.o)) $(LDAFTERFLAGS)
	$(DUMP_MIPS) --disassemble-all $(EXEC_NAME_1).axf > $(EXEC_NAME_1).lst
else
	$(LD_MIPS) $(LDFLAGS) -Ttext=$(LDSTART_ADDRESS) -e entry -s -N -o $(EXEC_NAME_1).axf \
		$(notdir $(OBJECTS_1:=.o)) $(LDAFTERFLAGS)
endif
	$(OBJCOPY_MIPS) -I elf32-big -O binary $(EXEC_NAME_1).axf $(EXEC_NAME_1).bin
	$(BIN2COE) $(EXEC_NAME_1).bin $(EXEC_NAME_1).vhdl
	
build_2:

	$(GCC_MIPS) $(CFLAGS) -o $(EXEC_NAME_2).o $(EXEC_NAME_2).c
ifdef DEBUG_MAKE
	$(GCC_MIPS) $(CFLAGS) -o $(EXEC_NAME_2).s -S $(EXEC_NAME_2).c
endif

ifdef DEBUG_MAKE
	$(LD_MIPS) $(LDFLAGS) -Ttext=$(LDSTART_ADDRESS) -e entry -Map $(EXEC_NAME_2).map -s -N -o $(EXEC_NAME_2).axf \
		$(notdir $(OBJECTS_2:=.o)) $(LDAFTERFLAGS)
	$(DUMP_MIPS) --disassemble-all $(EXEC_NAME_2).axf > $(EXEC_NAME_2).lst
else
	$(LD_MIPS) $(LDFLAGS) -Ttext=$(LDSTART_ADDRESS) -e entry -s -N -o $(EXEC_NAME_2).axf \
		$(notdir $(OBJECTS_2:=.o)) $(LDAFTERFLAGS)
endif
	$(OBJCOPY_MIPS) -I elf32-big -O binary $(EXEC_NAME_2).axf $(EXEC_NAME_2).bin
	$(BIN2COE) $(EXEC_NAME_2).bin $(EXEC_NAME_2).vhdl
	
build_3:

	$(GCC_MIPS) $(CFLAGS) -o $(EXEC_NAME_3).o $(EXEC_NAME_3).c
ifdef DEBUG_MAKE
	$(GCC_MIPS) $(CFLAGS) -o $(EXEC_NAME_3).s -S $(EXEC_NAME_3).c
endif

ifdef DEBUG_MAKE
	$(LD_MIPS) $(LDFLAGS) -Ttext=$(LDSTART_ADDRESS) -e entry -Map $(EXEC_NAME_3).map -s -N -o $(EXEC_NAME_3).axf \
		$(notdir $(OBJECTS_3:=.o)) $(LDAFTERFLAGS)
	$(DUMP_MIPS) --disassemble-all $(EXEC_NAME_3).axf > $(EXEC_NAME_3).lst
else
	$(LD_MIPS) $(LDFLAGS) -Ttext=$(LDSTART_ADDRESS) -e entry -s -N -o $(EXEC_NAME_3).axf \
		$(notdir $(OBJECTS_3:=.o)) $(LDAFTERFLAGS)
endif
	$(OBJCOPY_MIPS) -I elf32-big -O binary $(EXEC_NAME_3).axf $(EXEC_NAME_3).bin
	$(BIN2COE) $(EXEC_NAME_3).bin $(EXEC_NAME_3).vhdl
	
build_4:

	$(GCC_MIPS) $(CFLAGS) -o $(EXEC_NAME_4).o $(EXEC_NAME_4).c
ifdef DEBUG_MAKE
	$(GCC_MIPS) $(CFLAGS) -o $(EXEC_NAME_4).s -S $(EXEC_NAME_4).c
endif

ifdef DEBUG_MAKE
	$(LD_MIPS) $(LDFLAGS) -Ttext=$(LDSTART_ADDRESS) -e entry -Map $(EXEC_NAME_4).map -s -N -o $(EXEC_NAME_4).axf \
		$(notdir $(OBJECTS_4:=.o)) $(LDAFTERFLAGS)
	$(DUMP_MIPS) --disassemble-all $(EXEC_NAME_4).axf > $(EXEC_NAME_4).lst
else
	$(LD_MIPS) $(LDFLAGS) -Ttext=$(LDSTART_ADDRESS) -e entry -s -N -o $(EXEC_NAME_4).axf \
		$(notdir $(OBJECTS_4:=.o)) $(LDAFTERFLAGS)
endif
	$(OBJCOPY_MIPS) -I elf32-big -O binary $(EXEC_NAME_4).axf $(EXEC_NAME_4).bin
	$(BIN2COE) $(EXEC_NAME_4).bin $(EXEC_NAME_4).vhdl
	
build_5:

	$(GCC_MIPS) $(CFLAGS) -o $(EXEC_NAME_5).o $(EXEC_NAME_5).c
ifdef DEBUG_MAKE
	$(GCC_MIPS) $(CFLAGS) -o $(EXEC_NAME_5).s -S $(EXEC_NAME_5).c
endif

ifdef DEBUG_MAKE
	$(LD_MIPS) $(LDFLAGS) -Ttext=$(LDSTART_ADDRESS) -e entry -Map $(EXEC_NAME_5).map -s -N -o $(EXEC_NAME_5).axf \
		$(notdir $(OBJECTS_5:=.o)) $(LDAFTERFLAGS)
	$(DUMP_MIPS) --disassemble-all $(EXEC_NAME_5).axf > $(EXEC_NAME_5).lst
else
	$(LD_MIPS) $(LDFLAGS) -Ttext=$(LDSTART_ADDRESS) -e entry -s -N -o $(EXEC_NAME_5).axf \
		$(notdir $(OBJECTS_5:=.o)) $(LDAFTERFLAGS)
endif
	$(OBJCOPY_MIPS) -I elf32-big -O binary $(EXEC_NAME_5).axf $(EXEC_NAME_5).bin
	$(BIN2COE) $(EXEC_NAME_5).bin $(EXEC_NAME_5).vhdl
	
build_6:

	$(GCC_MIPS) $(CFLAGS) -o $(EXEC_NAME_6).o $(EXEC_NAME_6).c
ifdef DEBUG_MAKE
	$(GCC_MIPS) $(CFLAGS) -o $(EXEC_NAME_6).s -S $(EXEC_NAME_6).c
endif

ifdef DEBUG_MAKE
	$(LD_MIPS) $(LDFLAGS) -Ttext=$(LDSTART_ADDRESS) -e entry -Map $(EXEC_NAME_6).map -s -N -o $(EXEC_NAME_6).axf \
		$(notdir $(OBJECTS_6:=.o)) $(LDAFTERFLAGS)
	$(DUMP_MIPS) --disassemble-all $(EXEC_NAME_6).axf > $(EXEC_NAME_6).lst
else
	$(LD_MIPS) $(LDFLAGS) -Ttext=$(LDSTART_ADDRESS) -e entry -s -N -o $(EXEC_NAME_6).axf \
		$(notdir $(OBJECTS_6:=.o)) $(LDAFTERFLAGS)
endif
	$(OBJCOPY_MIPS) -I elf32-big -O binary $(EXEC_NAME_6).axf $(EXEC_NAME_6).bin
	$(BIN2COE) $(EXEC_NAME_6).bin $(EXEC_NAME_6).vhdl

clean:
	$(RM) . -name "*.o" -type f -delete
	$(RM) . -name "*.axf" -type f -delete
	$(RM) . -name "*.hex" -type f -delete
	$(RM) . -name "*.map" -type f -delete
	$(RM) . -name "*.lst" -type f -delete

