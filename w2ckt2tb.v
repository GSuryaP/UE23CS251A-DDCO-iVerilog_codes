module tb_simple_circuit;

reg A,B,C;
wire D;

simple_circuit M1(A,B,C,D);

initial

begin
#0
A=1'b0 ; B=1'b0; C=1'b0;
#20
A=1'b0 ; B=1'b0; C=1'b1;
#20
A=1'b0 ; B=1'b1; C=1'b0;
#20
A=1'b0 ; B=1'b1; C=1'b1;
#20
A=1'b1 ; B=1'b0; C=1'b0;
#20
A=1'b1 ; B=1'b0; C=1'b1;
#20
A=1'b1 ; B=1'b1; C=1'b0;
#20
A=1'b1 ; B=1'b1; C=1'b1;

end

initial
begin
$monitor($time,"A=%b, B=%b, C=%b, D=%b", A, B, C, D);
end
initial
begin
$dumpfile("simple2.vcd");
$dumpvars(0,tb_simple_circuit);
end
endmodule