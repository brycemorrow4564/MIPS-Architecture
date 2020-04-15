`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2019 09:09:44 PM
// Design Name: 
// Module Name: vgatimer
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
`timescale 1ns / 1ps 
`default_nettype none 
`include "display640x480.vh"

module vgatimer(
    input wire clk, 
    output wire hsync, vsync, activevideo, 
    output wire [`xbits-1:0] x, 
    output wire [`ybits-1:0] y
    );
    
    logic [1:0] clk_count = 0;
    always_ff @(posedge clk) 
        clk_count <= clk_count + 2'b01; 
    
    wire Every2ndTick = (clk_count[0] == 1'b1); 
    wire Every4thTick = (clk_count[1:0] == 2'b11); 
    
    //Nexys-A7 clock operates at ~100 MHz
    //This xy counter is activated every 4th tick, 
    //Thus it simulates a 25 MHz clock counter
    xycounter #(`WholeLine, `WholeFrame) xy(clk, Every4thTick, x, y); 
    
    assign hsync = (x < `hSyncStart) || 
                   (x > `hSyncEnd); 
    assign vsync = (y < `vSyncStart) || 
                   (y > `vSyncEnd); 
    assign activevideo = (x < `hVisible) && 
                         (y < `vVisible);       
    
endmodule
