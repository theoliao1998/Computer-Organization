`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/11 15:26:39
// Design Name: 
// Module Name: dataMem
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


module dataMem(clock, address, write, read, writeData,  readData, reset);
input wire read, write, reset, clock;
input wire[31:0] writeData, address;
output reg [31:0] readData;
reg [31:0] memory [0:63];
integer i;

initial begin
for(i=0;i<64;i=i+1) memory[i] <= 32'd0;   
end
always @(negedge clock)
if(read)
readData <= memory[address];
else readData <= 0;

always @(posedge clock)
begin
if (reset)
begin
for(i=0;i<64;i=i+1) memory[i] <= 32'd0;   
end
else if (write)
        memory[address] <= writeData;
end
endmodule
