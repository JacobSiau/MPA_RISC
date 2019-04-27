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
    //////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////
    // MULTIPLICATION: {ANS_HIGH, ANS_LOW} <= X * Y
    //////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////
    
    //////////////////////////////////////////////////////////////////////////////////////
    // WORKING REGISTERS AS PATTERNS
    //////////////////////////////////////////////////////////////////////////////////////
    parameter ANS_HIGH  = R28;
    parameter ANS_LOW   = R27;
    parameter        X  = R26;
    parameter        Y  = R25;
    parameter    COUNT  = R24;
    parameter TEST_LOW  = R23;
    parameter NEG_MASK  = R22;
    parameter X_IS_NEG  = R21;
    parameter Y_IS_NEG  = R20;
    parameter NEG_FLAG  = R19;
    parameter     TEMP  = R18;
    parameter XVAL = 15'd10;
    parameter YVAL = 15'd10;
    //////////////////////////////////////////////////////////////////////////////////////
    
    initial begin
    //////////////////////////////////////////////////////////////////////////////////////////
    // INITIALIZE X = XVAL, Y = YVAL
    //////////////////////////////////////////////////////////////////////////////////////////
//    INST[0]  = {ADI, X,  R0, XVAL}; // X = XVAL
//    INST[1]  = {ADI, Y,  R0, YVAL}; // Y = YVAL
    INST[0]  = {NOT, X,  R0, ZERO_15};
    INST[1]  = {NOT, Y,  R1, ZERO_15};
    //////////////////////////////////////////////////////////////////////////////////////////
    // [[ INIT ]]
    // -> INITIALIZE ANS_HIGH TO 0, ANS_LOW TO Y, COUNT TO 32, NEG_MASK TO 100..0
    //////////////////////////////////////////////////////////////////////////////////////////
    INST[2]  = {MOV, ANS_HIGH,  R0, ZERO_15}; // ANS_HIGH = 0
    INST[3]  = {MOV,  ANS_LOW,   Y, ZERO_15}; //  ANS_LOW = Y
    INST[4]  = {ADI,    COUNT, R31,  ONE_15}; //    COUNT = 32 (R31 + 1)
    INST[5]  = {ROR, NEG_MASK,  R1,  ONE_15}; // NEG_MASK = 10...0
    //////////////////////////////////////////////////////////////////////////////////////////
    // [[ XNEGCHECK ]]
    // -> IF X[31] == 1, X = ~X + 1, NEG_FLAG = 11..1
    //////////////////////////////////////////////////////////////////////////////////////////
    INST[6]  = {AND, X_IS_NEG,        X, NEG_MASK, ONE_10}; // X_IS_NEG = X[31] == 1
    INST[7]  = NOP_PATTERN;
    INST[8]  = { BZ,       R0, X_IS_NEG,            15'd2}; // IF X_IS_NEG != 1, GO TO [YNEGCHECK]
    INST[9]  = {NOT,        X,        X,          ZERO_15}; // X = ~X
    INST[10] = {ADI,        X,        X,           ONE_15}; // X = X + 1
    //////////////////////////////////////////////////////////////////////////////////////////
    // [[ YNEGCHECK ]]
    // -> IF Y[31] == 1, Y = ~Y + 1, NEG_FLAG = 11..1
    INST[11] = {AND, Y_IS_NEG,        Y, NEG_MASK, ONE_10}; // Y_IS_NEG = Y[31] == 1
    INST[12] = NOP_PATTERN;
    INST[13] = { BZ,       R0, Y_IS_NEG,            15'd4}; // IF Y_IS_NEG != 1, GO TO [TESTIFONE]
    INST[14] = {NOT,        Y,        Y,          ZERO_15}; // Y = ~Y
    INST[15] = {ADI,        Y,        Y,           ONE_15}; // Y = Y + 1
    INST[16] = {NOT,  ANS_LOW,  ANS_LOW,          ZERO_15}; // ANS_LOW = ~ANS_LOW
    INST[17] = {ADI,  ANS_LOW,  ANS_LOW,           ONE_15}; // ANS_LOW = ANS_LOW + 1
    //////////////////////////////////////////////////////////////////////////////////////////
    // [[ TESTIFONE ]]
    // -> IF ANS_LOW[0] == 1, X = X + Y, ELSE GO TO [SHIFTING]
    //////////////////////////////////////////////////////////////////////////////////////////
    INST[18] = {ANI, TEST_LOW,  ANS_LOW,     ONE_15}; // IS ANS_LOW[0] 1? 
    INST[19] = { BZ,       R0, TEST_LOW,      15'd1}; // NO: BRANCH TO [SHIFTING]
    INST[20] = {ADD, ANS_HIGH, ANS_HIGH, X, ZERO_10}; // YES: ANS_HIGH = ANS_HIGH + X
    //////////////////////////////////////////////////////////////////////////////////////////
    // [[ SHIFTING ]]
    // -> SHIFT RIGHT {ANS_HIGH, ANS_LOW} BY 1, PUT THE HIGH 32 BITS OF THIS IN ANS_LOW
    // -> ACTUALLY SHIFT RIGHT ANS_HIGH BY 1
    INST[21] = {RRC,  ANS_LOW, ANS_HIGH, ANS_LOW, ONE_10}; // {ANS_HIGH, ANS_LOW} >>= 1
    INST[22] = {LSR, ANS_HIGH, ANS_HIGH,          ONE_15}; // ACTUALLY SHIFT RIGHT ANS_HIGH BY 1
    //////////////////////////////////////////////////////////////////////////////////////////
    // [[ DECREMENT COUNT ]]
    // -> DECREMENT COUNT, IF COUNT == 0, GO TO [DONE], ELSE GO TO [TESTIFONE]
    //////////////////////////////////////////////////////////////////////////////////////////
    INST[23] = {SBI, COUNT, COUNT,  ONE_15}; // COUNT = COUNT - 1
    INST[24] = { BZ,    R0, COUNT,   15'd1}; // IF COUNT == 0, GO TO [NEGCHECK]
    INST[25] = {JMR,    R0,   R18, ZERO_15}; // GO TO [TESTIFONE]
    //////////////////////////////////////////////////////////////////////////////////////////
    // [[ NEGCHECK ]]
    // -> NEG_FLAG = (X_IS_NEG == 1) || (Y_IS_NEG == 1)
    //////////////////////////////////////////////////////////////////////////////////////////
    INST[26] = {XOR, NEG_FLAG, X_IS_NEG, Y_IS_NEG, ZERO_10}; // NEG_FLAG = X_IS_NEG || Y_IS_NEG
    INST[27] = {BZ,       R0, NEG_FLAG,             15'd5}; // IF NEG_FLAG == 0, GO TO [DONE]
    //////////////////////////////////////////////////////////////////////////////////////////
    // [[ TWOS COMPLEMENT ]]
    // -> {ANS_HIGH, ANS_LOW] = ~{ANS_HIGH, ANS_LOW} + 1
    //     -> INVERT ANS_HIGH
    //     -> IF ANS_LOW == 000..0: (ANS_LOW + 1 NEEDS TO CARRY A 1 INTO LSB OF ANS_HIGH}
    //         -> ANS_HIGH = ANS_HIGH + 1
    //     -> ELSE:
    //         -> ANS_LOW = ~ANS_LOW
    //         -> ANS_LOW = ANS_LOW + 1
    //////////////////////////////////////////////////////////////////////////////////////////
    INST[28] = {NOT, ANS_HIGH, ANS_HIGH, ZERO_15}; // ANS_HIGH = ~ANS_HIGH
    INST[29] = {BNZ,       R0,  ANS_LOW,   15'd1}; // IF ANS_LOW != 0, SKIP NEXT LINE
    INST[30] = {ADI, ANS_HIGH, ANS_HIGH,  ONE_15}; // ANS_HIGH = ANS_HIGH + 1
    INST[31] = {NOT,  ANS_LOW,  ANS_LOW, ZERO_15}; // ANS_LOW = ~ANS_LOW
    INST[32] = {ADI,  ANS_LOW,  ANS_LOW,  ONE_15}; // ANS_LOW = ANS_LOW + 1
    //////////////////////////////////////////////////////////////////////////////////////////
    // [[ DONE ]]
    // -> INVERT R1 TO SIGNAL DONE 
    //////////////////////////////////////////////////////////////////////////////////////////
    INST[33] = {NOT, R1, R1, ZERO_15}; // R1 = ~R1
    //////////////////////////////////////////////////////////////////////////////////////////
    // [[ PADDING ]]
    // -> PAD A FEW LINES WITH NOP PATTERNS
    // -> PAD THE REST WITH XXX PATTERNS
    //////////////////////////////////////////////////////////////////////////////////////////
    for (i = 34; i  < 40; i = i + 1) INST[i] = NOP_PATTERN; // PAD WITH NOP PATTERNS
    for (i = 40; i < 128; i = i + 1) INST[i] = XXX_PATTERN; // PAD WITH XXX PATTERNS
    //////////////////////////////////////////////////////////////////////////////////////////
    end
        
    assign PC_1 = PC + 8'b1;
    assign INSTRUCTION = INST[PC];
    
endmodule






