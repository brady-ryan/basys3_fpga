
set_property PACKAGE_PIN A18 [get_ports TxD]
set_property IOSTANDARD LVCMOS33 [get_ports TxD]

set_property CFGBVS VCCO [current_design]
#where value1 is either VCCO or GND

set_property CONFIG_VOLTAGE 3.3 [current_design]
#where value2 is the voltage provided to configuration bank 0

set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property PACKAGE_PIN U18 [get_ports btn]
set_property IOSTANDARD LVCMOS33 [get_ports btn]


create_clock -period 10.000 -name clk -waveform {0.000 5.000} [get_ports clk]



set_property PACKAGE_PIN V17 [get_ports send_data]
set_property IOSTANDARD LVCMOS33 [get_ports send_data]

set_property PACKAGE_PIN R2 [get_ports {switch[0]}]
set_property PACKAGE_PIN T1 [get_ports {switch[1]}]
set_property PACKAGE_PIN U1 [get_ports {switch[2]}]
set_property PACKAGE_PIN W2 [get_ports {switch[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[3]}]
