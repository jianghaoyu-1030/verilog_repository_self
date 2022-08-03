# //////////////////////////////////////////////////////////////////////////////////
# // Company: 
# // Engineer: 
# // 
# // Create Date: 2022/08/3 
# // Design Name: 
# // Module Name: tcl
# // Project Name: 
# // Target Devices: 
# // Tool Versions: 
# // Description: tcl自动化脚本
# // 
# // Dependencies: 执行改脚本前需要备份好以下文件
#                  1.V文件 (hdl,sim,xdc)
#                  2.tcl文件(bd.tcl,ip.tcl)
#  
# //生成bd的tcl文件指令：write_bd_tcl -force D:/jiang/2022_8/self/uart/uart_rx/src/bd/bd.tcl
#
#
# //生成ip的tcl文件指令：
# // write_ip_tcl -force [get_ips ila_0] -multiple_files  单个指定IP，如ila
# // write_ip_tcl -force [get_ips] -multiple_files        工程目录下所有IP
# //////////////////////////////////////////////////////////////////////////////////
# 创建 名为 uart_rx 的工程 存储在该目录下
create_project uart_rx D:/jiang/2022_8/self/uart/uart_rx/work -part xc7z010clg400-1

# 添加，导入V文件至工程
add_files -norecurse -scan_for_includes D:/jiang/2022_8/self/uart/uart_rx/src/hdl/uart_recv.v
import_files -norecurse D:/jiang/2022_8/self/uart/uart_rx/src/hdl/uart_recv.v

add_files -norecurse -scan_for_includes D:/jiang/2022_8/self/uart/uart_rx/src/hdl/uart_rec_data.v
import_files -norecurse D:/jiang/2022_8/self/uart/uart_rx/src/hdl/uart_rec_data.v

add_files -norecurse -scan_for_includes D:/jiang/2022_8/self/uart/uart_rx/src/hdl/top.v
import_files -norecurse D:/jiang/2022_8/self/uart/uart_rx/src/hdl/top.v

# 更新V文件
update_compile_order -fileset sources_1

# 添加，导入sim文件至工程
# set_property SOURCE_SET sources_1 [get_filesets sim_1]
# add_files -fileset sim_1 -norecurse -scan_for_includes F:/jiang/worked_project/uart_rx/uart_bytes_tx_test/sim/tb_uart_bytes_tx.v
# import_files -fileset sim_1 -norecurse F:/jiang/worked_project/uart_rx/uart_bytes_tx_test/sim/tb_uart_bytes_tx.v

# 更新sim文件
# update_compile_order -fileset sim_1

# 添加，导入xdc文件至工程
add_files -fileset constrs_1 -norecurse D:/jiang/2022_8/self/uart/uart_rx/src/xdc/pin.xdc
import_files -fileset constrs_1 D:/jiang/2022_8/self/uart/uart_rx/src/xdc/pin.xdc



# 执行该目录下的自动化IP脚本 (可执行的tcl脚本)
source D:/jiang/2022_8/self/uart/uart_rx/ip_repo/ila_0.tcl

# 执行该目录下的自动化bd脚本 (可执行的tcl脚本)
# source D:/jiang/2022_8/self/uart/uart_rx/src/bd/bd.tcl
# # 生成顶层V
# make_wrapper -files [get_files D:/jiang/2022_8/self/uart/uart_rx/work/uart_rx.srcs/sources_1/bd/system/system.bd] -top

# 更新V文件
update_compile_order -fileset sources_1

# # 跑行为仿真
# launch_simulation
# source tb_uart_bytes_tx.tcl

# 跑综合  jobs 24：CPU核心数设置
launch_runs synth_1 -jobs 8

# 跑实现  jobs 8：CPU核心数设置
launch_runs impl_1 -jobs 8

# # 生成bit流
# launch_runs impl_1 -to_step write_bitstream -jobs 8