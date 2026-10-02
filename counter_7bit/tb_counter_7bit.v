module tb_counter_7bit;

reg clk,rst;
wire [6:0] count;

counter_7bit uut(.clk(clk), .rst(rst), .count(count));

initial clk=0;
always #5 clk=~clk;
    initial begin 
        rst=1; #10;
        rst=0;
        #100 $finish;
    end
endmodule