# GCC MIPS cross compiler for Linux/Msys2 is assumed.

BIN_DIR = 
LD_DIR = 
PLASMA_DIR = ../plasma
CFLAGS = -Os -Wall -s -I$(PLASMA_DIR)
LDFLAGS = -L$(LD_DIR) -static

# Following are REQUIRED variables, but can be editted
INSTALL_DIR = 
PREFIX = $(BIN_DIR)mips-none-elf-
SUFFIX =
C_SOURCES = main.c $(PLASMA_DIR)/plasmasoc.c
ASM_SOURCES = $(PLASMA_DIR)/boot.asm

# No user editing or variables below this line

CFLAGS += -c -fno-pic -mips1 -mno-abicalls

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
		$(notdir $(OBJECTS:=.o)) -lc
	$(DUMP_MIPS) --disassemble-all $(EXEC_NAME).axf > $(EXEC_NAME).lst
else
	$(LD_MIPS) -Ttext=0 -e entry -s -N -o $(EXEC_NAME).axf \
		$(notdir $(OBJECTS:=.o)) -lc
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

