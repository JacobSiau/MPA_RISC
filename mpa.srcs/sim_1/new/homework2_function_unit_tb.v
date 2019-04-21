`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2019 04:49:03 PM
// Design Name: 
// Module Name: homework2_function_unit_tb
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
module homework2_function_unit_tb();

reg [15:0] A;
reg [15:0] B;
reg [3:0] G_select;
reg [1:0] H_select;
reg MF_select;

wire C, V, N, Z;
wire [15:0] F;

// instantiate the unit under test 
homework2_function_unit UUT (
    .A(A),
    .B(B),
    .G_select(G_select),
    .H_select(H_select),
    .MF_select(MF_select),
    .C(C),
    .N(N),
    .V(V),
    .Z(Z),
    .F(F)
);

initial begin

    A = 0;
    B = 0;
    G_select = 0;
    H_select = 0;
    MF_select = 0;
    
    #20;
    
    // arithmetic tests 
    MF_select = 1'b0;
    
    // transfer A tests
    G_select = 4'b0000;
    
    A = 16'hA5A5;
    
    #20;
    
    // increment A tests
    G_select = 4'b0001;
    
    A = 16'h0000;
    #10;
    A = 16'hFFFE;
    #10;
    A = 16'hFFFF;
    
    #20;
    
    // addition tests
    G_select = 4'b0010;
    
    A = 16'h0000;
    B = 16'h0001;
    #10;
    A = 16'h9999;
    B = 16'h6666;
    #10;
    A = 16'hFFFE;
    B = 16'hFFFF;
    #10;
    A = 16'hFFFF;
    B = 16'hFFFE;
    #10;
    A = 16'hA5A5;
    B = 16'h5A5A;
    
    #20;
    
    // add with carry in of 1 tests
    G_select = 4'b0011;
    
    A = 16'h0000;
    B = 16'h0000;
    #10;
    A = 16'h0000;
    B = 16'h0001;
    #10;
    A = 16'h9999;
    B = 16'h6666;
    #10;
    A = 16'hFFFF;
    B = 16'hFFFF;
    #10;
    A = 16'hA5A5;
    B = 16'h5A5A;
    
    #20;
    
    // A plus 1's complement of B tests
    G_select = 4'b0100;
    
    A = 16'h0000;
    B = 16'h0000;
    #10;
    A = 16'h0000;
    B = 16'hFFFF;
    #10;
    A = 16'hFFFF;
    B = 16'h0000;
    #10;
    A = 16'hFFFE;
    B = 16'h0000;
    #10;
    A = 16'hA5A5;
    B = 16'hA5A5;
    
    #20;
    
    // A - B tests 
    G_select = 4'b0101;
    
    A = 16'h0000;
    B = 16'h0000;
    #10;
    A = 16'h0001;
    B = 16'h0000;
    #10;
    A = 16'h0001;
    B = 16'h0001;
    #10;
    A = 16'hFFFF;
    B = 16'hFFFF;
    #10;
    A = 16'hFFFF;
    B = 16'h0000;
    #10;
    A = 16'h0000;
    B = 16'hFFFF;
    #10;
    A = 16'hFFFF;
    B = 16'h0001;
    #10;
    A = 16'hA5A5;
    B = 16'h5A5A;
    
    #20;
    
    // decrement A tests
    G_select = 4'b0110;
    
    A = 16'h0001;
    #10;
    A = 16'h0000;
    #10;
    A = 16'hFFFF;
    #10;
    A = 16'hA5A5;
    
    #20;
    
    // transfer A tests part 2 
    G_select = 4'b0111;
    
    A = 16'h0000;
    #10;
    A = 16'h0001;
    #10;
    A = 16'hFFFF;
    #10;
    A = 16'hA5A5;
    
    #20;
    
    // AND tests
    G_select = 4'b1000;
    
    A = 16'h0000;
    B = 16'h0000;
    #10;
    A = 16'h0001;
    B = 16'h0001;
    #10;
    A = 16'hFFFF;
    B = 16'hFFFF;
    #10;
    A = 16'h6666;
    B = 16'h9999;
    #10;
    A = 16'hFFFE;
    B = 16'h0001;
    
    #20;
    
    // OR tests 
    G_select = 4'b1010;
    
    A = 16'h0000;
    B = 16'h0000;
    #10;
    A = 16'h0001;
    B = 16'h0000;
    #10;
    A = 16'hFFFF;
    B = 16'h0000;
    #10;
    A = 16'h0000;
    B = 16'hFFFF;
    #10;
    A = 16'h6666;
    B = 16'h9999;
    
    #20;
    
    // XOR tests 
    G_select = 4'b1100;
    
    A = 16'h0000;
    B = 16'h0000;
    #10;
    A = 16'h0101;
    B = 16'h1010;
    #10;
    A = 16'h6666;
    B = 16'h9999;
    #10;
    A = 16'hFFFF;
    B = 16'hFFFF;
    
    #20;
    
    // NOT A tests 
    G_select = 4'b1110;
    
    A = 16'h0000;
    #10;
    A = 16'h0001;
    #10;
    A = 16'hFFFE;
    #10;
    A = 16'hFFFF;
    #10;
    A = 16'h6666;
    
    #20;
    
    // Shifter tests 
    G_select = 4'b0000;
    MF_select = 1'b1;
    
    // transfer B tests
    H_select = 2'b00;
    
    B = 16'h0000;
    #10;
    B = 16'h0001;
    #10;
    B = 16'hFFFF;
    
    #20;
    
    // shift right tests 
    H_select = 2'b01;
    
    B = 16'h0000;
    #10;
    B = 16'h1000;
    #10;
    B = 16'h0001;
    #10;
    B = 16'hFFFF;
    #10;
    B = 16'hAAAA;
    
    #20;
    
    // shift left tests
    H_select = 2'b10;
    
    B = 16'h0000;
    #10;
    B = 16'h1000;
    #10;
    B = 16'h0001;
    #10;
    B = 16'hFFFF;
    #10;
    B = 16'hAAAA;
    #10;
end

endmodule // homework2_function_unit_tb













