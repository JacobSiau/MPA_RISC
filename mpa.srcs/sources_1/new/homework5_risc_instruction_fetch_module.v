`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module homework5_risc_instruction_fetch_module(
    input [7:0] PC,        // PC from top module
    output [7:0] PC_1, // incremented PC to decode fetch module 
    output [31:0] INST  // instruction that is fetched
    );
    
    `include "INSTRUCTION_MEM.vh"
    
    integer i;

    reg [31:0] INST_MEM [127:0];
    
    initial
        begin
            INST_MEM[0] = INST0;
            INST_MEM[1] = INST1;
            INST_MEM[2] = INST0;
            INST_MEM[3] = INST2;
            INST_MEM[4] = INST0;
            INST_MEM[5] = INST3;
            INST_MEM[6] = INST0;
            INST_MEM[7] = INST4;
            INST_MEM[8] = INST0;
            INST_MEM[9] = INST5;
            INST_MEM[10] = INST0;
            INST_MEM[11] = INST6;
            INST_MEM[12] = INST0;
            INST_MEM[13] = INST7;
            INST_MEM[14] = INST0;
            INST_MEM[15] = INST8;
            INST_MEM[16] = INST0;
            INST_MEM[17] = INST9;
            INST_MEM[18] = INST0;
            INST_MEM[19] = INST10;
            INST_MEM[20] = INST0;
            INST_MEM[21] = INST11;
            INST_MEM[22] = INST0;
            INST_MEM[23] = INST12;
            INST_MEM[24] = INST0;
            INST_MEM[25] = INST13;
            INST_MEM[26] = INST0;
            INST_MEM[27] = INST14;
            INST_MEM[28] = INST0;
            INST_MEM[29] = INST15;
            INST_MEM[30] = INST0;
            INST_MEM[31] = INST16;
            INST_MEM[32] = INST0;
            INST_MEM[33] = INST17;
            INST_MEM[34] = INST0;
            INST_MEM[35] = INST18;
            INST_MEM[36] = INST0;
            INST_MEM[37] = INST19;
            INST_MEM[38] = INST0;
            INST_MEM[39] = INST20;
            INST_MEM[40] = INST0;
            INST_MEM[41] = INST21;
            INST_MEM[42] = INST0;
            INST_MEM[43] = INST22;
            INST_MEM[44] = INST0;
            INST_MEM[45] = INST23;
            INST_MEM[46] = INST0;
            INST_MEM[47] = INST24;
            INST_MEM[48] = INST0;
            for(i=49; i< 128; i = i+1)
                INST_MEM[i] = INSTX;
//              for(i = 2; i < 128; i = i + 1)
//                  INST_MEM[i] = INSTX;
        end
        
     assign PC_1 = PC + 8'b1;
     assign INST = INST_MEM[PC];
    
endmodule






