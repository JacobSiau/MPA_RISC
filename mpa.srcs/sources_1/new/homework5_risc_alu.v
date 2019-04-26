`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module homework5_risc_alu(
    input [31:0] A,
    input [31:0] B,
    input [2:0] S,  // FS[3:1]
    input CIN,      // FS[0]
    output reg C = 1'b0,
    output reg V = 1'b0,
    output reg [31:0] FOUT = 32'b0
    );
    
    always @(*) begin
        
        case (S[2]) // Mode select
        
            1'b0: // Arithmetic operations

                case (S[1:0]) // Operation select
                    2'b00: // Cin = 0 => Transfer A, Cin = 1 => A + 1, simply just add A + Cin
                        {C, FOUT} = {1'b0, A} + {31'b0, CIN};
                    2'b01: // Cin = 0 => A + B, Cin = 1 => A + B + 1, simply add A + B + Cin 
                        {C, FOUT} = {1'b0, A} + {1'b0, B} + {31'b0, CIN};
                    2'b10: // Cin = 0 => A + !B, Cin = 1 => A + !B + 1, simply add A + !B + Cin
                        {C, FOUT} = {1'b0, A} + {1'b0, ~B} + {31'b0, CIN};
                    2'b11: // Cin = 0 => A - 1, Cin = 1 => Transfer A, simply subtract A - !Cin
                        {C, FOUT} = {1'b0, A} - {31'b0, ~CIN};
                    default: // shouldn't get here 
                        {C, FOUT} = 33'bX;
                endcase 
                
            1'b1: // Logic operations
            
                case (S[1:0]) // Operation select
                    2'b00: // And 
                        {C, FOUT} = {1'b0, A & B};
                    2'b01: // Or
                        {C, FOUT} = {1'b0, A | B};
                    2'b10: // Xor 
                        {C, FOUT} = {1'b0, A ^ B};
                    2'b11: // Not A 
                        {C, FOUT} = {1'b0, ~A};
                    default: // shouldn't get here 
                        {C, FOUT} = 33'bX;
                endcase

        endcase // Mode select

        V <= (A[31] == B[31]) ? 1'b0 : (~(A[31] ^ B[31])) ^ (FOUT[31]);
    
    end // always @(*)
    
    
endmodule



