`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module homework5_risc_data_memory_tb();

reg CLK;
reg RST;
reg MW;
reg [5:0] MEM_ADDR;
reg [31:0] MEM_DIN;

wire [31:0] MEM_DOUT;

homework5_risc_data_memory UUT (
    .CLK(CLK),
    .RST(RST),
    .MW(MW),
    .MEM_ADDR(MEM_ADDR),
    .MEM_DIN(MEM_DIN),
    .MEM_DOUT(MEM_DOUT)
);

initial begin
    CLK <= 0;
    RST <= 0;
    MW <= 0;
    MEM_ADDR <= 6'b0;
    MEM_DIN <= 32'b0;
    
    #100
    
    // TEST: Get R1
    
    MEM_ADDR <= 6'd1;
    
    #100
    
    // TEST: M[R2] = 6
    
    MEM_ADDR <= 6'd2;
    MW <= 1'b1;
    MEM_DIN <= 32'd6;
    
    #100;
end

always begin
    #5 CLK <= ~CLK;
end



endmodule





