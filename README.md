# 8-bit Microprocessor (VHDL)

## Project Overview
Designed and implemented a full 8-bit microprocessor from scratch using modular **VHDL** architecture.  
The processor handles **16-bit instructions** using **8-bit data buses** through segmented transfers.

---

## Key Functions
- **ALU** – Performs arithmetic and logic operations.
- **Control Unit** – Decodes instructions and manages control signals.
- **Registers** – Store and manage data during execution.
- **Memory** – ROM and RAM for instructions and data.
- **I/O Interfaces** – Enable communication with external devices.

---

## Development Pipeline
1. Developed each module in a separate VHDL file for modularity.
2. Structured **16-bit instruction format** with defined opcodes and addresses.
3. Simulated and tested each module independently before top-level integration.

---

## Tools & Technologies
- **Vivado** – Design and synthesis
- **ModelSim** – Simulation and waveform analysis
- **VHDL** – Hardware description

---

## Results
- Verified timing using waveform analysis.
- Validated segmented data transfer over 8-bit path.
- Successfully integrated and simulated all modules.

