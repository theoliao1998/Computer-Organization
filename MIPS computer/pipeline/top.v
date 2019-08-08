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
module Clock_divider_500(clk_100M,clk_500);
reg [17:0]counter;
input clk_100M;
output clk_500;
reg clk_500;

initial begin
counter<=18'b0;
end

always@(posedge clk_100M) begin
if (counter==18'd200000)
    begin
        counter<=18'b0;
        clk_500<=1;
    end
else
    begin
        counter<=counter+1;
        clk_500<=0;
    end
end
endmodule



module top(
input clk_internal,clk, reset, sel,
input [4:0] observe,
output A3,A2,A1,A0,
output a,b,c,d,e,f,g);
wire [31:0] data_ob;
wire clk_500,clk_50;
wire [6:0]Cathodes0;
wire [6:0]Cathodes1;
wire [6:0]Cathodes2;
wire [6:0]Cathodes3;
wire [6:0]Cathodes4;
wire [6:0]Cathodes5;
wire [6:0]Cathodes6;
wire [6:0]Cathodes7;

Clock_divider_500 CD(clk_internal,clk_500);
Clock_divider_50 CD2(clk_500,clk_50);
main MAIN(clk, clk_50, reset, observe, data_ob);    

SSDDriver UUT1(.Q(data_ob[3:0]),.Cathodes(Cathodes0));
SSDDriver UUT2(.Q(data_ob[7:4]),.Cathodes(Cathodes1));
SSDDriver UUT3(.Q(data_ob[11:8]),.Cathodes(Cathodes2));
SSDDriver UUT4(.Q(data_ob[15:12]),.Cathodes(Cathodes3));

SSDDriver UUT5(MAIN.PC[3:0],Cathodes4);
SSDDriver UUT6(MAIN.PC[7:4],Cathodes5);
SSDDriver UUT7(MAIN.PC[11:8],Cathodes6);
SSDDriver UUT8(MAIN.PC[15:12],Cathodes7);

four_bit_Ring_Counter UUT(clk_500,{A3,A2,A1,A0});

assign {a,b,c,d,e,f,g} = ({A3, A2, A1, A0}==4'b0111 && sel) ? Cathodes3 :
                         ({A3, A2, A1, A0}==4'b1011 && sel) ? Cathodes2 :
                         ({A3, A2, A1, A0}==4'b1101 && sel) ? Cathodes1 :
                         ({A3, A2, A1, A0}==4'b1110 && sel) ? Cathodes0 :
                         ({A3, A2, A1, A0}==4'b0111 && sel == 0) ? Cathodes7 :
                         ({A3, A2, A1, A0}==4'b1011 && sel == 0) ? Cathodes6 :
                         ({A3, A2, A1, A0}==4'b1101 && sel == 0) ? Cathodes5 :
                         ({A3, A2, A1, A0}==4'b1110 && sel == 0) ? Cathodes4 : Cathodes3;

endmodule
