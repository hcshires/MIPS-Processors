# CPR E 381 Project: Three MIPS Processor Designs - VHDL and Waveform Simulations

![image](https://github.com/hcshires/MIPS-Processors/assets/25646224/73c25f80-61d1-420d-b293-bf000a82df01)

## Authors - Iowa State University Department of Electrical and Computer Engineering

- [Anthony Manschula](https://manschula.dev/): B.S. Computer Engineering Class of 2024
- [Henry Shires](https://hcshires.com): B.S. Computer Engineering Class of 2025

**IMPORTANT:** Before proceeding, ensure that you have reviewed the lab manuals and `cpre381-toolflow.pdf` located in `/manuals`.

## Overview

This repository contains the collaborative work of Anthony Manschula and Henry Shires for the undergraduate CPR E 381 Computer Organization & Assembly-Level Programming lab project at Iowa State University. 

## Design Modules

### 1. Single-Cycle

- Executes MIPS instructions in a single clock cycle.

### 2. Software-Scheduled

- Executes MIPS instructions using a 5-stage multi-cycle pipeline without hardware hazard mitigation.
- Note: MIPS programs tested under this design require the use of No-op instructions (`nop`) to handle data and control hazards.

### 3. Hardware-Scheduled

- Executes MIPS instructions using a 5-stage multi-cycle pipeline with hardware mitigation for data and control hazards.
- All MIPS programs can be tested unmodified for hazards (`nop`s not required).

## Project Structure

### Deliverables
- The root directory includes a [final report](https://github.com/hcshires/MIPS-Processors/blob/3dcc9e478ee680f379c6952cf45d9e31c6596f41/MIPS%20Processors%20-%20Design%20%26%20Analysis%20-%20Anthony%20Manschula%20and%20Henry%20Shires.pdf) of our design steps, analysis, and findings with each processor design and a [spreadsheet](https://github.com/hcshires/MIPS-Processors/blob/3dcc9e478ee680f379c6952cf45d9e31c6596f41/Processor%20Control%20Signals%20-%20TermProj_3_02.xlsx) documenting the core MIPS Instruction Set Architecture (ISA) instructions as handled by our control unit in all three processors.
- The final report also contains a high-level schematic of the single-cycle and pipelined processor hardware.

### Manuals

- `/Manuals` contains PDFs documenting the lab steps and guidelines on using the toolflow.

### Processor Directories

- `[proc]/internal` includes provided boilerplates for the `381_tf.sh` shell script. **DO NOT EDIT THESE**.
- `[proc]/proj` is the project source code and test files. The shell script will automatically generate necessary files based on the steps outlined in the manuals, execute test case assembly scripts, and output test case results.
- `[proc]/temp` includes a timing sheet for each processor that notes the clock frequency and critical path of the processor based on an FPGA sythesis run according to the toolflow instructions.

## Getting Started, Try the designs yourself!

1. Clone this repository to your local machine.
2. Review the lab manual and toolflow documentation in `/manuals`.
3. Navigate to the relevant processor directory `[proc]/proj`.
4. Run the toolflow with the given test cases to see how each processor performs, following the guidelines provided in the manuals.

## Additional Information

For any questions or clarifications, please contact the project authors:

- Anthony Manschula: [anthony@manschula.dev]
- Henry Shires: [hcsgeek@gmail.com]
