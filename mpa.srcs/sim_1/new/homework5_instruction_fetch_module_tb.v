`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module homework5_instruction_fetch_module_tb();

reg [7:0] PC;

wire [7:0] PC_1;
wire [31:0] INST;

homework5_risc_instruction_fetch_module UUT (
    .PC(PC),
    .PC_1(PC_1),
    .INST(INST)
);

initial begin
    PC <= 8'b0;
    #100
    PC <= 8'b00000001;
    #100 
    PC <= 8'b00000010;
end


endmodule
