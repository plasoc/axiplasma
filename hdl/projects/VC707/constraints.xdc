set_property -dict {PACKAGE_PIN E18 IOSTANDARD LVDS} [get_ports raw_clock_n]
set_property -dict {PACKAGE_PIN E19 IOSTANDARD LVDS} [get_ports raw_clock_p]

set_property -dict {PACKAGE_PIN AV40 IOSTANDARD LVCMOS18} [get_ports raw_nreset]

set_property -dict {PACKAGE_PIN AV30 IOSTANDARD LVCMOS18} [get_ports {gpio_input[0]}]
set_property -dict {PACKAGE_PIN AY33 IOSTANDARD LVCMOS18} [get_ports {gpio_input[1]}]
set_property -dict {PACKAGE_PIN BA31 IOSTANDARD LVCMOS18} [get_ports {gpio_input[2]}]
set_property -dict {PACKAGE_PIN BA32 IOSTANDARD LVCMOS18} [get_ports {gpio_input[3]}]
set_property -dict {PACKAGE_PIN AW30 IOSTANDARD LVCMOS18} [get_ports {gpio_input[4]}]
set_property -dict {PACKAGE_PIN AY30 IOSTANDARD LVCMOS18} [get_ports {gpio_input[5]}]
set_property -dict {PACKAGE_PIN BA30 IOSTANDARD LVCMOS18} [get_ports {gpio_input[6]}]
set_property -dict {PACKAGE_PIN BB31 IOSTANDARD LVCMOS18} [get_ports {gpio_input[7]}]

set_property -dict {PACKAGE_PIN AM39 IOSTANDARD LVCMOS18} [get_ports {gpio_output[0]}]
set_property -dict {PACKAGE_PIN AN39 IOSTANDARD LVCMOS18} [get_ports {gpio_output[1]}]
set_property -dict {PACKAGE_PIN AR37 IOSTANDARD LVCMOS18} [get_ports {gpio_output[2]}]
set_property -dict {PACKAGE_PIN AT37 IOSTANDARD LVCMOS18} [get_ports {gpio_output[3]}]
set_property -dict {PACKAGE_PIN AR35 IOSTANDARD LVCMOS18} [get_ports {gpio_output[4]}]
set_property -dict {PACKAGE_PIN AP41 IOSTANDARD LVCMOS18} [get_ports {gpio_output[5]}]
set_property -dict {PACKAGE_PIN AP42 IOSTANDARD LVCMOS18} [get_ports {gpio_output[6]}]
set_property -dict {PACKAGE_PIN AU39 IOSTANDARD LVCMOS18} [get_ports {gpio_output[7]}]

set_property -dict {PACKAGE_PIN AU36 IOSTANDARD LVCMOS18} [get_ports uart_rx]
set_property -dict {PACKAGE_PIN AU33 IOSTANDARD LVCMOS18} [get_ports uart_tx]

create_clock -period 20.000 -name VIRTUAL_clk_out1_ip_block_design_clk_wiz_0_0 -waveform {0.000 10.000}
set_input_delay -clock [get_clocks VIRTUAL_clk_out1_ip_block_design_clk_wiz_0_0] -min -add_delay 2.000 [get_ports {gpio_input[*]}]
set_input_delay -clock [get_clocks VIRTUAL_clk_out1_ip_block_design_clk_wiz_0_0] -max -add_delay 2.000 [get_ports {gpio_input[*]}]
set_input_delay -clock [get_clocks VIRTUAL_clk_out1_ip_block_design_clk_wiz_0_0] -min -add_delay 2.000 [get_ports raw_nreset]
set_input_delay -clock [get_clocks VIRTUAL_clk_out1_ip_block_design_clk_wiz_0_0] -max -add_delay 2.000 [get_ports raw_nreset]
set_output_delay -clock [get_clocks VIRTUAL_clk_out1_ip_block_design_clk_wiz_0_0] -min -add_delay 0.000 [get_ports {gpio_output[*]}]
set_output_delay -clock [get_clocks VIRTUAL_clk_out1_ip_block_design_clk_wiz_0_0] -max -add_delay 0.000 [get_ports {gpio_output[*]}]

create_clock -period 104166.672 -name virtual_uart_baud_clock -waveform {10.000 52093.328}
set_input_delay -clock [get_clocks virtual_uart_baud_clock] -min -add_delay 2.000 [get_ports uart_rx]
set_input_delay -clock [get_clocks virtual_uart_baud_clock] -max -add_delay 2.000 [get_ports uart_rx]
set_output_delay -clock [get_clocks virtual_uart_baud_clock] -min -add_delay 2.000 [get_ports uart_tx]
set_output_delay -clock [get_clocks virtual_uart_baud_clock] -max -add_delay 2.000 [get_ports uart_tx]