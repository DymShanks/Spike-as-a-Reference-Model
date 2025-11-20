# Copyright 2025, OpenHW Foundation
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
#
# Makefile for the CV32E40P Board Support Package.
# Generates libcv-verif.a which is assumed to be used as a library for CV32E40P test-programs running in CORE-V-VERIF.

CV_SW_TOOLCHAIN  ?= /opt/riscv
RISCV            ?= $(CV_SW_TOOLCHAIN)
RISCV_EXE_PREFIX ?= $(RISCV)/bin/riscv32-unknown-elf-
#RISCV_GCC = $(RISCV_EXE_PREFIX)gcc
#RISCV_AR = $(RISCV_EXE_PREFIX)ar
RISCV_GCC = $(RISCV)gcc
RISCV_AR = $(RISCV)ar
MARCH ?= rv32imc_zicsr_zifencei
SRC = crt0.S handlers.S syscalls.c vectors.S
OBJ = crt0.o handlers.o syscalls.o vectors.o
LIBCV-VERIF = libcv-verif.a
CFLAGS ?= -Os -g -static -mabi=ilp32 -march=$(MARCH) -Wall -pedantic

all: clean $(LIBCV-VERIF)

$(LIBCV-VERIF): $(OBJ)
	$(RISCV_AR) rcs $@ $(OBJ)

%.o : %.c
	$(RISCV_GCC) $(CFLAGS) -c $< -o $@

%.o : %.S
	$(RISCV_GCC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJ) $(LIBCV-VERIF)


vars:
	@echo "make bsp variables:"
	@echo "   CV_SW_TOOLCHAIN  = $(CV_SW_TOOLCHAIN)"
	@echo "   CV_SW_MARCH      = $(CV_SW_MARCH)"
	@echo "   RISCV            = $(RISCV)"
	@echo "   RISCV_EXE_PREFIX = $(RISCV_EXE_PREFIX)"
	@echo "   RISCV_GCC        = $(RISCV_GCC)"
	@echo "   RISCV_MARCH      = $(RISCV_MARCH)"

