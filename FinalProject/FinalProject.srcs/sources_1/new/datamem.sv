`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/12/2020 04:05:29 PM
// Design Name: 
// Module Name: datamem
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


module datamem #(
    parameter Abits = 6,               // Number of bits in address
    parameter Dbits = 32,               // Number of bits in data
    parameter Nloc = 64,              // Number of memory locations
    parameter initfile = "... .mem"     // initial data for data memory 
)(
    input wire clock,                                   // system clock 
    input wire dmem_wr,                                 // write enable 
    
    input wire [31:0] cpu_addr,                         // memory address from cpu 
    input wire [31:0] cpu_writedata,                    // data to write to screen address if CPU writes enabled 
    output wire [31:0] cpu_readdata                     // data read from screen address provided by CPU 
);
    
    wire [Abits-1:0] cpu_addr_adj = cpu_addr >> 2; 

   logic [Dbits-1 : 0] mem [Nloc-1 : 0];        // The actual storage where data resides
   initial $readmemh(initfile, mem, 0, Nloc-1); // Initialize memory contents from a file

   always_ff @(posedge clock)                   
      if(dmem_wr)
         mem[cpu_addr_adj[Abits-1:0]] <= cpu_writedata;

   assign cpu_readdata = mem[cpu_addr_adj[Abits-1:0]];     

endmodule
