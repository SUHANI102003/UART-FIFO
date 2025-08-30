<div align="center">

# 🚀 UART Protocol with FIFO Buffers

<img src="https://img.shields.io/badge/Language-Verilog-blue?style=for-the-badge" alt="Verilog" />
<img src="https://img.shields.io/badge/Protocol-UART-green?style=for-the-badge" alt="UART" />
<img src="https://img.shields.io/badge/Buffer-FIFO-orange?style=for-the-badge" alt="FIFO" />

</div>

---
## 📝 Overview

A Verilog-based **UART (Universal Asynchronous Receiver/Transmitter)** design integrated with **FIFO buffers** to enable efficient and reliable serial communication between devices.

### UART
A universal asynchronous receiver and transmitter (UART) is a circuit that sends and receives data through a serial line.

---

## ✨ Features

- **Full-Duplex Communication**: Transmit and receive data simultaneously.  
- **FIFO Buffers**: Smooth data handling between transmitter and receiver to prevent overflow or data loss.  
- **Configurable Parameters**: Adjustable baud rate, data bits, stop bits, and parity options.  
- **Self-Checking Testbenches**: Verify the functionality of UART and FIFO modules through simulation.  

---

## Design Details

### Block Diagram

<img width = "700" height = "500" src = "https://github.com/SUHANI102003/UART-FIFO/blob/main/assets/Screenshot%202025-08-03%20052922.png" alt = "diagram" />


### Transmitter ASMD Chart
<img width = "700" height = "700" src = "https://github.com/SUHANI102003/UART-FIFO/blob/main/assets/Screenshot%202025-08-03%20074655.png" alt = "tx" />


### Receiver ASMD Chart
<img width = "700" height = "800" src = "https://github.com/SUHANI102003/UART-FIFO/blob/main/assets/Screenshot%202025-08-03%20063356.png" alt = "rx" />


## 📂 Directory Structure
```
├── uart.v # Top-level UART module
├── uart_tx.v # UART transmitter
├── uart_rx.v # UART receiver
├── fifo.v # FIFO buffer module
├── uart_tb.v # UART testbench
├── fifo_tb.v # FIFO testbench
└── README.md # Project documentation
```

---

## 🛠️ Module Details

- **uart.v**: Integrates UART transmitter, receiver, and FIFO.  
- **uart_tx.v**: Handles serial data transmission.  
- **uart_rx.v**: Handles serial data reception.  
- **fifo.v**: Manages data buffering between TX and RX.  
- **uart_tb.v** & **fifo_tb.v**: Testbenches for simulation and verification.  

---

## 💻 Simulation 

### Requirements

- **Simulator**: ModelSim, Vivado Simulator, or any Verilog-compatible tool.  
- **FPGA Tool**: Quartus, Vivado, or any synthesis tool for FPGA deployment.  

### Simulation Steps

1. Compile all Verilog modules and testbenches.  
2. Load testbenches into the simulator.  
3. Run simulation and verify waveforms for correct data transfer.  


---

## 📜 License

This project is licensed under the MIT License.  



