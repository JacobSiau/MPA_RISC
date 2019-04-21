`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Texas Tech University
// Engineer: Jacob Siau
// 
// Create Date: 01/31/2019 05:39:54 PM
// Design Name: 
// Module Name: homework2_function_unit
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
module homework2_function_unit (
    input      [15:0] A,
    input      [15:0] B, 
    input      [3:0] G_select,  // ALU ops select/cin {S[2:0],Cin}
    input      [1:0] H_select,  // Shifter ops select {S[2:0]}
    input      MF_select,       // select for MUX F 
    output     C,               // carry flag
    output     N,               // negative flag
    output     V,               // overflow flag
    output     Z,               // zero flag
    output     [15:0] F
    );
    
    wire [15:0] G; // output register for ALU
    wire [15:0] H; // output register for Shifter
    
    homework2_alu alu(
        .A(A),
        .B(B),
        .S(G_select[3:1]),
        .Cin(G_select[0]),
        .C(C),
        .V(V),
        .G(G)    
    );
    
    homework2_shifter shifter(
        .A(B),
        .S(H_select),
        .ir(1'b0),
        .il(1'b0),
        .H(H)
    );
    
    homework2_mux_2_1 muxf(
        .A(G),
        .B(H),
        .S(MF_select),
        .Y(F)
    );
    
    assign Z = ~| F;         // Z detect
    assign N = (F[15] == 1); // N detect if MSB was 1
    
endmodule // homework2_function_unit



















