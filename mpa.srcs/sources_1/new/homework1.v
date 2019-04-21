`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jacob Siau 
// 
// Create Date: 01/27/2019 04:34:08 PM
// Design Name: 
// Module Name: homework1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: This module implements a circuit that accomplishes the following:
//
//      A AND ( ~B OR C ) 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module homework1 (
    input A,
    input B, 
    input C,
    output Y 
    );
    
assign Y = A & (~B | C); // Y = A AND (NOT(B) OR C)
    
endmodule
