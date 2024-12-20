`timescale 1ns / 1ps
module tb_up_down_counter;
    reg clk;
    reg reset;
    reg up_down;
    wire [2:0] count;
    up_down_counter uut (
        .clk(clk),
        .reset(reset),
        .up_down(up_down),
        .count(count)
    );
    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end
    initial begin
        reset = 1;
        up_down = 1; 
        #10 reset = 0;
        #80;
        up_down = 0;
        #80;
        #10 $finish;
    end
    initial begin
        $monitor("Time=%0d, clk=%b, reset=%b, up_down=%b, count=%b", $time, clk, reset, up_down, count);
    end
    initial begin
        $dumpfile("up_down_counter.vcd");  
        $dumpvars(0, tb_up_down_counter);   
    end
endmodule
