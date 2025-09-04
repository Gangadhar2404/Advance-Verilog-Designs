# Sequential Multiplier (Add & Decrement Method)

This project implements a **sequential multiplier** using the classic
**add-and-shift / add-and-decrement** approach.  
The design is split into two parts:

- **Datapath** – performs arithmetic operations (add, decrement, zero-check).  
- **Controller (FSM)** – generates control signals to orchestrate the datapath.  

---

## 📂 Project Structure

├── datapath.v # Datapath design
├── controller.v # FSM Controller
├── mul_test.v # Testbench
├── README.md # Documentation



---

## 🧩 Modules

### 1. `Pipo` and `Pipo1`
Parallel-in, Parallel-out registers used to store operands and result.

### 2. `adder`
Simple 16-bit combinational adder.

### 3. `decrement`
Register with decrement logic (used as loop counter).

### 4. `eqz`
Zero-detection logic (checks when counter reaches 0).

### 5. `datapath`
Interconnects registers, adder, decrementer, and comparator.

### 6. `controller`
Finite State Machine (FSM) to control loading, clearing, decrementing,
and checking for completion.

### 7. `MUL_test`
Testbench to simulate multiplier behavior.

---

## 🏗️ How It Works

1. **Load A** into register X.  
2. **Load B** into counter register.  
3. Clear the result register.  
4. Loop until counter = 0:
   - Add A to result register.  
   - Decrement counter.  
5. When counter reaches zero, multiplication is done.

---

## 🚦 State Machine

- **S0** – Idle, wait for `start`.  
- **S1** – Load first operand (A).  
- **S2** – Load second operand (B) and clear result.  
- **S3** – Loop: if counter ≠ 0 → add & decrement.  
- **S4** – Done, assert `done` flag.  

---

## ▶️ Simulation

### Example:  
Inputs:  
A = 17
B = 5

Expected Product:  
17 × 5 = 85


### Waveform:
- Result register increments by 17 each cycle until 85.  
- `done` signal asserted when multiplication completes.

---

## 🛠️ Running Simulation

1. Open project in your Verilog simulator (e.g., Icarus Verilog, ModelSim, GTKWave).  
2. Compile and run:

```bash
iverilog -o mul datapath.v controller.v mul_test.v
vvp mul
gtkwave mul.vcd
