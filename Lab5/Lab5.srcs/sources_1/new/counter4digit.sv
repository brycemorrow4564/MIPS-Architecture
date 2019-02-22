`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/22/2019 10:53:53 AM
// Design Name: 
// Module Name: counter4digit
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


module counter4digit(
    input wire clk, 
    output logic[7:0] segments, 
    output logic[7:0] digitselect
    );
    
    wire[15:0] value; 
    
    counter fourDigitCounter(clk, value); 
    display4digit fourDigitDisplay(value, clk, segments, digitselect); 
    
endmodule
