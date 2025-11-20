BANNER_TOP   = "\n*******************************************************************************"
BANNER_BOT   = "*******************************************************************************"
INFO         = " Spike CV32E40P example\n"
INFO        += "Compiles the example test-program 'eg.S' for rv32imc_zicsr_zifencei\n"
INFO        += "Simulates using Spike.\n"
INFO        += "\n Type 'make all' to run it."
RISCV       ?= riscv32-unknown-elf-
MARCH       ?= rv32imc_zicsr_zifencei

.PHONY: clean bsp

default: info

all: clean_all bsp cv32e40p.elf spike_cv32e40p

info:
	@echo $(INFO)

bsp:
	@echo $(BANNER_TOP)
	@echo "Compiling the BSP"
	@echo $(BANNER_BOT)
	make -C bsp all

#	$(RISCV)gcc     -o cv32e40p.elf -march=rv32imc_zicsr_zifencei -mabi=ilp32 -nostartfiles -mcmodel=medany -Tlink.ld eg.S

cv32e40p.elf: bsp eg.S
	@echo $(BANNER_TOP)
	@echo "cv32e40p.elf: compile eg.S for the CV32E40P core"
	@echo $(BANNER_BOT)
	$(RISCV)gcc     -o cv32e40p.elf -march=rv32imc_zicsr_zifencei -mabi=ilp32 -nostartfiles -mcmodel=medany eg.S -T bsp/link.ld -I bsp bsp/libcv-verif.a
	$(RISCV)objdump -D cv32e40p.elf > cv32e40p.objdump
	$(RISCV)readelf -a cv32e40p.elf > cv32e40p.readelf

spike_cv32e40p: cv32e40p.elf
	@echo $(BANNER_TOP)
	@echo "spike32: run cv32e40p.elf"
	@echo $(BANNER_BOT)
	spike --isa=rv32imc_zicsr_zifencei -l -m0x00004000:0x410000 cv32e40p.elf

clean_all:
	@echo $(BANNER_TOP)
	@echo "clean_all: remove all generated files, no exceptions"
	@echo $(BANNER_BOT)
	rm -rf *.elf *.objdump *.readelf
	make -C bsp clean
