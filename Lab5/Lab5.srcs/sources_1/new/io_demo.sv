`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/22/2019 12:07:23 PM
// Design Name: 
// Module Name: io_demo
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


module io_demo(
    input wire clk, 
    
    //Display
    output wire [7:0] segments,
    output wire [7:0] digitselect,
        
    //keyboard IO
    input wire ps2_clk, 
    input wire ps2_data,
    
    //sound IO
    output wire audPWM, 
    output wire audEn, 
    
    //accel IO
    input wire aclMISO, 
    output wire aclMOSI, 
    output wire aclSCK, 
    output wire aclSS, 
    
    //LED IO
    output wire [15:0] LED
    );
    
    //display wires
    wire [31:0] display;

    
    //Keyboard wires
    wire [31:0] kb_char; 
    wire [31:0] period;
    
    keyboard akeyboard(clk, ps2_clk, ps2_data, kb_char); 
    
    //Assigns the period based on key presses of numbers 1-8
    assign period = kb_char === 32'h0016 ? 382219 : 
                    kb_char === 32'h001E ? 340530 :  
                    kb_char === 32'h0026 ? 303370 : 
                    kb_char === 32'h0025 ? 286344 :
                    kb_char === 32'h002E ? 255102 : 
                    kb_char === 32'h0036 ? 227273 :
                    kb_char === 32'h003D ? 202478 : 
                    kb_char === 32'h003E ? 191113 : 0; 
           
    assign audEn = 1; 

    montek_sound_Nexys4 soundmod(clk, period, audPWM);
    
    //Acceleration / Temperature wires
    wire [8:0] accelX, accelY; 
    wire [11:0] accelTmp; 
    
    assign display[31:0] = {7'b0, accelX, 7'b0, accelY};
    display8digit d8(display, clk, segments, digitselect);
    
    accelerometer accelmod(clk, aclSCK, aclMOSI, aclMISO, aclSS, accelX, accelY, accelTmp);  

    assign LED[15:0] =  (accelY < 9'h020) ? 'b0000000000000001 : 
                        (accelY < 9'h040) ? 'b0000000000000010 :
                        (accelY < 9'h060) ? 'b0000000000000100 :
                        (accelY < 9'h080) ? 'b0000000000001000 :
                        (accelY < 9'h0A0) ? 'b0000000000010000 :
                        (accelY < 9'h0C0) ? 'b0000000000100000 :
                        (accelY < 9'h0E0) ? 'b0000000001000000 :
                        (accelY < 9'h110) ? 'b0000000010000000 :
                        (accelY < 9'h130) ? 'b0000000100000000 :
                        (accelY < 9'h150) ? 'b0000001000000000 :
                        (accelY < 9'h170) ? 'b0000010000000000 :
                        (accelY < 9'h190) ? 'b0000100000000000 :
                        (accelY < 9'h1B0) ? 'b0001000000000000 :
                        (accelY < 9'h1D0) ? 'b0010000000000000 :
                        (accelY < 9'h1D0) ? 'b0100000000000000 : 
                                            'b1000000000000000;

endmodule
