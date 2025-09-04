# Pipelined Arithmetic Unit

This project implements a **3-stage pipelined arithmetic design** in Verilog.  
The module computes:

f = ((a + b) + (c - d)) * d


using pipeline registers to improve throughput.

---

## 📂 Project Structure

├── pipelining.v # Pipelined design
├── README.md # Documentation


---

## 🧩 Module Description

### `pipelining #(parameter N=10)`
- **Inputs:**
  - `a, b, c, d` → N-bit operands
  - `clk` → clock signal
- **Output:**
  - `f` → N-bit result

### Internal Pipeline Registers
- **Stage 1:**  
  - `L12_x1 = a + b`  
  - `L12_x2 = c - d`  
  - `L12_d  = d`

- **Stage 2:**  
  - `L23_x3 = L12_x1 + L12_x2`  
  - `L23_d  = L12_d`

- **Stage 3:**  
  - `L34_f = L23_x3 * L23_d`

Final result is stored in `L34_f` and assigned to `f`.

---

## 🚦 Pipeline Stages

1. **Stage 1 (Input Stage):**
   - Perform addition and subtraction in parallel.
   - Pass operand `d` forward for later use.

2. **Stage 2 (Intermediate Stage):**
   - Add the results from stage 1.

3. **Stage 3 (Output Stage):**
   - Multiply the sum with the forwarded operand `d`.

---

## 🏗️ Timing & Throughput

- **Latency:** 3 clock cycles (result available after 3 cycles).  
- **Throughput:** 1 result per clock cycle (after pipeline is filled).  

---

## ▶️ Simulation Example

For inputs:  
a = 5, b = 7, c = 12, d = 3


Final output:  
f = 63


---

## 🛠️ Running Simulation

1. Save `pipelining.v`.  
2. Run with Icarus Verilog:

```bash
iverilog -o pipe pipelining.v testbench.v
vvp pipe
gtkwave pipe.vcd
