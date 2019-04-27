///////////////////////////////////////////////////////
// INSTRUCTION PATTERNS
parameter NOP_PATTERN = 32'b0;
parameter XXX_PATTERN = 32'bX;
parameter XXX = 7'bXXXXXXX;
parameter NOP = 7'b0000000;
parameter ADD = 7'b0000010;
parameter SUB = 7'b0000101;
parameter SLT = 7'b1100101;
parameter AND = 7'b0001000;
parameter OR  = 7'b0001010;
parameter XOR = 7'b0001100; 
parameter ST  = 7'b0000001;
parameter LD  = 7'b0100001;
parameter ADI = 7'b0100010; 
parameter SBI = 7'b0100101;
parameter NOT = 7'b0101110;
parameter ANI = 7'b0101000;
parameter ORI = 7'b0101010;
parameter XRI = 7'b0101100;
parameter AIU = 7'b1100010;
parameter SIU = 7'b1000101;
parameter MOV = 7'b1000000;
parameter LSL = 7'b0110000;
parameter LSR = 7'b0110001;
parameter ASL = 7'b0110010;
parameter ASR = 7'b0110011;
parameter ROL = 7'b0110100;
parameter ROR = 7'b0110101;
parameter RLC = 7'b0110110; 
parameter RRC = 7'b0110111;
parameter JMR = 7'b1100001;
parameter BZ  = 7'b0100000;
parameter BNZ = 7'b1100000;
parameter JMP = 7'b1000100;
parameter JML = 7'b0000111;
///////////////////////////////////////////////////////
// REGISTER PATTERNS
parameter R0  = 5'b00000;
parameter R1  = 5'b00001;
parameter R2  = 5'b00010;
parameter R3  = 5'b00011;
parameter R4  = 5'b00100;
parameter R5  = 5'b00101;
parameter R6  = 5'b00110;
parameter R7  = 5'b00111;
parameter R8  = 5'b01000;
parameter R9  = 5'b01001;
parameter R10 = 5'b01010;
parameter R11 = 5'b01011;
parameter R12 = 5'b01100;
parameter R13 = 5'b01101;
parameter R14 = 5'b01110;
parameter R15 = 5'b01111;
parameter R16 = 5'b10000;
parameter R17 = 5'b10001;
parameter R18 = 5'b10010;
parameter R19 = 5'b10011;
parameter R20 = 5'b10100;
parameter R21 = 5'b10101;
parameter R22 = 5'b10110;
parameter R23 = 5'b10111;
parameter R24 = 5'b11000;
parameter R25 = 5'b11001;
parameter R26 = 5'b11010;
parameter R27 = 5'b11011;
parameter R28 = 5'b11100;
parameter R29 = 5'b11101;
parameter R30 = 5'b11110;
parameter R31 = 5'b11111;
parameter RX  = 5'bXXXXX;
///////////////////////////////////////////////////////
// USEFUL BINARY PATTERNS
parameter ZERO_15 = 15'b0;
parameter ZERO_10 = 10'b0;
parameter ONE_15  = 15'b1;
parameter ONE_10  = 10'b1;
parameter TWO_15  = 15'd2;
parameter TWO_10  = 10'd2;



















