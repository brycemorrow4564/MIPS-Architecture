`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/06/2019 08:44:10 PM
// Design Name: 
// Module Name: hexcounterdisplay
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


module hexcounterdisplay(
    input wire clock, 
    output wire [7:0] digitselect, 
    output wire [7:0] segments 
    );
    
    //The binary value to convert to hex and show to the user 
    //starts off at 0, roughly every second it increments and 
    //wraps around when 4 bit overflow occurs 
    logic [3:0] value; 
    
    assign digitselect = ~(8'b0000_0001);
        
    counter1second counter (clock, value);
    hexto7seg display_encoder (value, segments); 
    
endmodule
