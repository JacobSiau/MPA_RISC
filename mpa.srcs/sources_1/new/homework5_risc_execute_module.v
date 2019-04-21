`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module homework5_risc_execute_module(
    input CLK,
    input RST,
    input [7:0] PC_2,
    
    input RW,
    input [4:0] DA,
    input [1:0] MD,
    input [1:0] BS,
    input PS,
    input MW,
    input [4:0] FS,
    input [4:0] SH, 
    
    input [31:0] A,
    input [31:0] B,
    
    output [31:0] BrA,
    output [31:0] RAA,
    output RW_1,
    output [4:0] DA_1,
    output [1:0] MD_1,
    output NXORV,
    output [3:0] ZVNC,
    output [31:0] FOUT,
    output [31:0] DOUT
    );
    
    wire Z;
    wire V;
    wire N;
    wire C;
    
    ////////////////////////////////////////////////////////////
    // FUNCTION UNIT
    homework5_risc_function_unit MFU (
        .A(A),
        .B(B),
        .FS(FS),
        .SH(SH),
        .C(C),
        .V(V),
        .N(N),
        .Z(Z),
        .F(FOUT)
    );
    ////////////////////////////////////////////////////////////
    
    ////////////////////////////////////////////////////////////
    // DATA MEMORY
    homework5_risc_data_memory DATAMEM (
        .CLK(CLK),
        .RST(RST),
        .MW(MW),
        .MEM_ADDR(A[5:0]),
        .MEM_DIN(B),
        .MEM_DOUT(DOUT)
    );
    ////////////////////////////////////////////////////////////
    
    ////////////////////////////////////////////////////////////
    // Control signals from IR, Branch Adder
    assign BrA = PC_2 + B;
    assign RAA = A;
    assign RW_1 = RW;
    assign DA_1 = DA;
    assign MD_1 = MD;
    assign NXORV = N ^ V;
    assign ZVNC = {Z, V, N, C};
    ////////////////////////////////////////////////////////////
    
endmodule
