module Testbench;
    reg clk, rst, we;
    reg [7:0] A, B;
    reg [1:0] opcode;
    reg [2:0] write_addr, read_addr;
    wire [7:0] read_data;

    // Instantiate the ALU and Register File Integration module
    ALU_Reg_Integration uut (
        .clk(clk),
        .rst(rst),
        .we(we),
        .A(A),
        .B(B),
        .opcode(opcode),
        .write_addr(write_addr),
        .read_addr(read_addr),
        .read_data(read_data)
    );

    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        we = 0;
        A = 8'b0;
        B = 8'b0;
        opcode = 2'b0;
        write_addr = 3'b0;
        read_addr = 3'b0;

        #5 rst = 0;

        // Test AND operation
        A = 8'b10010101; B = 8'b00001111; opcode = 2'b00; write_addr = 3'b001; we = 1;
        #10 we = 0; read_addr = 3'b001; 

        // Test OR operation
        #10 A = 8'b01101010; B = 8'b00001111; opcode = 2'b01; write_addr = 3'b010; we = 1;
        #10 we = 0; read_addr = 3'b010; 

        // Test NAND operation
        #10 A = 8'b01010011; B = 8'b00001111; opcode = 2'b10; write_addr = 3'b011; we = 1;
        #10 we = 0; read_addr = 3'b011; 

        // Test NOR operation
        #10 A = 8'b10101100; B = 8'b00001111; opcode = 2'b11; write_addr = 3'b100; we = 1;
        #10 we = 0; read_addr = 3'b100; 

        #20 $finish;
    end

    initial begin
        $monitor("Time: %0t , A: %b , B: %b , OpC: %b , Write_Address: %b , Read_Address: %b , W_enable: %b , Read_Data: %b", 
                 $time, A, B, opcode, write_addr, read_addr, we, read_data);
    end

    always #5 clk = ~clk;

    initial begin
        $dumpfile("hackathon.vcd"); 
        $dumpvars(0, Testbench);    
    end
endmodule