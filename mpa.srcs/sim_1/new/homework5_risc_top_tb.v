`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module homework5_risc_top_tb();

reg CLK;
reg RST;

homework5_risc_top UUT (
    .CLK(CLK),
    .RST(RST)
);

initial begin
    CLK <= 0;
    RST <= 0;
//    #10
//    RST = 0;
    #5 
    RST <= 1;
    #5
    RST <= 0;
end

always 
    #5 CLK <= ~CLK;

endmodule
