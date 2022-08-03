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
# // Description: tcl�Զ����ű�
# // 
# // Dependencies: ִ�иĽű�ǰ��Ҫ���ݺ������ļ�
#                  1.V�ļ� (hdl,sim,xdc)
#                  2.tcl�ļ�(bd.tcl,ip.tcl)
#  
# //����bd��tcl�ļ�ָ�write_bd_tcl -force D:/jiang/2022_8/self/uart/uart_rx/src/bd/bd.tcl
#
#
# //����ip��tcl�ļ�ָ�
# // write_ip_tcl -force [get_ips ila_0] -multiple_files  ����ָ��IP����ila
# // write_ip_tcl -force [get_ips] -multiple_files        ����Ŀ¼������IP
# //////////////////////////////////////////////////////////////////////////////////
# ���� ��Ϊ uart_rx �Ĺ��� �洢�ڸ�Ŀ¼��
create_project uart_rx D:/jiang/2022_8/self/uart/uart_rx/work -part xc7z010clg400-1

# ��ӣ�����V�ļ�������
add_files -norecurse -scan_for_includes D:/jiang/2022_8/self/uart/uart_rx/src/hdl/uart_recv.v
import_files -norecurse D:/jiang/2022_8/self/uart/uart_rx/src/hdl/uart_recv.v

add_files -norecurse -scan_for_includes D:/jiang/2022_8/self/uart/uart_rx/src/hdl/uart_rec_data.v
import_files -norecurse D:/jiang/2022_8/self/uart/uart_rx/src/hdl/uart_rec_data.v

add_files -norecurse -scan_for_includes D:/jiang/2022_8/self/uart/uart_rx/src/hdl/top.v
import_files -norecurse D:/jiang/2022_8/self/uart/uart_rx/src/hdl/top.v

# ����V�ļ�
update_compile_order -fileset sources_1

# ��ӣ�����sim�ļ�������
# set_property SOURCE_SET sources_1 [get_filesets sim_1]
# add_files -fileset sim_1 -norecurse -scan_for_includes F:/jiang/worked_project/uart_rx/uart_bytes_tx_test/sim/tb_uart_bytes_tx.v
# import_files -fileset sim_1 -norecurse F:/jiang/worked_project/uart_rx/uart_bytes_tx_test/sim/tb_uart_bytes_tx.v

# ����sim�ļ�
# update_compile_order -fileset sim_1

# ��ӣ�����xdc�ļ�������
add_files -fileset constrs_1 -norecurse D:/jiang/2022_8/self/uart/uart_rx/src/xdc/pin.xdc
import_files -fileset constrs_1 D:/jiang/2022_8/self/uart/uart_rx/src/xdc/pin.xdc



# ִ�и�Ŀ¼�µ��Զ���IP�ű� (��ִ�е�tcl�ű�)
source D:/jiang/2022_8/self/uart/uart_rx/ip_repo/ila_0.tcl

# ִ�и�Ŀ¼�µ��Զ���bd�ű� (��ִ�е�tcl�ű�)
# source D:/jiang/2022_8/self/uart/uart_rx/src/bd/bd.tcl
# # ���ɶ���V
# make_wrapper -files [get_files D:/jiang/2022_8/self/uart/uart_rx/work/uart_rx.srcs/sources_1/bd/system/system.bd] -top

# ����V�ļ�
update_compile_order -fileset sources_1

# # ����Ϊ����
# launch_simulation
# source tb_uart_bytes_tx.tcl

# ���ۺ�  jobs 24��CPU����������
launch_runs synth_1 -jobs 8

# ��ʵ��  jobs 8��CPU����������
launch_runs impl_1 -jobs 8

# # ����bit��
# launch_runs impl_1 -to_step write_bitstream -jobs 8