`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/31/2019 05:41:02 PM
// Design Name: 
// Module Name: homework2_alu
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
module homework2_alu (
    input      [15:0] A,
    input      [15:0] B,
    input      [2:0]  S, // {mode select, op select}
    input      Cin,      // carry in
    output reg C,        // carry flag
    output reg V,        // overflow flag
    output reg [15:0] G
    );
    
    always @(*) begin
        
        case (S[2]) // Mode select
        
            1'b0: // Arithmetic operations

                case (S[1:0]) // Operation select
                    2'b00: // Cin = 0 => Transfer A, Cin = 1 => A + 1, simply just add A + Cin
                        {C, G} = {1'b0, A} + {15'b0, Cin};
                    2'b01: // Cin = 0 => A + B, Cin = 1 => A + B + 1, simply add A + B + Cin 
                        {C, G} = {1'b0, A} + {1'b0, B} + {15'b0, Cin};
                    2'b10: // Cin = 0 => A + !B, Cin = 1 => A + !B + 1, simply add A + !B + Cin
                        {C, G} = {1'b0, A} + {1'b0, ~B} + {15'b0, Cin};
                    2'b11: // Cin = 0 => A - 1, Cin = 1 => Transfer A, simply subtract A - !Cin
                        {C, G} = {1'b0, A} - {15'b0, ~Cin};
                    default: // shouldn't get here 
                        {C, G} = 17'bx_xxxx_xxxx_xxxx_xxxx;
                endcase 
                
            1'b1: // Logic operations
            
                case (S[1:0]) // Operation select
                    2'b00: // And 
                        {C, G} = {1'b0, A & B};
                    2'b01: // Or
                        {C, G} = {1'b0, A | B};
                    2'b10: // Xor 
                        {C, G} = {1'b0, A ^ B};
                    2'b11: // Not A 
                        {C, G} = {1'b0, ~A};
                    default: // shouldn't get here 
                        {C, G} = 17'bx_xxxx_xxxx_xxxx_xxxx;
                endcase
            
        endcase // Mode select

        V <= ~S[2] & (C ^ Cin); // V flag depends only on arithmetic operations (S[2] is 0)
    
    end // always @(*)
    
endmodule // homework2_alu







