`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/30/2019 06:19:29 PM
// Design Name: 
// Module Name: CounterMod7
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


module CounterMod7(
    input wire clock, 
    input wire reset, 
    output logic unsigned [2:0] value
    );
    //counts 0,1,2,3,4,5,6 
    
    always_ff @(posedge clock) begin
        value <= reset ? 0 : ((value == 6) ? 0 : value + 1); 
    end 
    
endmodule
