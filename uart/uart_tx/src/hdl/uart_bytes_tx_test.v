
// *******************************************************************************************************************
// ** 作者 ： 孤独的单刀                                                   			
// ** 邮箱 ： zachary_wu93@163.com
// ** 博客 ： https://blog.csdn.net/wuzhikaidetb 
// ** 日期 ： 2022/07/31	
// ** 功能 ： 1、对基于FPGA的串口多字节发送模块进行测试的模块；
//			  2、设置好一次发送的字节数、波特率、主时钟频率；
//			  3、UART协议设置为起始位1bit，数据位8bit，停止位1bit，无奇偶校验（不可在端口更改，只能更改发送驱动源码）；                                           									                                                                          			
//			  4、数据发送顺序，先发送低字节、再发送高字节。如：发送16’h12_34，先发送单字节8'h34，再发送单字节8'h12。                                          									                                                                          			
// *******************************************************************************************************************	


module uart_bytes_tx_test(
//系统接口
	input 				sys_clk			,					//主时钟
	input 				sys_rst_n		,	                //低电平有效的复位信号
//UART发送线	
	output  			uart_txd							//UART发送线
);

localparam	integer		BYTES 	 = 5			;			//发送的字节数，单字节8bit
localparam	integer		BPS		 = 115200		;			//发送波特率
localparam 	integer		CLK_FRE	 = 50_000_000	;			//输入时钟频率
localparam	integer		CNT_MAX  = 50_000_000  	;			//发送时间间隔，1秒

reg		[31:0]			cnt_time; 
reg						uart_bytes_en;						//发送使能，当其为高电平时，代表此时需要发送数据		
reg		[BYTES*8-1 :0] 	uart_bytes_data;					//需要通过UART发送的数据，在uart_bytes_en为高电平时有效
 
//1s计数模块，每隔1s发送一个数据和拉高发送使能信号一次，数据从初始值开始递增1
always @(posedge sys_clk or negedge sys_rst_n)begin
	if(!sys_rst_n)begin
		cnt_time <= 'd0;
		uart_bytes_en <= 1'd0;
		uart_bytes_data <= 40'h9a_78_56_34_12;				//初始数据
	end
	else if(cnt_time == (CNT_MAX - 1'b1))begin
		cnt_time <= 'd0;
		uart_bytes_en <= 1'd1;								//拉高发送使能
		uart_bytes_data <= uart_bytes_data + 1'd1;			//发送数据累加1
	end
	else begin
		cnt_time <= cnt_time + 1'd1;
		uart_bytes_en <= 1'd0;
		uart_bytes_data <= uart_bytes_data; 
	end
end

//例化串口多字节发送模块
uart_bytes_tx
#(
	.BYTES 	 			(BYTES 				),				
	.BPS				(BPS				),				
	.CLK_FRE			(CLK_FRE			)				
)		
uart_bytes_tx_inst		
(		
		
	.sys_clk			(sys_clk			),			
	.sys_rst_n			(sys_rst_n			),				                                    
	.uart_bytes_data	(uart_bytes_data	),			
	.uart_bytes_en		(uart_bytes_en		),			                                   
	.uart_bytes_done	(					),			
	.uart_txd			(uart_txd			)			
);

endmodule