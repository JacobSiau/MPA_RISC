`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module homework5_risc_alu_tb();

reg [31:0] A;
reg [31:0] B;
reg [2:0] S;
reg CIN;

wire C;
wire V;
wire [31:0] FOUT;

homework5_risc_alu UUT (
    .A(A),
    .B(B),
    .S(S),
    .CIN(CIN),
    .C(C),
    .V(V),
    .FOUT(FOUT)
);

initial begin
    A <= 32'b0;
    B <= 32'b0;
    S <= 3'b0;
    CIN <= 1'b0;
    
    #100;
    
end



endmodule



