`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/02 22:26:06
// Design Name: 
// Module Name: 
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: FE EF 00 00 01 02 03 04 05 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module uart_rec_data
(
	input sys_clk,
	input sys_rst_n,
	input wire uart_rxd,
	output [7:0]value1,
	output [7:0]value2,
	output [7:0]value3,
	output [7:0]value4,
	output [7:0]value5,
	output rec_done 
);
////////////////////////////////////	
parameter  CLK_FREQ = 50000000;      
parameter  UART_BPS = 115200;  

////////////////////////////////////
wire       uart_en_w;                 
wire [7:0] uart_data_w; 
wire U_edge,D_edge;

reg  uart_a,uart_b;
reg [15:0]frame_head;
reg [7:0]rec_num;
reg [7:0]rec_uart_data[0:6];
reg [7:0] frame_data[0:1];
reg [31:0]crc_data;
reg [7:0]crc_data_in;
reg rec_done_r;
reg [7:0] value1_r;
reg [7:0] value2_r;
reg [7:0] value3_r;
reg [7:0] value4_r;
reg [7:0] value5_r;
////////////////////////////////////
assign rec_done=rec_done_r;
assign value1=value1_r;
assign value2=value2_r;
assign value3=value3_r;
assign value4=value4_r;
assign value5=value5_r;
///////////////ภýปฏ/////////////////////
uart_recv 
#(                          
    .CLK_FREQ       (CLK_FREQ),       
    .UART_BPS       (UART_BPS)
)       
u_uart_recv(                 
    .sys_clk        (sys_clk), 
    .sys_rst_n      (sys_rst_n),
    
    .uart_rxd       (uart_rxd),
    .uart_done      (uart_en_w),
    .uart_data      (uart_data_w)
    );
////////////////////////////////////	 
always @(posedge sys_clk) 
   begin 
	uart_a <= uart_en_w;
	uart_b <= uart_a;
   end 
assign U_edge = uart_a & ~uart_b;
assign D_edge = ~uart_a & uart_b;
////////////////////////////////////

always@(posedge sys_clk or negedge sys_rst_n)
if(!sys_rst_n)
	begin
	frame_head         <= 0; 
	 rec_num           <= 0;
	 rec_uart_data[0]  <= 0;
	 rec_uart_data[1]  <= 0;
	 rec_uart_data[2]  <= 0;
	 rec_uart_data[3]  <= 0;
	 rec_uart_data[4]  <= 0;
	 rec_uart_data[5]  <= 0;
	 rec_uart_data[6]  <= 0;
	 frame_data[0]     <= 0;
	 frame_data[1]     <= 0;
	 rec_done_r        <= 0;
	end
else if(U_edge == 1)
	begin
	rec_num<= rec_num + 1;
	if(frame_head == 16'hFEEF)
	begin
		if(rec_num == 6)
		begin
		value1_r <= rec_uart_data[2];
		value2_r <= rec_uart_data[3];
		value3_r <= rec_uart_data[4];
		value4_r <= rec_uart_data[5];
		value5_r <= uart_data_w;
		rec_num     <= 0;
		frame_head  <= 0;
		rec_done_r <=1'b1;
		//crc_data       <= rec_uart_data[0] + rec_uart_data[1] + rec_uart_data[2] + rec_uart_data[3] + rec_uart_data[4] + rec_uart_data[5] + rec_uart_data[6] ;
		end
		else
		begin
		rec_uart_data[rec_num] <= uart_data_w;
		rec_done_r<=1'b0;
		end
	end
	else
		begin
		frame_head <= {frame_head[7:0],uart_data_w};
		rec_num    <= 0;
		rec_done_r<=1'b0;
		end
	end





endmodule
	