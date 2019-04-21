`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jacob Siau
// 
// Create Date: 01/27/2019 04:39:08 PM
// Design Name: 
// Module Name: homework1_tb
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
module homework1_tb;

    // inputs 
    reg A, B, C;
    
    // outputs 
    wire Y;
    
    // instantiate the Unit Under Test (UUT)
    homework1 uut (
        .A(A),
        .B(B),
        .C(C),
        .Y(Y)
    );

    integer i;

    initial begin
        
        #100;
        
        for (i=0; i<8; i=i+1) begin
            {A, B, C} = i;
            #10;
        end
        
    end

endmodule
