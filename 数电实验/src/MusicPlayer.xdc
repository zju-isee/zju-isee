create_clock -period 10.000 -name clk -waveform {0.000 5.000} -add
set_property IOSTANDARD LVCMOS33 [get_ports BCLK]
set_property IOSTANDARD LVCMOS33 [get_ports DAC_SDATA]
set_property PACKAGE_PIN U5 [get_ports LRCLK]
set_property IOSTANDARD LVCMOS33 [get_ports LRCLK]
set_property PACKAGE_PIN U6 [get_ports MCLK]
set_property IOSTANDARD LVCMOS33 [get_ports MCLK]
set_property PACKAGE_PIN W5 [get_ports SCL]
set_property IOSTANDARD LVCMOS33 [get_ports SCL]
set_property PACKAGE_PIN V5 [get_ports SDA]
set_property IOSTANDARD LVCMOS33 [get_ports SDA]
set_property PACKAGE_PIN T4 [get_ports ADC_SDATA]
set_property IOSTANDARD LVCMOS33 [get_ports ADC_SDATA]

set_property PACKAGE_PIN R4 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property PACKAGE_PIN T5 [get_ports BCLK]


set_property PACKAGE_PIN W6 [get_ports DAC_SDATA]

set_property PACKAGE_PIN D22 [get_ports next_button]
set_property IOSTANDARD LVCMOS33 [get_ports next_button]
set_property PACKAGE_PIN D14 [get_ports play_button]
set_property PACKAGE_PIN T14 [get_ports play]
set_property PACKAGE_PIN U16 [get_ports {song[1]}]
set_property PACKAGE_PIN T16 [get_ports {song[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {song[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {song[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports play]
set_property IOSTANDARD LVCMOS33 [get_ports play_button]

set_property PACKAGE_PIN B22 [get_ports reset]

set_property IOSTANDARD LVCMOS33 [get_ports reset]
