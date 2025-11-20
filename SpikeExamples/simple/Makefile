BANNER_TOP   = "\n*******************************************************************************"
BANNER_BOT   = "*******************************************************************************"
INFO         = " Spike simple example\n"
INFO        += "Compiles the example test-program 'eg.S' for both rv32i and rv64i.\n"
INFO        += "Simulates both versions using Spike.\n"
INFO        += "\n Type 'make all' to run it."
RISCV       ?=/opt/riscv/bin/riscv32-unknown-elf-

default: info

all: clean_all example32.elf example64.elf spike32 spike64

info:
	@echo $(INFO)

example32.elf: eg.S
	@echo $(BANNER_TOP)
	@echo "example32: compile eg.S for an RV32I machine"
	@echo $(BANNER_BOT)
	$(RISCV)gcc     -o example32.elf -march=rv32i -mabi=ilp32 -nostartfiles -mcmodel=medany -Tlink.ld eg.S
	$(RISCV)objdump -D example32.elf > example32.objdump
	$(RISCV)readelf -a example32.elf > example32.readelf

example64.elf: eg.S
	@echo $(BANNER_TOP)
	@echo "example64: compile eg.S for an RV64I machine"
	@echo $(BANNER_BOT)
	$(RISCV)gcc     -o example64.elf -march=rv64i -mabi=lp64 -nostartfiles -mcmodel=medany -Tlink.ld eg.S
	$(RISCV)objdump -D example64.elf > example64.objdump
	$(RISCV)readelf -a example64.elf > example64.readelf

spike32: example32.elf
	@echo $(BANNER_TOP)
	@echo "spike32: run example32"
	@echo $(BANNER_BOT)
	spike --isa=rv32i -l -m0x00004000:0x410000 example32.elf

spike64: example64.elf
	@echo $(BANNER_TOP)
	@echo "spike64: run example64"
	@echo $(BANNER_BOT)
	spike --isa=rv64i -l -m0x00004000:0x410000 example64.elf

clean_all:
	@echo $(BANNER_TOP)
	@echo "clean_all: remove all generated files, no exceptions"
	@echo $(BANNER_BOT)
	rm -rf example??.* *.obj *.readelf
