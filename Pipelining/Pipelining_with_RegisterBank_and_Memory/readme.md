# Pipelined ALU with Register Bank and Memory

This project implements a **multi-stage pipelined ALU** in Verilog with
register bank and memory support.  
The design uses two clocks (`clk1`, `clk2`) to separate pipeline stages.

---

## 📂 Project Structure

├── pipelining.v # Pipelined ALU + memory design
├── README.md # Documentation


---

## 🧩 Module: `pipelining`

### **Inputs**
- `rs1`, `rs2` : 4-bit register source addresses  
- `rd` : 4-bit register destination address  
- `func` : 4-bit ALU operation selector  
- `clk1`, `clk2` : two-phase clocks for pipelining  
- `addr` : 8-bit memory address  

### **Outputs**
- `z_out` : Final ALU result  
- `mem_out_signal` : Memory output at address `addr`

---

## 🏗️ Pipeline Stages

### **Stage 1 (Instruction Fetch / Decode) – `clk1`**
- Read operands `rs1`, `rs2` from `regbank`.  
- Latch destination `rd`, function `func`, and memory `addr`.

Registers:
- `L12_a`, `L12_b`, `L12_rd`, `L12_func`, `L12_addr`

---

### **Stage 2 (Execution) – `clk2`**
- Perform ALU operation based on `func`.  
- Store result in `L23_z`.  
- Forward `rd` and `addr`.

Supported operations:
- `0000` : ADD  
- `0001` : SUB  
- `0010` : MUL  
- `0011` : AND  
- `0100` : OR  
- `0101` : XOR  
- `0110` : Pass A  
- `0111` : Pass B  
- `1000` : Neg A  
- `1001` : Neg B  
- `1010` : A >> 1  
- `1011` : B >> 1  

Registers:
- `L23_z`, `L23_rd`, `L23_addr`

---

### **Stage 3 (Write Back + Memory Write) – `clk1` & `clk2`**
- **`clk1`:**  
  - Write result `L23_z` into destination register `rd`.  
  - Forward result to `L34_z`.  
  - Latch memory address.

- **`clk2`:**  
  - Write `L34_z` into memory at `L34_addr`.

Registers:
- `L34_z`, `L34_addr`

---

## 🧮 Example Flow

1. Load operands from register bank.  
2. Perform selected ALU operation.  
3. Write result back to `regbank`.  
4. Store result into memory at given address.

Example:  
rs1 = 3, rs2 = 4, rd = 5, func = ADD
regbank[3] = 7, regbank[4] = 2

Pipeline Execution:

Stage 1: L12_a = 7, L12_b = 2
Stage 2: L23_z = 7 + 2 = 9
Stage 3: regbank[5] = 9, mem[addr] = 9


Final Output:
z_out = 9
mem_out_signal = 9


---

## 🚦 Timing & Pipeline Notes

- Two-phase clocks (`clk1`, `clk2`) ensure no read/write hazards.  
- Each instruction completes in **3 cycles latency**.  
- Throughput: 1 instruction per cycle (after pipeline is filled).  

---

## 🛠️ Running Simulation

1. Save `pipelining.v`.  
2. Write a testbench (`testbench.v`) that initializes regbank and applies inputs.  
3. Compile and run:

```bash
iverilog -o pipe pipelining.v testbench.v
vvp pipe
gtkwave pipe.vcd
