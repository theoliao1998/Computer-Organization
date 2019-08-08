`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/16 18:10:53
// Design Name: 
// Module Name: sim
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


module sim();
reg DONE;
reg reset;
reg clk, clk2;
reg [4:0] observe;
wire [31:0] data_ob;
wire [31:0] newPC, PC, PC_IF, Ins_IF, PC_ID, Ins_ID, Data1_ID, Data2_ID, WriteDataReg;
wire [31:0] ExtendedIn, ExtendedOut, Data1_EX, Data2_EX;
wire [31:0] ALURes, Address, WriteDataMem, ReadDataMem, ALUinput2;
wire [7:0] CtrlSig, CtrlSig_ID;
wire [1:0] WBSig_EX, MSig_EX, WBSig_MEM;
wire [4:0] rs_EX,rt_EX, rd_EX,dst_EX,dst_MEM, dst;
wire [3:0] ALUCtrlSig;
wire [1:0] ALUOp, ForwardA, ForwardB, ForwardCmp1, ForwardCmp2;
wire RegDst,ALUSrc,RegWrite,MemtoReg,Jump,Branch,Bne,MemRead,MemWrite;

wire [1:0] move;
wire PCwrite,IF_ID_write, IF_flush, nop, equal, MemReadEX, RegWriteMEM, RegWriteEX;
wire [31:0] JumpAddr, A, B, ReadDataWB, ALUresWB;
wire [31:0] compare1, compare2;

assign MemReadEX = MSig_EX[1];
assign RegWriteMEM = WBSig_MEM[1];
assign RegWriteEX = WBSig_EX[1];
assign PC_IF = PC + 4;

Forwarding fwd_cmp(RegWriteEX,RegWriteMEM,dst_EX, dst_MEM, Ins_ID[25:21], Ins_ID[20:16], ForwardCmp1, ForwardCmp2);    
assign compare1 = (ForwardCmp1 == 2'b00) ? Data1_ID :
                  (ForwardCmp1 == 2'b01) ? Address :
                  (ForwardCmp1 == 2'b10) ? ALURes : 0;
assign compare2 = (ForwardCmp2 == 2'b00) ? Data2_ID :
                  (ForwardCmp2 == 2'b01) ? Address :
                  (ForwardCmp2 == 2'b10) ? ALURes : 0;  

assign equal = (compare1 == compare2) ? 1 : 0;
assign move = (Jump || (Branch && equal) || (Bne && !equal)) ? 2'b10 :
              reset ? 2'b01 : 2'b00;
assign newPC = (move == 2'b00) ? (PC+4):
               (move == 2'b01) ? 0:
               (move == 2'b10) ? JumpAddr : 0;
assign JumpAddr = Jump ? {PC_ID[31:28],Ins_ID[25:0],{1'b0,1'b0}}:
                  (Branch && equal) || (Bne && !equal) ? (ExtendedIn * 4 + PC_ID) : 0;
            
assign CtrlSig_ID = nop ? 0 : CtrlSig;
assign A = (ForwardA == 2'b00) ? Data1_EX:
           (ForwardA == 2'b01) ? WriteDataReg:
           (ForwardA == 2'b10) ? Address : 0; 
assign B = (ForwardB == 2'b00) ? Data2_EX:
           (ForwardB == 2'b01) ? WriteDataReg:
           (ForwardB == 2'b10) ? Address : 0;            

assign ALUinput2 = (ALUSrc) ? ExtendedOut : B;

//assign ALUSource = ALUSrc ? ExtendedOut : Data2_EX;
assign dst_EX = RegDst ? rd_EX : rt_EX;
assign WriteDataReg = MemtoReg ? ReadDataWB : ALUresWB;

PC pc(clk,PCwrite,newPC, PC);
IM InsMem(Ins_IF, PC);
IF_ID if_id(clk,reset,IF_ID_write,IF_flush,PC_IF, Ins_IF, PC_ID, Ins_ID);
Hazard hzd(Ins_ID,MemReadEX,MemRead,rt_EX, rd_EX, dst_MEM,ALUOp,PCwrite,IF_ID_write,nop);
Control ctrl(equal,IF_ID_write,ALUOp,Ins_ID[31:26],Jump, Branch, Bne, IF_flush,CtrlSig);
Registers regs(clk,clk2, Ins_ID[25:21], Ins_ID[20:16],RegWrite,Data1_ID,Data2_ID,WriteDataReg,dst,observe, data_ob,reset);
signExtend sE(Ins_ID[15:0], ExtendedIn);
ID_EX id_ex(clk,reset,CtrlSig_ID,Data1_ID,Data2_ID,ExtendedIn,Ins_ID[25:21],Ins_ID[20:16],Ins_ID[15:11],
WBSig_EX,MSig_EX,RegDst,ALUOp,ALUSrc,Data1_EX, Data2_EX, ExtendedOut,rs_EX,rt_EX, rd_EX);
ALUControl aluctrl(ExtendedOut[5:0],ALUOp,ALUCtrlSig);
ALU alu(A,ALUinput2,ALUCtrlSig,ALURes);
Forwarding fwd(RegWriteMEM,RegWrite,dst_MEM,dst,rs_EX,rt_EX,ForwardA,ForwardB);
EX_MEM ex_mem(clk,reset,WBSig_EX,MSig_EX,ALURes,B,dst_EX,WBSig_MEM,MemRead,MemWrite,Address,WriteDataMem,dst_MEM);
dataMem dm(clk2, Address, MemWrite, MemRead,WriteDataMem,ReadDataMem,reset);
MEM_WB mem_wb(clk,reset, WBSig_MEM, ReadDataMem, Address,dst_MEM,dst,RegWrite,MemtoReg, ReadDataWB, ALUresWB);

always@(clk) begin
$display("time %0d\t CLK=%b PC=%h\n",$time,clk,PC);
$display("[$s0]=%h,[$s1]=%h,[$s2]=%h \n",regs.register[16],regs.register[17],regs.register[18]);
$display("[$s3]=%h,[$s4]=%h,[$s5]=%h \n",regs.register[19],regs.register[20],regs.register[21]);
$display("[$s6]=%h,[$s7]=%h,[$t0]=%h \n",regs.register[22],regs.register[23],regs.register[8]);
$display("[$t1]=%h,[$t2]=%h,[$t3]=%h \n",regs.register[9],regs.register[10],regs.register[11]);
$display("[$t4]=%h,[$t5]=%h,[$t6]=%h \n",regs.register[12],regs.register[13],regs.register[14]);
$display("[$t7]=%h,[$t8]=%h,[$t9]=%h \n",regs.register[15],regs.register[24],regs.register[25]);
end

always@(regs.register or dm.memory)begin
DONE = 1;
#5 DONE = 0;
end

initial begin
#0 clk = 0; clk2=0; reset = 1;observe = 17; DONE=0;
#51 reset = 0;
end

always #50 clk = ~clk;
always #10 clk2 = ~clk2;
initial #4000 $stop;
endmodule
