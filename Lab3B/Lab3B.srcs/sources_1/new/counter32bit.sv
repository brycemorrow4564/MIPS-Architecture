`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2019 12:15:10 AM
// Design Name: 
// Module Name: counter32bit
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


module counter32bit(
    input wire clock, 
    output logic [31:0] counter
    );
    
    always_ff @(posedge clock) begin
        counter <= counter + 1; 
    end 
    
endmodule
