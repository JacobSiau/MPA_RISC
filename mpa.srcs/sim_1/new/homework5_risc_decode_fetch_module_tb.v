`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module homework5_risc_decode_fetch_module_tb();

reg CLK;
reg RST;

reg [7:0] PC_1;
reg [31:0] IR;
wire [31:0] A_DATA;
wire [31:0] B_DATA;

wire [7:0] PC_2;
wire RW;
wire [4:0] DA;
wire [1:0] MD;
wire [1:0] BS;
wire PS;
wire MW;
wire [4:0] FS;
wire [4:0] SH;
wire [31:0] BUS_A;
wire [31:0] BUS_B;
wire [4:0] AA;
wire [4:0] BA;

homework5_risc_decode_fetch_module UUT (
    .PC_1(PC_1),
    .IR(IR),
    .A_DATA(A_DATA),
    .B_DATA(B_DATA),
    .PC_2(PC_2),
    .RW(RW),
    .DA(DA),
    .MD(MD),
    .BS(BS),
    .PS(PS),
    .MW(MW),
    .FS(FS),
    .SH(SH),
    .BUS_A(BUS_A),
    .BUS_B(BUS_B),
    .AA(AA),
    .BA(BA)
); 

homework5_risc_register_file REGFILE (
    .CLK(CLK),
    .RST(RST),
    .RW(RW),
    .AA(AA),
    .BA(BA),
    .DA(DA),
    .DIN(32'b0),
    .AOUT(A_DATA),
    .BOUT(B_DATA)
);

initial begin
    CLK <= 0;
    RST <= 0;
    PC_1 <= 8'b0;
    IR <= 32'b0;
    
    #100
    
    // Simulate first INST from IF
    PC_1 <= 8'b00000001;
    IR <= 32'b0000000_00000_00000_00000_0000000000;
    
    #100
    
    // Simulate second INST from IF
    PC_1 <= 8'b00000010;
    IR <= 32'b0000010_00001_00010_00011_0000000000;
    
    #100;
    
end


always begin
    #5 CLK <= ~CLK;
end






endmodule





















