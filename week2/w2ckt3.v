module and2(a,b,c);
	input a,b;
	output c;
	assign c=a&b;
endmodule
module or2(c,a,b);
	input a,b;
	output c;
	assign c=a|b;
endmodule
module not2(c,a);
	input a;
	output c;
	assign c=~a;
endmodule
module simple_circuit(A,B,C,D);
	output D;
	input A,B,C;
	wire w1,w2,w3;
	and G1(w1,B,C);
	or G2(w2,w1,A);
	and G3(w3,A,B);
	or G4(D,w3,w2);
endmodule