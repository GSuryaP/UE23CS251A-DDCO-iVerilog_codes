module xor3(a,b,c,d);
input a,b,c;
output d;
assign d=(a^b)^c;
endmodule

module and2(a,b,c);
input a,b;
output c;
assign c=a & b;
endmodule

module or3(a,b,c,d);
input a,b,c;
output d;
assign d=(a | b) | c;
endmodule

module fa (input wire i0, i1, cin, output wire sum, cout);   wire t0, t1, t2;  
xor3 _i0 (i0, i1, cin, sum); 
and2 _i1 (i0, i1, t0);  
and2 _i2 (i1, cin, t1);   
and2 _i3 (cin, i0, t2);  
or3 _i4 (t0, t1, t2, cout);
endmodule

module circuit3 (input wire [0:2] i1,input wire i2,output wire sum1,cout1);
wire x1,x2;
fa fa_1(i1[0],i1[1],i1[2],x1,x2);
fa fa_2(x1,x2,i2,sum1,cout1);
endmodule

