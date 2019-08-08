`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/04 11:35:29
// Design Name: 
// Module Name: Lab7
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
module four_bit_Ring_Counter(clock, Q);
input clock;
output reg [3:0] Q;
reg [1:0] q;

initial begin
q = 2'b00;
end

always @ (posedge clock)
 q <= q + 1;

always @ (q)
begin
case(q)
    2'b00: Q<=4'b0111;
    2'b01: Q<=4'b1011;
    2'b10: Q<=4'b1101;
    2'b11: Q<=4'b1110;
    default:  Q<=4'b0111;
endcase
end
endmodule
