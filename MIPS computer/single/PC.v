`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2018 10:39:06 AM
// Design Name: 
// Module Name: p2
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


module pc(clk, JumpIns, RelativeAddr, Jump, Branch, Bne, Zero, newPC,PC);
output reg [31:0] newPC, PC;
input clk, Jump, Branch, Bne, Zero;
input [25:0] JumpIns;
input [31:0] RelativeAddr;
wire Jump,Branch,Zero;
integer i;
wire [31:0] JumpAddr, BranchAddr;
wire [31:0] PCadd, ALUResult;


assign PCadd = PC + 4'b0100;
assign ALUResult = PCadd + RelativeAddr * 4;
assign JumpAddr = {PCadd[31:28],JumpIns[25:0],{1'b0,1'b0}};
assign BranchAddr = ({Branch,Zero} == {1'b1,1'b1} || {Bne,Zero} == {1'b1,1'b0}) ? ALUResult : PCadd;
initial begin
PC = 0;
end

always@(*)begin
case(Jump)
    1'b0: newPC <= BranchAddr;            
    1'b1: newPC <= JumpAddr;
    default:;
endcase
end

always @(posedge clk) begin
    begin
    PC <= newPC;
    end
end
endmodule

