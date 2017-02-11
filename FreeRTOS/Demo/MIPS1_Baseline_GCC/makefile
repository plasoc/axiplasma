# GCC MIPS cross compiler for Linux/Msys2 is assumed.

BIN_DIR = 
LD_DIR = /usr/local/mips-none-elf-newlib/mips-none-elf/lib
MISC_DIR = ../../../misc/
PLASMA_SRC_DIR = ../../../mips/plasma
PLASOC_SRC_DIR = ../../../mips/plasoc
FREERTOS_SRC_DIR = ../../Source
PORT_SRC_DIR = ../../Source/portable/GCC/MIPS1

INCLUDE_DIRS += $(PORT_SRC_DIR) $(FREERTOS_SRC_DIR)/include $(PLASMA_SRC_DIR) $(PLASOC_SRC_DIR)
WARNINGS += -Wall
CFLAGS += -Os -s -std=c11
LDFLAGS += -L$(LD_DIR) -static

# Following are REQUIRED variables, but can be edited
EXEC_NAME = FreeRTOS_Demo
INSTALL_DIR = ../../../hdl/testbenches/timer_interrupt_tb/
PREFIX = $(BIN_DIR)mips-none-elf-
SUFFIX =

C_SOURCES = \
main.c											\
$(FREERTOS_SRC_DIR)/tasks.c						\
$(FREERTOS_SRC_DIR)/queue.c						\
$(FREERTOS_SRC_DIR)/list.c						\
$(FREERTOS_SRC_DIR)/timers.c					\
$(FREERTOS_SRC_DIR)/portable/MemMang/heap_1.c	\
$(PORT_SRC_DIR)/port.c							

ASM_SOURCES = \
$(PLASMA_SRC_DIR)/boot.asm

# No user editing or variables below this line

CFLAGS += -c -fno-pic -mips1 -mno-abicalls $(patsubst %,-I%,$(INCLUDE_DIRS)) $(WARNINGS)
INCLUDE_DIRS += ./

RM = rm -f

GCC_MIPS = $(PREFIX)gcc$(SUFFIX) $(CFLAGS)
AS_MIPS = $(PREFIX)as$(SUFFIX)
LD_MIPS = $(PREFIX)ld$(SUFFIX) $(LDFLAGS)
DUMP_MIPS = $(PREFIX)objdump$(SUFFIX)
OBJCOPY_MIPS = $(PREFIX)objcopy$(SUFFIX)
BIN2COE = python2 $(MISC_DIR)/bin2coe.py --swap_bytes --plain_hex --word_count 16384

ASM_OBJECTS = $(ASM_SOURCES:.asm=)
C_OBJECTS = $(C_SOURCES:.c=)
SOURCES = $(ASM_SOURCES) $(C_SOURCES)
OBJECTS = $(ASM_OBJECTS) $(C_OBJECTS)


all: $(OBJECTS)
ifdef DEBUG_MAKE
	$(LD_MIPS) -Ttext=0 -e entry -Map $(EXEC_NAME).map -s -N -o $(EXEC_NAME).axf \
		$(notdir $(OBJECTS:=.o)) $(LD_FLAGS) -lc
	$(DUMP_MIPS) --disassemble-all $(EXEC_NAME).axf > $(EXEC_NAME).lst
else
	$(LD_MIPS) -Ttext=0 -e entry -s -N -o $(EXEC_NAME).axf \
		$(notdir $(OBJECTS:=.o)) $(LD_FLAGS) -lc
endif
	$(OBJCOPY_MIPS) -I elf32-big -O binary $(EXEC_NAME).axf $(EXEC_NAME).bin
	$(BIN2COE) $(EXEC_NAME).bin $(EXEC_NAME).hex


$(C_OBJECTS):%:%.c
	$(GCC_MIPS) -o $(notdir $@).o $@.c
ifdef DEBUG_MAKE
	$(GCC_MIPS) -o $(notdir $@).asm -S $@.c
endif
	
$(ASM_OBJECTS):%:%.asm
	$(AS_MIPS) -o $(notdir $@).o $@.asm


install:
ifneq ($(INSTALL_DIR),)
	install -d $(INSTALL_DIR)
	install -c $(EXEC_NAME).hex $(INSTALL_DIR)
else
	@echo Not installing, no installation directory selected
endif


clean:
	$(RM) $(EXEC_NAME).map $(EXEC_NAME).lst $(EXEC_NAME).axf $(EXEC_NAME).bin $(EXEC_NAME).hex $(notdir $(OBJECTS:=.o)) $(notdir $(C_OBJECTS:=.s))

