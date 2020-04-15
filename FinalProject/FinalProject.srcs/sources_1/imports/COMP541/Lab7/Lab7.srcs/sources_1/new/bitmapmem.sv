`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/29/2020 10:55:51 AM
// Design Name: 
// Module Name: bitmapmem
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

/*
Ex: Each sprite is 16x16, we have a 4x4 grid where each grid index can hold a sprite 
screen address corresponds to (2,1) i.e. the 3nd row and 2nd columnn of the char grid. 
We have 4 different sprites that can be shown in each location with codes 00,01,10,11

bitmap memory has 256 color values for each of the 4 sprites so, we have a ROM of size 1024 
00 -> 0
01 -> 256
10 -> 512
11 -> 768

offset is in range 0,255 so we can represent this as the lowest order 8 bits 
0:   00-0000-0000
256: 01-0000-0000
512: 10-0000-0000
768: 11-0000-0000
*/ 

module bitmapmem #(
    parameter charCount = 4,                    // the number of chars our visual memory supports
    parameter charDim = 16,                     // sprite has dimensions (charDim x charDim)  
    parameter initFile = "... .mem"                     
)(
    input wire [$clog2(charCount*charDim*charDim)-1:0] bitmapAddr,  // address of character color value
    output wire [11:0] colorValue                                   // color value for pixel of target sprite 
);

    /*
    There are charCount sprites in total and each sprite has charDim x charDim total pixels 
    Therefore, the number of 12 bit color values we need to store is charCount x charDim x charDim
    */ 
    logic [11:0] bitmapMemory [(charCount*charDim*charDim)-1:0]; 
    initial $readmemh(initFile, bitmapMemory, 0, (charCount*charDim*charDim)-1);
    
    assign colorValue = bitmapMemory[bitmapAddr]; 

endmodule
