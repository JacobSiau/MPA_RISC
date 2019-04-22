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
    
    initial
        begin
            INST_MEM[0] = {NOP,  R0,  R0,  R0, 10'b0 };
            INST_MEM[1] = {BZ,   R0,  R0,      15'b000000000010010};
            INST_MEM[2] = {MOV,  R2,  R3,      15'b0 };
            INST_MEM[3] = {MOV,  R1,  R2,      15'b0 };
            for (i = 4; i < 20; i = i + 1) begin
                INST_MEM[i] = {NOP,  R0,  R0,  R0, 10'b0 };
            end
            INST_MEM[20] = {MOV,  R5,  R6,      15'b0 };
            INST_MEM[21] = {NOP,  R0,  R0,  R0, 10'b0 };
            INST_MEM[22] = {NOP,  R0,  R0,  R0, 10'b0 };
            INST_MEM[23] = {NOP,  R0,  R0,  R0, 10'b0 };
            INST_MEM[24] = {NOP,  R0,  R0,  R0, 10'b0 };
            for (i = 25; i < 128; i = i + 1) begin
                INST_MEM[i] = {XXX, RX,  RX,  RX, 10'bX};
            end
//            INST_MEM[0] = {NOP,  R0,  R0,  R0, 10'b0};
//            INST_MEM[1] = {MOV,  R1,  R5,      15'b0};
//            INST_MEM[2] = {ADD,  R2,  R1,  R6, 10'b0};
//            INST_MEM[3] = {ADD,  R3,  R1,  R2, 10'b0};
//            INST_MEM[4] = {NOP,  R0,  R0,  R0, 10'b0};
//            INST_MEM[5] = {NOP,  R0,  R0,  R0, 10'b0};
//            INST_MEM[6] = {NOP,  R0,  R0,  R0, 10'b0};
//            for (i = 7; i < 128; i = i + 1) begin
//                INST_MEM[i] = {XXX, RX,  RX,  RX, 10'bX};
//            end
//            INST_MEM[0]  = {NOP, R0,  R0,  R0, 10'b0}; 
//            INST_MEM[1]  = {ADD, R1,  R2,  R3, 10'b0}; 
//            INST_MEM[2]  = {NOP, R0,  R0,  R0, 10'b0};
//            INST_MEM[3]  = {SUB, R2,  R6,  R2, 10'b0};
//            INST_MEM[4]  = {NOP, R0,  R0,  R0, 10'b0};
//            INST_MEM[5]  = {SLT, R1,  R0,  R6, 10'b0};
//            INST_MEM[6]  = {NOP, R0,  R0,  R0, 10'b0};
//            INST_MEM[7]  = {AND, R1,  R2,  R3, 10'b0};
//            INST_MEM[8]  = {NOP, R0,  R0,  R0, 10'b0};
//            INST_MEM[9]  = {OR,  R1,  R2,  R3, 10'b0};
//            INST_MEM[10] = {NOP, R0,  R0,  R0, 10'b0};
//            INST_MEM[11] = {XOR, R1,  R2,  R3, 10'b0};
//            INST_MEM[12] = {NOP, R0,  R0,  R0, 10'b0};
//            INST_MEM[13] = {ST,  R0,  R6,  R1, 10'b0};
//            INST_MEM[14] = {NOP, R0,  R0,  R0, 10'b0};
//            INST_MEM[15] = {LD,  R7,  R6,      15'b0};
//            INST_MEM[16] = {NOP, R0,  R0,  R0, 10'b0};
//            INST_MEM[17] = {ADI, R1,  R6,      15'b1};
//            INST_MEM[18] = {NOP, R0,  R0,  R0, 10'b0};
//            INST_MEM[19] = {SBI, R1,  R6,      15'b1};
//            INST_MEM[20] = {NOP, R0,  R0,  R0, 10'b0};
//            INST_MEM[21] = {NOT, R10, R1,      15'b0};
//            INST_MEM[22] = {NOP, R0,  R0,  R0, 10'b0};
//            INST_MEM[23] = {ANI, R11, R6,      15'b1};
//            INST_MEM[24] = {NOP, R0,  R0,  R0, 10'b0};
//            INST_MEM[25] = {ORI, R12, R6,      15'b0};
//            INST_MEM[26] = {NOP, R0,  R0,  R0, 10'b0};
//            INST_MEM[27] = {XRI, R13, R6,      15'b0};
//            INST_MEM[28] = {NOP, R0,  R0,  R0, 10'b0};
//            INST_MEM[29] = {AIU, R14, R6,      15'b1};
//            INST_MEM[30] = {NOP, R0,  R0,  R0, 10'b0};
//            INST_MEM[31] = {SIU, R15, R6,      15'b1};
//            INST_MEM[32] = {NOP, R0,  R0,  R0, 10'b0};
//            INST_MEM[33] = {MOV, R16, R6,      15'b0};
//            INST_MEM[34] = {NOP, R0,  R0,  R0, 10'b0};
//            INST_MEM[35] = {LSL, R17, R6,      15'b1};
//            INST_MEM[36] = {NOP, R0,  R0,  R0, 10'b0};
//            INST_MEM[37] = {LSR, R18, R6,      15'b1};
//            INST_MEM[38] = {NOP, R0,  R0,  R0, 10'b0};
//            for (i = 39; i < 128; i = i + 1) begin
//                INST_MEM[i] = {XXX, RX,  RX,  RX, 10'bX};
//            end
        end
        
     assign PC_1 = PC + 8'b1;
     assign INST = INST_MEM[PC];
    
endmodule






