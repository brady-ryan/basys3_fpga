
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

set_property PACKAGE_PIN R3 [get_ports {switch[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[4]}]

set_property PACKAGE_PIN T2 [get_ports {switch[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[5]}]

set_property PACKAGE_PIN T3 [get_ports {switch[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[6]}]

set_property PACKAGE_PIN L1 [get_ports {led[0]}]
set_property PACKAGE_PIN P1 [get_ports {led[1]}]
set_property PACKAGE_PIN N3 [get_ports {led[2]}]
set_property PACKAGE_PIN P3 [get_ports {led[3]}]
set_property PACKAGE_PIN U3 [get_ports {led[4]}]
set_property PACKAGE_PIN W3 [get_ports {led[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]


set_property PACKAGE_PIN W19 [get_ports {freq[0]}]
set_property PACKAGE_PIN T17 [get_ports {freq[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {freq[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {freq[1]}]

set_property PACKAGE_PIN U16 [get_ports ledclk]
set_property IOSTANDARD LVCMOS33 [get_ports ledclk]

set_property PACKAGE_PIN K17 [get_ports {outdata[0]}]
set_property PACKAGE_PIN M18 [get_ports {outdata[1]}]
set_property PACKAGE_PIN N19 [get_ports {outdata[2]}]
set_property PACKAGE_PIN P18 [get_ports {outdata[3]}]
set_property PACKAGE_PIN L17 [get_ports {outdata[4]}]
set_property PACKAGE_PIN M19 [get_ports {outdata[5]}]
set_property PACKAGE_PIN P17 [get_ports {outdata[6]}]
set_property PACKAGE_PIN R18 [get_ports {outdata[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {outdata[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {outdata[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {outdata[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {outdata[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {outdata[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {outdata[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {outdata[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {outdata[7]}]
