module Testbench;
    // Declare input/output signals
    reg clk, rst, we;                // Clock, Reset, and Write Enable signals
    reg [7:0] A, B;                 // 8-bit inputs for the ALU
    reg [1:0] opcode;               // 2-bit operation selector
    reg [2:0] write_addr, read_addr; // 3-bit addresses for register operations
    wire [7:0] read_data;           // 8-bit output from the register file

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

    // Testbench behavior
    initial begin
        // Step 1: Initialize all inputs
        clk = 0;           // Start with the clock low
        rst = 1;           // Assert reset to initialize the module
        we = 0;            // Disable writing to the register file
        A = 8'b0;          // Set inputs A and B to zero
        B = 8'b0;
        opcode = 2'b0;     // Set initial opcode to 0
        write_addr = 3'b0; // Set write and read addresses to 0
        read_addr = 3'b0;

        // Step 2: Deassert reset after some time
        #5 rst = 0;

        // Step 3: Test different operations on the ALU and register file

        // Test case 1: AND operation
        A = 8'b10010101;               // Input A
        B = 8'b11001100;               // Input B
        opcode = 2'b00;                // Opcode for AND
        write_addr = 3'b001;           // Write result to address 1
        we = 1;                        // Enable write
        #10 we = 0;                    // Disable write
        read_addr = 3'b001;            // Read from address 1

        // Test case 2: OR operation
        #10 A = 8'b01101010;
        B = 8'b11001100;
        opcode = 2'b01;                // Opcode for OR
        write_addr = 3'b010;           // Write result to address 2
        we = 1;
        #10 we = 0;
        read_addr = 3'b010;            // Read from address 2

        // Test case 3: NAND operation
        #10 A = 8'b10010101;
        B = 8'b11001100;
        opcode = 2'b10;                // Opcode for NAND
        write_addr = 3'b011;           // Write result to address 3
        we = 1;
        #10 we = 0;
        read_addr = 3'b011;            // Read from address 3

        // Test case 4: NOR operation
        #10 A = 8'b01010011;
        B = 8'b11001100;
        opcode = 2'b11;                // Opcode for NOR
        write_addr = 3'b100;           // Write result to address 4
        we = 1;
        #10 we = 0;
        read_addr = 3'b100;            // Read from address 4

        // Step 4: End simulation
        #20 $finish;
    end

    // Monitor changes in key signals and display them during simulation
    initial begin
        $monitor("Time: %0t | A: %b | B: %b | Opcode: %b | Write_Addr: %b | Read_Addr: %b | We: %b | Read_Data: %b", 
                 $time, A, B, opcode, write_addr, read_addr, we, read_data);
    end

    // Generate a clock signal that toggles every 5 time units
    always #5 clk = ~clk;

    // Generate a VCD file for waveform analysis
    initial begin
        $dumpfile("simulation.vcd"); // File name for the dump
        $dumpvars(0, Testbench);     // Dump all variables in the Testbench module
    end
endmodule
