`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/12/2020 10:41:57 AM
// Design Name: 
// Module Name: memIO
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

module memIO#(
    parameter dmem_init = "... .mem",   // initial data for data memory 
    parameter smem_init = "... .mem"    // initial data for screen memory 
)
(
    // MIPS   
    input wire clock,
    input wire cpu_wr, 
    input wire [31:0] cpu_addr, 
    input wire [31:0] cpu_writedata, 
    output wire [31:0] cpu_readdata, 
    
    // Display 
    input wire [10:0] vga_addr,
    output wire [3:0] vga_readdata,     
    
    // I/O 
    input wire [8:0] accelX, accelY, 
    input wire [31:0] keyb_char, 
    output logic [15:0] lights, 
    output logic [31:0] period,
     
    // DEBUGGING 
    output wire smem_reading, 
    output wire dmem_reading
    
);

    wire [31:0] smem_readdata, dmem_readdata;
    
    wire [31:0] accel = {7'b0, accelX, 7'b0, accelY}; 
    
    wire dmem_wr =      ((cpu_addr[17:16] == 'b01) & cpu_wr) ? 1 : 0;
    wire smem_wr =      ((cpu_addr[17:16] == 'b10) & cpu_wr) ? 1 : 0;
    wire lights_wr =    ((cpu_addr[17:16] == 'b11) & (cpu_addr[3:2] == 'b11) & cpu_wr) ? 1 : 0;
    wire sound_wr =     ((cpu_addr[17:16] == 'b11) & (cpu_addr[3:2] == 'b10) & cpu_wr) ? 1 : 0;
        
    // DEBUGGING 
    assign smem_reading = (cpu_addr[17:16] == 'b10); 
    assign dmem_reading = (cpu_addr[17:16] == 'b01); 
        
    assign cpu_readdata =   (cpu_addr[17:16] == 'b01) ? dmem_readdata :
                            (cpu_addr[17:16] == 'b10) ? smem_readdata : 
                            (cpu_addr[17:16] == 'b11) ? (
                                                            (cpu_addr[3:2] == 'b00) ?   keyb_char : 
                                                            (cpu_addr[3:2] == 'b01) ?   accel : 
                                                            (cpu_addr[3:2] == 'b10) ?   period : 
                                                            (cpu_addr[3:2] == 'b11) ?   lights : 
                                                                                        32'b0
                                                        ) : 
                                                        32'b0; 
    
    // Perform synchronous IO writes from CPU to device 
    always_ff @(posedge clock) begin
        if (lights_wr) lights <= cpu_writedata; 
        if (sound_wr)  period <= cpu_writedata; 
    end

    datamem #(.Abits(6),.Dbits(32),.Nloc(64),.initfile(dmem_init)) data_mem (
        .clock(clock),
        .dmem_wr(dmem_wr), 
        .cpu_addr(cpu_addr),
        .cpu_writedata(cpu_writedata), 
        .cpu_readdata(dmem_readdata)
    );
    
    screenmem #(.Abits(11),.Dbits(4),.Nloc(1200),.initfile(smem_init)) screen_mem (
        .clock(clock),
        .smem_wr(smem_wr), 
        .cpu_addr(cpu_addr),
        .cpu_writedata(cpu_writedata), 
        .cpu_readdata(smem_readdata),
        .vga_addr(vga_addr),
        .vga_readdata(vga_readdata)
    );
    
endmodule
