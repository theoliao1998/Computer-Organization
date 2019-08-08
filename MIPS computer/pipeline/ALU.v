`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/15 18:27:05
// Design Name: 
// Module Name: ALU
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


module ALU(
input [31:0] in1,in2,
input [3:0] Control,
output [31:0] Result);
assign Result = (Control == 4'b0010) ? (in1 + in2):
                (Control == 4'b0110) ? (in1 - in2):
                (Control == 4'b0000) ? (in1 & in2):
                (Control == 4'b0001) ? (in1 | in2):
                ((Control == 4'b0111) && (in1 < in2)) ? 1:0;

endmodule
