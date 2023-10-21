# pes_tff
# Contents
- [T-flip flop](#t-flip-flop)
- [Iverilog and yosys installation](#iverilog-and-yosys-installation)
- [GLS Process to verify T flip flop ](#gls-process-to-verify-t-flip-flop)

## T-flip flop
T Flip-Flop is a single input logic circuit that holds or toggles its output according to the input state. 
Toggling means changing the next state output to complement the current state. T is an abbreviation for Toggle. 
A good example to explain this concept is using a light switch. When you toggle a light switch you are either changing from the on state to an off state and vice versa. 
The main purpose of T Flip-Flop is to avoid the occurrence of the intermediate state in SR Flip-Flop.
### Architecture
![WhatsApp Image 2023-10-21 at 11 20 15 AM](https://github.com/vaishbv/pes_tff/assets/79531808/5470ee06-bc62-473a-928e-e5868c34e06d)

### Truth Table
![WhatsApp Image 2023-10-21 at 11 41 04 AM](https://github.com/vaishbv/pes_tff/assets/79531808/c5a17764-b575-45ed-ba1b-f02f80aa9b0a)



## Iverilog and yosys Installation
- To install iverilog and gtkwave we type the following
```
- sudo apt-get update
- sudo apt-get install iverilog gtkwave
```

- To install yosys we type the following
```
- git clone https://github.com/YosysHQ/yosys.git
- sudo apt install make
- sudo apt-get install build-essential clang bison flex \
   libreadline-dev gawk tcl-dev libffi-dev git \
   graphviz xdot pkg-config python3 libboost-system-dev \
   libboost-python-dev libboost-filesystem-dev zlib1g-dev
```

- Now we type ```cd yosys``` and go into the yosys folder.
- Now we type
```
sudo make install
```
## GLS Process to Verify T flip flop

First we will look at the waveform simulation of the program 
![1 (2)](https://github.com/vaishbv/pes_tff/assets/79531808/c8f8e644-77d8-4e1f-a4eb-825f18f4df7f)




- We first read the design and testbench file using the command
```
iverilog pes_tff.v pes_tff_tb.v
```
- Then we type ```./a.out``` to generate the .vcd file
- Now we type
```
gtkwave pes_tff_tb.vcd
```
![2](https://github.com/vaishbv/pes_tff/assets/79531808/e0ed79bc-a635-4a96-b464-14cebe8a0ef3)

The waveform is obtained as follows.'

![3](https://github.com/vaishbv/pes_tff/assets/79531808/bd07c8ad-ad8c-44c2-82f4-bc6f8cc186bc)


Now we will synthesize the design and generate the netlist file.
![4](https://github.com/vaishbv/pes_tff/assets/79531808/a5a70486-5eb3-4833-b37c-29102cf4752d)


```
read_liberty -lib sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog pes_tff.v
synth -top pes_tff
```
![5](https://github.com/vaishbv/pes_tff/assets/79531808/e21bda18-acd1-4c63-bada-bb7fccf74b71)

![6](https://github.com/vaishbv/pes_tff/assets/79531808/fce4bafa-4fc0-4e8b-b260-4704bfa236b2)


```
abc -liberty sky130_fd_sc_hd__tt_025C_1v80.lib
```
![7](https://github.com/vaishbv/pes_tff/assets/79531808/b6902232-fb3f-47fc-9bc2-9e826ae0e388)

- We type ```show``` to display the design.
![8](https://github.com/vaishbv/pes_tff/assets/79531808/59807c54-1499-4c91-a984-6a592baef87a)


- To generate the netlist file we must type the command
```
write_verilog -noattr pes_tff_netlist.v
```
![9](https://github.com/vaishbv/pes_tff/assets/79531808/59788f40-b685-4672-90be-cbd9b28a1c5b)

- Now using the netlist file, we verify the waveform once more

![WhatsApp Image 2023-10-21 at 1 17 37 PM](https://github.com/vaishbv/pes_tff/assets/79531808/3594bcd8-794f-4791-b544-934d04f16c1c)


- To read the design and test bench file we must use the command
```
iverilog primitives.v sky130_fd_sc_hd.v pes_tff_netlist.v pes_tff_tb.v
```
- Now we type ```./a.out``` to generate the .vcd file.
- To see the waveform we type the command
```
gtkwave pes_tff_tb.vcd
```

- The following waveform is generated.
![12](https://github.com/vaishbv/pes_tff/assets/79531808/26b1fba5-55d1-4bd5-8153-f0ce25f73eaa)

- THe synthesis and simulation are matching
