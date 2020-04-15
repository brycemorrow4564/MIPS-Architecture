`timescale 1ns / 1ps

module stopwatch(
    input wire clk, 
    input wire BTNU, BTNC, BTND,
    output logic[7:0] segments, 
    output logic[7:0] digitselect
    );
    
    // Value of N that debounces signal for 
    // approx 1/10 second 
    localparam N = 20; 
    
    /*
    Take the raw button input from the FPGA and 
    create debounced logical signal to feed to the
    FSM that controls the stopwatch. 
    
    Initial state is counting up starting from 0
    */
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
    
    /*
    Feed the debounced logical values to the FSM to get the 
    current state, defined by the two logic variables countup 
    and paused 
    */
    wire countup, paused; 
  
    fsm stopwatchFSM(
        .clk(clk), 
        .up(up), 
        .center(center), 
        .down(down), 
        .countup(countup),
        .paused(paused)
    ); 
    
    /*
    This is the value that drives the 8 bit display 
    it is set by the updowncounter module based on 
    the current state of the driving FSM
    */  
    wire[31:0] value;
    
    updowncounter ud_counter(
        .clk(clk), 
        .countup(countup), 
        .paused(paused), 
        .value(value)
    );
    
    /*
    Drive the display 
    */
    display8digit displayDriver(
        .val(value), 
        .clk(clk), 
        .segments(segments), 
        .digitselect(digitselect)
    ); 
    
    
endmodule
