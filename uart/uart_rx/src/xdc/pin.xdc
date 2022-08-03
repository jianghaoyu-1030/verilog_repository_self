create_clock -period 20.000 -name clk [get_ports sys_clk]

set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports sys_clk]
set_property -dict {PACKAGE_PIN N16 IOSTANDARD LVCMOS33} [get_ports sys_rst_n]
set_property -dict {PACKAGE_PIN K14 IOSTANDARD LVCMOS33} [get_ports uart_rxd]
# set_property -dict {PACKAGE_PIN M15 IOSTANDARD LVCMOS33} [get_ports uart_txd]