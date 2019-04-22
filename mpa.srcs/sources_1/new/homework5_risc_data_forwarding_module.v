`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module homework5_risc_data_forwarding_module(
    input RW,
    input [4:0] DA,
    input [1:0] MD,
    input MA,
    input MB,
    input [4:0] AA,
    input [4:0] BA,
    output reg HA = 1'b0,
    output reg HB = 1'b0
    );
    
    reg compA = 1'b0;
    reg compB = 1'b0;
    
    always @(*) begin
        compA <= (AA == DA);
        compB <= (BA == DA);
        HA <= (|DA) & (RW) & (~MA) & compA;
        HB <= (|DA) & (RW) & (~MB) & compB;
    end
    
    
endmodule



