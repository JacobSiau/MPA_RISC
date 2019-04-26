`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module homework5_risc_instruction_fetch_module(
    input [7:0] PC,        // PC from top module
    output [7:0] PC_1, // incremented PC to decode fetch module 
    output [31:0] INST  // instruction that is fetched
    );
    
    // `include "INSTRUCTION_MEM.vh"
    
    `include "INSTRUCTION_PATTERNS.vh" 
    
    integer i;

    reg [31:0] INST_MEM [127:0];
    
    ///////////////////////////////////////////////
    // MUL: {A, Q} <= B * Q
    // B = R10, Q = R11, 
    // (High half of product) A = R12, COUNT = R13
    // TESTLSB = R5
    // NEGMASK (1000..00) = R14
    
    initial
        begin
            INST_MEM[0]  = {MOV, R12, R0, 15'b0};   // A = 0
            INST_MEM[1]  = {MOV, R13, R31, 15'b0}; // N = 31
            INST_MEM[2]  = {ROR, R14, R1, 15'b1}; // Get NegMask
            INST_MEM[3]  = {ANI, R5, R11, 15'b1}; // TESTIFONE
            INST_MEM[4]  = {BZ, R0, R5,  15'd1}; // Branch to SR(A_Q) if no
            INST_MEM[5]  = {ADD, R12, R12, R10, 10'b0}; // A = A + B if yes
            INST_MEM[6]  = {RRC, R11, R12, R11, 10'b1}; // Shift Right A_Q into Q
            INST_MEM[7]  = {LSR, R12, R12, 15'b1}; // Actually shift A
            INST_MEM[8]  = {SBI, R13, R13, 15'b1}; // COUNT = COUNT - 1
            INST_MEM[9]  = {BZ, R0, R13, 15'd2};     // COUNT = 0?
            INST_MEM[10] = {JMR, R0, R3, 15'b0};     // No = Jump to TESTIFONE
            INST_MEM[11] = NOP;
            INST_MEM[12] = {NOT, R1, R1, 15'b0}; // Done flag (flip R1)
            for (i = 13; i < 18; i = i + 1) begin
                INST_MEM[i] = NOP;
            end
            for (i = 18; i < 127; i = i + 1) begin
                INST_MEM[i] = XXX;
            end
        end
        
     assign PC_1 = PC + 8'b1;
     assign INST = INST_MEM[PC];
    
endmodule






