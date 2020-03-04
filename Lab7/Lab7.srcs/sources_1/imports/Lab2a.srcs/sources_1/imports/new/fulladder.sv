`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/15/2019 05:54:35 PM
// Design Name: 
// Module Name: halfadder
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

module fulladder(
    input wire A,
    input wire B,
    input wire Cin,
    output wire Sum, 
    output wire Cout
    );
    
    assign Sum = Cin ^ A ^ B; 
    assign Cout = (A & B) | ((A ^ B) &  Cin);
     
endmodule


