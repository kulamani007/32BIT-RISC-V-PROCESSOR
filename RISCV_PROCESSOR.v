`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.01.2025 01:53:45
// Design Name: 
// Module Name: RISCV_PROCESSOR
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


module RISCV_PROCESSOR (
    input clk,
    input reset,
    output [31:0] pc,         // Program Counter
    output [31:0] alu_out,    // ALU result
    output [31:0] instr       // Current instruction
);

    // Internal signals
    wire [31:0] pc_next;
    wire [31:0] imm;
    wire [31:0] reg_data1, reg_data2, alu_result, mem_data;
    wire [3:0] alu_control;
    wire branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write;

    // Program Counter
    reg [31:0] program_counter;
    assign pc = program_counter;

    always @(posedge clk or posedge reset) begin
        if (reset)
            program_counter <= 32'b0;
        else
            program_counter <= pc_next;
    end

    // Instruction Memory (example ROM)
    reg [31:0] instruction_memory [0:255]; 
    assign instr = instruction_memory[pc[7:2]];

    // Register File
    reg [31:0] registers [0:31];

    // ALU
    alu alu_unit (
        .a(reg_data1),
        .b(alu_src ? imm : reg_data2),
        .alu_control(alu_control),
        .result(alu_out)
    );

    // Control Unit
    control_unit control (
        .opcode(instr[6:0]),
        .branch(branch),
        .mem_read(mem_read),
        .mem_to_reg(mem_to_reg),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .reg_write(reg_write),
        .alu_control(alu_control)
    );

    // Data Memory for load/store
    reg [31:0] data_memory [0:255]; 

endmodule

