`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/29/2020 10:04:40 AM
// Design Name: 
// Module Name: top
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
`include "displayProperties.vh"

module top(
    input wire clk, 
    output wire [3:0] red, green, blue, 
    output wire hsync, vsync
);
    
    wire [$clog2(`nloc)-1:0] screenAddr;            // index of current character code in screen memory 
    wire [$clog2(`charCount)-1:0] charCode;         // current character code read from screen memory 
    
    // Drives the VGA display 
    vgadisplaydriver #(
        .nrows(`nrows), 
        .ncols(`ncols), 
        .nloc(`nloc),
        .charCount(`charCount), 
        .charDim(`charDim) 
    ) vga_driver(
        .clk(clk), 
        .screenAddr(screenAddr),
        .charCode(charCode), 
        .red(red), 
        .green(green), 
        .blue(blue), 
        .hsync(hsync), 
        .vsync(vsync)
    );
    
    // Maps screen indices (blocks where characters can be placed) 
    // to the code of the character that should be placed there 
    screenmem #(
        .nloc(`nloc),
        .charCount(`charCount), 
        .initFile("smem_screentest.mem")
    ) screen_memory(
        .screenAddr(screenAddr), 
        .charCode(charCode)
    );
    
endmodule
