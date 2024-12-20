// ALU Module: Performs basic arithmetic and logical operations
module ALU (
    input [7:0] A, B,         // Two 8-bit inputs (operands)
    input [1:0] opcode,       // 2-bit code to select the operation
    output reg [7:0] result   // 8-bit result of the operation
);
    // Always block to evaluate operations based on the opcode
    always @(*) begin
        case (opcode)
            2'b00: result = A & B;    // Logical AND
            2'b01: result = A | B;    // Logical OR
            2'b10: result = ~(A & B); // Logical NAND
            2'b11: result = ~(A | B); // Logical NOR
            default: result = 8'b0;   // Default case: Output is zero
        endcase
    end
endmodule

// Register File Module: Stores data in 8 registers and allows read/write access
module RegisterFile (
    input clk,                   // Clock signal
    input rst,                   // Reset signal to initialize all registers
    input we,                    // Write enable: Allows writing when high
    input [2:0] write_addr,      // 3-bit address for the register to write to
    input [2:0] read_addr,       // 3-bit address for the register to read from
    input [7:0] write_data,      // 8-bit data to write to the register
    output reg [7:0] read_data   // 8-bit data read from the register
);
    reg [7:0] registers [7:0];   // 8 registers, each 8 bits wide
    integer i;                   // Loop variable for reset

    // Sequential block: Triggered on clock edge or reset signal
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset all registers to zero
            for (i = 0; i < 8; i = i + 1)
                registers[i] = 8'b0; // Blocking assignment for initialization
        end else if (we) begin
            // Write data to the selected register
            registers[write_addr] <= write_data; // Non-blocking assignment for sequential logic
        end
    end

    // Combinational block: Read data from the selected register
    always @(*) begin
        read_data = registers[read_addr]; // Read logic
    end
endmodule

// Top Module: Integrates ALU and Register File
module ALU_Reg_Integration (
    input clk,                    // Clock signal
    input rst,                    // Reset signal
    input we,                     // Write enable for the register file
    input [7:0] A, B,             // 8-bit inputs for the ALU
    input [1:0] opcode,           // Operation code for ALU
    input [2:0] write_addr,       // Register address to write the ALU result
    input [2:0] read_addr,        // Register address to read data
    output [7:0] read_data        // Data read from the register
);
    wire [7:0] alu_result;        // Output of the ALU

    // ALU Instance: Performs the operation and produces a result
    ALU alu (
        .A(A),                   // Connect input A
        .B(B),                   // Connect input B
        .opcode(opcode),         // Connect operation code
        .result(alu_result)      // Connect ALU result to wire
    );

    // Register File Instance: Stores and provides access to the ALU results
    RegisterFile reg_file (
        .clk(clk),               // Connect clock
        .rst(rst),               // Connect reset
        .we(we),                 // Connect write enable
        .write_addr(write_addr), // Connect write address
        .read_addr(read_addr),   // Connect read address
        .write_data(alu_result), // Write ALU result to the register
        .read_data(read_data)    // Read data from the register
    );
endmodule
