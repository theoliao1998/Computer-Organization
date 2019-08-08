`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/16 17:33:58
// Design Name: 
// Module Name: EX_MEM
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


module EX_MEM(
input clk, reset,
input [1:0] WBSig,
input [1:0] MSig,
input [31:0] ALURes,WriteDataIn,
input [4:0] dstIn,
output reg [1:0] CtrlLeft,
output reg MemRead, MemWrite,
output reg [31:0] Address, WriteDataOut,
output reg [4:0] dstOut);


always@(posedge clk)
begin
if(reset)
{CtrlLeft,MemRead, MemWrite,Address, WriteDataOut,dstOut} <= 0;
else begin
CtrlLeft <= WBSig;
MemRead <= MSig[1];
MemWrite <= MSig[0];
Address <= ALURes;
WriteDataOut <= WriteDataIn;
dstOut <= dstIn;
end
end
endmodule
