# GCC MIPS cross compiler for Linux/Msys2 is assumed.

BIN_DIR = 
PLASMA_SRC_DIR = ../plasma
FREERTOS_SRC_DIR = ../../Source
DEMO_SRC_DIR = ../Common/Minimal
PORT_SRC_DIR = ../../Source/portable/GCC/MIPS1

INCLUDE_DIRS = $(FREERTOS_SRC_DIR) $(PLASMA_SRC_DIR) $(DEMO_SRC_DIR) $(PORT_SRC_DIR)
WARNINGS = -Wall
CFLAGS = -Os -s
LDFLAGS =

# Following are REQUIRED variables, but can be editted
INSTALL_DIR = 
PREFIX = $(BIN_DIR)mips-none-elf-
SUFFIX =

C_SOURCES = \
main.c \
$(SOURCE_DIR)/tasks.c \
$(SOURCE_DIR)/queue.c \
$(SOURCE_DIR)/list.c \
$(SOURCE_DIR)/portable/MemMang/heap_1.c \
$(PORT_DIR)/port.c

ASM_SOURCES = \
$(PLASMA_DIR)/boot.asm

# No user editing or variables below this line

CFLAGS += -c -fno-pic -mips1 -mno-abicalls $(patsubst %,-I%,$(INCLUDE_DIRS)) $(WARNINGS)
LDFLAGS += -static -lc

RM = rm -rf

EXEC_NAME = $(shell basename $$(pwd))
GCC_MIPS = $(PREFIX)gcc$(SUFFIX) $(CFLAGS)
AS_MIPS = $(PREFIX)as$(SUFFIX)
LD_MIPS = $(PREFIX)ld$(SUFFIX) $(LDFLAGS)
DUMP_MIPS = $(PREFIX)objdump$(SUFFIX)
OBJCOPY_MIPS = $(PREFIX)objcopy$(SUFFIX)

ASM_OBJECTS = $(ASM_SOURCES:.asm=)
C_OBJECTS = $(C_SOURCES:.c=)
SOURCES = $(ASM_SOURCES) $(C_SOURCES)
OBJECTS = $(ASM_OBJECTS) $(C_OBJECTS)


all: $(OBJECTS)
ifdef DEBUG_MAKE
	$(LD_MIPS) -Ttext=0 -e entry -Map $(EXEC_NAME).map -s -N -o $(EXEC_NAME).axf \
		$(notdir $(OBJECTS:=.o)) $(LD_FLAGS)
	$(DUMP_MIPS) --disassemble-all $(EXEC_NAME).axf > $(EXEC_NAME).lst
else
	$(LD_MIPS) -Ttext=0 -e entry -s -N -o $(EXEC_NAME).axf \
		$(notdir $(OBJECTS:=.o)) $(LD_FLAGS)
endif
	$(OBJCOPY_MIPS) -I elf32-big -O binary $(EXEC_NAME).axf $(EXEC_NAME).bin


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
	install -c $(EXEC_NAME).bin $(INSTALL_DIR)
else
	@echo Not installing, no installation directory selected
endif


clean:
	$(RM) $(EXEC_NAME).map $(EXEC_NAME).lst $(EXEC_NAME).axf $(EXEC_NAME).bin $(notdir $(OBJECTS:=.o)) $(notdir $(C_OBJECTS:=.s))

