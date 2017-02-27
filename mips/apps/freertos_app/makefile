# GCC MIPS cross compiler for Linux/Msys2 is assumed.
MIPS_GCC_BIN = C:/mips-none-elf-newlib/bin/
MIPS_GCC_LIB = C:/mips-none-elf-newlib/mips-none-elf/lib
#MIPS_GCC_BIN = /opt/mips_cross_compiler/mips/bin/
#MIPS_GCC_LIB = /opt/mips_cross_compiler/mips/mips-none-elf
MISC_DIR = ../../../misc
PLASMA_DIR = ../../plasma
PLASOC_DIR = ../../plasoc
FREERTOS_DIR = ../../freertos
CFLAGS = -O3 -Wall -s -I$(PLASMA_DIR) -I$(PLASOC_DIR) -I$(FREERTOS_DIR)
LDFLAGS = -static -lc
ASFLAGS = 

# Following are REQUIRED variables, but can be editted
INSTALL_DIR = ../../../hdl/testbenches/timer_interrupt_tb/
PREFIX = $(MIPS_GCC_BIN)mips-none-elf-
SUFFIX =
C_SOURCES = main.c $(PLASOC_DIR)/plasoc_cpu.c $(FREERTOS_DIR)/list.c $(FREERTOS_DIR)/queue.c $(FREERTOS_DIR)/tasks.c $(FREERTOS_DIR)/port.c $(FREERTOS_DIR)/heap_1.c
ASM_SOURCES = $(PLASMA_DIR)/boot.asm $(FREERTOS_DIR)/port_asm.asm
BIN2COE = python2 $(MISC_DIR)/bin2coe.py --swap_bytes --vhdl_hex --word_count 8192 --full_count 16384

# No user editing or variables below this line

CFLAGS += -c -fno-pic -mips1 -mno-abicalls
LDFLAGS += -L$(MIPS_GCC_LIB)
ASFLAGS += 

RM = rm -rf

EXEC_NAME = main
GCC_MIPS = $(PREFIX)gcc$(SUFFIX)
AS_MIPS = $(PREFIX)as$(SUFFIX)
LD_MIPS = $(PREFIX)ld$(SUFFIX)
DUMP_MIPS = $(PREFIX)objdump$(SUFFIX)
OBJCOPY_MIPS = $(PREFIX)objcopy$(SUFFIX)

ASM_OBJECTS = $(ASM_SOURCES:.asm=)
C_OBJECTS = $(C_SOURCES:.c=)
SOURCES = $(ASM_SOURCES) $(C_SOURCES)
OBJECTS = $(ASM_OBJECTS) $(C_OBJECTS)


all: check $(OBJECTS)
ifdef DEBUG_MAKE
	$(LD_MIPS) $(LDFLAGS) -Ttext=0 -e entry -Map $(EXEC_NAME).map -s -N -o $(EXEC_NAME).axf \
		$(notdir $(OBJECTS:=.o)) -lc
	$(DUMP_MIPS) --disassemble-all $(EXEC_NAME).axf > $(EXEC_NAME).lst
else
	$(LD_MIPS) $(LDFLAGS) -Ttext=0 -e entry -s -N -o $(EXEC_NAME).axf \
		$(notdir $(OBJECTS:=.o)) -lc
endif
	$(OBJCOPY_MIPS) -I elf32-big -O binary $(EXEC_NAME).axf $(EXEC_NAME).bin
	$(BIN2COE) $(EXEC_NAME).bin $(EXEC_NAME).vhdl

check:
ifndef MIPS_GCC_BIN
	$(error MIPS_GCC_BIN not defined)
endif
ifndef MIPS_GCC_LIB
	$(error MIPS_GCC_LIB not defined)
endif

$(C_OBJECTS):%:%.c
	$(GCC_MIPS) $(CFLAGS) -o $(notdir $@).o $@.c
ifdef DEBUG_MAKE
	$(GCC_MIPS) $(CFLAGS) -o $(notdir $@).s -S $@.c
endif
	
$(ASM_OBJECTS):%:%.asm
	$(AS_MIPS) -o $(notdir $@).o $@.asm


install:
ifneq ($(INSTALL_DIR),)
	install -d $(INSTALL_DIR)
	install -c $(EXEC_NAME).vhdl $(INSTALL_DIR)
else
	@echo Not installing, no installation directory selected
endif


clean:
	$(RM) $(EXEC_NAME).hex $(EXEC_NAME).map $(EXEC_NAME).lst $(EXEC_NAME).axf $(EXEC_NAME).bin $(notdir $(OBJECTS:=.o)) $(notdir $(C_OBJECTS:=.s))

