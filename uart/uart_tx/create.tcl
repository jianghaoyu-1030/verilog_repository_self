# ���� ��Ϊ uart_tx �Ĺ��� �洢�ڸ�Ŀ¼��
create_project uart_tx F:/jiang/github/uart/uart_tx/work -part xc7z020clg484-2

# ��ӣ�����V�ļ�������
add_files -norecurse -scan_for_includes F:/jiang/github/uart/uart_tx/src/hdl/uart_tx.v
import_files -norecurse F:/jiang/github/uart/uart_tx/src/hdl/uart_tx.v

add_files -norecurse -scan_for_includes F:/jiang/github/uart/uart_tx/src/hdl/uart_bytes_tx.v
import_files -norecurse F:/jiang/github/uart/uart_tx/src/hdl/uart_bytes_tx.v

add_files -norecurse -scan_for_includes F:/jiang/github/uart/uart_tx/src/hdl/uart_bytes_tx_test.v
import_files -norecurse F:/jiang/github/uart/uart_tx/src/hdl/uart_bytes_tx_test.v

# ����V�ļ�
update_compile_order -fileset sources_1

# ��ӣ�����sim�ļ�������
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse -scan_for_includes F:/jiang/github/uart/uart_tx/src/sim/tb_uart_bytes_tx.v
import_files -fileset sim_1 -norecurse F:/jiang/github/uart/uart_tx/src/sim/tb_uart_bytes_tx.v

# ����sim�ļ�
update_compile_order -fileset sim_1

# ���ۺ�  jobs 24��CPU����������
launch_runs synth_1 -jobs 24

# ����Ϊ����
launch_simulation
source tb_uart_bytes_tx.tcl