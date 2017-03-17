# define this in the envrionment, not the makefile, Andrew...
ifeq ($(MIPS_GCC_BIN),)
	$(error Location of MIPS cross-compiler tools not set in MIPS_GCC_BIN)
endif
ifeq ($(MIPS_GCC_LIB),)
	$(error Location of MIPS cross-compiler libraries not set in MIPS_GCC_LIB)
endif
MISC_DIR = ../../../misc
PLASMA_DIR = ../../plasma
PLASOC_DIR = ../../plasoc
FREERTOS_DIR = ../../freertos
CFLAGS = -Os -Wall -s -I$(PLASMA_DIR) -I$(PLASOC_DIR) -I$(FREERTOS_DIR) -DENABLE_PRINTF
LDSTART_ADDRESS = 0x01000000
LDFLAGS = 
LDAFTERFLAGS = -L$(MIPS_GCC_LIB) -static -lc -T$(PLASOC_DIR)/linker.ld 
ifeq ($(SERIALPORT),)
	$(error Path to the serial terminal connected to bootloader not set in SERIALPORT)
endif
INSTALL_DIR = ../../../hdl/testbenches/timer_interrupt_tb/
PREFIX = $(MIPS_GCC_BIN)mips-none-elf-
SUFFIX =
C_SOURCES = ./tm_porting_layer_freertos.c $(PLASOC_DIR)/printf.c $(PLASOC_DIR)/plasoc_cpu.c $(FREERTOS_DIR)/list.c $(FREERTOS_DIR)/queue.c $(FREERTOS_DIR)/tasks.c $(FREERTOS_DIR)/port.c $(FREERTOS_DIR)/heap_4.c
ASM_SOURCES = $(PLASMA_DIR)/boot.asm $(FREERTOS_DIR)/port_asm.asm
BIN2COE = python2 $(MISC_DIR)/bin2coe.py --swap_bytes --vhdl_hex
ICSP = python2 $(MISC_DIR)/icsp.py 
ICSPFLAGS = --serial_port $(SERIALPORT)

CFLAGS += -c -fno-pic -mips1 -mno-abicalls
RM = rm

GCC_MIPS = $(PREFIX)gcc$(SUFFIX)
AS_MIPS = $(PREFIX)as$(SUFFIX)
LD_MIPS = $(PREFIX)ld$(SUFFIX)
DUMP_MIPS = $(PREFIX)objdump$(SUFFIX)
OBJCOPY_MIPS = $(PREFIX)objcopy$(SUFFIX)
STRIP_MIPS = $(PREFIX)strip$(SUFFIX)

ASM_OBJECTS = $(ASM_SOURCES:.asm=)
C_OBJECTS = $(C_SOURCES:.c=)

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
		$(@:%.bin=%.o) $(LDAFTERFLAGS)
	$(DUMP_MIPS) --disassemble-all $(@:%.bin=%.axf) > $(@:%.bin=%.lst)
else
	$(LD_MIPS) $(LDFLAGS) -Ttext=$(LDSTART_ADDRESS) -e entry -s -N -o $(@:%.bin=%.axf) \
		$(@:%.bin=%.o) $(LDAFTERFLAGS)
endif
	$(OBJCOPY_MIPS) -I elf32-big -O binary $(@:%.bin=%.axf) $@
	$(BIN2COE) $@ $(@:%.bin=%_pack.vhd) --package_name main_pack
	
clean:
	$(RM) . -name "*.o" -type f -delete
	$(RM) . -name "*.axf" -type f -delete
	$(RM) . -name "*.hex" -type f -delete
	$(RM) . -name "*.map" -type f -delete
	$(RM) . -name "*.lst" -type f -delete
	$(RM) . -name "*.bin" -type f -delete
	$(RM) . -name "*.vhd" -type f -delete
	$(RM) . -name "*.s" -type f -delete

