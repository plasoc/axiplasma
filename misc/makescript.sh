#!/bin/bash

## @file makescript.sh
## @author Kaleb T Barrett
## @date 19 January 2017
## @brief Generates cross-compiler for MIPS architecture.
##
## Doxygen support for Bash can be found here.
## http://rickfoosusa.blogspot.com/2011/08/howto-have-doxygen-support-bash-script.html

PREFIX=/usr/local/$FULL_TARGET
BASE_DIR=$(pwd)
SOURCE_DIR=$BASE_DIR/source
BUILD_DIR=$BASE_DIR/build
LOG_DIR=$BASE_DIR/log
TARGET=mips-none-elf
FULL_TARGET=mips-none-elf-newlib
BINUTILS_VER=2.27
GCC_VER=6.3.0
NEWLIB_VER=2.4.0
MPC_VER=1.0.3
GMP_VER=6.1.2
MPFR_VER=3.1.5
GCC_PASS2_CONF="--enable-lto --enable-languages=c,c++ --with-newlib --enable-interwork --disable-shared --disable-thread"
GCC_PASS1_CONF="--enable-lto --enable-languages=c --without-headers --with-newlib --enable-interwork --disable-shared --disable-thread"
NEWLIB_CONF="--disable-newlib-supplied-syscalls"
BINUTILS_CONF="--enable-lto --enable-interwork"

function gen_heirarchy() {
	mkdir -p $SOURCE_DIR
	mkdir -p $LOG_DIR
	mkdir -p $BUILD_DIR
}

function grab_deps() {
	gen_heirarchy
	cd $SOURCE_DIR
	echo "Grabbing sources if any are missing"
	if [ ! -f binutils-$BINUTILS_VER.tar.bz2 ]; then
		echo "	binutils"
		wget -q https://ftp.gnu.org/gnu/binutils/binutils-$BINUTILS_VER.tar.bz2
		tar -xf binutils-$BINUTILS_VER.tar.bz2
	fi
	if [ ! -f gcc-$GCC_VER.tar.bz2 ]; then
		echo "	GCC"
		wget -q https://ftp.gnu.org/gnu/gcc/gcc-$GCC_VER/gcc-$GCC_VER.tar.bz2 
		tar -xf gcc-$GCC_VER.tar.bz2
	fi
	if [ ! -f newlib-$NEWLIB_VER.*.tar.gz ]; then
		echo "	newlib"
		wget -q ftp://sourceware.org/pub/newlib/$(wget -qO - ftp://sourceware.org/pub/newlib/index.html | grep newlib-2.4.0 | sort -r | head -1 | grep -P -o newlib-$NEWLIB_VER\.[0-9]+\.tar\.gz | uniq)
		tar -xf newlib-$NEWLIB_VER.*.tar.gz
	fi
	if [ ! -f mpc-$MPC_VER.tar.gz ]; then
		echo "	mpc"
		wget -q https://ftp.gnu.org/gnu/mpc/mpc-$MPC_VER.tar.gz 
		tar -xf mpc-$MPC_VER.tar.gz
	fi
	if [ ! -f gmp-$GMP_VER.tar.bz2 ]; then
		echo "	gmp"
		wget -q https://ftp.gnu.org/gnu/gmp/gmp-$GMP_VER.tar.bz2 
		tar -xf gmp-$GMP_VER.tar.bz2
	fi
	if [ ! -f mpfr-$MPFR_VER.tar.bz2 ]; then
		echo "	mpfr"
		wget -q https://ftp.gnu.org/gnu/mpfr/mpfr-$MPFR_VER.tar.bz2 
		tar -xf mpfr-$MPFR_VER.tar.bz2
	fi
	ln -sf $SOURCE_DIR/mpc-$MPC_VER gcc-$GCC_VER/mpc
	ln -sf $SOURCE_DIR/mpfr-$MPFR_VER gcc-$GCC_VER/mpfr
	ln -sf $SOURCE_DIR/gmp-$GMP_VER gcc-$GCC_VER/gmp
	cd $BASE_DIR
}

