`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module homework5_risc_register_file(
    input CLK,
    input RST,
    input RW,
    input [4:0] AA,
    input [4:0] BA,
    input [4:0] DA,
    input [31:0] DIN,
    output [31:0] AOUT,
    output [31:0] BOUT
    );
    
    reg [31:0] REGFILE [31:0];
    
    assign AOUT = REGFILE[AA];
    assign BOUT = REGFILE[BA];
    
    integer i;
    
    initial begin
        for(i = 0; i < 32; i = i + 1) 
            REGFILE[i] = i;
    end
    
    always @(posedge CLK) begin
        if(RST)
            for(i = 0; i < 32; i = i + 1)
                REGFILE[i] = i;                                    // clear all regs on reset
        else if(RW)                                                        // if not clearing, then write
            REGFILE[DA] <= DIN;        
    end

endmodule




