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
module SSDDriver(Q, Cathodes);
input [3:0]Q;
output [6:0] Cathodes; 
reg a,b,c,d,e,f,g;
always @(Q) begin 
case (Q) 
4'b0000:  begin a=0;b=0;c=0;d=0;e=0;f=0;g=1; end
4'b0001:  begin a=1;b=0;c=0;d=1; e=1; f=1; g=1; end
4'b0010:  begin a=0;b=0;d=0;e=0;g=0;c=1; f=1; end
4'b0011:  begin a=0;b=0;c=0;d=0;g=0;e=1; f=1; end
4'b0100:  begin a=1;b=0;c=0;g=0;e=1; d=1; f=0; end
4'b0101:  begin a=0;c=0;d=0;g=0;f=0;b=1; e=1; end
4'b0110:  begin a=0;g=0;b=1;c=0;d=0;e=0;f=0; end
4'b0111:  begin a=0;b=0;c=0; d=1; e=1; f=1; g=1; end
4'b1000:  begin a=0;b=0;c=0;d=0;e=0;f=0; g=0; end
4'b1001:  begin a=0;b=0;c=0;f=0;g=0; d=0; e=1; end
4'b1010:  begin a=0;b=0;c=0;f=0;g=0; d=1; e=0; end
4'b1011:  begin a=1;b=1;c=0;f=0;g=0; d=0; e=0; end
4'b1100:  begin a=0;b=1;c=1;f=0;g=1; d=0; e=0; end
4'b1101:  begin a=1;b=0;c=0;f=1;g=0; d=0; e=0; end
4'b1110:  begin a=0;b=1;c=1;f=0;g=0; d=0; e=0; end
4'b1111:  begin a=0;b=1;c=1;f=0;g=0; d=1; e=0; end
default  begin  a=0;b=0;c=0;d=0;e=0;f=0;g=0; end
endcase 
end

assign Cathodes={a,b,c,d,e,f,g};

endmodule


