# MIPS Single-Cycle 32-bit Processor

## Overview

This project implements a 32-bit single-cycle MIPS processor in Verilog. The design supports a subset of MIPS instructions and is aimed at simulating basic arithmetic, logical, and control flow operations typically used in educational environments to understand processor design and instruction execution.

## Features

- **32-bit Data Path**: The processor supports 32-bit registers and memory addresses.
- **Single-Cycle Execution**: Each instruction is completed in a single clock cycle.
- **Supported Instructions**:
  - Arithmetic: `ADD`, `SUB`, `ADDI`
  - Logical: `AND`, `OR`
  - Memory Access: `LW` (load word), `SW` (store word)
  - Control Flow: `BEQ` (branch if equal), `J` (jump)
 
### Processor Schematic
Here is the schematic for the MIPS single-cycle processor:
![Screenshot 2024-09-22 170751](https://github.com/user-attachments/assets/38a6ef69-ab23-4d7b-9c72-6dcd4eae63e2)

  
## Hierarchy Structure

- **Top_level**
  - **Data_mem**: Memory for data storage
  - **Inst_mem**: Memory for instruction storage
  - **MIPS_Single_Cycle**: Top-level module for single-cycle MIPS architecture
    - **Control_Unit_single_cycle**: Manages control signals for single-cycle operations
      - **main_decoder**: Decodes main control signals
      - **ALU_Decoder**: Decodes ALU operation signals
    - **datapath_Single_cycle**: Implements the data path for single-cycle operations
      - **ALU** (Branch adder): Performs branch address calculation
      - **ALU** (Data adder): Performs arithmetic operations on data
      - **D_reg_n_bit**: N-bit data register for temporary storage
      - **reg_file**: Register file for storing general-purpose registers
      - **sign_extend**: Extends immediate values to appropriate size
      - **ALU** (PC adder): Adds to the program counter for instruction fetch
      - **shifter**: Performs bitwise shifts on data


## Instruction Set

The processor implements a subset of the MIPS instruction set. The supported instructions are:

| Instruction | Operation                  | Format      |
|-------------|----------------------------|-------------|
| `ADD`       | Add                        | `R`         |
| `SUB`       | Subtract                   | `R`         |
| `AND`       | Bitwise AND                | `R`         |
| `OR`        | Bitwise OR                 | `R`         |
| `SLT`       | Set less than              | `R`         |
| `ADDI`      | Add Immediate              | `I`         |
| `LW`        | Load Word                  | `I`         |
| `SW`        | Store Word                 | `I`         |
| `BEQ`       | Branch if Equal            | `I`         |
| `J`         | Jump                       | `J`         |

## Design Details

### Top View of the Processor
The top view of the single-cycle processor with the datapath and control unit is shown below:
![Screenshot 2024-09-22 171123](https://github.com/user-attachments/assets/dcc8623a-4075-40f1-ae1d-c3e1dd1e5be8)

## 1. **Data Path**

The data path is the core of the processor and includes the following components:

- **Register File**: 
  - General-purpose registers used to hold operands and results of operations.

- **ALU**: 
  - Performs arithmetic and logical operations on the data fetched from the register file.
  - Instances:
    - **Branch adder**: Calculates branch addresses.
    - **Data adder**: Performs arithmetic operations on data.
    - **PC adder**: Increments the program counter for the next instruction.

- **D_reg_n_bit**: 
  - N-bit data register used for temporary storage.

- **Sign Extend**: 
  - Extends immediate values to the appropriate size for operations.

- **Shifter**: 
  - Performs bitwise shifts on data.

## 2. Control Unit

The control unit decodes the instruction fetched from instruction memory. Based on the opcode and function fields, it generates control signals that control the behavior of the ALU, register file, memory access, and other components. These control signals determine which operations the ALU performs, whether the register file writes data, or if the processor branches to another instruction.

Key control signals include:

- **Opcode**: The operation code that specifies the instruction type.
- **RegWrite**: Enables writing to a register.
- **RegDst**: Determines which register to write to (destination register).
- **ALUSrc**: Chooses the second operand for the ALU (immediate value or register).
- **Branch**: Indicates whether to branch based on the result of a comparison.
- **MemWrite**: Enables writing to memory.
- **MemtoReg**: Determines the source of data to be written to a register (ALU result or memory data).
- **ALUOp**: Specifies the operation the ALU should perform.


The following table illustrates the control signals for different instructions:
![Screenshot 2024-09-22 170949](https://github.com/user-attachments/assets/beace4f2-be87-481c-8ead-7a55aecb46f8)


### 3. **Instruction Formats**

The processor supports three types of instruction formats: R-type, I-type, and J-type.

- **R-type** (Register): Used for operations involving only registers (e.g., `ADD`, `SUB`, `AND`).
- **I-type** (Immediate): Used for instructions that include an immediate value or memory address (e.g., `ADDI`, `LW`, `SW`).
- **J-type** (Jump): Used for jump instructions that require a direct address (e.g., `J`).

### 4. **Memory Access**

The processor has separate instruction and data memories:
- **Instruction Memory** stores the program’s instructions and is read-only.
- **Data Memory** is used for storing and loading data during execution of instructions like `LW` and `SW`.

Memory access follows the standard MIPS memory hierarchy:
- `LW` (load word) reads a word from memory and stores it in a register.
- `SW` (store word) writes a word from a register to memory.

## Future Work

- **Support for More Instructions**: Expand the instruction set to include more complex MIPS instructions like `BNE` (Branch if Not Equal), `SLT` (Set Less Than), `LUI` (Load Upper Immediate), etc.

