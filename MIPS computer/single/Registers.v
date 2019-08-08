`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/14 21:33:15
// Design Name: 
// Module Name: Regs
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


module Registers(clk, rs, rt,RegWrite, Data1, Data2, writeData, writeReg,observe,Data_ob,reset);
input clk,RegWrite, reset;
input [4:0] rs;
input [4:0] rt;
input [4:0] observe;
output [31:0] Data1, Data2, Data_ob;
input wire [4:0] writeReg;
input wire [31:0] writeData;
reg [31:0] register[0:31];
integer i;
initial begin
    for (i = 0; i < 32; i = i+1) register[i] <= 0; //Initialize the registers
end

assign Data_ob = register[observe];

always @(posedge clk) 
begin
if (reset)
begin
    for (i = 0; i < 32; i = i+1) register[i] <= 0; //Initialize the registers
end
else if(RegWrite == 1 && writeReg != 0) register[writeReg] <= writeData; 
end
assign Data1 = register[rs];
assign Data2 = register[rt];

endmodule
