`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module homework5_risc_branch_logic_module(
    input [7:0] PC_1,
    input [1:0] BS,
    input PS, 
    input Z,
    input [31:0] BrA,
    input [31:0] RAA,
    output reg [7:0] PC = 8'b0
    );
    
    reg [1:0] logic = 2'b0;
    
    always @(*) begin
    
        logic <= {BS[1], (((PS ^ Z)|BS[1])&BS[0])};
        case (logic)
            2'd0: PC <= PC_1;
            2'd1: PC <= BrA[7:0];
            2'd2: PC <= RAA[7:0];
            2'd3: PC <= BrA[7:0];
            default: PC <= 8'bX;
         endcase
         
    end
    
endmodule
