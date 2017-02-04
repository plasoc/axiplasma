# GCC MIPS cross compiler for Linux/Msys2 is assumed.

# It's time Andrew...
# 	add the line 'export $PATH=$PATH:/opt/mips_cross_compiler/mips/bin/'
# 	to your .bashrc or start specifying this on this command line with
# 	'make BIN_DIR=/opt/mips_cross_compiler/mips/bin/'
# Sorry, but I don't feel like getting into a commit war

MISC_DIR = ../../../misc
PLASMA_DIR = ../../plasma
PLASOC_DIR = ../../plasoc

CFLAGS += -Os -Wall -s -I$(PLASMA_DIR) -I$(PLASOC_DIR)
LDFLAGS += -L$(LD_DIR) -static

# Following are used directly by the script, but can be editted by the user
BIN_PREFIX = $(BIN_DIR)mips-none-elf-
BIN_SUFFIX =
INSTALL_DIR = ../../../hdl/testbenches/timer_interrupt_tb/
C_SOURCES = main.c $(PLASOC_DIR)/plasoc_cpu.c
ASM_SOURCES = $(PLASMA_DIR)/boot.asm

# No user editing or variables below this line

CFLAGS += -c -fno-pic -mips1 -mno-abicalls

RM = rm -rf

EXEC_NAME = main
GCC_MIPS = $(BIN_PREFIX)gcc$(BIN_SUFFIX) $(CFLAGS)
AS_MIPS = $(BIN_PREFIX)as$(BIN_SUFFIX)
LD_MIPS = $(BIN_PREFIX)ld$(BIN_SUFFIX) $(LDFLAGS)
DUMP_MIPS = $(BIN_PREFIX)objdump$(BIN_SUFFIX)
OBJCOPY_MIPS = $(BIN_PREFIX)objcopy$(BIN_SUFFIX)
BIN2COE = python2 $(MISC_DIR)/bin2coe.py --swap_bytes --plain_hex --word_count 16384

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
	$(RM) $(EXEC_NAME).hex $(EXEC_NAME).map $(EXEC_NAME).lst $(EXEC_NAME).axf $(EXEC_NAME).bin $(notdir $(OBJECTS:=.o)) $(notdir $(C_OBJECTS:=.s))

