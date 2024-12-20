module not2_test;
reg a;
wire c;
not not2_test(c,a);
initial
begin
#000 a=0;
#020 a=1;
#020 a=0;
#020 a=1;
#020 a=0;
#020 a=1;
end 
initial
begin
$monitor($time,"a=%b,c=%b",a,c);
end
initial 
begin 
$dumpfile("not2_test.vcd");
$dumpvars(0,not2_test);
end
endmodule