/*
 * Simple linker control script for compiling Spike test-programs.
 * Defines a non-default memory region and places the .text and
 * .tohost symbols in that memory region.
 */

OUTPUT_ARCH( "riscv" )
ENTRY(rvtest_entry_point)

MEMORY
{
/* name (attr) : ORIGIN = <start_addr>, LENGTH = <length> */
/*       attr : "r" is "read-able"   */
/*              "w" is "write-able"  */
/*              "x" is "executable"  */
/*              "a" is "allocated"   */
/*              "i" is "initialized" */

/*  imem is read-able, executable, NOT write-able, allocated or initialized */
  imem (rx!wai) : ORIGIN = 0x00008000, LENGTH = 0x400000

/*  mmio is read-able, write-able, NOT executable, allocated or initialized */
  mmio (rw!xai) : ORIGIN = 0x00004000, LENGTH = 0x100
}

SECTIONS
{
  .text : {
    *(.text)
  } > imem

  .spike_labels : ALIGN(0x1000)
  {
    *(.tohost)
  } > mmio

  _end = .;
}
