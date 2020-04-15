`timescale 1ns / 1ps

`define W_SCANCODE 32'h1D
`define A_SCANCODE 32'h1C 
`define S_SCANCODE 32'h1B 
`define D_SCANCODE 32'h23 

module buttonInput (
    input wire clk, 
    input wire BTNU, BTNC, BTND,
    output wire [31:0] keyb_char
    );
    
    // Value of N that debounces signal for 
    // approx 1/10 second 
    localparam N = 20; 
    logic up, center, down; 
    
    debouncer #(N) upDebouncer (
        .clk(clk), 
        .raw(BTNU),
        .clean(up)
    );
    debouncer #(N) centerDebouncer (
        .clk(clk), 
        .raw(BTNC), 
        .clean(center)
    );
    debouncer #(N) downDebouncer (
        .clk(clk), 
        .raw(BTND), 
        .clean(down)
    ); 
    
    assign keyb_char = (up == 1) ? `W_SCANCODE : 
                       (down == 1) ? `A_SCANCODE : 32'h4D; 

endmodule
