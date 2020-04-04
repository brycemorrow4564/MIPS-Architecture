`timescale 1ns / 1ps
 `default_nettype none
 
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2020 01:59:49 PM
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

`define pcInit 'h0040_0000                  // starting address for program counter 

module datapath #(
    parameter Nreg=32,                      // number of registers
    parameter Dbits=32                      // word size for the processor
)(
    input wire clk,
    input wire reset,
    input wire enable,
    output wire [31:0] pc,
    input wire [31:0] instr,
    input wire [1:0] pcsel, 
    input wire [1:0] wasel, 
    input wire sext, 
    input wire bsel, 
    input wire [1:0] wdsel, 
    input wire [4:0] alufn, 
    input wire werf, 
    input wire [1:0] asel,
    output wire Z,
    input wire [31:0] mem_readdata, 
    output wire [31:0] mem_addr, 
    output wire [31:0] mem_writedata
    );
    
    logic [Dbits-1:0] pcValue = `pcInit;      // memory unit to maintain program counter 
    wire [Dbits-1:0] signImm,                // extended immediate value (zero pad or sign extend) 
                     ReadData1, ReadData2,   // data read from registers
                     BT,                     // used for branch instructions 
                     aluA, aluB,             // ALU inputs
                     alu_result;             // ALU output
    wire [4:0] reg_writeaddr;                // the register address to write to 
    wire [Dbits-1:0] reg_writedata;          // the data to write to the regiter address 
                    
    assign pc = pcValue; 
    
    always_ff @(posedge clk) begin
        pcValue <= (enable == 0) ? pcValue 
                 : (reset == 1) ? `pcInit 
                 : (pcsel == 0) ? pcValue + 4
                 : (pcsel == 1) ? BT
                 : (pcsel == 2) ? {pcValue[31:28], instr[25:0], 2'b00} 
                 : (pcsel == 3) ? ReadData1 
                 :                `pcInit ;
    end 
    
    assign signImm = (sext == 1) ?  {{16{instr[15]}}, instr[15:0]} : 
                                    {16'b0000_0000_0000_0000, instr[15:0]};

    assign BT = (pcValue + 4 + (signImm[31:0] << 2)); 
 
     assign aluA =  (asel == 2'b00) ? ReadData1
                  : (asel == 2'b01) ? instr[10:6]  // shamt 
                  : (asel == 2'b10) ? 16
                  :                   0;   
                       
    assign aluB = (bsel == 0) ? ReadData2
                : (bsel == 1) ? signImm
                :               0;   
    
    assign reg_writeaddr = (wasel == 0) ? instr[15:11] 
                         : (wasel == 1) ? instr[20:16] 
                         : (wasel == 2) ? 31  
                         :                0;  
                        
    assign reg_writedata = (wdsel == 0) ? pc+4 
                         : (wdsel == 1) ? alu_result
                         : (wdsel == 2) ? mem_readdata
                         :                0;   
                                      
    assign mem_writedata = ReadData2;
    
    assign mem_addr = alu_result;
               
    register_file #(Nreg, Dbits) regfile_instance(
        .clock(clk), 
        .wr(werf), 
        .ReadAddr1(instr[25:21]), 
        .ReadAddr2(instr[20:16]), 
        .WriteAddr(reg_writeaddr), 
        .WriteData(reg_writedata), 
        .ReadData1(ReadData1), 
        .ReadData2(ReadData2)
    );
   
    ALU #(32) alu_instance(
        .A(aluA), 
        .B(aluB), 
        .R(alu_result), 
        .ALUfn(alufn), 
        .FlagZ(Z)
    );
    
endmodule
