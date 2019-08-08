`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/16 18:03:41
// Design Name: 
// Module Name: MEM_WB
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


module MEM_WB(
input clk,reset,
input [1:0] CtrlSig,
input [31:0] ReadDataIn, ALUResIn,
input [4:0] dstIn,
output reg [4:0] dstOut,
output reg RegWrite,MemtoReg,
output reg [31:0] ReadDataOut,ALUResOut);

always@(posedge clk)
if(reset)
{dstOut,RegWrite,MemtoReg,ReadDataOut,ALUResOut} <= 0;
else begin
RegWrite <= CtrlSig[1];
MemtoReg <= CtrlSig[0];
ReadDataOut <= ReadDataIn;
ALUResOut <= ALUResIn;
dstOut <= dstIn;
end

endmodule
