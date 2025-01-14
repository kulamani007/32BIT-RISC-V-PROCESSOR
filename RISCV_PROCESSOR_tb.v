`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.01.2025 01:55:45
// Design Name: 
// Module Name: RISCV_PROCESSOR_tb
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


module RISCV_PROCESSOR_tb;

    // Clock and Reset signals
    reg clk;
    reg reset;

    // Outputs to observe
    wire [31:0] pc;
    wire [31:0] alu_out;
    wire [31:0] instr;

    // Instantiate the RISC-V Processor
    RISCV_PROCESSOR uut (
        .clk(clk),
        .reset(reset),
        .pc(pc),
        .alu_out(alu_out),
        .instr(instr)
    );

    // Clock generation: 10ns period (100MHz)
    always #5 clk = ~clk;

    // Test procedure
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        
        // Apply reset for a few clock cycles
        #20 reset = 0;
        
        // Simulate for a fixed duration
        #200 $stop;
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %t | PC: %h | ALU_OUT: %h | INSTR: %h",
                 $time, pc, alu_out, instr);
    end

endmodule

