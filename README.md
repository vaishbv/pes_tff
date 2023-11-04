# pes_tff
# Contents
- [T-flip flop](#t-flip-flop)
- [Iverilog and yosys installation](#iverilog-and-yosys-installation)
- [GLS Process to verify T flip flop ](#gls-process-to-verify-t-flip-flop)
- [Installation of ngspice magic and OpenLANE](#installation-of-ngspice-magic-and-openlane)
- [OpenLANE Flow](#openlane-flow)
  
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

  
## Installation of ngspice magic and OpenLANE

**ngspice**
- Download the tarball from https://sourceforge.net/projects/ngspice/files/ to a local directory
```
cd $HOME
sudo apt-get install libxaw7-dev
tar -zxvf ngspice-41.tar.gz
cd ngspice-41
mkdir release
cd release
../configure  --with-x --with-readline=yes --disable-debug
sudo make
sudo make install
```

**magic**
```
sudo apt-get install m4
sudo apt-get install tcsh
sudo apt-get install csh
sudo apt-get install libx11-dev
sudo apt-get install tcl-dev tk-dev
sudo apt-get install libcairo2-dev
sudo apt-get install mesa-common-dev libglu1-mesa-dev
sudo apt-get install libncurses-dev
git clone https://github.com/RTimothyEdwards/magic
cd magic
./configure
sudo make
sudo make install
```

**OpenLANE**
```
sudo apt-get update
sudo apt-get upgrade
sudo apt install -y build-essential python3 python3-venv python3-pip make git

sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io
sudo docker run hello-world
sudo groupadd docker
sudo usermod -aG docker $USER
sudo reboot 
# After reboot
docker run hello-world (should show you the output under 'Example Output' in https://hub.docker.com/_/hello-world)

- To install the PDKs and Tools
cd $HOME
git clone https://github.com/The-OpenROAD-Project/OpenLane
cd OpenLane
make
make test
```

## OpenLANE Flow

- First we create a folder under the name of our design in the 'designs' folder.
- Do ```cd pes_ripple_counter```.
- Here we create a config.json file.
- We make a new directory called 'src'.
- Do ```cd src```
- We add the following files to this directory.
- All these files are found above in the 'pes_tff' folder.
- Now in the main 'Openlane' directory type ```mkdir pdks```.
- Copy paste the above file in it. Found in the verilog_model folder above.

- Type ```make mount``` in the main Openlane folder.
- Then type ```./flow.tcl -interactive```.
- To prep the design type
```
prep -design pes_ripple_counter
```


### Synthesis
- Type
```
run_synthesis
```

![WhatsApp Image 2023-11-04 at 10 53 20 AM](https://github.com/vaishbv/pes_tff/assets/79531808/a0fd04ec-3220-4e1a-8f43-b7ea135f555b)
![WhatsApp Image 2023-11-04 at 10 52 15 AM](https://github.com/vaishbv/pes_tff/assets/79531808/d6258573-8bff-41d2-8b0b-5aa7c975d802)


**Physical Cells**
![WhatsApp Image 2023-11-04 at 10 53 54 AM](https://github.com/vaishbv/pes_tff/assets/79531808/c9440aa6-bf24-42cc-b088-c494db5ab845)


- Flop Ratio = 2/6 = 0.33

### Floorplan
- Now to run the floorplan we type
```
run_floorplan
```
![WhatsApp Image 2023-11-04 at 10 54 31 AM](https://github.com/vaishbv/pes_tff/assets/79531808/7f6f1a05-456c-411a-810a-60100f325265)

- To view the design we type
```
magic -T /home/vsduser/Desktop/work/tools/openlane_working_dir/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.lef def pes_tff.floorplan.def &
```
<img width="1037" alt="Screenshot 2023-11-04 at 12 03 31 PM" src="https://github.com/vaishbv/pes_tff/assets/79531808/f2e61d94-9ab6-478a-a771-14893b9c631c">

![WhatsApp Image 2023-11-04 at 10 44 31 AM](https://github.com/vaishbv/pes_tff/assets/79531808/076fac24-7c2e-4630-a040-900fc08f7551)

### Placement
- Now to run the placement we type
```
run_placement
```
![WhatsApp Image 2023-11-04 at 10 55 35 AM](https://github.com/vaishbv/pes_tff/assets/79531808/8ed2106d-b007-4305-9994-82ec0bad1db6)

- To view the design we type
```
magic -T /home/vsduser/Desktop/work/tools/openlane_working_dir/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.lef def pes_tff.placement.def &
```
<img width="1319" alt="Screenshot 2023-11-04 at 12 01 58 PM" src="https://github.com/vaishbv/pes_tff/assets/79531808/7a8f5b15-50da-412d-acf0-6c779c7a43dc">

### CTS(Clock Tree Synthesis)
- Now to run cts we type
```
run_cts
```

- The reports generated are given below



**Power Report**

**Skew Report**

**Area Report**

### Routing
- Now to run routing we type
```
run_routing
```

- To view the design we type
```
magic -T /home/aniruddhan/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef def pes_ripco.def &
```


**Congestion Report**

**Power and Clock Skew Report**

**Summary Report and Area Report**

**Statistics**
- Area = 351.155 um2
- Internal Power = 2.08e-06 W
- Switching Power = 5.18e-07
- Leakage Power = 8.24e-11
- Total Power = 2.59e-06
