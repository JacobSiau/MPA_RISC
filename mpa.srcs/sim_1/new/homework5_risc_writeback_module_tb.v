`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module homework5_risc_writeback_module_tb();

reg [1:0] MD_1;
reg NXORV;
reg [31:0] FOUT;
reg [31:0] DOUT;
reg [3:0] ZVNC;

wire [31:0] DDATA;

homework5_risc_writeback_module UUT (
    .MD_1(MD_1),
    .NXORV(NXORV),
    .FOUT(FOUT),
    .DOUT(DOUT),
    .ZVNC(ZVNC),
    .DDATA(DDATA)
);

reg CLK;
reg RST;
reg RW;
reg [4:0] AA;
reg [4:0] BA;

wire [31:0] AOUT;
wire [31:0] BOUT;

homework5_risc_register_file REGFILE (
    .CLK(CLK),
    .RST(RST),
    .RW(RW),
    .AA(AA),
    .BA(BA),
    .DA(DOUT),
    .DIN(DDATA),
    .AOUT(AOUT),
    .BOUT(BOUT)
);



initial begin
    CLK <= 0;
    RST <= 0;
    RW <= 1'b0;
    AA <= 5'b0;
    BA <= 5'b0;
    MD_1 <= 2'b0;
    NXORV <= 1'b0;
    FOUT <= 32'b0;
    DOUT <= 32'b0;
    ZVNC <= 4'b0;
    
    #100
    
    // TEST: R1 <- R2 + R3 happened, FOUT = 5
    MD_1 <= 2'b00;
    NXORV <= 1'b0;
    FOUT <= 32'd5;
    DOUT <= 32'd2;
    ZVNC <= 4'b0;
    
    RW <= 1'b1;
    AA <= 5'd2;
    BA <= 5'd3;
    
    
    #100
    
    // TEST: STORE M[R4] <- R1 happened, FOUT = 1, DOUT = 1, store in REGFILE
    MD_1 <= 2'b00;
    NXORV <= 1'b0;
    FOUT <= 32'd1;
    DOUT <= 32'd1;
    ZVNC <= 4'b0000;
    
    RW <= 1'b0;
    AA <= 5'd4;
    BA <= 5'd1;
    
    #100;
    
end

always begin
    #5 CLK <= ~CLK;
end



endmodule
