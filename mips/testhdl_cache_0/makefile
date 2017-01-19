# GCC MIPS cross compiler for Linux is assumed.

CP = cp
RM = rm -rf 
DWIN32 =
BIN_MIPS = /opt/cross-compiler-mips/bin/
LD_DIR = /opt/cross-compiler-mips/lib/
LINUX_PWD = ./
PLASMA_DIR = ../plasma/
GCC_MIPS = $(BIN_MIPS)mips-gcc $(CFLAGS)
AS_MIPS = $(BIN_MIPS)mips-as
LD_MIPS = $(BIN_MIPS)mips-ld $(LFLAGS)
DUMP_MIPS = $(BIN_MIPS)mips-objdump
CONVERT_BIN = $(BIN_MIPS)mips-objcopy -I elf32-big -O binary main.axf main.bin 

CFLAGS = -O3 -Wall -c -s
CFLAGS += -fno-pic -mips1 -mno-abicalls -I$(PLASMA_DIR)
LFLAGS = -L$(LD_DIR)

all:
	$(AS_MIPS) -o boot.o $(PLASMA_DIR)boot.asm 
	$(GCC_MIPS) main.c 
	$(GCC_MIPS) main.c -S
	$(GCC_MIPS) $(PLASMA_DIR)no_os.c 
	$(GCC_MIPS) $(PLASMA_DIR)plasmasoc.c 
	$(GCC_MIPS) $(PLASMA_DIR)plasmasoc.c -S
	$(LD_MIPS) -Ttext 0 -e entry -Map main.map -s -N -o main.axf \
		boot.o main.o no_os.o plasmasoc.o -static -lc
	-$(DUMP_MIPS) --disassemble-all main.axf > main.lst
	$(CONVERT_BIN)

clean:
	-$(RM) *.o *.obj *.map *.lst *.hex *.txt *.exe *.axf

