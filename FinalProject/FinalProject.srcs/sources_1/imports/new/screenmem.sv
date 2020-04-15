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
    parameter Abits = 11,               // Number of bits in address
    parameter Dbits = 4,               // Number of bits in data
    parameter Nloc = 1200,              // Number of memory locations
    parameter initfile = "... .mem"     // initial data for data memory 
)(
    input wire clock,                                   // system clock 
    input wire smem_wr,                                 // write enable   
    
    // CPU read / write port 
    output wire [31:0] cpu_readdata,            // data read from screen address provided by CPU 
    input wire [31:0] cpu_addr,                         // memory address from cpu 
    input wire [31:0] cpu_writedata,                    // data to write to screen address if CPU writes enabled 
    
    // VGA read port 
    input wire [Abits-1:0] vga_addr,             // screen address from vga driver 
    output wire [Dbits-1:0] vga_readdata     // data to read from screen address provided by vga driver 
);

    // screen address from CPU
    wire [Abits-1:0] cpu_addr_adj = cpu_addr >> 2; 

    // storage for screen memory 
    logic [Dbits-1:0] smem [Nloc-1:0]; 
    initial $readmemh(initfile, smem, 0, Nloc-1);

    // CPU write port 
    always_ff @(posedge clock)                       
          if(smem_wr)
             smem[cpu_addr_adj] <= cpu_writedata[Dbits-1:0];
    
    // CPU read port 
    assign cpu_readdata = {0, smem[cpu_addr_adj]}; // zero pad to fill word size  
    
    // VGA read port
    assign vga_readdata = smem[vga_addr]; 

endmodule
