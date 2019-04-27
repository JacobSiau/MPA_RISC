`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module homework5_risc_barrel_shifter(
    input [31:0] AIN,
    input [31:0] BIN,
    input [5:0] SH,
    input [2:0] FTN,        // FS[3:1]
    input LEFT_NOTRIGHT,    // !FS[0], 0 = Left, 1 = Right
    output reg [31:0] AOUT
    );
    
    parameter LOG_CASE = 0, ARI_CASE = 1, ROT_CASE = 2, ROC_CASE = 3;
    
    wire [63:0] LOG;
    wire [63:0] ARI;
    wire [63:0] ROT;
    wire [63:0] ROC;
    
    reg [63:0] AOUT_w;
    
    assign LOG = {         32'b0, AIN};
    assign ARI = { {32{AIN[31]}}, AIN};
    assign ROT = {           AIN, AIN};
    assign ROC = {           AIN, BIN};
    
    always @(*) begin
        case(FTN)
            LOG_CASE: AOUT_w <= LEFT_NOTRIGHT ? LOG << SH : LOG >> SH;
            ARI_CASE: AOUT_w <= LEFT_NOTRIGHT ? ARI << SH : ARI >> SH;
            ROT_CASE: AOUT_w <= LEFT_NOTRIGHT ? ROT >> (32-SH) : ROT >> SH;
            ROC_CASE: AOUT_w <= LEFT_NOTRIGHT ? ROC << SH : ROC >> SH;
            default: AOUT_w = AIN;
         endcase
         
         AOUT <= ((FTN == 3'd3) & LEFT_NOTRIGHT) ? AOUT_w[63:32] : AOUT_w;
    end
        
endmodule
