`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/29/2020 10:06:36 AM
// Design Name: 
// Module Name: screenmem
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

module screenmem #(
    parameter initFile = "... .mem",    // the file to use to intialize screen memory 
    parameter nloc = 1200,              // the number of screen memory locations
    parameter charCount = 4             // the number of sprites our visual memory supports 
)(
    input wire [$clog2(nloc)-1:0] screenAddr,
    output wire [$clog2(charCount)-1:0] charCode
);

    // Maps index for a char-based display to the code for the character 
    // to place in the current location 
    logic [$clog2(charCount)-1:0] screenMemory [nloc-1:0]; 
    initial $readmemb(initFile, screenMemory, 0, nloc-1);
    
    // Get the current character code for the target screen index 
    assign charCode = screenMemory[screenAddr]; 

endmodule
