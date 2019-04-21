`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2019 04:32:42 PM
// Design Name: 
// Module Name: homework2_mux_2_1
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
module homework2_mux_2_1(
    input      [15:0] A,
    input      [15:0] B,
    input             S, // select bit 
    output     [15:0] Y
    );
    
    assign Y = (S == 1'b0) ? A : B;
    
endmodule // homework2_mux_2_1
