`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module homework5_risc_function_unit(
    input [31:0] A,
    input [31:0] B,
    input [4:0] FS,
    input [4:0] SH,
    output C,
    output V,
    output reg N = 1'b0,
    output reg Z = 1'b0,
    output reg [31:0] F = 32'b0
    );
    
    wire [31:0] ALU_OUT;  // output of ALU
    wire [31:0] SHIFT_OUT;  // output of SHIFTER
    
    ////////////////////////////////////////////////////////////
    // ALU
    homework5_risc_alu ALU (
        .A(A),
        .B(B),
        .S(FS[3:1]),
        .CIN(FS[0]),
        .C(C),
        .V(V),
        .FOUT(ALU_OUT)
    );
    ////////////////////////////////////////////////////////////
    
    ////////////////////////////////////////////////////////////
    // BARREL SHIFTER
    homework5_risc_barrel_shifter SHIFTER (
        .AIN(A),
        .SH({1'b0, SH}),
        .LEFT_NOTRIGHT(!FS[0]),
        .AOUT(SHIFT_OUT)
    );
    ////////////////////////////////////////////////////////////
    
    ////////////////////////////////////////////////////////////
    // OUTPUT
    always @(*) begin
        case (FS[4]) 
            1'b0: F <= ALU_OUT;
            1'b1: F <= SHIFT_OUT;
            default: F <= 32'bX;
        endcase
        Z <= ~| F;
        N <= F[31];
    end
    ////////////////////////////////////////////////////////////
    
endmodule







































