`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/22/2019 11:20:48 AM
// Design Name: 
// Module Name: counter8digit
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


module counter8digit(
    input wire clk, 
    output logic[7:0] segments, 
    output logic[7:0] digitselect
    );
    
    wire[31:0] value; 
    
    counter eightDigitCounter(clk, value); 
    display8digit eightDigitDisplay(value, clk, segments, digitselect); 
    
endmodule
