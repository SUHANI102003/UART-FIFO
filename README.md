<div align="center">

# 🚀 UART Protocol with FIFO Buffers

<img src="https://img.shields.io/badge/Language-Verilog-blue?style=for-the-badge" alt="Verilog" />
<img src="https://img.shields.io/badge/Protocol-UART-green?style=for-the-badge" alt="UART" />
<img src="https://img.shields.io/badge/Buffer-FIFO-orange?style=for-the-badge" alt="FIFO" />

</div>

---
## 📝 Overview

A Verilog-based **UART (Universal Asynchronous Receiver/Transmitter)** design integrated with **FIFO buffers** to enable efficient and reliable serial communication between devices.

### What is UART?

**UART (Universal Asynchronous Receiver/Transmitter)** is a hardware protocol for **serial communication**, transmitting and receiving data **one bit at a time**.  
It is asynchronous, meaning the transmitter and receiver **do not share a clock**, but agree on a baud rate to interpret data correctly.

**Key Points:**
- Converts parallel data to serial and vice versa.  
- Uses start and stop bits for synchronization.  
- Supports full-duplex communication.  
- Commonly used in microcontrollers, FPGAs, PCs, and peripherals.  

### Why and Where is UART Used?

- **Why:** Simple, cost-effective, and reliable for short distances.  
- **Where:** Communication between microcontrollers, FPGA boards, PCs, sensors, GPS modules, Bluetooth devices, ADCs, etc.

### Working with 16× Oversampling

- Receiver samples the incoming data **16 times per bit period**.  
- Allows detection of the **middle of each bit**, reducing timing errors.  
- Example: For 9600 bps, the sampling clock runs at `9600 × 16 = 153600 Hz`.  
- Start bit detection → sample data bits at 16× rate → stop bit verification.  

---

## ✨ Features

### UART Features
- Asynchronous serial communication.  
- Full-duplex support.  
- Configurable data frame of 5–8 data bits, parity, 1–2 stop bits (Here, 8 data bits, no parity, 1 stop bit)
- Simple hardware implementation.  
- Reliable for short distances.  
- Configurable baud rate.  
- Supports error detection.  
- Widely supported in embedded systems.  

### FIFO Features
- First-In-First-Out data handling.  
- Temporary data storage between producer and consumer.  
- Smooth operation in full-duplex systems.  
- Configurable depth and width.  
- Status signals: full, almost full, empty, almost empty.  
- Reduces data loss during bursts.  
- Hardware-friendly design for FPGA/ASIC systems.  

---

## 🧰 Working
The serial transmission starts with a 'start bit' which is 0, followed by data bits (1 byte), and ends with a 'stop bit'. Here, for simplicity we are not considering parity bits. Transmission of a single byte is show in the following figure:

<img width = "700" height = "500" src = "https://github.com/SUHANI102003/UART-FIFO/blob/main/assets/Screenshot%202025-08-31%20034146.png" />

The transfer is asynchronous, which mean that there is no clock information, therefore the receiver and transmitter must agree on what baud rate,stop bits and parity bit are used. In this example one byte will be transferred with a baud rate of 9600, 1 stop bit and no parity bits.

An oversampling scheme of 16x will be used to estimate the middle point of the data bit at a rate 16 times the baud rate, as shown in the figure below.

<img width = "700" height = "500" src = "https://github.com/SUHANI102003/UART-FIFO/blob/main/assets/Screenshot%202025-08-31%20034214.png" />

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



