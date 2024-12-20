module TB;
    reg in;
    reg sel;

    wire y0;
    wire y1;

    dmux2 newdmux(in, sel,y0,y1);
    initial begin
        in = 1'b0;sel=1'b0;
        #5      in= 1'b1;sel=1'b0;
        #5      in= 1'b1;sel=1'b1;
        #5      in= 1'b0;sel=1'b1;
        #5      in= 1'b1;sel=1'b0;
        #5      in= 1'b0;sel=1'b0;
        #5      in= 1'b1;sel=1'b1;
        #5      in= 1'b0;sel=1'b1;
    end
    initial begin
        $monitor("Time = %0t: in = %b, sel = %b, y0 = %b, y1=%b", $time, in, sel, y0, y1);
    end
    initial begin
        $dumpfile("DMUX2_test.vcd");
        $dumpvars(0, TB);
    end
endmodule