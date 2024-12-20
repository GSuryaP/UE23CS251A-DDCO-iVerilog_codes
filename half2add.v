module full_adder(input i0, i1, i2, output S0, C0);
  wire t1, t2, t3;

  assign S0 = i0 ^ i1 ^ i2;
  
  assign t1 = i0 & i1;
  assign t2 = i1 & i2;
  assign t3 = i2 & i0;
  assign C0 = t1 | t2 | t3;
endmodule

module half_adder(input a, b, output sum, cout);
  assign sum = a ^ b;
  assign cout = a & b;
endmodule

module top_module(
  input wire [2:0] i,       
  input wire Y0,            
  input wire Y,             
  output wire final_sum,    
  output wire final_cout    
);
  wire S0, C0;              
  wire Y1;                  
  wire Y_not;               

  full_adder FA (.i0(i[0]), .i1(i[1]), .i2(i[2]), .S0(S0), .C0(C0));

  assign Y_not = ~Y;

  assign Y1 = S0 & C0 & Y_not;

  half_adder HA (.a(Y1), .b(Y0), .sum(final_sum), .cout(final_cout));
endmodule
