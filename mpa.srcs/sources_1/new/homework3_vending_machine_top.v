`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/26/2019 11:13:45 AM
// Design Name: 
// Module Name: homework3_vending_machine_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`define NICKEL 7'b0000101
`define DIME 7'b0001010
`define QUARTER 7'b0011001
`define HALFDOLLAR 7'b0110010
`define DOLLAR 7'b1100100
`define NORMAL 2'b00
`define VEND 2'b01
`define COIN_RETURN 2'b10

module homework3_vending_machine_top 
    (
    input clock,
    input reset,
    input [4:0] coin_stock,         // external input for available coins at any time
    input [5:0] soda_stock,         // external input for available sodas at any time
    input [6:0] coin,               // decimal value of coin is the coin inserted
    input [2:0] choice,             // 6 soda choices
    input coinreturn,               // coin return button 
    output reg vend = 0,                // signal to vend 
    output reg [6:0] change = 0,        // decimal value is the coin to be returned
    output reg exact_change = 0,        // simulated LED for exact change only needed
    output reg [5:0] out_of_stock = 0   // simulated LEDS for out of stock options
    );
 
    
    reg [1:0] state = 0;
    reg [1:0] next_state = 0;
    reg [32:0] current_change = 0;
    
    // The actual state machine's changing of states on clock ticks 
    always @ (posedge clock) begin
        if (reset) begin
            state <= `NORMAL; 
        end 
        else begin
            state <= next_state;
        end
    end
    
    // The state machine
    always @ (*) begin
    
        case (state)
            
            `NORMAL:
            begin
                current_change <= coin;
                vend <= 0;
            end
            
            `VEND:
            begin
            
            end
            
            `COIN_RETURN:
            begin
            
            end
            
        endcase
    
    end
    
    
    
endmodule // homework3_vending_machine_top











