`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module homework5_risc_barrel_shifter_tb();

reg [31:0] AIN;
reg [5:0] SH;
reg LEFT_NOTRIGHT;

wire [31:0] AOUT;

homework5_risc_barrel_shifter UUT (
    .AIN(AIN),
    .SH(SH),
    .LEFT_NOTRIGHT(LEFT_NOTRIGHT),
    .AOUT(AOUT)
);

initial begin
    AIN <= 32'b0;
    SH <= 6'b0;
    LEFT_NOTRIGHT <= 1'b0;
    
    #100 
    
    // TEST: A <- A * 2
    AIN <= 32'd4;
    SH <= 6'b000001;
    LEFT_NOTRIGHT <= 1'b1;
    
    #100 
    
    // TEST: A <- A / 2
    SH <= 6'b000001;
    LEFT_NOTRIGHT <= 1'b0;
    
    #100
    
    // TEST: A <- A * 4
    SH <= 6'b000010;
    LEFT_NOTRIGHT <= 1'b1;
    
    #100;
end


endmodule


