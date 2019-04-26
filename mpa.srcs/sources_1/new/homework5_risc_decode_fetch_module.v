`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module homework5_risc_decode_fetch_module(
    input [7:0] PC_1,
    input [31:0] IR,
    input [31:0] A_DATA,
    input [31:0] B_DATA,
    
    // inputs from data forwarding
    input HA,
    input HB,
    input [31:0] BUS_DD,
    
    output [7:0] PC_2,
    
    // outputs from IR
    output reg RW = 1'b0,
    output reg [4:0] DA = 5'b0,
    output reg [1:0] MD = 2'b0,
    output reg [1:0] BS = 2'b0,
    output reg PS = 1'b0,
    output reg MW = 1'b0,
    output reg [4:0] FS = 5'b0,
    output reg [4:0] SH = 5'b0,
    output reg [31:0] BUS_A = 32'b0,
    output reg [31:0] BUS_B = 32'b0,
    
    // outputs to top module for regfile data back
    output reg [4:0] AA = 5'b0,
    output reg [4:0] BA = 5'b0
    );
    
    `include "INSTRUCTION_PATTERNS.vh"
   
    
    reg [6:0] OPCODE_reg = 7'b0;
    reg [14:0] IM_reg = 15'b0;
    reg MB = 1'd0;
    reg MA = 1'd0;
    reg CS = 1'd0;
    
    assign PC_2 = PC_1;
    
    // Instruction Decoder
    always @(*) begin
    
        {OPCODE_reg, IM_reg, SH} <= {IR[31:25], IR[14:0], IR[4:0]};
        {DA, AA, BA} <= {IR[24:20], IR[19:15], IR[14:10]};
    
        case(OPCODE_reg) 
        
            NOP: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b0_00_00_0_0_00000_0_0_0;
            ADD: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_00010_0_0_0;
            SUB: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_00101_0_0_0;
            SLT: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_10_00_0_0_00101_0_0_0;
            AND: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_01000_0_0_0;
            OR: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_01010_0_0_0;
            XOR: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_01100_0_0_0;
            ST: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b0_00_00_0_1_00000_0_0_0;
            LD: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_01_00_0_0_00000_0_0_0;
            ADI: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_00010_1_0_1;
            SBI: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_00101_1_0_1;
            NOT: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_01110_0_0_0;
            ANI: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_01000_1_0_0;
            ORI: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_01010_1_0_0;
            XRI: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_01100_1_0_0;
            AIU: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_00010_1_0_0;
            SIU: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_00101_1_0_0;
            MOV: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_00000_0_0_0;
            LSL: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_10000_0_0_0;
            LSR: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_10001_0_0_0;
            ASL: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_10010_0_0_0;
            ASR: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_10011_0_0_0;
            ROL: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_10100_0_0_0;
            ROR: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_10101_0_0_0;
            RLC: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_10110_0_0_0;
            RRC: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_10111_0_0_0;
            JMR: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b0_00_10_0_0_00000_0_0_0;
            BZ: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b0_00_01_0_0_00000_1_0_1;
            BNZ: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b0_00_01_1_0_00000_1_0_1;
            JMP: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b0_00_11_0_0_00000_1_0_1;
            JML: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_11_0_0_00111_1_1_1;
            default: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'bX_XX_XX_X_X_XXXXX_X_X_X;
            
        endcase
        
    end
    
    // MUXA
    always @(*) begin
        if (HA) begin
            BUS_A <= BUS_DD;
        end
        else begin
            case(MA) 
                1'b0: BUS_A <= A_DATA;
                1'b1: BUS_A <= {24'b0, PC_1};
                default: BUS_A <= 32'bX;
            endcase
        end
    end
    
    // MUXB
    always @(*) begin
        if (HB) begin
            BUS_B <= BUS_DD;
        end
        else begin 
            case(MB)
                1'b0: BUS_B <= B_DATA;
                1'b1: begin 
                    BUS_B <= CS ? {{17{IM_reg[14]}}, IM_reg[14:0]} : {{17{1'b0}}, IM_reg[14:0]}; // constant unit
                end
                default: BUS_B <= 32'bX;
            endcase
        end
    end
    
endmodule








