`timescale 1 ns / 100 ps
`define TESTVECS 8

module tb;
  reg clk, reset, wr, sel;
  reg [1:0] op;
  reg [2:0] rd_addr_a, rd_addr_b, wr_addr;
  reg [15:0] d_in;
  wire [15:0] d_out_a, d_out_b;
  reg [28:0] test_vecs [0:(`TESTVECS-1)];
  integer i;

  // Dump file generation for waveform analysis
  initial begin 
    $dumpfile("tb_reg_alu.vcd"); 
    $dumpvars(0, tb); 
  end

  // Reset signal generation
  initial begin 
    reset = 1'b1; 
    #12.5 reset = 1'b0; 
  end

  // Clock generation
  initial clk = 1'b0; 
  always #5 clk = ~clk;

  // Test vectors initialization
  initial begin
    test_vecs[0][28] = 1'b0; test_vecs[0][27] = 1'b1; test_vecs[0][26:25] = 2'bxx;
    test_vecs[0][24:22] = 3'ox; test_vecs[0][21:19] = 3'ox;
    test_vecs[0][18:16] = 3'h3; test_vecs[0][15:0] = 16'hcdef;

    test_vecs[1][28] = 1'b0; test_vecs[1][27] = 1'b1; test_vecs[1][26:25] = 2'bxx;
    test_vecs[1][24:22] = 3'ox; test_vecs[1][21:19] = 3'ox;
    test_vecs[1][18:16] = 3'o7; test_vecs[1][15:0] = 16'h3210;

    test_vecs[2][28] = 1'b0; test_vecs[2][27] = 1'b1; test_vecs[2][26:25] = 2'bxx;
    test_vecs[2][24:22] = 3'o3; test_vecs[2][21:19] = 3'o7;
    test_vecs[2][18:16] = 3'o5; test_vecs[2][15:0] = 16'h4567;

    test_vecs[3][28] = 1'b0; test_vecs[3][27] = 1'b1; test_vecs[3][26:25] = 2'bxx;
    test_vecs[3][24:22] = 3'o1; test_vecs[3][21:19] = 3'o5;
    test_vecs[3][18:16] = 3'o1; test_vecs[3][15:0] = 16'hba98;

    test_vecs[4][28] = 1'b0; test_vecs[4][27] = 1'b0; test_vecs[4][26:25] = 2'bxx;
    test_vecs[4][24:22] = 3'o1; test_vecs[4][21:19] = 3'o5;
    test_vecs[4][18:16] = 3'o1; test_vecs[4][15:0] = 16'hxxxx;

    test_vecs[5][28] = 1'b1; test_vecs[5][27] = 1'b1; test_vecs[5][26:25] = 2'b00;
    test_vecs[5][24:22] = 3'o1; test_vecs[5][21:19] = 3'o5;
    test_vecs[5][18:16] = 3'o2; test_vecs[5][15:0] = 16'hxxxx;

    test_vecs[6][28] = 1'b1; test_vecs[6][27] = 1'b1; test_vecs[6][26:25] = 2'b01;
    test_vecs[6][24:22] = 3'o2; test_vecs[6][21:19] = 3'o7;
    test_vecs[6][18:16] = 3'o4; test_vecs[6][15:0] = 16'hxxxx;

    test_vecs[7][28] = 1'b1; test_vecs[7][27] = 1'b0; test_vecs[7][26:25] = 2'b01;
    test_vecs[7][24:22] = 3'o4; test_vecs[7][21:19] = 3'o4;
    test_vecs[7][18:16] = 3'ox; test_vecs[7][15:0] = 16'hxxxx;
  end

  // Initialize inputs
  initial {sel, wr, op, rd_addr_a, rd_addr_b, wr_addr, d_in} = 0;

  // Instantiate the reg_alu module
  reg_alu reg_alu_0 (
    .clk(clk), 
    .reset(reset), 
    .sel(sel), 
    .wr(wr), 
    .op(op), 
    .rd_addr_a(rd_addr_a), 
    .rd_addr_b(rd_addr_b), 
    .wr_addr(wr_addr), 
    .d_in(d_in),
    .d_out_a(d_out_a), 
    .d_out_b(d_out_b), 
    .cout(cout)
  );

  // Monitor signals
  initial begin
    $monitor("At time %0t: sel=%b, wr=%b, op=%b, rd_addr_a=%b, rd_addr_b=%b, wr_addr=%b, d_in=%h, d_out_a=%h, d_out_b=%h, cout=%b",
      $time, sel, wr, op, rd_addr_a, rd_addr_b, wr_addr, d_in, d_out_a, d_out_b, cout);
  end

  // Apply test vectors
  initial begin
    #6 for(i = 0; i < `TESTVECS; i = i + 1) begin
      #10 {sel, wr, op, rd_addr_a, rd_addr_b, wr_addr, d_in} = test_vecs[i]; 
    end
    #100 $finish;
  end

endmodule
