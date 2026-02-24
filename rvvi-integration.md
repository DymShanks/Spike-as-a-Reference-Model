# Integrating Spike with RVVI for Tandem Simulation

This guide outlines the methodology for integrating the RISC-V Verification Interface (RVVI) into the `riscv-isa-sim` (Spike) build system to enable bare-metal tandem simulation as a reference model.

## 1. Architectural Overview
When running Spike with bare-metal code for tandem simulation, the OS boot sequence is bypassed to simplify initialization. The custom RVVI C-API bridge is designed to accept the `processor_t` pointer directly from the testbench. This allows the extraction hooks (e.g., `rvviRefPcGet`, `rvviRefGprGet`) to cleanly map to Spike's internal architectural state.

## 2. Build System Integration
Spike utilizes an autotools-based build system. To compile the RVVI bridge seamlessly into the core simulator, the source file must be injected into the primary makefile definitions.

1. Place the custom bridge source (`rvvi_bridge.cc`) into the core `riscv/` directory.
2. Modify the autotools manifest to include the new component:

**File:** `riscv/riscv.mk.in`
```makefile
riscv_srcs = \
  rvvi_bridge.cc \
  processor.cc \
  execute.cc \
  # ... (existing files)
```

## 3. Configuration and Compilation
To ensure the internal headers resolve properly during compilation, the path to the official RVVI standard headers must be passed to the configure script using `CPPFLAGS`.

```bash
# Create a dedicated build directory
mkdir build
cd build

# Run configure with RVVI header paths
../configure CPPFLAGS="-I/path/to/rvvi-standard/include/host/"

# Compile the simulator
make -j$(nproc)
```
```
This configuration successfully bakes the RVVI bridge directly into the core `libriscv.a` static library and links it into the final `spike` executable without modifying the root build architecture.
