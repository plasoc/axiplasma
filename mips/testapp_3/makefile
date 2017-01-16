# The CC_X86 is for compiling tools on your PC.
# The GCC_MIPS is for compiling code on the target.
# Convert_bin changes test.axf into code.txt which is used by the VHDL.
# Convert_bin == "objcopy -I elf32-big -O binary test.axf test.bin"


ifeq ($(LANG),)

# Customize for Windows
# The MIPS gcc compiler must use the cygwin1.dll that came with the compiler.
CC_X86 = cl /O1 /nologo
CP = copy
RM = del
DWIN32 = -DWIN32
BIN_MIPS = ..\gccmips_elf
VHDL_DIR = ..\vhdl
LINUX_PWD =
GCC_MIPS  = $(BIN_MIPS)\gcc $(CFLAGS)
AS_MIPS   = $(BIN_MIPS)\as
LD_MIPS   = $(BIN_MIPS)\ld
DUMP_MIPS = $(BIN_MIPS)\objdump
CONVERT_BIN = $(LINUX_PWD)convert_bin.exe

else

# Customized for Linux
# See http://www.opencores.com/projects.cgi/web/mips/linux_tools.htm
CC_X86 = gcc -Wall -O -g
CP = cp
RM = rm -rf 
DWIN32 =
BIN_MIPS = /opt/cross-compiler-mips/bin/
LD_DIR = /opt/cross-compiler-mips/lib/
VHDL_DIR = ../vhdl
LINUX_PWD = ./
PLASMA_DIR = ../plasma/
GCC_MIPS = $(BIN_MIPS)mips-gcc $(CFLAGS)
AS_MIPS = $(BIN_MIPS)mips-as
LD_MIPS = $(BIN_MIPS)mips-ld $(LFLAGS)
DUMP_MIPS = $(BIN_MIPS)mips-objdump
CONVERT_BIN = $(BIN_MIPS)mips-objcopy -I elf32-big -O binary main.axf main.bin 

endif

CFLAGS = -O0 -Wall -c -s
CFLAGS += -fno-pic -mips1 -mno-abicalls -I$(PLASMA_DIR)
LFLAGS = -L$(LD_DIR)

all:
	$(AS_MIPS) -o boot.o $(PLASMA_DIR)boot.asm 
	$(GCC_MIPS) main.c -std=c99
	$(GCC_MIPS) main.c -std=c99 -S
	$(GCC_MIPS) $(PLASMA_DIR)no_os.c 
	$(LD_MIPS) -Ttext 0 -e entry -Map main.map -s -N -o main.axf \
		boot.o main.o no_os.o
	-$(DUMP_MIPS) --disassemble-all main.axf > main.lst
	$(CONVERT_BIN)

clean:
	-$(RM) *.o *.obj *.map *.lst *.hex *.txt *.exe *.axf

