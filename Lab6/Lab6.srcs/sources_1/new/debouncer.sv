`timescale 1ns / 1ps
`default_nettype none

module debouncer #(parameter N=20)(
    input wire clk, 
    input wire raw, 
    output logic clean
    );
    
    logic [N:0] count; 
    
    always_ff @(posedge clk) begin
        count <= (raw != clean) ? count + 1'b1 : 0;
        clean <= (count[N] == 1'b1) ? raw : clean; 
    end  
    
endmodule
