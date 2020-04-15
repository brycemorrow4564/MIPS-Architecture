//////////////////////////////////////////////////////////////////////////////////
// Montek Singh
// 9/28/2017 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`default_nettype none

module fsm(
    input wire clk,
    input wire up, center, down,     //input signals from 3 buttons on the Nexsy Board
    output logic countup, paused
    );

    // The next line is our state encoding
    // You enumerate states, and the compiler decides state encoding
    enum {  
            COUNTING_UP, 
            COUNTING_DOWN, 
            RESUMING_UP, 
            RESUMING_DOWN, 
            PAUSING_UP, 
            PAUSING_DOWN, 
            PAUSED_UP, 
            PAUSED_DOWN 
         } 
         state, next_state;

    // Instantiate the state storage elements (flip-flops)
    always_ff @(posedge clk) 
        state <= next_state;

    // Define next_state logic => combinational
    // Every case must either be a conditional expression
    //   or an "if" with a matching "else"
        
    /*
    up button: set direction of counting to up, 1 is on, 0 is off
    center button: toggles between counting and pausing. 0 is counting, 1 is paused 
    down button: set direction of counting to down, 1 is on, 0 is off 
    */
    always_comb     
      case (state)         
            COUNTING_UP:    next_state <= (center == 1) ? PAUSING_UP : ((down == 1) ? COUNTING_DOWN : COUNTING_UP); 
            COUNTING_DOWN:  next_state <= (center == 1) ? PAUSING_DOWN : ((up == 1) ? COUNTING_UP : COUNTING_DOWN); 
            PAUSED_UP:      next_state <= (center == 1) ? RESUMING_UP : ((down == 1) ? PAUSED_DOWN : PAUSED_UP); 
            PAUSED_DOWN:    next_state <= (center == 1) ? RESUMING_DOWN : ((up == 1) ? PAUSED_UP : PAUSED_DOWN); 
            RESUMING_UP:    next_state <= (center == 1) ? RESUMING_UP : COUNTING_UP; 
            RESUMING_DOWN:  next_state <= (center == 1) ? RESUMING_DOWN : COUNTING_DOWN; 
            PAUSING_UP:     next_state <= (center == 1) ? PAUSING_UP : PAUSED_UP; 
            PAUSING_DOWN:   next_state <= (center == 1) ? PAUSING_DOWN : PAUSED_DOWN; 
            
            default:        next_state <= COUNTING_UP;
      endcase

    // The outputs, countup and paused, are a combinational function of the current state 
    always_comb     
      case (state)
            COUNTING_UP:    begin countup = 1; paused = 0; end 
            COUNTING_DOWN:  begin countup = 0; paused = 0; end 
            RESUMING_UP:    begin countup = 1; paused = 0; end 
            RESUMING_DOWN:  begin countup = 0; paused = 0; end 
            PAUSING_UP:     begin countup = 1; paused = 1; end 
            PAUSING_DOWN:   begin countup = 0; paused = 1; end 
            PAUSED_UP:      begin countup = 1; paused = 1; end 
            PAUSED_DOWN:    begin countup = 0; paused = 1; end 
            
            default:        begin countup = 1; paused = 0; end 
      endcase

endmodule