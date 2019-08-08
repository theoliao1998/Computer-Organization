`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/15 14:19:37
// Design Name: 
// Module Name: main
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


module main(CLK, CLK2, reset, observe, data_ob);
input CLK,CLK2,reset;
input [4:0] observe;
output data_ob;
wire [31:0] Instruction, RelativeValue;
wire [31:0] PCin,PCout; 
wire [31:0]ReadData1,ReadData2,WriteData, DataMemRead,ALURes;
wire [31:0] ALUin1, ALUin2;
wire RegDst, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
wire Jump, Branch, Bne,Zero;
wire [1:0] ALUOp;
wire [3:0] ALUControl;
wire [4:0] ReadReg1, ReadReg2, WriteReg;

assign WriteReg = RegDst ? {Instruction[15:11]}:{Instruction[20:16]};
assign ReadReg1 = {Instruction[25:21]};
assign ReadReg2 = {Instruction[20:16]};
assign WriteData = MemtoReg ? DataMemRead : ALURes;
assign ALUin1 = ReadData1;
assign ALUin2 = ALUSrc ? RelativeValue : ReadData2;

signExtend signext(.in(Instruction[15:0]), .out(RelativeValue));
pc PC(.clk(CLK), .JumpIns(Instruction[25:0]), .RelativeAddr(RelativeValue), .Jump(Jump), .Branch(Branch), .Bne(Bne), .Zero(Zero), .newPC(PCin), .PC(PCout));
IM InsMem(.Instruction(Instruction), .PC(PCout));
Control control(Instruction[31:26], RegDst, Jump, Branch,Bne, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, ALUOp);
Registers regs(CLK2, ReadReg1, ReadReg2, RegWrite, ReadData1, ReadData2, WriteData, WriteReg,observe,data_ob,reset);
ALUcontrol ALUCTRL(Instruction[5:0], ALUOp, ALUControl);
ALU alu(ALUin1, ALUin2, ALUControl, Zero, ALURes);
dataMem DM(CLK2, ALURes, MemWrite, MemRead, ReadData2, DataMemRead, reset);

endmodule
