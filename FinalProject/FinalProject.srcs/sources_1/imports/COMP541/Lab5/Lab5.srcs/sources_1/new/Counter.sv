`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/22/2019 11:11:16 AM
// Design Name: 
// Module Name: Counter
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

//A counter module to drive an 8 bit display
module counter(
    input wire clk, 
    output logic [31:0] value
    );
    
    //size of this logic is dependent on timing 
    //semantics of the 8 bit display
    logic[60:0] counter; 
    
    always_ff @(posedge clk)
	   counter <= counter + 1'b1;
       
    assign value[31:0] = counter[50:19]; 
    
endmodule
