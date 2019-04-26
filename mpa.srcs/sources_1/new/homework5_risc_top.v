`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module homework5_risc_top(
    input CLK,
    input RST
    );
    
    // PC interface registers
    reg [7:0] PC_reg = 8'b0;                    // Program Counter 
    reg [7:0] PC_1_reg = 8'b0;                  // PC, Decode stage
    reg [7:0] PC_2_reg = 8'b0;                  // PC, Execute stage
    
    // IR interface register
    reg [31:0] IR_reg = 32'b0;                  // IR, Decode stage
    
    // DECODE to EXECUTE interface registers
    reg RW_reg = 1'b0;
    reg [4:0] DA_reg = 5'b0;
    reg [1:0] MD_reg = 2'b0;
    reg [1:0] BS_reg = 2'b0;
    reg PS_reg = 1'b0;
    reg MW_reg = 1'b0;
    reg [4:0] FS_reg = 5'b0;
    reg [4:0] SH_reg = 5'b0;
    reg [31:0] BUS_A_reg = 32'b0;
    reg [31:0] BUS_B_reg = 32'b0;
    
    // EXECUTE to WRITEBACK interface registers
    reg RW_1_reg = 1'b0;
    reg [4:0] DA_1_reg = 5'b0;
    reg [1:0] MD_1_reg = 2'b0;
    reg NXORV_reg = 1'b0;
    reg [31:0] FOUT_reg = 32'b0;
    reg [31:0] DOUT_reg = 32'b0;
    reg [3:0] ZVNC_reg = 4'b0;
    
    // physical wires between modules 
    wire [7:0] PC;
    wire [7:0] PC_1;
    wire [7:0] PC_2;
    wire [31:0] IR;
    
    // branch prediction line
    wire branchBeingTaken;
    
    ////////////////////////////////////////////////////////////
    // REGFILE
    wire [4:0] AA;
    wire [4:0] BA;
    wire [31:0] DIN;
    wire [31:0] AOUT;
    wire [31:0] BOUT;
    homework5_risc_register_file REGFILE (
        .CLK(CLK),
        .RST(RST),
        .RW(RW_1_reg),
        .AA(AA),
        .BA(BA),
        .DA(DA_1_reg),
        .DIN(DIN),
        .AOUT(AOUT),
        .BOUT(BOUT)
    );
    ////////////////////////////////////////////////////////////
    
    ////////////////////////////////////////////////////////////
    // INSTRUCTION FETCH 
    homework5_risc_instruction_fetch_module IF (
        .PC(PC_reg),
        .PC_1(PC_1),
        .INST(IR)
    );
    ////////////////////////////////////////////////////////////
    
    ////////////////////////////////////////////////////////////
    // DECODE
    wire RW;
    wire [4:0] DA;
    wire [1:0] MD;
    wire [1:0] BS;
    wire PS;
    wire MW;
    wire [4:0] FS;
    wire [4:0] SH;
    wire [31:0] BUS_A;
    wire [31:0] BUS_B;
    wire HA;
    wire HB;
    wire [31:0] BUS_DD;
    homework5_risc_decode_fetch_module DOF (
        .PC_1(PC_1_reg),
        .IR(IR_reg),
        .A_DATA(AOUT),
        .B_DATA(BOUT),
        .HA(HA),
        .HB(HB),
        .BUS_DD(BUS_DD),
        .PC_2(PC_2),
        .RW(RW),
        .DA(DA),
        .MD(MD), 
        .BS(BS),
        .PS(PS),
        .MW(MW),
        .FS(FS),
        .SH(SH),
        .BUS_A(BUS_A),
        .BUS_B(BUS_B),
        .AA(AA),
        .BA(BA)
    );
    ////////////////////////////////////////////////////////////
    
    ////////////////////////////////////////////////////////////
    // DATA FORWARDING MODULE
    homework5_risc_data_forwarding_module DATA_FORWARD (
        .RW(RW_reg),
        .DA(DA_reg),
        .MD(MD_reg),
        .MA(IR_reg[1]),
        .MB(IR_reg[2]),
        .AA(AA),
        .BA(BA),
        .HA(HA),
        .HB(HB)
    );
    ////////////////////////////////////////////////////////////
    
    ////////////////////////////////////////////////////////////
    // EXECUTE
    wire [31:0] BrA;
    wire [31:0] RAA;
    wire RW_1;
    wire [4:0] DA_1;
    wire [1:0] MD_1;
    wire NXORV;
    wire [3:0] ZVNC;
    wire [31:0] FOUT;
    wire [31:0] DOUT;
    homework5_risc_execute_module EX (
        .CLK(CLK),
        .RST(RST),
        .PC_2(PC_2_reg),
        .RW(RW_reg),
        .DA(DA_reg),
        .MD(MD_reg),
        .BS(BS_reg),
        .PS(PS_reg),
        .MW(MW_reg),
        .FS(FS_reg),
        .SH(SH_reg),
        .A(BUS_A_reg),
        .B(BUS_B_reg),
        .BrA(BrA),
        .RAA(RAA),
        .RW_1(RW_1),
        .DA_1(DA_1),
        .MD_1(MD_1),
        .NXORV(NXORV),
        .ZVNC(ZVNC),
        .FOUT(FOUT),
        .DOUT(DOUT),
        .BUS_DD(BUS_DD)
    );
    ////////////////////////////////////////////////////////////
    
    ////////////////////////////////////////////////////////////
    // WRITEBACK
    homework5_risc_writeback_module WB (
        .MD_1(MD_1_reg),
        .NXORV(NXORV_reg),
        .FOUT(FOUT_reg),
        .DOUT(DOUT_reg),
        .ZVNC(ZVNC_reg),
        .DDATA(DIN)
    );
    ////////////////////////////////////////////////////////////
    
    ////////////////////////////////////////////////////////////
    // BRANCH LOGIC (BS, PS, Z, MUXC)
    homework5_risc_branch_logic_module MUXC (
        .PC_1(PC_1),
        .BS(BS_reg),
        .PS(PS_reg),
        .Z(ZVNC[3]), 
        .BrA(BrA),
        .RAA(RAA),
        .PC(PC),
        .branchBeingTaken(branchBeingTaken)
    );
    ////////////////////////////////////////////////////////////
    
    ////////////////////////////////////////////////////////////
    // TOP LEVEL LATCHING OF REGISTERS ON CLOCK EDGES 
    always @(negedge CLK or posedge RST) begin
        if (RST) begin
            {PC_reg, PC_1_reg, PC_2_reg} <= {8'b0, 8'b0, 8'b0};
            IR_reg <= 32'b0;
            {RW_reg, DA_reg, MD_reg, BS_reg, PS_reg, MW_reg, FS_reg, SH_reg} <= {1'b0, 5'b0, 2'b0, 2'b0, 1'b0, 1'b0, 5'b0, 5'b0};
            {BUS_A_reg, BUS_B_reg} <= {32'b0, 32'b0};
            {RW_1_reg, DA_1_reg, MD_1_reg} <= {1'b0, 5'b0, 2'b0};
            {NXORV_reg, FOUT_reg, DOUT_reg, ZVNC_reg} <= {1'b0, 32'b0, 32'b0, 4'b0};
        end 
        else begin
            PC_reg <= PC;
            PC_1_reg <= PC_1;
            PC_2_reg <= PC_2;
            IR_reg <= IR & ~{32{branchBeingTaken}};
            {RW_reg, DA_reg, MD_reg, BS_reg, PS_reg, MW_reg, FS_reg, SH_reg} <= {RW & (~branchBeingTaken), DA, MD, BS & ~{2{branchBeingTaken}}, PS, MW & (~branchBeingTaken), FS, SH};
            {BUS_A_reg, BUS_B_reg} <= {BUS_A, BUS_B};
            {RW_1_reg, DA_1_reg, MD_1_reg} <= {RW_1, DA_1, MD_1};
            {NXORV_reg, FOUT_reg, DOUT_reg, ZVNC_reg} <= {NXORV, FOUT, DOUT, ZVNC};
        end
    end
    ////////////////////////////////////////////////////////////
    
endmodule // homework5_risc_top