function build_binutils() {
	grab_deps
	mkdir -p $BUILD_DIR/binutils
	cd $BUILD_DIR/binutils
	if [ ! -f finished ]; then
		echo "Building Binutils"
		$SOURCE_DIR/binutils-$BINUTILS_VER/configure --prefix=$PREFIX --program-prefix=$TARGET- --target=$TARGET $BINUTILS_CONF 2>&1 | tee $LOG_DIR/configure_binutils.log &&
		make -k -j4 2>&1 | tee $LOG_DIR/build_binutils.log &&
		make install 2>&1 | tee $LOG_DIR/install_binutils.log
		if [ $? -ne 0 ]; then
			echo "Building binutils failed"
			exit
		else
			echo "Building binutils succeeded"
			touch finished
		fi
	else
		echo "binutils already built"
	fi
	export PATH=$PATH:$PREFIX/bin
	cd $BASE_DIR
}

function build_gcc_pass1() {
	build_binutils
	mkdir -p $BUILD_DIR/gcc1
	cd $BUILD_DIR/gcc1
	if [ ! -f finished ]; then
		echo "Building GCC (pass 1)"
		$SOURCE_DIR/gcc-$GCC_VER/configure --prefix=$PREFIX --program-prefix=$TARGET- --target=$TARGET $GCC_PASS1_CONF 2>&1 | tee $LOG_DIR/configure_gcc_pass1.log &&
		make -k -j4 all-gcc 2>&1 | tee $LOG_DIR/build_gcc_pass1.log &&
		make install-gcc 2>&1 | tee $LOG_DIR/install_gcc_pass1.log
		if [ $? -ne 0 ]; then
			echo "Building GCC (pass 1) failed"
			exit
		else
			echo "Building GCC (pass 1) succeeded"
			touch finished
		fi
	else
		echo "First pass of GCC already built"
	fi
	cd $BASE_DIR
}

function build_newlib() {
	grab_deps
	mkdir -p $BUILD_DIR/newlib
	cd $BUILD_DIR/newlib
	if [ ! -f finished ]; then
		echo "Building newlib"
		$(find $SOURCE_DIR -type d -name "newlib-$NEWLIB_VER.*")/configure --prefix=$PREFIX --target=$TARGET $NEWLIB_CONF 2>&2 | tee $LOG_DIR/configure_newlib.log &&
		make -k -j4 2>&1 | tee $LOG_DIR/build_newlib.log &&
		make install 2>&1 | tee $LOG_DIR/install_newlib.log
		if [ $? -ne 0 ]; then
			echo "Building newlib failed"
			exit
		else
			echo "Building newlib succeeded"
			touch finished
		fi
	else
		echo "newlib already built"
	fi
	cd $BASE_DIR
}

function build_gcc_pass2() {
	build_gcc_pass1
	build_newlib
	mkdir -p $BUILD_DIR/gcc2
	cd $BUILD_DIR/gcc2
	if [ ! -f finished ]; then
		echo "Building GCC (pass 2)"
		$SOURCE_DIR/gcc-$GCC_VER/configure --prefix=$PREFIX --program-prefix=$TARGET- --target=$TARGET $GCC_PASS2_CONF 2>&1 | tee $LOG_DIR/configure_gcc_pass2.log &&
		make -j4 2>&1 | tee $LOG_DIR/build_gcc_pass2.log &&
		make install 2>&1 | tee $LOG_DIR/install_gcc_pass2.log
		if [ $? -ne 0 ]; then
			echo "Building GCC (pass 2) failed"
			exit
		else
			echo "Building GCC (pass 2) succeeded"
			touch finished
		fi
	else
		echo "Second pass of GCC already built"
	fi
	cd $BASE_DIR
}

function clean_build() {
	gen_heirarchy
	echo "Cleaning up build files"
	rm -rf $LOG_DIR/*
	rm -rf $BUILD_DIR/*
}

function clean_install() {
	echo "Cleaning up install files"
	rm -rf $PREFIX
}

if [ $# -lt 1 ]; then
	echo "Building all"
	build_gcc_pass2
else
	case $1 in
		grab_deps)
			time grab_deps;;
		build_binutils)
			time build_binutils;;
		build_gcc_pass1)
			time build_gcc_pass1;;
		build_gcc_pass2|all)
			time build_gcc_pass2;;
		build_newlib)
			time build_newlib;;
		clean_build)
			clean_build;;
		clean_install)
			clean_install;;
		clean_all|clean)
			clean_build
			clean_install
			;;
		*)
			echo "Invalid argument"
			exit 1
			;;
	esac
fi

