//////////////////////////////////////////////////////////////////////////////////
// Montek Singh
// 1/30/2019
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`default_nettype none

module hexto7seg(
   /*
   Defines the transtlation between the hexadecimal 
   value we wish to encode (stored in the 4 bit wire 
   X), and the activated entries of the segments array, 
   which will activate LED lights on the Artix-7 board. 
   */
   input wire [3:0] X,
   output wire [7:0] segments
);

   assign segments = ~(                              
   
            X == 4'h0 ? 8'b11111100      
          : X == 4'h1 ? 8'b01100000
          : X == 4'h2 ? 8'b11011010
          : X == 4'h3 ? 8'b11110010
          : X == 4'h4 ? 8'b01100110
          : X == 4'h5 ? 8'b10110110
          : X == 4'h6 ? 8'b10111110
          : X == 4'h7 ? 8'b11100000
          : X == 4'h8 ? 8'b11111110
          : X == 4'h9 ? 8'b11110110
          
          : X == 4'hA ? 8'b11101110
          : X == 4'hB ? 8'b11111110
          : X == 4'hC ? 8'b10011100
          : X == 4'hD ? 8'b11111100
          : X == 4'hE ? 8'b10011110
          : X == 4'hF ? 8'b10001110
          
          : 8'b00000001 );            // To catch a value that doesn't match any of the above
                                      // That would include not only X and Z values, but also
                                      //   10 to 15.

endmodule