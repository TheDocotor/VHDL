## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

# Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]
 
# Switches
#set_property PACKAGE_PIN V17 [get_ports {sw[0]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[0]}]
#set_property PACKAGE_PIN V16 [get_ports {sw[1]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[1]}]
set_property PACKAGE_PIN B18 [get_ports {Cin}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Cin}]
set_property PACKAGE_PIN A18 [get_ports {tdata}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {tdata}]

# LEDs
set_property PACKAGE_PIN U16 [get_ports {pdata[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {pdata[0]}]
set_property PACKAGE_PIN E19 [get_ports {pdata[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {pdata[1]}]
set_property PACKAGE_PIN U19 [get_ports {pdata[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {pdata[2]}]
set_property PACKAGE_PIN V19 [get_ports {pdata[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {pdata[3]}]
set_property PACKAGE_PIN W18 [get_ports {pdata[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {pdata[4]}]
set_property PACKAGE_PIN U15 [get_ports {pdata[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {pdata[5]}]
set_property PACKAGE_PIN U14 [get_ports {pdata[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {pdata[6]}]
set_property PACKAGE_PIN V14 [get_ports {pdata[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {pdata[7]}]
#set_property PACKAGE_PIN V13 [get_ports {position[8]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {position[8]}]
set_property PACKAGE_PIN L1 [get_ports {busy}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {busy}]
	

## Buttons
set_property PACKAGE_PIN U18 [get_ports rst]						
	set_property IOSTANDARD LVCMOS33 [get_ports rst]
#set_property PACKAGE_PIN T18 [get_ports btn]						
	#set_property IOSTANDARD LVCMOS33 [get_ports btn]
#set_property PACKAGE_PIN W19 [get_ports exe]						
	#set_property IOSTANDARD LVCMOS33 [get_ports exe]
#set_property PACKAGE_PIN T17 [get_ports btnR]						
	#set_property IOSTANDARD LVCMOS33 [get_ports btnR]
#set_property PACKAGE_PIN U17 [get_ports btnD]						
	#set_property IOSTANDARD LVCMOS33 [get_ports btnD]
	
## Switches for  8-bit binary input value

#set_property PACKAGE_PIN V17 [get_ports {UI[0]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {UI[0]}]
#set_property PACKAGE_PIN V16 [get_ports {UI[1]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {UI[1]}]
#set_property PACKAGE_PIN W16 [get_ports {UI[2]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {UI[2]}]
#set_property PACKAGE_PIN W17 [get_ports {UI[3]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {UI[3]}]
#set_property PACKAGE_PIN W15 [get_ports {UI[4]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {UI[4]}]
#set_property PACKAGE_PIN V15 [get_ports {UI[5]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {UI[5]}]
#set_property PACKAGE_PIN W14 [get_ports {UI[6]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {UI[6]}]
#set_property PACKAGE_PIN W13 [get_ports {UI[7]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {UI[7]}]
	
## Switches for address/memory select

#set_property PACKAGE_PIN V2 [get_ports {addr_UI[0]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {addr_UI[0]}]
#set_property PACKAGE_PIN T3 [get_ports {addr_UI[1]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {addr_UI[1]}]
#set_property PACKAGE_PIN T2 [get_ports {addr_UI[2]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {addr_UI[2]}]
#set_property PACKAGE_PIN R3 [get_ports {addr_UI[3]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {addr_UI[3]}]
	
## Switches for operation select

#set_property PACKAGE_PIN W2 [get_ports {operation[0]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {operation[0]}]
#set_property PACKAGE_PIN U1 [get_ports {operation[1]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {operation[1]}]
#set_property PACKAGE_PIN T1 [get_ports {operation[2]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {operation[2]}]
#set_property PACKAGE_PIN R2 [get_ports {code[3]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {code[0]}]