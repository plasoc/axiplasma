# Set timing constraints
create_clock -period 20.000 -name clock [get_ports aclk]
set_input_delay -clock [get_clocks clock] 2.000 [get_ports aresetn]
set_output_delay -clock [get_clocks clock] 2.000 [get_ports bram_rst_a]
set_output_delay -clock [get_clocks clock] 2.000 [get_ports bram_clk_a]
set_output_delay -clock [get_clocks clock] 2.000 [get_ports bram_en_a]
set_output_delay -clock [get_clocks clock] 2.000 [get_ports bram_we_a]
set_output_delay -clock [get_clocks clock] 2.000 [get_ports bram_addr_a]
set_output_delay -clock [get_clocks clock] 2.000 [get_ports bram_wrdata_a]
set_input_delay -clock [get_clocks clock] 2.000 [get_ports bram_rddata_a]
set_output_delay -clock [get_clocks clock] 2.000 [get_ports debug_cpu_pause]

