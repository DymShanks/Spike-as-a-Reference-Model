BANNER_TOP   = "\n*******************************************************************************"
BANNER_BOT   = "*******************************************************************************"
INFO         = " Spike CV32E40P example\n"
INFO        += "Compiles the example test-program 'eg.S' for rv32imc_zicsr_zifencei\n"
INFO        += "Simulates using Spike.\n"
INFO        += "\n Type 'make <test-program>.spiked' to run it."
RISCV       ?= riscv32-unknown-elf-
MARCH       ?= rv32imc_zicsr_zifencei

.PHONY: clean bsp

default: info

#all: clean_all bsp cv32e40p.elf spike_cv32e40p

info:
	@echo $(INFO)

bsp:
	@echo $(BANNER_TOP)
	@echo "Compiling the BSP"
	@echo $(BANNER_BOT)
	make -C bsp all

#	$(RISCV)gcc     -o cv32e40p.elf -march=rv32imc_zicsr_zifencei -mabi=ilp32 -nostartfiles -mcmodel=medany -Tlink.ld eg.S

##############################################################################
#    $@ is the file being generated.
#    $< is first prerequiste.
#    $^ is all prerequistes.
#    $* is file_name (w/o extension) of target
##############################################################################

# Generate elf, objdump, readelf and hexfile from assembly source.
%.elf: clean_all bsp %.S
	@echo $(BANNER_TOP)
	@echo "$*.elf: compile $*.S for the CV32E40P core"
	@echo $(BANNER_BOT)
	$(RISCV)gcc     -o $*.elf -march=rv32imc_zicsr_zifencei -mabi=ilp32 -nostartfiles -mcmodel=medany $*.S -T bsp/link.ld -I hdrs bsp/libcv-verif.a
	$(RISCV)objdump -D $*.elf > $*.objdump
	$(RISCV)readelf -a $*.elf > $*.readelf
	$(RISCV)objcopy -O verilog $*.elf $*.hex

# Run Spike on the assembled/compiled source(s).
# We "cat" the logfile since Spike writes it out silently.
%.spiked: %.elf
	@echo $(BANNER_TOP)
	@echo "spike: run $*.elf"
	@echo $(BANNER_BOT)
	spike --isa=rv32imc_zicsr_zifencei -l --log=$*.spike.log -m0x00004000:0x410000 $*.elf
	@cat $*.spike.log
	@touch $*.spiked

clean_all:
	@echo $(BANNER_TOP)
	@echo "clean_all: remove all generated files, no exceptions"
	@echo $(BANNER_BOT)
	rm -rf *.elf *.objdump *.readelf *.hex *.spiked *.spike.log
	make -C bsp clean
