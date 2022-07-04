
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/06/2022 03:42:42 PM
// Design Name: 
// Module Name: mux
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
module mux(
 input [7:0] sel,
 input [31:0] data0,
 input [31:0] data1,
 input [31:0] data2,
 input [31:0] data3,
 input [31:0] data4,
  output reg [31:0] Q
 );

 //reg [31:0] Q;
 initial
 begin
 Q <= 0;
 end
 always @(sel)
 begin
 case(sel[7:0])
 8'b00000001: begin
 Q <= data0;
 end
 8'b00000010: begin
 Q <= data1;
 end
 8'b00000011: begin
 Q <= data2;
 end
 8'b00000100: begin
 Q <= data3;
 end
 8'b00000101: begin
 Q <= data4;
 end

 default: begin
 Q <= 32'hFFFFFFFF; //-1 en u32
 end
 endcase
 end

 //assign Qout = Q;

endmodule
