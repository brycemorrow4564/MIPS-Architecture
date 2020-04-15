//////////////////////////////////////////////////////////////////////////////////
//
// Montek Singh
// 2/7/2019 
//
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`default_nettype none
`include "display640x480.vh"

module vgadisplaydriver#(
    parameter nrows = 30, 
    parameter ncols = 40, 
    parameter nloc = 1200,              // the number of screen memory locations
    parameter charCount = 16,            // the number of sprites our visual memory supports 
    parameter charDim = 16              // the square pixel dimension of a single character 
)(
    input wire clk,
    input wire [$clog2(charCount)-1:0] charCode, 
    output wire [$clog2(nloc)-1:0] screenAddr, 
    output wire [3:0] red, green, blue,
    output wire hsync, vsync
    );

   wire activevideo;                                            // on screen when activevideo == 1
   wire [`xbits-1:0] x;                                         // x coordinate of current pixel being updated
   wire [`ybits-1:0] y;                                         // y coordinate of current pixel being updated 
   wire [`xbits-1:0] j = x >> 4;                                // mapping to screen memory x dimension 
   wire [`ybits-1:0] k = y >> 4;                                // mapping to screen memory y dimension 
   wire [$clog2(charDim)-1:0] offsetX = x[$clog2(charDim)-1:0]; // x offset within current character bitmap     
   wire [$clog2(charDim)-1:0] offsetY = y[$clog2(charDim)-1:0]; // y offset within current character bitmap 
   wire [$clog2(charCount*charDim*charDim)-1:0] bitmapAddr;     // starting address of current character color data 
   wire [11:0] colorValue;
   
   assign screenAddr = j+(k*ncols);                        // index of character code in screen memory 
   assign bitmapAddr = {charCode,offsetY,offsetX};          // index of color value in bitmap memory 
   
   assign red[3:0]   = (activevideo == 1) ? colorValue[11:8] : 4'b0; 
   assign green[3:0] = (activevideo == 1) ? colorValue[7:4]  : 4'b0; 
   assign blue[3:0]  = (activevideo == 1) ? colorValue[3:0]  : 4'b0; 

   bitmapmem #(
    .charCount(charCount),
    .charDim(charDim), 
    .initFile("bmem_screentest.mem")
   ) bitmap_memory(
    .bitmapAddr(bitmapAddr), 
    .colorValue(colorValue)
   ); 
    
   vgatimer myvgatimer(clk, hsync, vsync, activevideo, x, y);

endmodule