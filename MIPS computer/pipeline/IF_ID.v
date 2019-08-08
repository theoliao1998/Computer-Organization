`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/16 16:59:26
// Design Name: 
// Module Name: IF_ID
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


module IF_ID(
input clk,reset,
input IF_ID_write,IF_flush,
input [31:0] PCin, InsIn,
output reg [31:0] PCout, InsOut);

always@(posedge clk)
begin
if(reset) InsOut <= 0;
else if(IF_flush) InsOut <= 0;
else if(IF_ID_write)
begin
PCout <= PCin;
InsOut <= InsIn;
end
end
endmodule
