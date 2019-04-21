`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module homework5_risc_function_unit_tb();

reg [31:0] A;
reg [31:0] B;
reg [4:0] FS;
reg [4:0] SH;
wire C;
wire V;
wire N;
wire Z;
wire [31:0] F;

homework5_risc_function_unit UUT (
    .A(A),
    .B(B),
    .FS(FS),
    .SH(SH),
    .C(C),
    .V(V),
    .N(N),
    .Z(Z),
    .F(F)
);

initial begin
    A <= 32'b0;
    B <= 32'b0;
    FS <= 5'b0;
    SH <= 5'b0;
    
    #100
    
    // TEST: 2 + 3
    A <= 32'd2;
    B <= 32'd3;
    FS <= 5'b00010;
    SH <= 5'b0;
    
    #100
    
    // TEST: 4 * 4
    A <= 32'd4;
    B <= 32'b0;
    FS <= 5'b10000;
    SH <= 5'b00010;
    
    #100;
    
end





endmodule





