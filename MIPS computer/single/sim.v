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


module sim;
reg CLK,CLK2,reset;
reg [4:0] observe;
wire [31:0] Instruction, RelativeValue, data_ob;
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

always@(CLK) begin
$display("time %0d\t CLK=%b PC=%h\n",$time,CLK,PCout);
$display("[$s0]=%h,[$s1]=%h,[$s2]=%h \n",regs.register[16],regs.register[17],regs.register[18]);
$display("[$s3]=%h,[$s4]=%h,[$s5]=%h \n",regs.register[19],regs.register[20],regs.register[21]);
$display("[$s6]=%h,[$s7]=%h,[$t0]=%h \n",regs.register[22],regs.register[23],regs.register[8]);
$display("[$t1]=%h,[$t2]=%h,[$t3]=%h \n",regs.register[9],regs.register[10],regs.register[11]);
$display("[$t4]=%h,[$t5]=%h,[$t6]=%h \n",regs.register[12],regs.register[13],regs.register[14]);
$display("[$t7]=%h,[$t8]=%h,[$t9]=%h \n",regs.register[15],regs.register[24],regs.register[25]);
end

initial begin
#0 CLK = 0;CLK2 = 0; reset = 0; observe = 20;
#51 reset=0;
end


always #50 CLK = ~CLK;
always #5 CLK2 = ~CLK2;
initial #3000 $stop;
endmodule
