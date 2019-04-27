`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module homework5_risc_instruction_fetch_module(
    input  [7:0]  PC,            // PC from top module
    output [7:0]  PC_1,          // incremented PC to decode fetch module 
    output [31:0] INSTRUCTION    // instruction that is fetched
    );
    
    `include "INSTRUCTION_PATTERNS.vh" 
    
    integer i;

    reg [31:0] INST [127:0];
    
    //////////////////////////////////////////////////////////////////////////////////////
    // MULTIPLICATION: {ANS_HIGH, ANS_LOW} <= X * Y

    parameter ANS_HIGH = R21;
    parameter ANS_LOW  = R20;
    parameter        X = R19;
    parameter        Y = R18;
    parameter    COUNT = R17;
    parameter NEG_MASK = R16;
    parameter TEST_LOW = R15;
    
    // CURRENT TEST VALUES
    parameter XVAL = 15'd0;
    parameter YVAL = 15'd0;
    
    //////////////////////////////////////////////////////////////////////////////////////
    
    initial
        begin
            //////////////////////////////////////////////////////////////////////////////////////////
            // INITIALIZE X = XVAL, Y = YVAL
            //////////////////////////////////////////////////////////////////////////////////////////
            INST[0]  = {ADI, X,  R0, XVAL}; // X = XVAL
            INST[1]  = {ADI, Y,  R0, YVAL}; // Y = YVAL
//            INST[0]  = {MOV, X, R12, ZERO_15}; // X
//            INST[1]  = {MOV, Y,  R4, ZERO_15}; // Y
            //////////////////////////////////////////////////////////////////////////////////////////
            // [[ INIT ]]
            // -> INITIALIZE ANS_HIGH TO 0, ANS_LOW TO Y, COUNT TO 31, NEG_MASK TO 100..0
            //////////////////////////////////////////////////////////////////////////////////////////
            INST[2]  = {MOV, ANS_HIGH,  R0, ZERO_15}; // ANS_HIGH = 0
            INST[3]  = {MOV,  ANS_LOW,   Y, ZERO_15}; //  ANS_LOW = Y
            INST[4]  = {ADI,    COUNT, R31,  ONE_15}; //    COUNT = 32 (R31 + 1)
            INST[5]  = {ROR, NEG_MASK,  R1,  ONE_15}; // NEG_MASK = 10...0
            //////////////////////////////////////////////////////////////////////////////////////////
            // [[ TESTIFONE ]]
            // -> IF ANS_LOW[0] == 1, X = X + Y, ELSE GO TO [SHIFTING]
            //////////////////////////////////////////////////////////////////////////////////////////
            INST[6]  = {ANI, TEST_LOW,  ANS_LOW,     ONE_15}; // IS ANS_LOW[0] 1? 
            INST[7]  = { BZ,       R0, TEST_LOW,      15'd1}; // NO: BRANCH TO [SHIFTING]
            INST[8]  = {ADD, ANS_HIGH, ANS_HIGH, X, ZERO_10}; // YES: ANS_HIGH = ANS_HIGH + X
            //////////////////////////////////////////////////////////////////////////////////////////
            // [[ SHIFTING ]]
            // -> SHIFT RIGHT {ANS_HIGH, ANS_LOW} BY 1, PUT THE HIGH 32 BITS OF THIS IN ANS_LOW
            // -> ACTUALLY SHIFT RIGHT ANS_HIGH BY 1
            INST[9]  = {RRC,  ANS_LOW, ANS_HIGH, ANS_LOW, ONE_10}; // {ANS_HIGH, ANS_LOW} >>= 1
            INST[10] = {LSR, ANS_HIGH, ANS_HIGH,          ONE_15}; // ACTUALLY SHIFT RIGHT ANS_HIGH BY 1
            //////////////////////////////////////////////////////////////////////////////////////////
            // [[ DECREMENT COUNT ]]
            // -> DECREMENT COUNT, IF COUNT == 0, GO TO [DONE], ELSE GO TO [TESTIFONE]
            //////////////////////////////////////////////////////////////////////////////////////////
            INST[11] = {SBI, COUNT, COUNT,  ONE_15}; // COUNT = COUNT - 1
            INST[12] = { BZ,    R0, COUNT,   15'd1}; // IF COUNT == 0, GO TO [DONE]
            INST[13] = {JMR,    R0,    R6, ZERO_15}; // GO TO [TESTIFONE]
            //////////////////////////////////////////////////////////////////////////////////////////
            // [[ DONE ]]
            // -> INVERT R1
            //////////////////////////////////////////////////////////////////////////////////////////
            INST[14] = {NOT, R1, R1, ZERO_15}; // R1 = ~R1
            //////////////////////////////////////////////////////////////////////////////////////////
            // [[ PADDING ]]
            // -> PAD A FEW LINES WITH NOP PATTERNS
            // -> PAD THE REST WITH XXX PATTERNS
            //////////////////////////////////////////////////////////////////////////////////////////
            for (i = 15; i  < 20; i = i + 1) INST[i] = NOP_PATTERN; // PAD WITH NOP PATTERNS
            for (i = 20; i < 128; i = i + 1) INST[i] = XXX_PATTERN; // PAD WITH XXX PATTERNS
            //////////////////////////////////////////////////////////////////////////////////////////
        end
        
     assign PC_1 = PC + 8'b1;
     assign INSTRUCTION = INST[PC];
    
endmodule






