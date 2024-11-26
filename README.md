# ICS3203-CAT2-Assembly-MachariaHopeWaithera

## Overview
This repository contains assembly language programs developed for the CAT2 assignment. The tasks cover concepts in assembly programming, including control flow, array manipulation, modular programming, and data monitoring with port-based simulation.

---

## Tasks
### Task 1: Control Flow and Conditional Logic
**Purpose**: Classify a user-input number as:
- **POSITIVE**
- **NEGATIVE**
- **ZERO**

The program demonstrates branching logic using conditional and unconditional jumps.

### Task 2: Array Manipulation with Looping and Reversal
**Purpose**: Accepts an array of integers, reverses it in place, and outputs the reversed array. No additional memory is used for reversal.

### Task 3: Modular Program with Subroutines for Factorial Calculation
**Purpose**: Computes the factorial of a number using a subroutine. Demonstrates modular programming and register management with the stack.

### Task 4: Data Monitoring and Control Using Port-Based Simulation
**Purpose**: Simulates a control system that monitors a "sensor" and performs actions like turning on/off a motor or triggering an alarm based on the sensor's value.

---

## Compilation and Execution Instructions
### Prerequisites
- **NASM** (Netwide Assembler)
- **Linux environment** (Native/Virtual Machine/WSL)
- **GCC or LD** (Linker)

### Steps to Compile and Run:
1. Clone the repository:
   ```bash
   git clone https://github.com/Intelligentlyfavoured/ICS3203-CAT2-Assembly-MachariaHopeWaithera.git
  

2. Navigate to the desired task directory:
   ```bash
   cd ICS3203-CAT2-Assembly-HopeMacharia
3. Assemble the code using an assembler: filename in this case represents TASK1, TASK2, TASK3, TASK4
   ```bash
   nasm -f bin <filename>.asm -o <filename>.com

ICS3203-CAT2-Assembly-MachariaHopeWaithera-150326>/
│
├── Task1-ControlFlow/
│   ├── TASK1.asm
│  
│
├── Task2-ArrayReversal/
│   ├── TASK2.asm
│   
│
├── Task3-FactorialSubroutine/
│   ├── TASK3.asm
│   
│
└── Task4-PortSimulation/
    ├── TASK4.asm
    


   
