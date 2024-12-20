module tb;
  reg [2:0] i;
  reg Y0, Y;
  wire final_sum, final_cout;

    top_module uut (
    .i(i),
    .Y0(Y0),
    .Y(Y),
    .final_sum(final_sum),
    .final_cout(final_cout)
  );

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, tb);
    
    i = 3'b000; Y0 = 0; Y = 0; #10;
    i = 3'b001; Y0 = 1; Y = 1; #10;
    i = 3'b010; Y0 = 0; Y = 1; #10;
    i = 3'b011; Y0 = 1; Y = 0; #10;
    i = 3'b100; Y0 = 1; Y = 1; #10;
    i = 3'b111; Y0 = 0; Y = 1; #10;
    
    $finish;
  end

  initial begin
    $monitor("Time = %0t | i = %b | Y0 = %b | Y = %b | final_sum = %b | final_cout = %b", 
              $time, i, Y0, Y, final_sum, final_cout);
  end
endmodule
