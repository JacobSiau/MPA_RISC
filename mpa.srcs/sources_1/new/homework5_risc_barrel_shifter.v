`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module homework5_risc_barrel_shifter(
    input [31:0] AIN,
    input [5:0] SH,
    input LEFT_NOTRIGHT,    // FS[4], 1 = Left, 0 = Right
    output [31:0] AOUT
    );
    
    assign AOUT = LEFT_NOTRIGHT ? {32'b0, AIN} << SH : {32'b0, AIN} >> SH;
    
endmodule
