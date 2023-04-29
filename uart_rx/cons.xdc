ED[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[5]}]
set_property PACKAGE_PIN U14 [get_ports {LED[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[6]}]
set_property PACKAGE_PIN V14 [get_ports {LED[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[7]}]


##Buttons
set_property PACKAGE_PIN U18 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]


##USB-RS232 Interface
set_property PACKAGE_PIN B18 [get_ports RxD]
set_property IOSTANDARD LVCMOS33 [get_ports RxD]


set_property BITSTREAM.STARTUP.STARTUPCLK JTAGCLK [current_design]

set_property CFGBVS VCCO [current_design]
#where value1 is either VCCO or GND

set_property CONFIG_VOLTAGE 3.3 [current_design]
#where value2 is the voltage provided to configuration bank 0
