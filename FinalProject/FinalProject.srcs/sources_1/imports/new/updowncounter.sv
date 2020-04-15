`timescale 1ns / 1ps
`default_nettype none 
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/01/2019 10:37:32 PM
// Design Name: 
// Module Name: updowncounter
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


module updowncounter(
    input wire clk, 
    input wire countup, 
    input wire paused, 
    output wire[31:0] value
    );
    
    //The wrap around bit space container 
    //Using this as well as the 100MHz clock 
    logic[60:0] rawvalue = 0; 
    
    always_ff @(posedge clk) begin
        if (~paused)
            rawvalue <= countup ? rawvalue + 1 : rawvalue - 1;  
    end 
    
    //This will be displayed to the user 
    //on an 8 number display
    assign value[31:0] = rawvalue[50:19]; 
    
    
endmodule
