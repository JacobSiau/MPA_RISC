`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module homework5_risc_data_memory(
    input CLK,
    input RST,
    input MW,
    input [5:0] MEM_ADDR,
    input [31:0] MEM_DIN,
    output [31:0] MEM_DOUT
    );
    
    reg [31:0] datamem [63:0];
    integer i;
    
    assign MEM_DOUT = datamem[{58'b0, MEM_ADDR}];
    
    initial begin
        for (i = 0; i < 64; i = i + 1)
            datamem[i] = i;
    end
    
    always @(posedge CLK) begin
        if (RST)
            for (i = 0; i < 64; i = i + 1) 
                datamem[i] = i;
        else if (MW)
            datamem[MEM_ADDR] <= MEM_DIN;
    end
    
endmodule

