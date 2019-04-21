`ifndef _OPCODES_VH_
`define _OPCODES_VH_
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
parameter JMR = 7'b1100001;
parameter BZ  = 7'b0100000;
parameter BNZ = 7'b1100000;
parameter JMP = 7'b1000100;
parameter JML = 7'b0000111;
`endif
