`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/16 17:15:34
// Design Name: 
// Module Name: ID_EX
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


module ID_EX(
input clk,reset,
input [7:0] CtrlSig,
input [31:0] data1in, data2in, extendedin,
input [4:0] rs_ID, rt_ID, rd_ID,
output reg [1:0] WBSig,
output reg [1:0] MSig,
output reg RegDst, 
output reg [1:0] ALUOp,
output reg ALUSrc,
output reg [31:0] data1out,data2out,extendedout,
output reg [4:0]  rs_EX, rt_EX, rd_EX);

always@(posedge clk)
if (reset){WBSig,MSig,RegDst,ALUOp,ALUSrc,data1out,data2out,extendedout,rs_EX,rt_EX,rd_EX} <= 0; 
else
begin
WBSig <= CtrlSig[7:6];
MSig <= CtrlSig[5:4];
RegDst <= CtrlSig[3];
ALUOp <= CtrlSig[2:1];
ALUSrc <= CtrlSig[0];
data1out <= data1in;
data2out <= data2in;
extendedout <= extendedin;
rs_EX <= rs_ID;
rt_EX <= rt_ID;
rd_EX <= rd_ID;
end

endmodule
