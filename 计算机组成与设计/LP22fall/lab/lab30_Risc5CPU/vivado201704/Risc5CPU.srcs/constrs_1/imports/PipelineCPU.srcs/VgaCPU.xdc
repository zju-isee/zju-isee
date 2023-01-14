


set_property IOSTANDARD TMDS_33 [get_ports {TMDSp[0]}]

set_property PACKAGE_PIN W1 [get_ports {TMDSp[0]}]
set_property PACKAGE_PIN Y1 [get_ports {TMDSn[0]}]
set_property IOSTANDARD TMDS_33 [get_ports {TMDSn[0]}]

set_property IOSTANDARD TMDS_33 [get_ports {TMDSp[1]}]

set_property PACKAGE_PIN AA1 [get_ports {TMDSp[1]}]
set_property PACKAGE_PIN AB1 [get_ports {TMDSn[1]}]
set_property IOSTANDARD TMDS_33 [get_ports {TMDSn[1]}]



set_property PACKAGE_PIN AB3 [get_ports {TMDSp[2]}]
set_property PACKAGE_PIN AB2 [get_ports {TMDSn[2]}]
set_property IOSTANDARD TMDS_33 [get_ports {TMDSp[2]}]
set_property IOSTANDARD TMDS_33 [get_ports {TMDSn[2]}]


set_property IOSTANDARD TMDS_33 [get_ports TMDSp_clk]

set_property PACKAGE_PIN T1 [get_ports TMDSp_clk]
set_property PACKAGE_PIN U1 [get_ports TMDSn_clk]
set_property IOSTANDARD TMDS_33 [get_ports TMDSn_clk]

set_property PACKAGE_PIN R4 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

set_property PACKAGE_PIN B22 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]


set_property PACKAGE_PIN F15 [get_ports step]
set_property IOSTANDARD LVCMOS33 [get_ports step]
set_property PACKAGE_PIN E22 [get_ports run_mode]
set_property IOSTANDARD LVCMOS33 [get_ports run_mode]
