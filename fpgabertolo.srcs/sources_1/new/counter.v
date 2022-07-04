
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/06/2022 03:19:02 PM
// Design Name: 
// Module Name: counter
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
`timescale 1ns / 100ps
module counter(
 input clk,
 input reset,
 input en,
output [31:0] Q
);
reg [31:0] count;
always@(posedge clk)
begin
 if(reset)
 count <= 32'b0;
 else if (en)
 count <= count + 1;
end
assign Q = count;
endmodule
