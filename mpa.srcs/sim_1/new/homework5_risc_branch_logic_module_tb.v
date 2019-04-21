`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module homework5_risc_branch_logic_module_tb();

reg [7:0] PC_1;
reg [1:0] BS;
reg PS;
reg Z;
reg [31:0] BrA;
reg [31:0] RAA;

wire [7:0] PC;

homework5_risc_branch_logic_module UUT (
    .PC_1(PC_1),
    .BS(BS),
    .PS(PS),
    .Z(Z),
    .BrA(BrA),
    .RAA(RAA),
    .PC(PC)
);

//  BS[0]   BS[1]   PS  Z   FUNCTION
//      0       0    0  0   PC_1   
//      0       0    0  1   PC_1   
//      0       0    1  0   PC_1   
//      0       0    1  1   PC_1   
//      0       1    0  0   RAA        
//      0       1    0  1   RAA   
//      0       1    1  0   RAA   
//      0       1    1  1   RAA  
//      1       0    0  0   PC_1        
//      1       0    0  1   BRA   
//      1       0    1  0   BRA   
//      1       0    1  1   PC_1  
//      1       1    0  0   BRA        
//      1       1    0  1   BRA   
//      1       1    1  0   BRA   
//      1       1    1  1   BRA


initial begin
    PC_1 <= 8'b0;
    BS <= 2'b0;
    PS <= 1'b0;
    Z <= 1'b0;
    BrA <= 32'b0;
    RAA <= 32'b0;
    
    #100
    
    // Testing PC_1 output
    PC_1 <= 8'b00000001;
    BrA <= 32'b0;
    RAA <= 32'b0;
    {BS, PS, Z} <= 4'b0000;
    #10
    {BS, PS, Z} <= 4'b0001;
    #10
    {BS, PS, Z} <= 4'b0010;
    #10
    {BS, PS, Z} <= 4'b0011;
    #10
    {BS, PS, Z} <= 4'b0100;
    #10
    {BS, PS, Z} <= 4'b0111;
    
    #100
    
    // Testing BRA output
    PC_1 <= 8'b0;
    BrA <= 32'b1;
    RAA <= 32'b0;
    {BS, PS, Z} <= 4'b0101;
    #10
    {BS, PS, Z} <= 4'b0110;
    #10
    {BS, PS, Z} <= 4'b1100;
    #10
    {BS, PS, Z} <= 4'b1101;
    #10
    {BS, PS, Z} <= 4'b1110;
    #10
    {BS, PS, Z} <= 4'b1111;
    
    #100
    
    // Testing RAA output 
    PC_1 <= 8'b0;
    BrA <= 32'b0;
    RAA <= 32'b1;
    {BS, PS, Z} <= 4'b1000;
    #10
    {BS, PS, Z} <= 4'b1001;
    #10
    {BS, PS, Z} <= 4'b1010;
    #10
    {BS, PS, Z} <= 4'b1011;
    
end



endmodule
