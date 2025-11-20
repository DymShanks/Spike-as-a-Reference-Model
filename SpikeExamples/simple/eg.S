# Directive to declare the start of a text (program) section of memory.
.section .text

# The linker expects a global label at the top of the initial text section.
# This label must also appear as the ENTRY point in the linker control script.
#
# A lot of RVI supported software tools seem to use "rvtest_entry_point" for
# this global label, but really, anything _should_ work if its consistent
# across both the program and the linker control script.
.globl rvtest_entry_point
rvtest_entry_point:
    li a0, 42

# A write to the label 'tohost' will cause Spike to terminate the simulation.
write_to_host:
    la t1, tohost # Load address of tohost label into t1
    li t0, 1      # 1 for success, 3 for failure
    sw t0, 0(t1)  # Send success code

# In CORE-V-VERIF we typically end a test-program with a
# wait-for-interrupt to ensure idling of the pipeline.
    wfi

#.section .tohost
.section .spike_labels
tohost:
    .dword 0
fromhost:
    .dword 0
