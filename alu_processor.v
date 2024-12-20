module ALU (
    input [7:0] A, B,          
    input [1:0] opcode,        
    output reg [7:0] result   
);
    always @(*) begin
        case (opcode)
            2'b00: result = A & B;    // AND
            2'b01: result = A | B;    // OR
            2'b10: result = ~(A & B); // NAND
            2'b11: result = ~(A | B); // NOR
            default: result = 8'b0;   // Default case
        endcase
    end
endmodule

// Register File Module
module RegisterFile (
    input clk,                    
    input rst,                    
    input we,                    
    input [2:0] write_addr, 
    input [2:0] read_addr,  
    input [7:0] write_data, 
    output reg [7:0] read_data 
);
    reg [7:0] registers [7:0];    
    integer i;                    

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < 8; i = i + 1)
                registers[i] = 8'b0; 
        end else if (we) begin
            registers[write_addr] <= write_data; 
        end
    end

    always @(*) begin
        read_data = registers[read_addr];
    end
endmodule

module ALU_Reg_Integration (
    input clk,                      
    input rst,                      
    input we,                      
    input [7:0] A, B,           
    input [1:0] opcode,       
    input [2:0] write_addr, 
    input [2:0] read_addr,  
    output [7:0] read_data 
);
    wire [7:0] alu_result;   

    ALU alu (
        .A(A),
        .B(B),
        .opcode(opcode),
        .result(alu_result)
    );

    RegisterFile reg_file (
        .clk(clk),
        .rst(rst),
        .we(we),
        .write_addr(write_addr),
        .read_addr(read_addr),
        .write_data(alu_result),
        .read_data(read_data)
    );
endmodule