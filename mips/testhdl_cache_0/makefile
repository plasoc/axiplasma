# GCC MIPS cross compiler for Linux is assumed.

CP = cp
RM = rm -rf 
BIN_DIR = /opt/mips_cross_compiler/mips/bin/
LD_DIR = /opt/mips_cross_compiler/mips/mips-none-elf/lib/
PLASMA_DIR = ../plasma/
GCC_MIPS = $(BIN_DIR)mips-none-elf-gcc $(CFLAGS)
AS_MIPS = $(BIN_DIR)mips-none-elf-as
LD_MIPS = $(BIN_DIR)mips-none-elf-ld $(LFLAGS)
DUMP_MIPS = $(BIN_DIR)mips-none-elf-objdump
CONVERT_BIN = $(BIN_DIR)mips-none-elf-objcopy -I elf32-big -O binary main.axf main.bin 

CFLAGS = -Os -Wall -c -s
CFLAGS += -fno-pic -mips1 -mno-abicalls -I$(PLASMA_DIR)
LFLAGS = -L$(LD_DIR)

all:
	$(AS_MIPS) -o boot.o $(PLASMA_DIR)boot.asm 
	$(GCC_MIPS) main.c 
	$(GCC_MIPS) main.c -S
	$(GCC_MIPS) $(PLASMA_DIR)no_os.c 
	$(GCC_MIPS) $(PLASMA_DIR)plasmasoc.c 
	$(GCC_MIPS) $(PLASMA_DIR)plasmasoc.c -S
	$(LD_MIPS) -Ttext 0x0 -e entry -Map main.map -s -N -o main.axf \
		boot.o main.o no_os.o plasmasoc.o
	-$(DUMP_MIPS) --disassemble-all main.axf > main.lst
	$(CONVERT_BIN)

clean:
	-$(RM) *.o *.obj *.map *.lst *.hex *.txt *.exe *.axf

