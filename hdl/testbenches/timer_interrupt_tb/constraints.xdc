set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports raw_clock]
#create_clock -period 10.000 -name clock -waveform {0.000 5.000} -add [get_ports raw_clock]
set_property -dict {PACKAGE_PIN C12 IOSTANDARD LVCMOS33} [get_ports raw_nreset]
set_property -dict {PACKAGE_PIN J15 IOSTANDARD LVCMOS33} [get_ports {gpio_input[0]}]
set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports {gpio_input[1]}]
set_property -dict {PACKAGE_PIN M13 IOSTANDARD LVCMOS33} [get_ports {gpio_input[2]}]
set_property -dict {PACKAGE_PIN R15 IOSTANDARD LVCMOS33} [get_ports {gpio_input[3]}]
set_property -dict {PACKAGE_PIN R17 IOSTANDARD LVCMOS33} [get_ports {gpio_input[4]}]
set_property -dict {PACKAGE_PIN T18 IOSTANDARD LVCMOS33} [get_ports {gpio_input[5]}]
set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports {gpio_input[6]}]
set_property -dict {PACKAGE_PIN R13 IOSTANDARD LVCMOS33} [get_ports {gpio_input[7]}]
set_property -dict { PACKAGE_PIN T8    IOSTANDARD LVCMOS18 } [get_ports { gpio_input[8] }]; #IO_L24N_T3_34 Sch=sw[8]
set_property -dict { PACKAGE_PIN U8    IOSTANDARD LVCMOS18 } [get_ports { gpio_input[9] }]; #IO_25_34 Sch=sw[9]
set_property -dict { PACKAGE_PIN R16   IOSTANDARD LVCMOS33 } [get_ports { gpio_input[10] }]; #IO_L15P_T2_DQS_RDWR_B_14 Sch=sw[10]
set_property -dict { PACKAGE_PIN T13   IOSTANDARD LVCMOS33 } [get_ports { gpio_input[11] }]; #IO_L23P_T3_A03_D19_14 Sch=sw[11]
set_property -dict { PACKAGE_PIN H6    IOSTANDARD LVCMOS33 } [get_ports { gpio_input[12] }]; #IO_L24P_T3_35 Sch=sw[12]
set_property -dict { PACKAGE_PIN U12   IOSTANDARD LVCMOS33 } [get_ports { gpio_input[13] }]; #IO_L20P_T3_A08_D24_14 Sch=sw[13]
set_property -dict { PACKAGE_PIN U11   IOSTANDARD LVCMOS33 } [get_ports { gpio_input[14] }]; #IO_L19N_T3_A09_D25_VREF_14 Sch=sw[14]
set_property -dict { PACKAGE_PIN V10   IOSTANDARD LVCMOS33 } [get_ports { gpio_input[15] }]; #IO_L21P_T3_DQS_14 Sch=sw[15]

set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVCMOS33} [get_ports {gpio_output[0]}]
set_property -dict {PACKAGE_PIN K15 IOSTANDARD LVCMOS33} [get_ports {gpio_output[1]}]
set_property -dict {PACKAGE_PIN J13 IOSTANDARD LVCMOS33} [get_ports {gpio_output[2]}]
set_property -dict {PACKAGE_PIN N14 IOSTANDARD LVCMOS33} [get_ports {gpio_output[3]}]
set_property -dict {PACKAGE_PIN R18 IOSTANDARD LVCMOS33} [get_ports {gpio_output[4]}]
set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS33} [get_ports {gpio_output[5]}]
set_property -dict {PACKAGE_PIN U17 IOSTANDARD LVCMOS33} [get_ports {gpio_output[6]}]
set_property -dict {PACKAGE_PIN U16 IOSTANDARD LVCMOS33} [get_ports {gpio_output[7]}]
set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports { gpio_output[8] }]; #IO_L16N_T2_A15_D31_14 Sch=led[8]
set_property -dict { PACKAGE_PIN T15   IOSTANDARD LVCMOS33 } [get_ports { gpio_output[9] }]; #IO_L14N_T2_SRCC_14 Sch=led[9]
set_property -dict { PACKAGE_PIN U14   IOSTANDARD LVCMOS33 } [get_ports { gpio_output[10] }]; #IO_L22P_T3_A05_D21_14 Sch=led[10]
set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS33 } [get_ports { gpio_output[11] }]; #IO_L15N_T2_DQS_DOUT_CSO_B_14 Sch=led[11]
set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS33 } [get_ports { gpio_output[12] }]; #IO_L16P_T2_CSI_B_14 Sch=led[12]
set_property -dict { PACKAGE_PIN V14   IOSTANDARD LVCMOS33 } [get_ports { gpio_output[13] }]; #IO_L22N_T3_A04_D20_14 Sch=led[13]
set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS33 } [get_ports { gpio_output[14] }]; #IO_L20N_T3_A07_D23_14 Sch=led[14]
set_property -dict { PACKAGE_PIN V11   IOSTANDARD LVCMOS33 } [get_ports { gpio_output[15] }]; #IO_L21N_T3_DQS_A06_D22_14 Sch=led[15]

set_property -dict {PACKAGE_PIN C4 IOSTANDARD LVCMOS33} [get_ports { uart_rx }];
set_property -dict {PACKAGE_PIN D4 IOSTANDARD LVCMOS33} [get_ports { uart_tx }];

create_clock -period 20.000 -name VIRTUAL_clk_out1_ip_block_design_clk_wiz_0_0 -waveform {0.000 10.000}
set_input_delay -clock [get_clocks VIRTUAL_clk_out1_ip_block_design_clk_wiz_0_0] -min -add_delay 2.000 [get_ports {gpio_input[*]}]
set_input_delay -clock [get_clocks VIRTUAL_clk_out1_ip_block_design_clk_wiz_0_0] -max -add_delay 2.000 [get_ports {gpio_input[*]}]
set_input_delay -clock [get_clocks VIRTUAL_clk_out1_ip_block_design_clk_wiz_0_0] -min -add_delay 2.000 [get_ports raw_nreset]
set_input_delay -clock [get_clocks VIRTUAL_clk_out1_ip_block_design_clk_wiz_0_0] -max -add_delay 2.000 [get_ports raw_nreset]
set_output_delay -clock [get_clocks VIRTUAL_clk_out1_ip_block_design_clk_wiz_0_0] -min -add_delay 0.000 [get_ports {gpio_output[*]}]
set_output_delay -clock [get_clocks VIRTUAL_clk_out1_ip_block_design_clk_wiz_0_0] -max -add_delay 0.000 [get_ports {gpio_output[*]}]

create_clock -period 104166.67 -name virtual_uart_baud_clock -waveform {0.00 52083.33}
set_input_delay -clock [get_clocks virtual_uart_baud_clock] -min -add_delay 2.000 [get_ports { uart_rx }];
set_input_delay -clock [get_clocks virtual_uart_baud_clock] -max -add_delay 2.000 [get_ports { uart_rx }];
set_output_delay -clock [get_clocks virtual_uart_baud_clock] -min -add_delay 2.000 [get_ports { uart_tx }];
set_output_delay -clock [get_clocks virtual_uart_baud_clock] -max -add_delay 2.000 [get_ports { uart_tx }];