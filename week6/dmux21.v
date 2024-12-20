module dmux2(
	input wire in,
	input wire sel,
	output wire y0,
	output wire y1
);
	assign y0=(sel==0)?in:0;
	assign y1=(sel==1)?in:0;
endmodule