# 创建 名为 uart_tx 的工程 存储在该目录下
create_project uart_tx F:/jiang/github/uart/uart_tx/work -part xc7z020clg484-2

# 添加，导入V文件至工程
add_files -norecurse -scan_for_includes F:/jiang/github/uart/uart_tx/src/hdl/uart_tx.v
import_files -norecurse F:/jiang/github/uart/uart_tx/src/hdl/uart_tx.v

add_files -norecurse -scan_for_includes F:/jiang/github/uart/uart_tx/src/hdl/uart_bytes_tx.v
import_files -norecurse F:/jiang/github/uart/uart_tx/src/hdl/uart_bytes_tx.v

add_files -norecurse -scan_for_includes F:/jiang/github/uart/uart_tx/src/hdl/uart_bytes_tx_test.v
import_files -norecurse F:/jiang/github/uart/uart_tx/src/hdl/uart_bytes_tx_test.v

# 更新V文件
update_compile_order -fileset sources_1

# 添加，导入sim文件至工程
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse -scan_for_includes F:/jiang/github/uart/uart_tx/src/sim/tb_uart_bytes_tx.v
import_files -fileset sim_1 -norecurse F:/jiang/github/uart/uart_tx/src/sim/tb_uart_bytes_tx.v

# 更新sim文件
update_compile_order -fileset sim_1

# 跑综合  jobs 24：CPU核心数设置
launch_runs synth_1 -jobs 24

# 跑行为仿真
launch_simulation
source tb_uart_bytes_tx.tcl