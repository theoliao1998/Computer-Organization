`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/17 10:43:51
// Design Name: 
// Module Name: Forwarding
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


module Forwarding(
input MEM_RegWrite,WB_RegWrite,
input [4:0] MEM_rd,WB_rd,EX_rs,EX_rt,
output reg [1:0] ForwardA, ForwardB);
initial begin
ForwardA <= 2'b00;
ForwardB <= 2'b00;
end
always @(*)
begin
if(MEM_RegWrite && (MEM_rd !=0) && (MEM_rd == EX_rs)) ForwardA <= 2'b10;
else if (WB_RegWrite && (WB_rd != 0) && (WB_rd == EX_rs)) ForwardA <= 2'b01;
else ForwardA <= 2'b00;

if(MEM_RegWrite && (MEM_rd !=0) && (MEM_rd == EX_rt)) ForwardB <= 2'b10;
else if (WB_RegWrite && (WB_rd != 0) && (WB_rd == EX_rt)) ForwardB <= 2'b01;
else ForwardB <= 2'b00;

end

endmodule
