set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports raw_clock]
set_property -dict {PACKAGE_PIN J15 IOSTANDARD LVCMOS33} [get_ports {gpio_input[0]}]
set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports {gpio_input[1]}]
set_property -dict {PACKAGE_PIN M13 IOSTANDARD LVCMOS33} [get_ports {gpio_input[2]}]
set_property -dict {PACKAGE_PIN R15 IOSTANDARD LVCMOS33} [get_ports {gpio_input[3]}]


set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVCMOS33} [get_ports {gpio_output[0]}]
set_property -dict {PACKAGE_PIN K15 IOSTANDARD LVCMOS33} [get_ports {gpio_output[1]}]
set_property -dict {PACKAGE_PIN J13 IOSTANDARD LVCMOS33} [get_ports {gpio_output[2]}]
set_property -dict {PACKAGE_PIN N14 IOSTANDARD LVCMOS33} [get_ports {gpio_output[3]}]

create_clock -period 20.000 -name vclock -waveform {0.000 10.000}
set_input_delay -clock [get_clocks vclock] -min -add_delay 2.000 [get_ports {gpio_input[*]}]
set_input_delay -clock [get_clocks vclock] -max -add_delay 2.000 [get_ports {gpio_input[*]}]
set_output_delay -clock [get_clocks vclock] -min -add_delay 0.000 [get_ports {gpio_output[*]}]
set_output_delay -clock [get_clocks vclock] -max -add_delay 0.000 [get_ports {gpio_output[*]}]
