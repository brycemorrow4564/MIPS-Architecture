`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2020 03:35:52 PM
// Design Name: 
// Module Name: sext
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


module sext(
    input wire sext,             // if true sign extend. otherwise, 0 pad 
    input wire [15:0] value,     // the input value to process            
    output wire [32:0] sext_value
    );
    
    sext_value = sext ? {16{value[15]}{value}} : 
                        {{16'b0}{value}}; 
    
    
    
endmodule
