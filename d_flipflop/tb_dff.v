module tb_dff;

reg clk,d,rst;
wire qout;

dff uut(.clk(clk), .rst(rst), .q(q), .d(d));

initial clk=0;
always #5 clk=~clk;

initial begin
    d=1'b1; #10;
    d=1'b0; #10;
    d=1'b1; rst=1; #10;
    d=1'b1; rst=0; #10;
    d=1'b1; rst=1; #10;
    $finish;
end
endmodule