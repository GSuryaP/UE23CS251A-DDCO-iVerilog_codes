module and2(a,b,c);
	input a,b;
	output c;
	assign c=a&b;
endmodule

module or2(a,b,c);
	input a,b;
	output c;
	assign c=a | b;
endmodule

module not2(a,c);
	input a;
	output c;
	assign c=~a;
endmodule

module simple_circuit (A,B,C,D,E);
	output D, E;
	input A, B, C;
	wire w1;	
	and G1 (w1,A,B);
	not G2 (E,C);
	or G3 (D,w1,E);
endmodule