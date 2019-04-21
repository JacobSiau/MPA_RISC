`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/09/2019 03:54:59 PM
// Design Name: 
// Module Name: homework2_shifter
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
module homework2_shifter(
    input      [15:0] A,
    input      [1:0] S, // op select
    input      ir,      // bit to shift in from right
    input      il,      // bit to shift in from left 
    output reg [15:0] H
    );
    
    always @(*) begin
    
        case (S) // op select
        
            2'b00: // transfer
                H = A;
            2'b01: // shift right
                H = A >> 1;
            2'b10: // shift left
                H = A << 1;
            2'b11: // transfer (shouldn't get here)
                H = A;
            default: // shouldn't get here 
                H = 16'bxxxx_xxxx_xxxx_xxxx;
        
        endcase
    
    end // always @(*)
    
endmodule // homework2_shifter





