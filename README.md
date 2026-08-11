# SPI-master-and-save
SPI Master Using Verilog

Description

A Verilog-based SPI Master that communicates with an SPI slave using serial clock, MOSI, MISO, and chip-select signals.

Features

- 8-bit serial data transfer
- SPI Master operation
- MOSI and MISO communication
- Clock generation
- Chip Select control
- Synthesizable Verilog RTL

Signals

Signal| Direction| Description
clk| Input| System clock
rst| Input| Active-high reset
start| Input| Starts SPI transfer
data_in| Input| 8-bit data to transmit
miso| Input| Data from SPI slave
sclk| Output| SPI clock
mosi| Output| Master Out Slave In
cs| Output| Chip Select
data_out| Output| Received 8-bit data
done| Output| Transfer completion

Working

1. Apply reset to initialize the SPI Master.
2. Load 8-bit data into "data_in".
3. Set "start" high to begin transmission.
4. The SPI Master generates the serial clock.
5. Data is transmitted through MOSI.
6. Data is received through MISO.
7. After 8 bits, "done" becomes high and the received data is available at "data_out".

Tools

- Verilog HDL
- Icarus Verilog / ModelSim / Vivado
- GTKWave for waveform simulation

Applications

- Sensor interfacing
- Flash memory communication
- ADC/DAC interfacing
- Microcontroller peripheral communication
author:sai teja sree 
