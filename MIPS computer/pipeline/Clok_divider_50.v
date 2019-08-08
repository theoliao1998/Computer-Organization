`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/20 12:10:23
// Design Name: 
// Module Name: top
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
module Clock(clk_500,clk2);
reg [8:0]counter;
input clk_500;
output reg clk2;


initial begin
counter<=9'b0;
clk2 = 0;
end

always@(posedge clk_500) begin
if (counter==9'd100)
    begin
        counter<=9'b0;
        clk2<=~clk2;
    end
else
    begin
        counter<=counter+1;
    end
end
endmodule