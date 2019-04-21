`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module homework5_risc_writeback_module(
    input [1:0] MD_1,
    input NXORV,
    input [31:0] FOUT,
    input [31:0] DOUT,
    input [3:0] ZVNC,
    output reg [31:0] DDATA = 32'b0
    );
    
    ////////////////////////////////////////////////////////////
    // MUX D
    always @(*) begin
        case (MD_1) 
            2'b00: DDATA <= FOUT;
            2'b01: DDATA <= DOUT;
            2'b10: DDATA <= {{31'b0}, NXORV};
            2'b11: DDATA <= {{28'b0}, ZVNC};
            default: DDATA <= 32'bX;
        endcase
    end
    ////////////////////////////////////////////////////////////
    
endmodule
