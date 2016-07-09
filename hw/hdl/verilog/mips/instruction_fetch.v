//=============================================================================
// EE108B Lab 2
//
// Instruction fetch module. Maintains PC and updates it. Reads from the
// instruction ROM.
//=============================================================================

module instruction_fetch (
    input clk,
    input rst,
    input en,
    input jump_branch,
    input jump_target,
    input jump_reg,
    input [31:0] rs_data,
    input [31:0] rs_data_jr,
    input [31:0] pc_id,
    input [25:0] instr_id,  // Lower 26 bits of the instruction

    output [31:0] pc
);


    wire [31:0] pc_id_p4 = pc_id + 3'h4;
    wire [31:0] j_addr = {pc_id_p4[31:28], instr_id[25:0], 2'b0};
    wire [31:0] b_imm = ({{16{instr_id[15]}}, instr_id[15:0]}) << 2;
    wire [31:0] pc_next = (jump_target) ? ((jump_reg) ? rs_data_jr : j_addr) : (jump_branch ? (pc_id_p4 + b_imm) : (pc + 3'h4));
    // wire [31:0] pc_next = (jump_target) ? j_addr : (jump_branch ? (pc_id_p4 + b_imm) : (pc + 3'h4));

    dffare #(32) pc_reg (.clk(clk), .r(rst), .en(en), .d(pc_next), .q(pc));

endmodule
