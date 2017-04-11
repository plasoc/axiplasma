# GCC MIPS cross compiler for Linux/Msys2 is assumed.
#MIPS_GCC_BIN = C:/mips-none-elf-newlib/bin/
#MIPS_GCC_LIB = C:/mips-none-elf-newlib/mips-none-elf/lib
MIPS_GCC_BIN = /opt/mips_cross_compiler/mips/bin/
MIPS_GCC_LIB = /opt/mips_cross_compiler/mips/mips-none-elf/lib
MISC_DIR = ../../../misc
PLASMA_DIR = ../../plasma
PLASOC_DIR = ../../plasoc
FREERTOS_DIR = ../../freertos
CFLAGS = -O3 -Wall -s -I$(PLASMA_DIR) -I$(PLASOC_DIR) -I$(FREERTOS_DIR) 
LDSTART_ADDRESS = 0x01000000
LDFLAGS = 
LDAFTERFLAGS = -L$(MIPS_GCC_LIB) -static -lc -T$(PLASOC_DIR)/linker.ld
SERIALPORT = /dev/ttyUSB1
INSTALL_DIR = ../../../hdl/projects/Nexys4/
VC707_INSTALL_DIR = ../../../hdl/projects/Nexys4/
PREFIX = $(MIPS_GCC_BIN)mips-none-elf-
SUFFIX =
C_SOURCES = main.c $(PLASOC_DIR)/plasoc_cpu.c $(FREERTOS_DIR)/list.c $(FREERTOS_DIR)/queue.c $(FREERTOS_DIR)/tasks.c $(FREERTOS_DIR)/port.c $(FREERTOS_DIR)/heap_4.c
ASM_SOURCES = $(PLASMA_DIR)/boot.asm $(FREERTOS_DIR)/port_asm.asm
BIN2COE = python2 $(MISC_DIR)/bin2coe.py --swap_bytes --vhdl_hex
ICSP = python2 $(MISC_DIR)/icsp.py 
ICSPFLAGS = --serial_port $(SERIALPORT)

CFLAGS += -c -fno-pic -mips1 -mno-abicalls 
RM = find
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
	$(LD_MIPS) $(LDFLAGS) -Ttext=$(LDSTART_ADDRESS) -e entry -Map $(EXEC_NAME).map -s -N -o $(EXEC_NAME).axf \
		$(notdir $(OBJECTS:=.o)) $(LDAFTERFLAGS)
	$(DUMP_MIPS) --disassemble-all $(EXEC_NAME).axf > $(EXEC_NAME).lst
else
	$(LD_MIPS) $(LDFLAGS) -Ttext=$(LDSTART_ADDRESS) -e entry -s -N -o $(EXEC_NAME).axf \
		$(notdir $(OBJECTS:=.o)) $(LDAFTERFLAGS)
endif
	$(OBJCOPY_MIPS) -I elf32-big -O binary $(EXEC_NAME).axf $(EXEC_NAME).bin
	$(BIN2COE) $(EXEC_NAME).bin $(EXEC_NAME)_pack.vhd --package_name $(EXEC_NAME)_pack

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
	install -c $(EXEC_NAME)_pack.vhd $(INSTALL_DIR)
else
	@echo Not installing, no installation directory selected
endif
ifneq ($(VC707_INSTALL_DIR),)
	install -d $(VC707_INSTALL_DIR)
	install -c $(EXEC_NAME)_pack.vhd $(VC707_INSTALL_DIR)
else
	@echo Not installing, no installation directory selected
endif

launch:
	$(ICSP) $(EXEC_NAME).bin $(ICSPFLAGS)

clean:
	$(RM) . -name "*.o" -type f -delete
	$(RM) . -name "*.axf" -type f -delete
	$(RM) . -name "*.hex" -type f -delete
	$(RM) . -name "*.map" -type f -delete
	$(RM) . -name "*.lst" -type f -delete
	$(RM) . -name "*.vhd" -type f -delete
	$(RM) . -name "*.s" -type f -delete
