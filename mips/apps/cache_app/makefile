# GCC MIPS cross compiler for Linux/Msys2 is assumed.
#BIN_DIR = C:/mips-none-elf-newlib/bin/
#LD_DIR = C:/mips-none-elf-newlib/mips-none-elf/lib
BIN_DIR = /opt/mips_cross_compiler/mips/bin/
LD_DIR = /opt/mips_cross_compiler/mips/mips-none-elf/lib
MISC_DIR = ../../../misc
PLASMA_DIR = ../../plasma
PLASOC_DIR = ../../plasoc
CFLAGS = -Os -Wall -s -I$(PLASMA_DIR) -I$(PLASOC_DIR)
LDFLAGS = -L$(LD_DIR) -static
LDSTART_ADDRESS = 0x00000000

# Following are REQUIRED variables, but can be editted
INSTALL_DIR = ../../../hdl/testbenches/timer_interrupt_tb/
PREFIX = $(BIN_DIR)mips-none-elf-
SUFFIX =
C_SOURCES = main.c $(PLASOC_DIR)/plasoc_cpu.c
ASM_SOURCES = $(PLASMA_DIR)/boot.asm
BIN2COE = python2 $(MISC_DIR)/bin2coe.py --swap_bytes --vhdl_hex --word_count 8192 --full_count 16384

# No user editing or variables below this line

CFLAGS += -c -fno-pic -mips1 -mno-abicalls

RM = rm -rf

EXEC_NAME = main
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
		$(notdir $(OBJECTS:=.o)) -lc --section-start=.text=$(LDSTART_ADDRESS)
	$(DUMP_MIPS) --disassemble-all $(EXEC_NAME).axf > $(EXEC_NAME).lst
else
	$(LD_MIPS) -Ttext=0 -e entry -s -N -o $(EXEC_NAME).axf \
		$(notdir $(OBJECTS:=.o)) -lc --section-start=.text=$(LDSTART_ADDRESS)
endif
	$(OBJCOPY_MIPS) -I elf32-big -O binary $(EXEC_NAME).axf $(EXEC_NAME).bin
	$(BIN2COE) $(EXEC_NAME).bin $(EXEC_NAME).vhdl


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
	install -c $(EXEC_NAME).vhdl $(INSTALL_DIR)
else
	@echo Not installing, no installation directory selected
endif


clean:
	$(RM) $(EXEC_NAME).hex $(EXEC_NAME).map $(EXEC_NAME).lst $(EXEC_NAME).axf $(EXEC_NAME).bin $(notdir $(OBJECTS:=.o)) $(notdir $(C_OBJECTS:=.s))

