`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/15 22:33:22
// Design Name: 
// Module Name: Control
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


module Control(
input [5:0]opcode,
output reg RegDst,Jump, Branch, Bne, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite,
output reg [1:0] ALUOp);
initial begin
RegDst <= 0;
Jump <= 0;
Branch <= 0;
Bne <= 0;
MemRead <= 0;
MemtoReg <= 0;
MemWrite <= 0;
ALUSrc <= 0;
RegWrite <= 0;
ALUOp <= 2'b00;
end
always @(opcode) begin
case(opcode)
6'b000000://R
begin
RegDst <= 1;
Jump <= 0;
Branch <= 0;
Bne <= 0;
MemRead <= 0;
MemtoReg <= 0;
MemWrite <= 0;
ALUSrc <= 0;
RegWrite <= 1;
ALUOp <= 2'b10;
end
6'b001000://addi
begin
RegDst <= 0;
Jump <= 0;
Branch <= 0;
Bne <= 0;
MemRead <= 0;
MemtoReg <= 0;
MemWrite <= 0;
ALUSrc <= 1;
RegWrite <= 1;
ALUOp <= 2'b00;
end          
6'b001100://andi
begin
RegDst <= 0;
Jump <= 0;
Branch <= 0;
Bne <= 0;
MemRead <= 0;
MemtoReg <= 0;
MemWrite <= 0;
ALUSrc <= 1;
RegWrite <= 1;
ALUOp <= 2'b11;
end
6'b000100://beq
begin
RegDst <= 0;
Jump <= 0;
Branch <= 1;
Bne <= 0;
MemRead <= 0;
MemtoReg <= 0;
MemWrite <= 0;
ALUSrc <= 0;
RegWrite <= 0;
ALUOp <= 2'b01;
end
6'b000101://bne
begin
RegDst <= 0;
Jump <= 0;
Branch <= 0;
Bne <= 1;
MemRead <= 0;
MemtoReg <= 0;
MemWrite <= 0;
ALUSrc <= 0;
RegWrite <= 0;
ALUOp <= 2'b01;
end
6'b000010://j
begin
RegDst <= 0;
Jump <= 1;
Branch <= 0;
Bne <= 0;
MemRead <= 0;
MemtoReg <= 0;
MemWrite <= 0;
ALUSrc <= 0;
RegWrite <= 0;
ALUOp <= 2'b00;
end
6'b100011://lw
begin
RegDst <= 0;
Jump <= 0;
Branch <= 0;
Bne <= 0;
MemRead <= 1;
MemtoReg <= 1;
MemWrite <= 0;
ALUSrc <= 1;
RegWrite <= 1;
ALUOp <= 2'b00;
end
6'b101011://sw
begin
RegDst <= 0;
Jump <= 0;
Branch <= 0;
Bne <= 0;
MemRead <= 0;
MemtoReg <= 0;
MemWrite <= 1;
ALUSrc <= 1;
RegWrite <= 0;
ALUOp <= 2'b00;
end
endcase
end
endmodule


