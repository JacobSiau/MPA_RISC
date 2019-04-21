`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module homework5_risc_execute_module_tb();

reg CLK;
reg RST;
reg [7:0] PC_2;
reg RW;
reg [4:0] DA;
reg [1:0] MD;
reg [1:0] BS;
reg PS;
reg MW;
reg [4:0] FS;
reg [4:0] SH;
reg [31:0] A;
reg [31:0] B;

wire [31:0] BrA;
wire [31:0] RAA;
wire RW_1;
wire [4:0] DA_1;
wire [1:0] MD_1;
wire NXORV;
wire [3:0] ZVNC;
wire [31:0] FOUT;
wire [31:0] DOUT;

homework5_risc_execute_module UUT (
    .CLK(CLK),
    .RST(RST),
    .PC_2(PC_2),
    .RW(RW),
    .DA(DA),
    .MD(MD),
    .BS(BS),
    .PS(PS),
    .MW(MW),
    .FS(FS),
    .SH(SH),
    .A(A),
    .B(B),
    .BrA(BrA),
    .RAA(RAA),
    .RW_1(RW_1),
    .DA_1(DA_1),
    .MD_1(MD_1),
    .NXORV(NXORV),
    .ZVNC(ZVNC),
    .FOUT(FOUT),
    .DOUT(DOUT)
);

initial begin
    CLK <= 0;
    RST <= 0;
    PC_2 <= 8'b0;
    RW <= 1'b0;
    DA <= 5'b0;
    MD <= 2'b0;
    BS <= 2'b0;
    PS <= 1'b0;
    MW <= 1'b0;
    FS <= 5'b0;
    SH <= 5'b0;
    A <= 32'b0;
    B <= 32'b0;
    
    #100
    
    // TEST: ADD R1 <- R2 + R3 INSTRUCTION FROM DOF
    PC_2 <= 8'b00000001;
    {RW, MD, BS, PS, MW, FS, SH} = 17'b1_00_00_0_0_00010_00000;
    A <= 32'd2;
    B <= 32'd3;
    
    #100
    
    // TEST: STORE M[R4] <- R1
    {RW, MD, BS, PS, MW, FS, SH} <= 17'b0_00_00_0_1_00000_00000;
    A <= 32'd4;
    B <= 32'd1;
    
end

always begin
    #5 CLK <= ~CLK;
end

endmodule











