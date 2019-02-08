//////////////////////////////////////////////////////////////////////////////////
// ryce Morrow 
// 2/7/2019
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`default_nettype none

module counter1second(
    /*
    counter module with a 4 bit output 
    that changes roughly once per second 
    */
    input wire clock, 
    output logic [3:0] value
    );

    logic [31:0] counter; 
    always_ff @(posedge clock) begin
        counter <= counter + 1; 
    end
    
    assign value[3:0] = counter[30:27]; 
    
endmodule