`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/02 22:26:06
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top
(
    input sys_clk,
	input sys_rst_n,
	input wire uart_rxd
);

////////////////////////////////////
parameter  CLK_FREQ = 50_000_000;      
parameter  UART_BPS = 115200;  
///////////////////////////////////
wire [7:0]value1;
wire [7:0]value2;
wire [7:0]value3;
wire [7:0]value4;
wire [7:0]value5;
wire rec_done;

///////////////////////////////////
uart_rec_data 
#(
    .CLK_FREQ (CLK_FREQ ),
    .UART_BPS (UART_BPS )
)
u_uart_rec_data(
    .sys_clk   (sys_clk   ),
    .sys_rst_n (sys_rst_n ),
    .uart_rxd  (uart_rxd  ),
    .value1    (value1    ),
    .value2    (value2    ),
    .value3    (value3    ),
    .value4    (value4    ),
    .value5    (value5    ),
    .rec_done  (rec_done  )
);
///////////////////////////////////
ila_0 ila_0_i (
	.clk(sys_clk), // input wire clk

	.probe0(value1), // input wire [7:0]  probe0  
	.probe1(value2), // input wire [7:0]  probe1 
	.probe2(value3), // input wire [7:0]  probe2 
	.probe3(value4), // input wire [7:0]  probe3 
	.probe4(value5), // input wire [7:0]  probe4 
	.probe5(rec_done) // input wire [0:0]  probe5
);

endmodule
