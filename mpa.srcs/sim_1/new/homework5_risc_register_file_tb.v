`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module homework5_risc_register_file_tb();

reg CLK;
reg RST;
reg RW;
reg [4:0] AA;
reg [4:0] BA;
reg [4:0] DA;
reg [31:0] DIN;

wire [31:0] AOUT;
wire [31:0] BOUT;

homework5_risc_register_file UUT (
    .CLK(CLK),
    .RST(RST),
    .RW(RW),
    .AA(AA),
    .BA(BA),
    .DA(DA),
    .DIN(DIN),
    .AOUT(AOUT),
    .BOUT(BOUT)
);

initial begin
    CLK <= 0;
    RST <= 0;
    RW <= 0;
    AA <= 5'b0;
    BA <= 5'b0;
    DA <= 5'b0;
    DIN <= 32'b0;
    
    #100
    
    // TEST: Read AA = R1 and BA = R3
    AA <= 5'd1;
    BA <= 5'd3;
    
    #100 
    
    // TEST: Write 72 to R4
    RW <= 1'b1;
    DA <= 5'd4;
    DIN <= 32'd72;
    
    #100;
end

always begin
    #5 CLK <= ~CLK;
end


endmodule
