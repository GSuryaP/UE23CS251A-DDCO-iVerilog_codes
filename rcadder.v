module and2(c,a,b);
input a,b;
output c;
assign c=a&b;
endmodule
module or2(c,a,b);
input a,b;
output c;
assign c=a|b;
endmodule
module xor2(c,a,b);
input a,b;
output c;
assign c=a ^ b;
endmodule
module fulladd (input wire a, b, cin,output wire sum, cout);
    wire [4:0] t;
    xor x0 (t[0], a, b); 
    xor x1 (sum, t[0], cin); 
    and a0 (t[1], a, b); 
    and a1 (t[2], a, cin); 
    and a2 (t[3], b, cin); 
    or o0 (t[4], t[1], t[2]); 
    or o1 (cout, t[4], t[3]); 
endmodule
module fulladdR (input wire [3:0] a, b, input wire cin, output wire [3:0] sum,output wire cout);
wire [2:0] c; 
fulladd u0 ( a[0], b[0], cin, sum[0], cout0); 
fulladd u1 ( a[1], b[1], cout0, sum[1], cout1); 
fulladd u2 ( a[2], b[2], cout1, sum[2], cout2); 
fulladd u3 ( a[3], b[3], cout2, sum[3], cout); 
endmodule