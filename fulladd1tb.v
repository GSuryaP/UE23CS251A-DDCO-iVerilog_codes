`define TESTVECS 6

module tb;
  reg [2:0] i1;  // 3-bit input
  reg i2;        // 1-bit input (carry in)
  wire sum1, cout1;  // sum and carry out
  reg [3:0] test_vecs [0:(`TESTVECS-1)];  // Test vectors
  integer i;

  // Dump waveform
  initial begin
    $dumpfile("circuit_3.vcd");     
    $dumpvars(0, tb); 
  end

  // Initialize test vectors
  initial begin  
    test_vecs[0][3:1] = 3'b000;  test_vecs[0][0:0] = 1'b0;    
    test_vecs[1][3:1] = 3'b001;  test_vecs[1][0:0] = 1'b1;    
    test_vecs[2][3:1] = 3'b010;  test_vecs[2][0:0] = 1'b0;    
    test_vecs[3][3:1] = 3'b011;  test_vecs[3][0:0] = 1'b1;  
    test_vecs[4][3:1] = 3'b100;  test_vecs[4][0:0] = 1'b0;    
    test_vecs[5][3:1] = 3'b111;  test_vecs[5][0:0] = 1'b1;
  end

  // Instantiate the circuit3 module
  circuit3 circuit3_0 (i1, i2, sum1, cout1); 

  // Monitor the values
  initial begin
    $monitor("Time: %0t | i1: %b | i2: %b | sum1: %b | cout1: %b", $time, i1, i2, sum1, cout1);
  end

  // Apply test vectors
  initial begin       
    for (i = 0; i < `TESTVECS; i = i + 1) begin
      #10 {i1, i2} = test_vecs[i];  // Apply each test vector
    end
  end
endmodule
