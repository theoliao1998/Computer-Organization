`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/17 09:53:22
// Design Name: 
// Module Name: Hazard
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


module Hazard(
input [31:0] Ins,
input ID_EX_MemRead, MemRead,
input [4:0] ID_EX_rt,ID_EX_rd, dst_MEM,
input [1:0] ALUOp_EX,
output reg PC_write, IF_ID_write, nop);
wire [5:0] opcode;
wire [4:0] rs, rt;
assign opcode = Ins[31:26];
assign rs = Ins[25:21];
assign rt = Ins[20:16];
initial begin
PC_write <= 1;
IF_ID_write <= 1;
nop = 0;
end
always @(*)begin
if(ID_EX_MemRead && (rs == ID_EX_rt || rt == ID_EX_rt))begin //lw
PC_write <= 0;
IF_ID_write <= 0;
nop <= 1;
end
else if ((opcode == 6'b000100 || opcode == 6'b000101) &&  ALUOp_EX == 2'b10  && (rs == ID_EX_rd || rt == ID_EX_rd))
begin
PC_write <= 0;
IF_ID_write <= 0;
nop <= 1;
end
else if ((opcode == 6'b000100 || opcode == 6'b000101) && MemRead && (rs == dst_MEM || rt == dst_MEM))
begin
PC_write <= 0;
IF_ID_write <= 0;
nop <= 1;
end
else
begin
PC_write <= 1;
IF_ID_write <= 1;
nop <= 0;
end
end

endmodule
