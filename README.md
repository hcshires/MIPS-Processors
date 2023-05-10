# CPR E 381 Project: Three MIPS Processor Designs - VHDL and Waveform Simulations

### Iowa State University Department of Electrical and Computer Engineering

## Authors

> Anthony Manschula: Team Member, Computer Engineering

> Henry Shires: Team Member, Computer Engineering

**IMPORTANT:** Please read the lab manual and `cpre381-toolflow.pdf` found in `/manuals` before proceeding.

## Design Modules

`Single-Cycle` - Executes MIPS instructions in a single cycle

`Software-Scheduled` - Executes MIPS instructions using a 5-stage multi-cycle pipeline without hardware hazard mitigation. All MIPS programs tested require the use of No-op instructions or `nop`s with data and control hazards

`Hardware-Scheduled` - Executes MIPS instructions using a 5-stage multi-cycle pipeline WITH hardware hazard mitigation. All MIPS programs can be tested unmodified for hazards.

## Project Files

`/Manuals` - PDFs documenting the lab steps and how to use the toolflow

`[proc]/internal` - Provided boilerplates for the shell script to utilize. **DO NOT EDIT THESE**

`[proc]/proj` - Project source code and test files. Edit and write the project solutions here. The shell script will automatically generate needed files based on the steps in the manuals.
