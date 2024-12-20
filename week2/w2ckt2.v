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

module simple_circuit (A,B,C,D);
	output D;
	input A, B, C;
	wire w1;	
	and G1 (w1,C,B);
	or G2 (D,w1,A);
endmodule