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
input equal, IF_ID_write,
input [1:0] ALUOp_EX,
input [5:0]opcode,
output reg Jump, Branch, Bne, IF_flush,
output [7:0] CtrlSig);
reg RegDst, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
reg [1:0] ALUOp;
assign CtrlSig = {RegWrite,MemtoReg,MemRead, MemWrite,RegDst, ALUOp, ALUSrc};
initial begin
IF_flush <= 0;
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
always @(*) begin
case(opcode)
6'b000000://R
begin
IF_flush <= 0;
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
IF_flush <= 0;
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
IF_flush <= 0;
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
if(IF_ID_write) IF_flush<=equal ? 1:0;
else IF_flush<=0;
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
if(IF_ID_write) IF_flush<=equal ? 0:1;
else IF_flush<=0;
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
IF_flush <= 1;
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
IF_flush <= 0;
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
IF_flush <= 0;
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


