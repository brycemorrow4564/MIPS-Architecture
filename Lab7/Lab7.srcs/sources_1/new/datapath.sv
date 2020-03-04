`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2020 10:06:45 AM
// Design Name: 
// Module Name: datapath
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

module datapath#(
   parameter Nloc = 32, // Number of memory locations
   parameter Dbits = 32 // Number of bits in data
)(
    input wire clock, 
    input wire RegWrite,                                                // write enable flag 
    input wire [$clog2(Nloc)-1 : 0] ReadAddr1, ReadAddr2, WriteAddr,    // 3 addresses, two for reading and one for writing
    input wire[4:0] ALUFN, 
    input wire [Dbits-1:0] WriteData, 
    output logic [Dbits-1:0] ReadData1, 
    output logic [Dbits-1:0] ReadData2, 
    output wire [Dbits-1:0] ALUResult, 
    output wire FlagZ
);
    
    register_file #(Nloc, Dbits) regfile_instance(
        .clock(clock), 
        .wr(RegWrite), 
        .ReadAddr1(ReadAddr1), 
        .ReadAddr2(ReadAddr2), 
        .WriteAddr(WriteAddr), 
        .WriteData(WriteData), 
        .ReadData1(ReadData1), 
        .ReadData2(ReadData2)
    );
    
    ALU #(32) alu_instance(
        .A(ReadData1), 
        .B(ReadData2), 
        .R(ALUResult), 
        .ALUfn(ALUFN), 
        .FlagZ(FlagZ)
    );
    
endmodule
